module "rgroup-n01517377" {
  source = "./modules/rgroup-n01517377"

   resource_group_name = var.resource_group_name
   location = var.location 

   common_tags = local.common_tags

}

module "network-n01517377" {
  source = "./modules/network-n01517377"
  
  resource_group_name = module.rgroup-n01517377.resource_group_name
  location = module.rgroup-n01517377.location
  
  vnet_name = var.vnet_name
  subnet_name = var.subnet_name
  nsg_name = var.nsg_name

  common_tags = local.common_tags
}

module "common-n01517377" {
  source = "./modules/common-n01517377"
  
  resource_group_name = module.rgroup-n01517377.resource_group_name
  location = module.rgroup-n01517377.location

  common_tags = local.common_tags
}

module "vmlinux-n01517377" {
  source = "./modules/vmlinux-n01517377"
  
  resource_group_name = module.rgroup-n01517377.resource_group_name
  location = module.rgroup-n01517377.location
  
  subnet_id =  module.network-n01517377.subnet_id
  storage_account_uri = module.common-n01517377.storage_account-primary_blob_endpoint
  
  common_tags = local.common_tags
}

module "vmwindows-n01517377" {
  source = "./modules/vmwindows-n01517377"
  
  resource_group_name = module.rgroup-n01517377.resource_group_name
  location = module.rgroup-n01517377.location
  
  subnet_id =  module.network-n01517377.subnet_id
  storage_account_uri = module.common-n01517377.storage_account-primary_blob_endpoint
  
  common_tags = local.common_tags
}

module "datadisk-n01517377" {
  source = "./modules/datadisk-n01517377"
  
  resource_group_name = module.rgroup-n01517377.resource_group_name
  location = module.rgroup-n01517377.location

  linux_vm_ids        = module.vmlinux-n01517377.vmlinux.ids 
  windows_vm_ids      = module.vmwindows-n01517377.windows.ids
  
  all_vm_ids = concat(module.vmlinux-n01517377.vmlinux.ids, module.vmwindows-n01517377.windows.ids) 
  common_tags = local.common_tags
}

module "loadbalancer-n01517377" {
  source              = "./modules/loadbalancer-n01517377"
  
  resource_group_name = module.rgroup-n01517377.resource_group_name
  location = module.rgroup-n01517377.location
 
  linux_vm_nic_ids	      =	module.vmlinux-n01517377.vmlinux-nic-ids
  linux_vm_name           = module.vmlinux-n01517377.vmlinux.hostnames
  common_tags = local.common_tags
}

module "database-n01517377" {
  source                       = "./modules/database-n01517377"
  
  resource_group_name = module.rgroup-n01517377.resource_group_name
  location = module.rgroup-n01517377.location

  common_tags = local.common_tags
}
