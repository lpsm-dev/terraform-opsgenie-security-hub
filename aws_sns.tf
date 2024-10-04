# ==================================================================
# CREATE SNS TOPIC
# ==================================================================

resource "aws_sns_topic" "this" {
  name            = "opsgenie-security-hub-finding"
  display_name    = "opsgenie-security-hub-finding"
  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false,
    "defaultRequestPolicy": {
      "headerContentType": "text/plain; charset=UTF-8"
    }
  }
}
EOF
}

# ==================================================================
# CREATE SNS TOPIC POLICY
# ==================================================================

resource "aws_sns_topic_policy" "this" {
  arn    = aws_sns_topic.this.arn
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Action": "sns:Publish",
      "Resource": "${aws_sns_topic.this.arn}"
    }
  ]
}
EOF
}

# ==================================================================
# CREATE SNS TOPIC SUBSCRIPTION
# ==================================================================

resource "aws_sns_topic_subscription" "this" {
  topic_arn = aws_sns_topic.this.arn
  protocol  = "https"
  endpoint  = "https://api.opsgenie.com/v1/json/integrations/webhooks/amazonsecurityhub?apiKey=${opsgenie_api_integration.aws_security_hub.api_key}"
}
