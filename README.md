## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8 |
| <a name="requirement_opsgenie"></a> [opsgenie](#requirement\_opsgenie) | 0.6.37 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.70.0 |
| <a name="provider_opsgenie"></a> [opsgenie](#provider\_opsgenie) | 0.6.37 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.12.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.security_hub_inspector_findings_ecr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_sns_topic.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_sns_topic_subscription.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [opsgenie_api_integration.aws_security_hub](https://registry.terraform.io/providers/opsgenie/opsgenie/0.6.37/docs/resources/api_integration) | resource |
| [opsgenie_team.this](https://registry.terraform.io/providers/opsgenie/opsgenie/0.6.37/docs/resources/team) | resource |
| [time_static.creation](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [opsgenie_user.users](https://registry.terraform.io/providers/opsgenie/opsgenie/0.6.37/docs/data-sources/user) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_environment"></a> [aws\_environment](#input\_aws\_environment) | Ambiente da AWS | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Região da AWS | `string` | n/a | yes |
| <a name="input_opsgenie_api_key"></a> [opsgenie\_api\_key](#input\_opsgenie\_api\_key) | API Key do OpsGenie | `string` | n/a | yes |
| <a name="input_opsgenie_team_description"></a> [opsgenie\_team\_description](#input\_opsgenie\_team\_description) | Descrição do Time do OpsGenie | `string` | n/a | yes |
| <a name="input_opsgenie_team_name"></a> [opsgenie\_team\_name](#input\_opsgenie\_team\_name) | Nome do Time do OpsGenie | `string` | n/a | yes |
| <a name="input_opsgenie_users"></a> [opsgenie\_users](#input\_opsgenie\_users) | Lista de usuários do OpsGenie | `list(map(string))` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_opsgenie_security_hub_role_arn"></a> [opsgenie\_security\_hub\_role\_arn](#output\_opsgenie\_security\_hub\_role\_arn) | n/a |
| <a name="output_opsgenie_security_hub_role_name"></a> [opsgenie\_security\_hub\_role\_name](#output\_opsgenie\_security\_hub\_role\_name) | n/a |
