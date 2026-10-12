resource "azurerm_postgresql_flexible_server" "psql" {
  for_each = var.postgresql
  name                   = each.value.psqlflexibleserver_name
  resource_group_name    = each.value.resource_group_name 
  location               = each.value.location
  version                       = "18"
  public_network_access_enabled = true
  administrator_login    = each.value.administrator_login 
  administrator_password = each.value.administrator_password 
  zone                          = "1"
  storage_tier = "P4"
  storage_mb   = 32768
  sku_name = "B_Standard_B1ms"
}

resource "azurerm_postgresql_flexible_server_database" "psqldb" {
for_each = var.postgresql
  name      = "axiondb"
  server_id = azurerm_postgresql_flexible_server.psql[each.key].id
  collation = "en_US.utf8"
  charset   = "UTF8"

  }