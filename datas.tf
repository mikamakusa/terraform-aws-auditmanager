data "aws_default_tags" "this" {}

data "aws_caller_identity" "this" {}

data "aws_kms_key" "this" {
  count  = try(var.aws_kms_key ? 1 : 0)
  key_id = try(var.aws_kms_key)
}

data "aws_s3_bucket" "this" {
  count  = try(var.aws_s3_bucket ? 1 : 0)
  bucket = try(var.aws_s3_bucket)
}

data "aws_iam_role" "assessment_delegation_role" {
  count = try(var.assessment_delegation_role ? 1 : 0)
  name  = try(var.assessment_delegation_role)
}

data "aws_iam_role" "assessment_role" {
  count = try(var.assessment_role ? 1 : 0)
  name  = try(var.assessment_role)
}