# ==================================================================
# CREATE EVENT RULE
# ==================================================================

resource "aws_cloudwatch_event_rule" "security_hub_inspector_findings_ecr" {
  name          = "opsgenie-security-hub-inspector-findings-ecr"
  description   = "Rule to notify Opsgenie of critical and high findings discovery in specific ECR images"
  event_pattern = <<EOF
{
  "source": ["aws.securityhub"],
  "detail-type": ["Security Hub Findings - Imported"],
  "detail": {
    "findings": {
      "ProductName": ["Inspector"],
      "Severity": {
        "Label": ["CRITICAL", "HIGH"]
      },
      "Workflow": {
        "Status": ["NEW"]
      },
      "Resources": {
        "Type": ["AwsEcrContainerImage"],
        "Id": [{
          "wildcard": "*images*"
        }]
      }
    }
  }
}  
EOF
}

resource "aws_cloudwatch_event_rule" "security_hub_custom_action_opsgenie" {
  name          = "opsgenie-security-hub-custom-action-opsgenie"
  description   = "Rule to notify Opsgenie based on a Security Hub custom action"
  event_pattern = <<EOF
{
  "source": ["aws.securityhub"],
  "detail-type": ["Security Hub Findings - Custom Action"],
  "resources": ["${aws_securityhub_action_target.opsgenie.arn}"]
}
EOF
}

# ==================================================================
# CREATE EVENT TARGET
# ==================================================================

resource "aws_cloudwatch_event_target" "security_hub_inspector_findings_ecr" {
  rule = aws_cloudwatch_event_rule.security_hub_inspector_findings_ecr.name
  arn  = aws_sns_topic.this.arn
}

resource "aws_cloudwatch_event_target" "security_hub_custom_action_opsgenie" {
  rule = aws_cloudwatch_event_rule.security_hub_custom_action_opsgenie.name
  arn  = aws_sns_topic.this.arn
}
