terraform {
  required_providers {
    dcnm = {
      source = "CiscoDevNet/dcnm"
    }
  }
}

#configure provider with your cisco dcnm/ndfc credentials.
provider "dcnm" {
  # cisco-dcnm/ndfc user name
  username = "admin"
  # cisco-dcnm/ndfc password
  password = "C1sco12345"
  # cisco-dcnm/ndfc url
  url      = "https://198.18.134.200"
  insecure = true
  platform = "dcnm"
}

variable "switches" {
  type = list
  default = [
  "Leaf-2",
  "Leaf-3"
  ]
}
data "dcnm_inventory" "leaf" {
  for_each    = toset(var.switches)
  fabric_name = "myFabric"
  switch_name = each.value
}

resource "dcnm_vrf" "terraform" {
  fabric_name = var.fabric
  name        = "terraform"
  vlan_name   = "terraform"
  deploy      = true
  dynamic "attachments" {
    for_each = [for l in data.dcnm_inventory.leaf : l.serial_number]
    content {
      serial_number = attachments.value
      attach        = true
    }
  }
}

resource "dcnm_network" "terraform" {
  fabric_name  = var.fabric
  name         = "network_terraform"
  description  = "create from terraform"
  vrf_name     = "terraform"
  ipv4_gateway = "10.10.1.1/24"
  ipv6_gateway = "2021:10:10:1::1/64"

  deploy = true
  dynamic "attachments" {
    for_each = [for l in data.dcnm_inventory.leaf : l.serial_number]
    content {
      serial_number = attachments.value
      attach        = true
      switch_ports  = var.int_grp
    }
  }
  depends_on = [
    dcnm_vrf.terraform
  ]
}
