terraform {
  required_version = ">= 0.13.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.88, < 5.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}
