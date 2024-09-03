module "kms" {
  source = "./modules/terraform-aws-kms"
  key    = var.kms_key
}

module "s3" {
  source = "./modules/terraform-aws-s3"
  bucket = var.s3_bucket
}