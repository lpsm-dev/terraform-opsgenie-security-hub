# ==================================================================
# CREATE SECURITY HUB CUSTOM ACTION
# ==================================================================

resource "aws_securityhub_action_target" "opsgenie" {
  name        = "Send to Opsgenie"
  identifier  = "SendToOpsgenie"
  description = "This is a custom action that sends selected findings to Opsgenie"
}
