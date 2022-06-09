terraform {
required_providers {
  intersight = {
      source  = "CiscoDevNet/intersight"
    }
}
}
data "intersight_organization_organization" "myorg" {
  name = var.organization
}
resource "intersight_workflow_workflow_info" "Workflow-web" {
  name         = var.web_workflowname
  pause_reason = null
  action       = "Start"

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.myorg.id
  }
  workflow_definition {
    object_type = "workflow.WorkflowDefinition"
    moid        = var.web_worflow_moid
}
}
