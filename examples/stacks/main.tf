terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~>3.0"
    }
  }
}

provider "azuread" {}

module "example" {
  source            = "../../"
  identity_name     = "example-identity"
  organization_name = "example-org"
  stacks = [
    {
      stack_name      = "example-stack"
      deployment_name = "example-deployment"
      project_name    = "example-project"
      operations      = ["plan", "apply"]
    },
    {
      stack_name      = "another-stack"
      deployment_name = "another-deployment"
      project_name    = "another-project"
      operations      = ["plan"]
    }
  ]
}