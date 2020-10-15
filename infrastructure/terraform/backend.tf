terraform {
  backend "s3" {
    bucket         = "smartpension-tfstate"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "sp-locks"
    encrypt        = true
  }
}
