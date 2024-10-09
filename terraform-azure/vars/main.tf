resource "azurerm_resource_group" "myrg2" {
  name     = "myrg2"
  location = var.location
  tags     = local.tags
}
# resource "azurerm_storage_account" "mysa1" {
#   name                            = "mysa"
#   resource_group_name             = azurerm_resource_group.myrg2.name
#   location                        = azurerm_resource_group.myrg2.location
#   account_tier                    = "Standard"
#   account_replication_type        = "LRS"
#   tags                            = local.tags
# }

resource "azurerm_key_vault" "kv1" {
  name                        = "kv1"
  location                    = var.location
  resource_group_name         = azurerm_resource_group.myrg2.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_subscription.current.tenant_id

  sku_name = "standard"

  #   network_acls {
  #   default_action = "Allow"
  #   bypass         = "AzureServices"
  # }
}

resource "azurerm_role_assignment" "rbac_role" {
  scope                = azurerm_key_vault.kv1.id
  role_definition_name = "Key Vault Administrator"  
  principal_id         = data.azuread_client_config.current.object_id 
}