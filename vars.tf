## TAGS

variable "tags" {
  type    = map(string)
  default = {}
}

## DATAS

variable "aws_kms_key" {
  type    = string
  default = null
}

variable "aws_s3_bucket" {
  type    = string
  default = null
}

variable "assessment_delegation_role" {
  type    = string
  default = null
}

variable "assessment_role" {
  type    = string
  default = null
}

## MODULES

variable "kms_key" {
  type    = any
  default = []
}

variable "s3_bucket" {
  type    = any
  default = []
}

## RESOURCES

variable "account_registration" {
  type = list(object({
    id                      = number
    delegated_admin_account = optional(string)
    deregister_on_destroy   = optional(bool)
    kms_key_id              = optional(any)
  }))
  default = []
}

variable "assessment" {
  type = list(object({
    id           = number
    framework_id = any
    name         = string
    description  = optional(string)
    tags         = optional(map(string))
    roles = list(object({
      role_arn  = optional(any)
      role_type = optional(string)
    }))
    assessment_reports_destination = list(object({
      bucket_id        = any
      destination_type = string
    }))
    scope = list(object({
      aws_services = list(object({
        service_name = string
      }))
    }))
  }))
  default = []
}

variable "assessment_delegation" {
  type = list(object({
    id             = number
    assessment_id  = any
    control_set_id = string
    role_arn       = string
    role_type      = string
    comment        = optional(string)
  }))
  default = []
}

variable "assessment_report" {
  type = list(object({
    id            = number
    assessment_id = any
    name          = string
  }))
  default = []
}

variable "control" {
  type = list(object({
    id                       = number
    name                     = string
    action_plan_instructions = optional(string)
    action_plan_title        = optional(string)
    description              = optional(string)
    tags                     = optional(map(string))
    testing_information      = optional(string)
    control_mapping_sources = list(object({
      source_name          = string
      source_set_up_option = string
      source_type          = string
      source_description   = optional(string)
      source_frequency     = optional(string)
      troubleshooting_text = optional(string)
      source_kerword = list(object({
        keyword_input_type = string
        keyword_value      = string
      }))
    }))
  }))
  default = []
}

variable "framework" {
  type = list(object({
    id              = number
    name            = string
    compliance_type = optional(string)
    description     = optional(string)
    tags            = optional(map(string))
    control_sets = list(object({
      name = string
      controls = list(object({
        control_id = any
      }))
    }))
  }))
  default = []

  validation {
    condition     = length([for a in var.framework : true if contains(["CIS", "HIPAA"], a.compliance_type)]) == length(var.framework)
    error_message = "Compliance type that the new custom framework supports, such as CIS or HIPAA."
  }
}

variable "framework_share" {
  type = list(object({
    id                  = number
    destination_account = string
    destination_region  = string
    framework_id        = any
    comment             = optional(string)
  }))
  default = []
}

variable "organization_admin_account_registration" {
  type = list(object({
    id               = number
    admin_account_id = string
  }))
  default = []
}