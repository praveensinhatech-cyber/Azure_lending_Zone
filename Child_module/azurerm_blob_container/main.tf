resource "azurerm_storage_container" "container" {
  for_each              = var.containers
  name                  = each.value.name
  storage_account_id    =data.azurerm_storage_account.existing_stg.id
  container_access_type = each.value.container_access_type
  
}