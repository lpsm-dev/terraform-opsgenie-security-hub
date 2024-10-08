# ==================================================================
# PROVIDER AWS - DEFAULT
# ==================================================================

provider "aws" {
  region = local.aws_region
  default_tags {
    tags = {
      "metadata:creation-time" = local.aws_default_tags.metadata_creation_time
      "metadata:managed-by"    = local.aws_default_tags.metadata_managedby
    }
  }
}

# ==================================================================
# PROVIDERS - OPSGENIE
# ==================================================================

provider "opsgenie" {
  api_url = "api.eu.opsgenie.com"
  api_key = var.opsgenie_api_key
}

# ==================================================================
# PROVIDER OTHERS
# ==================================================================

provider "time" {}
