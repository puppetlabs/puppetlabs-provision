terraform {
  required_version = ">= 0.13.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.20.1"
    }

    hiera5 = {
      source  = "chriskuchin/hiera5"
      version = "0.5.4"
    }
  }
}
