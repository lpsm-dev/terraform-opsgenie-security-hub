# ==================================================================
# VARIABLES - AWS
# ==================================================================

variable "aws_environment" {
  description = "Environment of AWS"
  type        = string
}

variable "aws_region" {
  description = "Region of AWS"
  type        = string
}

# ==================================================================
# VARIABLES - OPSGENIE
# ==================================================================

variable "opsgenie_api_key" {
  description = "API Key of Opsgenie"
  type        = string
}

variable "opsgenie_team_name" {
  description = "Team name of Opsgenie"
  type        = string
}

variable "opsgenie_team_description" {
  description = "Team description of Opsgenie"
  type        = string
}

variable "opsgenie_users" {
  description = "Opsgenie list users and roles"
  type        = list(map(string))
}
