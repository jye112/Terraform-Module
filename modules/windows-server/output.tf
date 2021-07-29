output "windows_vm_private_ip" {
    count = var.windows_vm_num
    value = azurerm_windows_virtual_machine.windows_vm.private_ip_address[count.index]
}

output "windows_vm_public_ip" {
    count = var.windows_vm_num
    value = azurerm_windows_virtual_machine.windows_vm.public_ip_address[count.index]
}