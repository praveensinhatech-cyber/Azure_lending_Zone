module "resource_group" {
  source = "../../Child_module/azurerm_resource_group"
  rgs    = var.rgs

}

module "storage_account" {
  source     = "../../Child_module/azurerm_storage_account"
  storages   = var.storages
  depends_on = [module.resource_group]

}

module "blob_container" {
  source     = "../../Child_module/azurerm_blob_container" # Path to blob container module
  containers = var.containers
  depends_on = [module.storage_account]
}

module "virtual_network" {
  depends_on = [module.resource_group]
  source     = "../../Child_module/azurerm_virtual_network"
  vnets      = var.vnets

}

module "subnet" {
  depends_on = [module.resource_group, module.virtual_network]
  source     = "../../Child_module/azurerm_subnet"
  snets      = var.snets

}

module "public_ip" {
  depends_on = [module.resource_group]
  source     = "../../Child_module/azurerm_public_ip"
  pips       = var.pips

}

module "network_interface" {
  source     = "../../Child_module/azurerm_network_interface_card"
  nics       = var.nics
  depends_on = [module.resource_group, module.subnet, module.public_ip]
}

# module "network_security_group" {
#   source     = "../../Child_module/azurerm_nsg"
#   nsgs       = var.nsgs
#   depends_on = [module.resource_group, module.subnet]
# }

module "linux_virtual_machine" {
  depends_on = [module.resource_group, module.network_interface]
  source     = "../../Child_module/azurerm_linux_virtual_machine"
  vms        = var.vms

}

module "azurerm_postgresql_flexible_server" {
  depends_on = [module.resource_group]
  source     = "../../Child_module/azurerm_postgresql_flexible_server"
  postgresql = var.postgresql


}