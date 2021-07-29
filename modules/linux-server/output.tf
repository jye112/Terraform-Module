output "linux_vm_private_ip" {
    count = var.linux_vm_num
    value = azurerm_linux_virtual_machine.linux_vm.private_ip_address[count.index]
}

output "linux_vm_public_ip" {
    count = var.linux_vm_num
    value = azurerm_linux_virtual_machine.linux_vm.public_ip_address[count.index]
}