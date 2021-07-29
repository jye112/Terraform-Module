output "linux_vm_private_ip" {
    value = azurerm_linux_virtual_machine.linux_vm[var.linux_vm_num.index].private_ip_address
}

output "linux_vm_public_ip" {
    value = azurerm_linux_virtual_machine.linux_vm[var.linux_vm_num.index].public_ip_address
}