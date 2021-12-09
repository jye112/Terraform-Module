data "azurerm_resource_group" "pip" {
  name = var.resource_group_name
}

resource "azurerm_public_ip" "pip" {
  count               = var.pip_num
  name                = format("%s-%d", var.pip_name, count.index+1)
  resource_group_name = data.azurerm_resource_group.pip.name
  location            = coalesce(var.location, data.azurerm_resource_group.pip.location)
  allocation_method   = var.pip_allocation_method
  sku                 = var.pip_sku
  availability_zone   = var.pip_av_zone  #Zone-Redundant, 1, 2, 3, and No-Zone Defaults to Zone-Redundant.
}
