resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Network
module "network" {
  source                = "../modules/network"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = var.location
  vnet_name             = "test-vnet"
  vnet_address_space    = ["10.0.0.0/16"]
  subnet_name           = "test-subnet-01"
  subnet_address_prefix = ["10.0.0.0/24"]

  depends_on = [
    azurerm_resource_group.rg
  ]
}

# NSG
module "nsg" {
  source              = "../modules/nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  nsg_name            = "test-nsg"

  rules = [
    {
      name                       = "SSH"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_address_prefix      = "211.215.58.26"
      source_port_range          = "*"
      destination_address_prefix = "*"
      destination_port_range     = "22"
    },
    {
      name                       = "RDP"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_address_prefix      = "211.215.58.26"
      source_port_range          = "*"
      destination_address_prefix = "*"
      destination_port_range     = "3389"
    },
    {
      name                       = "HTTP"
      priority                   = 120
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_address_prefix      = "Internet"
      source_port_range          = "*"
      destination_address_prefix = "*"
      destination_port_range     = "80,8080"
    },

  ]

  # if you want attach nsg to subnet, set true and subnet_id
  # if you don't want attach nsg to subnet, set false alone
  attach_to_subnet = [true, module.network.subnet_id]
  depends_on = [
    azurerm_resource_group.rg
  ]
}

module "linux_public_ip" {
  source                = "../modules/pip"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = var.location
  pip_name              = "linux-vm-pip"
  pip_allocation_method = var.allocation_method

  depends_on = [
    azurerm_resource_group.rg
  ]
}

module "window_public_ip" {
  source                = "../modules/pip"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = var.location
  pip_name              = "windows-vm-pip"
  pip_allocation_method = var.allocation_method

  depends_on = [
    azurerm_resource_group.rg
  ]
}

module "linux" {
  source               = "../modules/linux-server"
  resource_group_name  = azurerm_resource_group.rg.name
  location             = var.location
  linux_vm_num         = 2
  linux_vm_name        = "test-linux-vm"
  vm_size              = var.vm_size
  admin_username       = var.admin_username
  admin_password       = var.admin_password
  os_disk_sku          = var.os_disk_sku
  publisher            = "Canonical"
  offer                = "UbuntuServer"
  sku                  = "18.04-LTS"
  os_tag               = var.os_tag
  subnet_id            = module.network.subnet_id
  #public_ip_address_id = module.linux_public_ip.public_ip_address_id
  depends_on = [
    azurerm_resource_group.rg
  ]
}

module "window" {
  source               = "../modules/windows-server"
  resource_group_name  = azurerm_resource_group.rg.name
  location             = var.location
  windows_vm_num       = 2
  windows_vm_name      = "test-win-vm"
  vm_size              = var.vm_size
  admin_username       = var.admin_username
  admin_password       = var.admin_password
  os_disk_sku          = var.os_disk_sku
  publisher            = "MicrosoftWindowsServer"
  offer                = "WindowsServer"
  sku                  = "2019-Datacenter"
  os_tag               = var.os_tag
  subnet_id            = module.network.subnet_id
  #public_ip_address_id = module.window_public_ip.public_ip_address_id
  depends_on = [
    azurerm_resource_group.rg
  ]
}