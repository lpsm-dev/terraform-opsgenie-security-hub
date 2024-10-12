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
  # AWS DEFAULT
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
  opsgenie_integrations = [
    "sh-manual-action",
    "sh-inspector-findings",
    "sh-standards-findings",
    "sh-guardduty-findings"
  ]
  opsgenie_api_keys = {
    for k, v in opsgenie_api_integration.this : k => v.api_key
  }
  opsgenie_api_endpoints = {
    for k in local.opsgenie_integrations : k => "https://api.opsgenie.com/v1/json/integrations/webhooks/amazonsecurityhub?apiKey=${opsgenie_api_integration.this[k].api_key}"
  }
  opsgenie_atlassian_aws_accounts_roles = [
    "arn:aws:iam::089311581210:role/opsgenie-securityhub-app",
    "arn:aws:iam::401089113854:role/opsgenie-securityhub-app",
    "arn:aws:iam::838921230308:role/opsgenie-securityhub-app",
    "arn:aws:iam::028860521379:role/opsgenie-securityhub-app"
  ]
}
