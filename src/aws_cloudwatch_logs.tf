# ==================================================================
# CREATE CLOUDWATCH LOG GROUP
# ==================================================================

module "cw_opsgenie_sh_custom_action" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/log-group"
  version = "~> 5.6"

  name              = "/aws/events/eventbridge/opsgenie-sh-custom-action"
  retention_in_days = 3
}
