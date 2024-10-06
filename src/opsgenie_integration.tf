# ==================================================================
# CREATE OPSGENIE INTEGRATION
# ==================================================================

resource "opsgenie_api_integration" "security_hub_general" {
  name                           = "security-hub-general"
  type                           = "AmazonSecurityHub"
  enabled                        = true
  allow_write_access             = true
  ignore_responders_from_payload = false
  suppress_notifications         = false
  owner_team_id                  = opsgenie_team.this.id
}

resource "opsgenie_api_integration" "security_hub_inspector" {
  name                           = "security-hub-inspector"
  type                           = "AmazonSecurityHub"
  enabled                        = true
  allow_write_access             = true
  ignore_responders_from_payload = false
  suppress_notifications         = false
  owner_team_id                  = opsgenie_team.this.id
}

resource "opsgenie_api_integration" "security_hub_guardduty" {
  name                           = "security-hub-guardduty"
  type                           = "AmazonSecurityHub"
  enabled                        = true
  allow_write_access             = true
  ignore_responders_from_payload = false
  suppress_notifications         = false
  owner_team_id                  = opsgenie_team.this.id
}
