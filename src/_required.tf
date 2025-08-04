# ==================================================================
# TERRAFORM REQUIRED CONFIGURATION
# ==================================================================

terraform {
  required_version = ">= 1.8"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.70"
    }
    opsgenie = {
      source  = "opsgenie/opsgenie"
      version = "~> 0.6"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.13"
    }
  }
}
