terraform {
cloud {
organization = "CL-CLUS"

workspaces {
  name = "DCNM-Intersight"
}
}
required_providers {
  dcnm = {
    source = "CiscoDevNet/dcnm"
  }
  intersight = {
      source  = "CiscoDevNet/intersight"
    }
}
}
provider "dcnm" {
  # cisco-dcnm/ndfc user name
  username = var.dcnm_username
  # cisco-dcnm/ndfc password
  password = var.dcnm_password
  # cisco-dcnm/ndfc url
  url      = var.dcnm_url
  insecure = true
  platform = "dcnm"
  }
provider "intersight" {
    # intersight api key
      apikey    = var.intersight_apikey
    # intersight secretkey
      secretkey = var.intersight_secretkey
    # intersight url
      endpoint  = var.intersight_url
    }
##DCNM local module##

module "dcnm" {
source = "./modules/dcnm"
vrf = var.vrf
network = var.network
fabric = var.fabric
switches = var.switches
}

##IST NEW ubuntu VM workflow module##

module "workflow-vm" {

source = "./modules/vm"
organization = var.organization
vm_workflowname = var.vm_workflowname
vm = var.vm
vm_worflow_moid = var.vm_worflow_moid
}

##IST webserver workflow module##

module "workflow-web" {

source = "./modules/web"
organization = var.organization
web_workflowname = var.web_workflowname
web_worflow_moid = var.web_worflow_moid
##Run this workflow only after vm workflow is finished
depends_on = [module.workflow-vm]
}
