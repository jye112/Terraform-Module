output "linux_vm_private_ip" {
    value = azurerm_linux_virtual_machine.linux_vm.*.private_ip_address
}

output "linux_vm_public_ip" {
    value = azurerm_linux_virtual_machine.linux_vm.*.public_ip_address
}

output "linux_vm_nic" {
    value = azurerm_linux_virtual_machine.linux_vm.*.network_interface_ids
}
