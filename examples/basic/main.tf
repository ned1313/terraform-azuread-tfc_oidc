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
  workspaces = [
    {
      workspace_name = "example-workspace"
      project_name   = "example-project"
      phases         = ["plan", "apply"]
    },
    {
      workspace_name = "another-workspace"
      project_name   = "another-project"
      phases         = ["plan"]
    }
  ]
}