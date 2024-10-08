# ==================================================================
# CREATE SNS TOPIC
# ==================================================================

resource "aws_sns_topic" "this" {
  for_each        = toset(local.opsgenie_integrations)
  name            = "opsgenie-integration-${each.key}"
  display_name    = "Trigger Opsgenie Integration - ${each.key}"
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
  for_each = aws_sns_topic.this
  arn      = each.value.arn
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "default"
    Statement = [
      {
        Sid    = "default"
        Effect = "Allow"
        Principal = {
          Service = "events.amazonaws.com"
        }
        Action   = "SNS:Publish"
        Resource = each.value.arn
      }
    ]
  })
}

# ==================================================================
# CREATE SNS TOPIC SUBSCRIPTION
# ==================================================================

resource "aws_sns_topic_subscription" "this" {
  for_each  = local.opsgenie_api_endpoints
  topic_arn = aws_sns_topic.this[each.key].arn
  protocol  = "https"
  endpoint  = each.value
}