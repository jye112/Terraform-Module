data "azurerm_resource_group" "linux_vm" {
  name = var.resource_group_name
}

resource "azurerm_availability_set" "linux_avset" {
  name                         = var.linux_avset
  location                     = coalesce(var.location, data.azurerm_resource_group.linux_vm.location)
  resource_group_name          = data.azurerm_resource_group.linux_vm.name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
}

resource "azurerm_network_interface" "linux_vm_nic" {
  count               = var.linux_vm_num
  name                = format("%s-%d-nic", var.linux_vm_name, count.index+1)
  resource_group_name = data.azurerm_resource_group.linux_vm.name
  location            = coalesce(var.location, data.azurerm_resource_group.linux_vm.location)

  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
   # public_ip_address_id          = var.public_ip_address_id
  }
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  count               = var.linux_vm_num
  name                = format("%s-%d", var.linux_vm_name, count.index+1)
  resource_group_name = data.azurerm_resource_group.linux_vm.name
  location            = coalesce(var.location, data.azurerm_resource_group.linux_vm.location)
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  availability_set_id = azurerm_availability_set.linux_avset.id
  network_interface_ids = [
    azurerm_network_interface.linux_vm_nic[count.index].id,
  ]

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_sku
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.os_tag
  }

  disable_password_authentication = false
  
  custom_data = var.custom_data == null ? null : var.custom_data
}
