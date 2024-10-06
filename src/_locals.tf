# ==================================================================
# RESOURCE TIME
# ==================================================================

resource "time_static" "creation" {}

# ==================================================================
# GLOBAL LOCALS
# ==================================================================

locals {
  creation_time = time_static.creation.rfc3339
  # ==================================================================
  # AWS GENERAL
  # ==================================================================
  aws_account_id = data.aws_caller_identity.current.account_id
  # ==================================================================
  # AWS TAGS
  # ==================================================================
  aws_default_tags = {
    metadata_creation_time = local.creation_time
    metadata_managedby     = "terraform"
  }
  # ==================================================================
  # OPSGENIE
  # ==================================================================
  opsgenie_api_key_general           = opsgenie_api_integration.security_hub_general.api_key
  opsgenie_api_key_inspector         = opsgenie_api_integration.security_hub_inspector.api_key
  opsgenie_api_key_guardduty         = opsgenie_api_integration.security_hub_guardduty.api_key
  opsgenie_api_endpoint_security_hub = "https://api.opsgenie.com/v1/json/integrations/webhooks/amazonsecurityhub?apiKey=${local.opsgenie_api_key_inspector}"
  opsgenie_aws_accounts_roles = [
    "arn:aws:iam::089311581210:role/opsgenie-securityhub-app",
    "arn:aws:iam::401089113854:role/opsgenie-securityhub-app",
    "arn:aws:iam::838921230308:role/opsgenie-securityhub-app",
    "arn:aws:iam::028860521379:role/opsgenie-securityhub-app"
  ]
}
