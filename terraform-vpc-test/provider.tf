
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.57.0"
    }

  }
    backend "s3" {
      bucket="daws93-state-dev"
      key      = "expense-vpc-test"
      region   = "us-east-1"
      dynamodb_table = "daws-93-locking-dev"
      
    }



}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}