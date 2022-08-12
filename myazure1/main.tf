provider "azurerm" {
features {}
}

resource "azurerm_resource_group" "test1" {
  name = "accenturetraining"
  location = "West US 2"
}

resource "azurerm_virtual_network" "test1" {
   name                = "acctvn"
   address_space       = ["11.0.0.0/16"]
   location            = azurerm_resource_group.test1.location
   resource_group_name = azurerm_resource_group.test1.name
}

 resource "azurerm_subnet" "test1" {
   name                 = "acctsub"
   resource_group_name  = azurerm_resource_group.test1.name
   virtual_network_name = azurerm_virtual_network.test1.name
   address_prefixes     = ["11.0.2.0/24"]
 }

