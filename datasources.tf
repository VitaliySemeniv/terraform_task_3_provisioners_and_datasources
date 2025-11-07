data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name                = "default-vnet"
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_subnet" "subnet" {
  name                 = "default"
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.rg.name
}

data "azurerm_network_interface" "nic" {
  name                = "my-nic"
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_public_ip" "pip" {
  name                = "nginx-public-ip"
  resource_group_name = data.azurerm_resource_group.rg.name
}
