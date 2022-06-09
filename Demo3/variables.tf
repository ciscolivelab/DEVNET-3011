variable "dcnm_username" {
  type        = string
}
variable "dcnm_password" {
  type        = string
}
variable "dcnm_url" {
  type        = string
}
variable "intersight_apikey" {
  type        = string
}
variable "intersight_secretkey" {
  type        = string
}
variable "intersight_url" {
  type        = string
}

variable "vrf" {
type = list(object({
vrf_name = string
vrf_vlan_name = string
vrf_id = string
}))
}
variable "network" {
type = list(object({
network_name = string
network_description = string
network_id = string
vlan_id = string
network_vrf = string
network_ipv4_gw = string
network_ipv6_gw = string
network_int_grp = list(any)
}))
}
variable "fabric" {
  description = "fabric name"
  type        = string
}
variable "switches" {
  type = list
}


variable "organization" {
description = "intersight organization name"
type = string
}
variable "vm_workflowname" {
description = "intersight workflow name"
type = string
}
variable "web_workflowname" {
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
variable "web_worflow_moid"{
description = "intersight workflow moid"
type = string
}
