resource "azurerm_subnet" "subnet1" {
  name                 = "mysubnet1"
  resource_group_name  = data.azurerm_resource_group.myrg.name
  virtual_network_name = data.azurerm_virtual_network.myvnet.name
  address_prefixes     = ["10.0.0.0/28"]
}

# resource "azurerm_subnet" "subnet2" {
#   name                 = "mysubnet2"
#   resource_group_name  = data.azurerm_resource_group.myrg.name
#   virtual_network_name = data.azurerm_virtual_network.myvnet.name
#   address_prefixes     = ["10.0.0.16/28"]
# }

# resource "azurerm_network_security_group" "NSG1" {
#   name                = "TestNSG1"
#   location            = data.azurerm_resource_group.myrg.location
#   resource_group_name = data.azurerm_resource_group.myrg.name
#   security_rule {
#     name                       = "TestRule1"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "443"
#     source_address_prefix      = "192.168.0.0/16"
#     destination_address_prefix = "10.0.0.0/28"
#   }
# }

# resource "azurerm_subnet_network_security_group_association" "mynsg1" {
#   subnet_id                 = azurerm_subnet.subnet1.id
#   network_security_group_id = azurerm_network_security_group.NSG1.id
# }

resource "azurerm_route_table" "rt" {
  for_each = var.route_tables

  name                = each.key
  location            = var.location
  resource_group_name = data.azurerm_resource_group.myrg.name
  tags                = local.tags_re

  route = each.value.route
}

# NSG required for subnets module
resource "azurerm_network_security_group" "nsg" {
  for_each = var.network_security_groups

  name                = each.key
  location            = var.location
  resource_group_name = data.azurerm_resource_group.myrg.name
  tags                = local.tags_re

  security_rule = each.value.network_security_rules
}
