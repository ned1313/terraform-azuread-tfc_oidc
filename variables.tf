variable "identity_name" {
  type        = string
  description = "(Required) Name of application and service principal."
}

variable "organization_name" {
  type        = string
  description = "(Required) Name of the HCP Terraform organization."
}

variable "workspaces" {
  type = list(object({
    workspace_name = string
    project_name   = string
    phases         = list(string)
  }))

  description = "(Required) A list of workspaces to create, where each workspace is a map with workspace_name, project_name, and a list of phases. The list can contain plan and apply."
}

variable "owner_id" {
  type        = string
  description = "(Optional) Object ID of owner to be assigned to service principal. Assigned to current user if not set."
  default     = null
}