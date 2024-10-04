# ==================================================================
# CREATE OPSGENIE INTEGRATION
# ==================================================================

resource "opsgenie_api_integration" "aws_security_hub" {
  name                           = "aws-security-hub-findings"
  type                           = "AmazonSecurityHub"
  enabled                        = true
  allow_write_access             = true
  ignore_responders_from_payload = false
  suppress_notifications         = false
  owner_team_id                  = opsgenie_team.this.id
}
