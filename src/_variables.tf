# ==================================================================
# VARIABLES - AWS GENERAL
# ==================================================================

variable "aws_environment" {
  description = "The environment to deploy the resources"
  type        = string
  default     = "production"
  validation {
    condition     = contains(["develop", "stage", "production", "sandbox", "pocs"], var.aws_environment)
    error_message = "Invalid argument \"aws_environment\", please choose one of: (\"develop\",\"stage\",\"production\",\"sandbox\",\"pocs\")."
  }
}

variable "aws_region" {
  description = "AWS region to deploy the resources"
  type        = string
  default     = "us-east-1"
  validation {
    condition     = contains(["us-east-1", "sa-east-1"], var.aws_region)
    error_message = "Invalid argument \"aws_region\", please choose one of: (\"us-east-1\",\"sa-east-1\")."
  }
}

# ==================================================================
# VARIABLES - OPSGENIE
# ==================================================================

variable "opsgenie_api_key" {
  description = "API Key of Opsgenie"
  type        = string
  sensitive   = true
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
