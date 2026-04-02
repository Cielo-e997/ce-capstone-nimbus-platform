terraform {
  backend "s3" {
    bucket         = "nimbus-terraform-state-cielo"
    key            = "global/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "nimbus-terraform-locks"
    encrypt        = true
  }
}
