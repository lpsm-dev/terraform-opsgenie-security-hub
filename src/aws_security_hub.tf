# ==================================================================
# CREATE SECURITY HUB CUSTOM ACTION
# ==================================================================

resource "aws_securityhub_action_target" "opsgenie" {
  name        = "Send to Opsgenie"
  identifier  = "SendToOpsgenie"
  description = "This is a custom action triggered manually when you want to create an alert in Opsgenie based on a Security Hub finding"
}
