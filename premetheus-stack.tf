provider "azurerm" {
  features {
  }
}

module "vn"{
    source = "modules/vn"
    location = var.locations
    resource_group_name = var.rgname
}

module "aks" {
  source = "modules/aks"
  location = var.location
  resource_group_name = var.rgname

}