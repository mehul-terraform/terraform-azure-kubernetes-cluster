resource "azurerm_virtual_network" "project-az-vnet01" {
  name                = "project-az-vnet01"
  location            = azurerm_resource_group.project-az-rg01.location
  resource_group_name = azurerm_resource_group.project-az-rg01.name
  address_space       = ["192.168.0.0/16"]
  dns_servers         = ["8.8.8.8"]

  tags = {
    Name = "project-az-vnet01"
  }
}
resource "azurerm_subnet" "project-az-vm" {
  name                 = "project-az-vm"
  resource_group_name  = azurerm_resource_group.project-az-rg01.name
  virtual_network_name = azurerm_virtual_network.project-az-vnet01.name
  address_prefixes     = ["192.168.1.0/24"]
}
resource "azurerm_subnet" "project-az-webapp" {
  name                 = "project-az-webapp"
  resource_group_name  = azurerm_resource_group.project-az-rg01.name
  virtual_network_name = azurerm_virtual_network.project-az-vnet01.name
  address_prefixes     = ["192.168.2.0/24"]
}
resource "azurerm_subnet" "project-az-db" {
  name                 = "project-az-db"
  resource_group_name  = azurerm_resource_group.project-az-rg01.name
  virtual_network_name = azurerm_virtual_network.project-az-vnet01.name
  address_prefixes     = ["192.168.3.0/24"]
}
resource "azurerm_subnet" "project-az-storage" {
  name                 = "roject-az-storage"
  resource_group_name  = azurerm_resource_group.project-az-rg01.name
  virtual_network_name = azurerm_virtual_network.project-az-vnet01.name
  address_prefixes     = ["192.168.4.0/24"]
}
resource "azurerm_subnet" "project-az-aks" {
  name                 = "project-az-aks"
  resource_group_name  = azurerm_resource_group.project-az-rg01.name
  virtual_network_name = azurerm_virtual_network.project-az-vnet01.name
  address_prefixes     = ["192.168.5.0/24"]
}
resource "azurerm_subnet" "GatewaySubnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.project-az-rg01.name
  virtual_network_name = azurerm_virtual_network.project-az-vnet01.name
  address_prefixes     = ["192.168.255.0/24"]
}