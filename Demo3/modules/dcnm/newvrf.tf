terraform {
required_providers {
  dcnm = {
    source = "CiscoDevNet/dcnm"
  }
  }
  }
data "dcnm_inventory" "leaf" {
  for_each    = toset(var.switches)
  fabric_name = var.fabric
  switch_name = each.value
}
  resource "dcnm_vrf" "vrf" {
    for_each = { for index, vrf in var.vrf: vrf.vrf_name => vrf}
    ##use vrf name as index
    fabric_name = var.fabric
    name        = each.value["vrf_name"]
    vlan_name   = each.value["vrf_vlan_name"]
    segment_id = each.value["vrf_id"]
    deploy      = true
    dynamic "attachments" {
      for_each = [for l in data.dcnm_inventory.leaf : l.serial_number]
      content {
        serial_number = attachments.value
        attach        = true
      }
    }
  }

  resource "dcnm_network" "net" {
    for_each = { for index, network in var.network: network.network_name => network}
    ##use network_name as index  
    fabric_name  = var.fabric
    name         = each.value["network_name"]
    description  = each.value["network_description"]
    network_id   = each.value["network_id"]
    vlan_id      = each.value["vlan_id"]
    vrf_name     = each.value["network_vrf"]
    ipv4_gateway = each.value["network_ipv4_gw"]
    ipv6_gateway = each.value["network_ipv6_gw"]

    deploy = true
    dynamic "attachments" {
      for_each = [for l in data.dcnm_inventory.leaf : l.serial_number]
      content {
        serial_number = attachments.value
        attach        = true
        switch_ports  = each.value["network_int_grp"]
      }
    }
    depends_on = [
      dcnm_vrf.vrf
    ]
    }
