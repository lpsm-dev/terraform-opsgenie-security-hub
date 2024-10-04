plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

rule "terraform_deprecated_interpolation" {
  enabled = false
}

plugin "aws" {
  enabled = true
  version = "0.33.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}
