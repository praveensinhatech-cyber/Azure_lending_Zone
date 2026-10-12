data "azurerm_subnet" "snet" {
  for_each = var.nics
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_public_ip" "pip" {
  for_each = var.nics
  name                = each.value.public_ip
  resource_group_name = each.value.resource_group_name
}