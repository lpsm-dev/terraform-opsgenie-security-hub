module "eventbridge" {
  source  = "terraform-aws-modules/eventbridge/aws"
  version = "~> 3.11"

  create_bus = false
  rules = {
    opsgenie-sh-custom-action = {
      description = "Rule to create an alert in Opsgenie based on a Security Hub custom action trigger manually"
      event_pattern = jsonencode(
        {
          "source" : ["aws.securityhub"],
          "detail-type" : ["Security Hub Findings - Custom Action"],
          "resources" : ["${aws_securityhub_action_target.opsgenie.arn}"]
        }
      )
    },
    opsgenie-sh-findings-inspector = {
      description = "Rule to create an alert in Opsgenie when Inspector generates a finding in Security Hub related to ECR images"
      event_pattern = jsonencode(
        {
          "source" : ["aws.securityhub"],
          "detail-type" : ["Security Hub Findings - Imported"],
          "detail" : {
            "findings" : {
              "ProductArn" : ["arn:aws:securityhub:us-east-1::product/aws/inspector", "arn:aws:securityhub:sa-east-1::product/aws/inspector"],
              "Severity" : {
                "Label" : ["CRITICAL", "HIGH"]
              },
              "Workflow" : {
                "Status" : ["NEW"]
              },
              "Resources" : {
                "Type" : ["AwsEcrContainerImage"],
                "Details" : {
                  "AwsEcrContainerImage" : {
                    "ImageTags" : [{
                      "prefix" : "latest"
                      }, {
                      "suffix" : "latest"
                    }]
                  }
                },
                "Id" : [{
                  "wildcard" : "*images*"
                }]
              }
            }
          }
        }
      )
    },
    opsgenie-sh-findings-standards = {
      description = "Rule to create an alert in Opsgenie when Security Standards generates a finding in Security Hub"
      event_pattern = jsonencode(
        {
          "source" : ["aws.securityhub"],
          "detail-type" : ["Security Hub Findings - Imported"],
          "detail" : {
            "findings" : {
              "ProductName" : ["Security Hub"],
              "Severity" : {
                "Label" : ["CRITICAL", "HIGH"]
              },
              "Workflow" : {
                "Status" : ["NEW"]
              }
            }
          }
        }
      )
    },
    opsgenie-sh-findings-guardduty = {
      description = "Rule to create an alert in Opsgenie when GuardDuty generates a finding in Security Hub"
      event_pattern = jsonencode(
        {
          "source" : ["aws.securityhub"],
          "detail-type" : ["Security Hub Findings - Imported"],
          "detail" : {
            "findings" : {
              "ProductName" : ["GuardDuty"],
              "Severity" : {
                "Label" : ["CRITICAL", "HIGH"]
              },
              "Workflow" : {
                "Status" : ["NEW"]
              }
            }
          }
        }
      )
    }
  }

  targets = {
    opsgenie-sh-custom-action = [
      {
        name = "sh-manual-action"
        arn  = aws_sns_topic.this["sh-manual-action"].arn
      }
    ],
    opsgenie-sh-findings-inspector = [
      {
        name = "sh-inspector-findings"
        arn  = aws_sns_topic.this["sh-inspector-findings"].arn
      }
    ],
    opsgenie-sh-findings-standards = [
      {
        name = "sh-standards-findings"
        arn  = aws_sns_topic.this["sh-standards-findings"].arn
      }
    ],
    opsgenie-sh-findings-guardduty = [
      {
        name = "sh-guardduty-findings"
        arn  = aws_sns_topic.this["sh-guardduty-findings"].arn
      }
    ]
  }
}
