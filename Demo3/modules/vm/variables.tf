variable "organization" {
description = "intersight organization name"
type = string
}
variable "vm_workflowname" {
description = "intersight workflow name"
type = string
}
variable "vm" {
description = "inputs for new VM"
type = list(object({
vm_name = string
vm_CPUs = number
vm_memory = number
vm_poweron = bool
}))
}
variable "vm_worflow_moid"{
description = "intersight workflow moid"
type = string
}
