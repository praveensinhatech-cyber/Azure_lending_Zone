resource "azurerm_network_security_group" "example" {
    for_each = var.nsgs
  name                = each.value.nsg_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# resource "azurerm_subnet_network_security_group_association" "example" {
#   subnet_id                 = data.azurerm_subnet.snet[each.key].id
#   network_security_group_id = azurerm_network_security_group.example.id
# }

resource "azurerm_subnet_network_security_group_association" "this" {
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.this.id
}
