# Define identities to create
locals {
  workspaces_by_phase = flatten([for workspace in var.workspaces : [
    for phase in workspace.phases : {
      workspace_name = workspace.workspace_name
      project_name   = workspace.project_name
      phase          = phase
    }
  ]])
  workspaces = { for ws in local.workspaces_by_phase : "${ws.workspace_name}_${ws.phase}" => ws }
}

# Create an application
resource "azuread_application_registration" "oidc" {
  display_name = var.identity_name
}

# Create federated identities
resource "azuread_application_federated_identity_credential" "branches" {
  for_each       = local.workspaces
  application_id = azuread_application_registration.oidc.id
  display_name   = "${azuread_application_registration.oidc.display_name}-${each.key}"
  description    = "HCP Terraform OIDC for ${each.value.workspace_name} and phase ${each.value.phase}."
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://app.terraform.io"
  subject        = "organization:${var.organization_name}:project:${each.value.project_name}:workspace:${each.value.workspace_name}:run_phase:${each.value.phase}"
}


# Create a service principal
data "azuread_client_config" "current" {}

locals {
  owner_id = var.owner_id != null ? var.owner_id : data.azuread_client_config.current.object_id
}

resource "azuread_service_principal" "oidc" {
  client_id = azuread_application_registration.oidc.client_id
  owners    = [local.owner_id]
}