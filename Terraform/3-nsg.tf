resource "azurerm_network_security_group" "project-az-nsg01" {
  name                = "project-az-nsg01"
  location            = azurerm_resource_group.project-az-rg01.location
  resource_group_name = azurerm_resource_group.project-az-rg01.name
}

