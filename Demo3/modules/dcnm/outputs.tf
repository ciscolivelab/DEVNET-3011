output "new_networks" {
##Return gateway
 value = values(dcnm_network.net).*.ipv4_gateway
}

output "new_vlan"{
##Return vlan id
value = values(dcnm_network.net).*.attachments.vlan_id
}
