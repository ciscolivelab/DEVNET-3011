variable "vrf" {
description = "list of vrf"
type = list(object({
vrf_name = string
vrf_vlan_name = string
vrf_id = string
}))
}
variable "network" {
description = "list of network"
type = list(object({
network_name = string
network_description = string
network_id = string
network_vrf = string
vlan_id = string
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
