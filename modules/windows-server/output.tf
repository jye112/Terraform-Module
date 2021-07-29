output "windows_vm_private_ip" {
    value = azurerm_windows_virtual_machine.windows_vm[count.index].private_ip_address
}

output "windows_vm_public_ip" {
    value = azurerm_windows_virtual_machine.windows_vm[count.index].public_ip_address
}