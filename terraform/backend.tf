terraform {
  backend "s3" {
    bucket         = "sp-test-tfstate"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "smartpension-locks"
    encrypt        = true
  }
}
