terraform {
  required_version = ">= 0.13.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.5.0"
    }

    hiera5 = {
      source  = "chriskuchin/hiera5"
      version = "0.3.0"
    }
  }
}
