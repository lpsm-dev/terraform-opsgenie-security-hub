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

# ==================================================================
# CREATE EVENT TARGET
# ==================================================================

resource "aws_cloudwatch_event_target" "sns" {
  rule = aws_cloudwatch_event_rule.security_hub_inspector_findings_ecr.name
  arn  = aws_sns_topic.this.arn
}
