resource "aws_auditmanager_account_registration" "this" {
  count                   = length(var.account_registration)
  delegated_admin_account = lookup(var.account_registration[count.index], "delegated_admin_account")
  deregister_on_destroy   = lookup(var.account_registration[count.index], "deregister_on_destroy")
  kms_key                 = try(var.aws_kms_key != null ? data.aws_kms_key.this.id : element(module.kms.*.key_id, lookup(var.account_registration[count.index], "kms_key_id")))
}

resource "aws_auditmanager_assessment" "this" {
  count        = length(var.framework) == 0 ? 0 : length(var.assessment)
  framework_id = try(element(aws_auditmanager_framework.this.*.id, lookup(var.assessment[count.index], "framework_id")))
  name         = lookup(var.assessment[count.index], "name")
  description  = lookup(var.assessment[count.index], "description")
  tags         = merge(var.tags, data.aws_default_tags.this.tags, lookup(var.assessment[count.index], "tags"))

  dynamic "roles" {
    for_each = try(lookup(var.assessment[count.index], "roles"))
    iterator = rol
    content {
      role_arn  = try(data.aws_iam_role.assessment_role.arn)
      role_type = lookup(rol.value, "role_type", "PROCESS_OWNER")
    }
  }

  dynamic "assessment_reports_destination" {
    for_each = try(lookup(var.assessment[count.index], "assessment_reports_destination"))
    iterator = ass
    content {
      destination      = try(var.aws_s3_bucket != null ? join("//", ["s3:", data.aws_s3_bucket.this.bucket]) : join("//", ["s3:", element(module.s3.*.s3_bucket_id, lookup(ass.value, "bucket_id"))]))
      destination_type = lookup(ass.value, "destination_type", "S3")
    }
  }

  dynamic "scope" {
    for_each = try(lookup(var.assessment[count.index], "scope"))
    iterator = sco
    content {
      aws_accounts {
        id = data.aws_caller_identity.this.account_id
      }
      dynamic "aws_services" {
        for_each = lookup(sco.value, "aws_services")
        iterator = aws
        content {
          service_name = lookup(aws.value, "service_name")
        }
      }
    }
  }
}

resource "aws_auditmanager_assessment_delegation" "this" {
  count          = length(var.assessment) == 0 ? 0 : length(var.assessment_delegation)
  assessment_id  = try(element(aws_auditmanager_assessment.this.*.id, lookup(var.assessment_delegation[count.index], "assessment_id")))
  control_set_id = lookup(var.assessment_delegation[count.index], "control_set_id")
  role_arn       = data.aws_iam_role.assessment_delegation_role.arn
  role_type      = lookup(var.assessment_delegation[count.index], "role_type", "RESOURCE_OWNER")
  comment        = lookup(var.assessment_delegation[count.index], "comment")
}

resource "aws_auditmanager_assessment_report" "this" {
  count         = length(var.assessment) == 0 ? 0 : length(var.assessment_report)
  assessment_id = try(element(aws_auditmanager_assessment.this.*.id, lookup(var.assessment_report[count.index], "assessment_id")))
  name          = lookup(var.assessment_report[count.index], "name")
}

resource "aws_auditmanager_control" "this" {
  count                    = length(var.control)
  name                     = lookup(var.control[count.index], "name")
  action_plan_instructions = lookup(var.control[count.index], "action_plan_instructions")
  action_plan_title        = lookup(var.control[count.index], "action_plan_title")
  description              = lookup(var.control[count.index], "description")
  tags                     = merge(var.tags, data.aws_default_tags.this.tags, lookup(var.control[count.index], "tags"))
  testing_information      = lookup(var.control[count.index], "testing_information")

  dynamic "control_mapping_sources" {
    for_each = lookup(var.control[count.index], "control_mapping_sources")
    iterator = cms
    content {
      source_name          = lookup(cms.value, "source_name")
      source_set_up_option = lookup(cms.value, "source_set_up_option")
      source_type          = lookup(cms.value, "source_type")
      source_description   = lookup(cms.value, "source_description")
      source_frequency     = lookup(cms.value, "source_frequency")
      troubleshooting_text = lookup(cms.value, "troubleshooting_text")

      dynamic "source_keyword" {
        for_each = lookup(cms.value, "source_keyword")
        iterator = sk
        content {
          keyword_input_type = lookup(sk.value, "keyword_input_type")
          keyword_value      = lookup(sk.value, "keyword_value")
        }
      }
    }
  }
}

resource "aws_auditmanager_framework" "this" {
  count           = length(var.framework)
  name            = lookup(var.framework[count.index], "name")
  compliance_type = lookup(var.framework[count.index], "compliance_type")
  description     = lookup(var.framework[count.index], "description")
  tags            = merge(var.tags, data.aws_default_tags.this.tags, lookup(var.framework[count.index], "tags"))

  dynamic "control_sets" {
    for_each = lookup(var.framework[count.index], "control_sets")
    iterator = cs
    content {
      name = lookup(cs.value, "name")

      dynamic "controls" {
        for_each = lookup(cs.value, "controls")
        content {
          id = element(aws_auditmanager_control.this.*.id, lookup(controls.value, "control_id"))
        }
      }
    }
  }
}

resource "aws_auditmanager_framework_share" "this" {
  count               = length(var.framework) == 0 ? 0 : length(var.framework_share)
  destination_account = lookup(var.framework_share[count.index], "destination_account")
  destination_region  = lookup(var.framework_share[count.index], "destination_region")
  framework_id        = try(element(aws_auditmanager_framework.this.*.id, lookup(var.framework_share[count.index], "framework_id")))
  comment             = lookup(var.framework_share[count.index], "comment")
}

resource "aws_auditmanager_organization_admin_account_registration" "this" {
  count            = length(var.organization_admin_account_registration)
  admin_account_id = lookup(var.organization_admin_account_registration[count.index], "admin_account_id")
}