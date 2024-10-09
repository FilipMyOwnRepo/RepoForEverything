data "azurerm_resource_group" "myrg" {
  name = "myrg"
}
data "azurerm_virtual_network" "myvnet" {
  name                = "myvnet"
  resource_group_name = data.azurerm_resource_group.myrg.name
}

data "azurerm_resource_group" "rgnet" {
  name = "myrg"
}

data "azuread_client_config" "current" {}

data "azurerm_subscription" "current" {}

data "azurerm_subnet" "subnet2" {
  name                 = "mysubnet"
  resource_group_name  = data.azurerm_resource_group.myrg.name
  virtual_network_name = data.azurerm_virtual_network.myvnet.name
}