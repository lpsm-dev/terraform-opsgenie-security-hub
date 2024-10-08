# ==================================================================
# TERRAFORM REQUIRED CONFIGURATION
# ==================================================================

terraform {
  required_version = ">= 1.8"
  required_providers {
    opsgenie = {
      source  = "opsgenie/opsgenie"
      version = "~> 0.6"
    }
  }
}
