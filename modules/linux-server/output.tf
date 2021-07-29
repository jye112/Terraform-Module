output "linux_vm_private_ip" {
    value = azurerm_linux_virtual_machine.linux_vm[count.index].private_ip_address
}

output "linux_vm_public_ip" {
    value = azurerm_linux_virtual_machine.linux_vm[count.index].public_ip_address
}