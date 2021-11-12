# RG
variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
  default     = "test-rg"
}

variable "location" {
  type        = string
  description = "Location"
  default     = "koreacentral"
}


# VM
variable "vm_size" {
  type = string
  default = "Standard_D2s_v3"
}

variable "os_disk_sku" {
  type = string
  default = "Standard_LRS"
}

variable "os_tag" {
  type = string
  default = "latest"
}

variable "admin_username" {
  type    = string
  default = "adminuser"
}

variable "admin_password" {
  type    = string
  default = ""
}

