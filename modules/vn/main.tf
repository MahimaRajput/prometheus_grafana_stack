provider "azurerm" {
  features {
  }
}

resource "azurerm_resource_group" "virtualrg" {
  name = var.virtualnetrg
  location = var.location
}

resource "azurerm_virtual_network" "virtualnetwork" {
  name = var.virtualnetworkname
  location = var.location
  resource_group_name = var.virtualnetrg
  address_space = [ "0.0.0.0/16" ]
  depends_on = [ azurerm_resource_group.virtualrg ]
}

resource "azurerm_subnet" "subnet" {
  name = var.subnet
  resource_group_name = var.virtualnetrg
  virtual_network_name = var.virtualnetworkname
  address_prefixes = [ "0.0.1.0/24" ]
  depends_on = [ azurerm_virtual_network.virtualnetwork ]
}

