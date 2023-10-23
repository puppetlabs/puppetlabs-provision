terraform {
  required_version = ">= 0.13.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.88, < 5.0"
    }

    hiera5 = {
      source  = "chriskuchin/hiera5"
      version = "0.5.4"
    }
  }
}
