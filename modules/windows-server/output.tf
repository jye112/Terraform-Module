output "windows_vm_private_ip" {
    value = azurerm_windows_virtual_machine.windows_vm[var.windows_vm_num.index].private_ip_address
}

output "windows_vm_public_ip" {
    value = azurerm_windows_virtual_machine.windows_vm[var.windows_vm_num.index].public_ip_address
}