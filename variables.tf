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

  default = null

  description = "(Required) A list of workspaces to create, where each workspace is a map with workspace_name, project_name, and a list of phases. The list can contain plan and apply."
}

variable "stacks" {
  type = list(object({
    stack_name      = string
    deployment_name = string
    project_name    = string
    operations      = list(string)
  }))

  default = null

  description = "(Required) A list of stacks to create, where each stack is a map with stack_name, deployment_name, project_name, and a list of operations. The list can contain plan and apply."
}

variable "owner_id" {
  type        = string
  description = "(Optional) Object ID of owner to be assigned to service principal. Assigned to current user if not set."
  default     = null
}