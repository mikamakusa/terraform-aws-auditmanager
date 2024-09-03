## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.64.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.64.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_kms"></a> [kms](#module\_kms) | ./modules/terraform-aws-kms | n/a |
| <a name="module_s3"></a> [s3](#module\_s3) | ./modules/terraform-aws-s3 | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_auditmanager_account_registration.this](https://registry.terraform.io/providers/hashicorp/aws/5.64.0/docs/resources/auditmanager_account_registration) | resource |
| [aws_auditmanager_assessment.this](https://registry.terraform.io/providers/hashicorp/aws/5.64.0/docs/resources/auditmanager_assessment) | resource |
| [aws_auditmanager_assessment_delegation.this](https://registry.terraform.io/providers/hashicorp/aws/5.64.0/docs/resources/auditmanager_assessment_delegation) | resource |
| [aws_auditmanager_assessment_report.this](https://registry.terraform.io/providers/hashicorp/aws/5.64.0/docs/resources/auditmanager_assessment_report) | resource |
| [aws_auditmanager_control.this](https://registry.terraform.io/providers/hashicorp/aws/5.64.0/docs/resources/auditmanager_control) | resource |
| [aws_auditmanager_framework.this](https://registry.terraform.io/providers/hashicorp/aws/5.64.0/docs/resources/auditmanager_framework) | resource |
| [aws_auditmanager_framework_share.this](https://registry.terraform.io/providers/hashicorp/aws/5.64.0/docs/resources/auditmanager_framework_share) | resource |
| [aws_auditmanager_organization_admin_account_registration.this](https://registry.terraform.io/providers/hashicorp/aws/5.64.0/docs/resources/auditmanager_organization_admin_account_registration) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/5.64.0/docs/data-sources/caller_identity) | data source |
| [aws_default_tags.this](https://registry.terraform.io/providers/hashicorp/aws/5.64.0/docs/data-sources/default_tags) | data source |
| [aws_iam_role.assessment_delegation_role](https://registry.terraform.io/providers/hashicorp/aws/5.64.0/docs/data-sources/iam_role) | data source |
| [aws_iam_role.assessment_role](https://registry.terraform.io/providers/hashicorp/aws/5.64.0/docs/data-sources/iam_role) | data source |
| [aws_kms_key.this](https://registry.terraform.io/providers/hashicorp/aws/5.64.0/docs/data-sources/kms_key) | data source |
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/5.64.0/docs/data-sources/s3_bucket) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_registration"></a> [account\_registration](#input\_account\_registration) | n/a | <pre>list(object({<br>    id                      = number<br>    delegated_admin_account = optional(string)<br>    deregister_on_destroy   = optional(bool)<br>    kms_key_id              = optional(any)<br>  }))</pre> | `[]` | no |
| <a name="input_assessment"></a> [assessment](#input\_assessment) | n/a | <pre>list(object({<br>    id           = number<br>    framework_id = any<br>    name         = string<br>    description  = optional(string)<br>    tags         = optional(map(string))<br>    roles = list(object({<br>      role_arn  = optional(any)<br>      role_type = optional(string)<br>    }))<br>    assessment_reports_destination = list(object({<br>      bucket_id        = any<br>      destination_type = string<br>    }))<br>    scope = list(object({<br>      aws_services = list(object({<br>        service_name = string<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_assessment_delegation"></a> [assessment\_delegation](#input\_assessment\_delegation) | n/a | <pre>list(object({<br>    id             = number<br>    assessment_id  = any<br>    control_set_id = string<br>    role_arn       = string<br>    role_type      = string<br>    comment        = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_assessment_delegation_role"></a> [assessment\_delegation\_role](#input\_assessment\_delegation\_role) | n/a | `string` | `null` | no |
| <a name="input_assessment_report"></a> [assessment\_report](#input\_assessment\_report) | n/a | <pre>list(object({<br>    id            = number<br>    assessment_id = any<br>    name          = string<br>  }))</pre> | `[]` | no |
| <a name="input_assessment_role"></a> [assessment\_role](#input\_assessment\_role) | n/a | `string` | `null` | no |
| <a name="input_aws_kms_key"></a> [aws\_kms\_key](#input\_aws\_kms\_key) | n/a | `string` | `null` | no |
| <a name="input_aws_s3_bucket"></a> [aws\_s3\_bucket](#input\_aws\_s3\_bucket) | n/a | `string` | `null` | no |
| <a name="input_control"></a> [control](#input\_control) | n/a | <pre>list(object({<br>    id                       = number<br>    name                     = string<br>    action_plan_instructions = optional(string)<br>    action_plan_title        = optional(string)<br>    description              = optional(string)<br>    tags                     = optional(map(string))<br>    testing_information      = optional(string)<br>    control_mapping_sources = list(object({<br>      source_name          = string<br>      source_set_up_option = string<br>      source_type          = string<br>      source_description   = optional(string)<br>      source_frequency     = optional(string)<br>      troubleshooting_text = optional(string)<br>      source_kerword = list(object({<br>        keyword_input_type = string<br>        keyword_value      = string<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_framework"></a> [framework](#input\_framework) | n/a | <pre>list(object({<br>    id              = number<br>    name            = string<br>    compliance_type = optional(string)<br>    description     = optional(string)<br>    tags            = optional(map(string))<br>    control_sets = list(object({<br>      name = string<br>      controls = list(object({<br>        control_id = any<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_framework_share"></a> [framework\_share](#input\_framework\_share) | n/a | <pre>list(object({<br>    id                  = number<br>    destination_account = string<br>    destination_region  = string<br>    framework_id        = any<br>    comment             = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_kms_key"></a> [kms\_key](#input\_kms\_key) | n/a | `any` | `[]` | no |
| <a name="input_organization_admin_account_registration"></a> [organization\_admin\_account\_registration](#input\_organization\_admin\_account\_registration) | n/a | <pre>list(object({<br>    id               = number<br>    admin_account_id = string<br>  }))</pre> | `[]` | no |
| <a name="input_s3_bucket"></a> [s3\_bucket](#input\_s3\_bucket) | n/a | `any` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_registration_id"></a> [account\_registration\_id](#output\_account\_registration\_id) | n/a |
| <a name="output_assessment_arn"></a> [assessment\_arn](#output\_assessment\_arn) | n/a |
| <a name="output_assessment_delegation_id"></a> [assessment\_delegation\_id](#output\_assessment\_delegation\_id) | n/a |
| <a name="output_assessment_id"></a> [assessment\_id](#output\_assessment\_id) | n/a |
| <a name="output_assessment_name"></a> [assessment\_name](#output\_assessment\_name) | n/a |
| <a name="output_assessment_report_id"></a> [assessment\_report\_id](#output\_assessment\_report\_id) | n/a |
| <a name="output_control_arn"></a> [control\_arn](#output\_control\_arn) | n/a |
| <a name="output_control_id"></a> [control\_id](#output\_control\_id) | n/a |
| <a name="output_framework_arn"></a> [framework\_arn](#output\_framework\_arn) | n/a |
| <a name="output_framework_id"></a> [framework\_id](#output\_framework\_id) | n/a |
| <a name="output_framework_share_id"></a> [framework\_share\_id](#output\_framework\_share\_id) | n/a |
| <a name="output_organization_admin_account_registration_id"></a> [organization\_admin\_account\_registration\_id](#output\_organization\_admin\_account\_registration\_id) | n/a |
