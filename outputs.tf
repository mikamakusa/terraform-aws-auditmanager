output "account_registration_id" {
  value = try(aws_auditmanager_account_registration.this.*.id)
}

output "assessment_id" {
  value = try(aws_auditmanager_assessment.this.*.id)
}

output "assessment_arn" {
  value = try(aws_auditmanager_assessment.this.*.arn)
}

output "assessment_name" {
  value = try(aws_auditmanager_assessment.this.*.name)
}

output "assessment_delegation_id" {
  value = try(aws_auditmanager_assessment_delegation.this.*.id)
}

output "assessment_report_id" {
  value = try(aws_auditmanager_assessment_report.this.*.id)
}

output "control_id" {
  value = try(aws_auditmanager_control.this.*.id)
}

output "control_arn" {
  value = try(aws_auditmanager_control.this.*.arn)
}

output "framework_id" {
  value = try(aws_auditmanager_framework.this.*.id)
}

output "framework_arn" {
  value = try(aws_auditmanager_framework.this.*.arn)
}

output "framework_share_id" {
  value = try(aws_auditmanager_framework_share.this.*.id)
}

output "organization_admin_account_registration_id" {
  value = try(aws_auditmanager_organization_admin_account_registration.this.*.id)
}