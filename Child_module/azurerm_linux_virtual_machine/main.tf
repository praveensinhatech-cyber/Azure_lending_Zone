
resource "azurerm_network_security_group" "nsg" {
    for_each = var.vms
  name                = each.value.nsg_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  security_rule {
    name                       = "Allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range    = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource  "azurerm_network_interface_security_group_association" "nsg-association" {
  for_each = var.vms
  network_interface_id      = data.azurerm_network_interface.nic[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}





resource "azurerm_linux_virtual_machine" "vm" {
    for_each = var.vms
  name                = each.value.vm_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = each.value.size

  admin_username = each.value.admin_username
  admin_password = each.value.admin_password

  network_interface_ids = [data.azurerm_network_interface.nic[each.key].id]

  disable_password_authentication = false

  
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
}