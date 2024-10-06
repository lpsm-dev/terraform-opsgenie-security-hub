# ==================================================================
# CREATE EVENT RULE
# ==================================================================

resource "aws_cloudwatch_event_rule" "custom_action" {
  name          = "opsgenie-sh-custom-action"
  description   = "Rule for creating an alert in Opsgenie based on a Security Hub custom action trigger manually"
  event_pattern = <<EOF
{
  "source": ["aws.securityhub"],
  "detail-type": ["Security Hub Findings - Custom Action"],
  "resources": ["${aws_securityhub_action_target.opsgenie.arn}"]
}
EOF
}

resource "aws_cloudwatch_event_rule" "findings_inspector_ecr" {
  name          = "opsgenie-sh-findings-inspector-ecr"
  description   = "Rule to create an alert in Opsgenie when Inspector generates a finding in Security Hub related to ECR images"
  event_pattern = <<EOF
{
  "source": ["aws.securityhub"],
  "detail-type": ["Security Hub Findings - Imported"],
  "detail": {
    "findings": {
      "ProductArn": ["arn:aws:securityhub:us-east-1::product/aws/inspector", "arn:aws:securityhub:sa-east-1::product/aws/inspector"],
      "Severity": {
        "Label": ["CRITICAL", "HIGH"]
      },
      "Workflow": {
        "Status": ["NEW"]
      },
      "Resources": {
        "Type": ["AwsEcrContainerImage"],
        "Details": {
          "AwsEcrContainerImage": {
            "ImageTags": [{
              "prefix": "latest"
            }, {
              "suffix": "latest"
            }]
          }
        },
        "Id": [{
          "wildcard": "*images*"
        }]
      }
    }
  }
}
EOF
}

resource "aws_cloudwatch_event_rule" "findings_security_standards" {
  name          = "opsgenie-sh-findings-security-standards"
  description   = "Rule to create an alert in Opsgenie when Security Standards generates a finding in Security Hub"
  event_pattern = <<EOF
{
  "source": ["aws.securityhub"],
  "detail-type": ["Security Hub Findings - Imported"],
  "detail": {
    "findings": {
      "ProductName": "Security Hub",
      "Severity": {
        "Label": ["CRITICAL", "HIGH"]
      },
      "Workflow": {
        "Status": ["NEW"]
      }
    }
  }
}
EOF
}

resource "aws_cloudwatch_event_rule" "findings_guardduty" {
  name          = "opsgenie-findings-guardduty"
  description   = "Rule to create an alert in Opsgenie when GuardDuty generates a finding in Security Hub"
  event_pattern = <<EOF
{
  "source": ["aws.securityhub"],
  "detail-type": ["Security Hub Findings - Imported"],
  "detail": {
    "findings": {
      "ProductName": "GuardDuty",
      "Severity": {
        "Label": ["CRITICAL", "HIGH"]
      },
      "Workflow": {
        "Status": ["NEW"]
      }
    }
  }
}
EOF
}

# ==================================================================
# CREATE EVENT TARGET
# ==================================================================

resource "aws_cloudwatch_event_target" "custom_action" {
  rule = aws_cloudwatch_event_rule.custom_action.name
  arn  = aws_sns_topic.this.arn
}

resource "aws_cloudwatch_event_target" "findings_inspector_ecr" {
  rule = aws_cloudwatch_event_rule.findings_inspector_ecr.name
  arn  = aws_sns_topic.this.arn
}
