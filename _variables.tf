# ==================================================================
# VARIABLES - AWS
# ==================================================================

variable "aws_environment" {
  description = "Ambiente da AWS"
  type        = string
}

variable "aws_region" {
  description = "Região da AWS"
  type        = string
}

# ==================================================================
# VARIABLES - OPSGENIE
# ==================================================================

variable "opsgenie_api_key" {
  description = "API Key do OpsGenie"
  type        = string
}

variable "opsgenie_team_name" {
  description = "Nome do Time do OpsGenie"
  type        = string
}

variable "opsgenie_team_description" {
  description = "Descrição do Time do OpsGenie"
  type        = string
}

variable "opsgenie_users" {
  description = "Lista de usuários do OpsGenie"
  type        = list(map(string))
}
