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

resource "intersight_workflow_workflow_info" "Workflow-VM" {
  name         = var.vm_workflowname
  pause_reason = null
  action       = "Start"
  for_each = { for index, vm in var.vm: vm.vm_name => vm}
  input = jsonencode({
     "vmname" = each.value["vm_name"]
     "CPUs" = each.value["vm_CPUs"]
     "Memory" = each.value["vm_memory"]
     "poweron" = each.value["vm_poweron"]
  })
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.myorg.id
  }
  workflow_definition {
    object_type = "workflow.WorkflowDefinition"
    moid        = var.vm_worflow_moid
}

}
