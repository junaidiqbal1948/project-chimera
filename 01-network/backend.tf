terraform {
  backend "s3" {
    bucket         = "chimera-tf-state-654984"
    key            = "01-network/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "chimera-tf-locks"
    encrypt        = true
  }
}
