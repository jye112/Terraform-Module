data "azurerm_resource_group" "network" {
  name = var.resource_group_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.network.name
  location            = coalesce(var.location, data.azurerm_resource_group.network.location)

  address_space       = var.vnet_address_space
}

resource "azurerm_subnet" "subnet" {
  count                = var.subnet_num
  name                 = var.subnet_name[count.index]
  resource_group_name  = data.azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address_prefix[count.index]
}