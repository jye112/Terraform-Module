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

variable "admin_username" {
  type    = string
  default = "adminuser"
}

variable "admin_password" {
  type    = string
  default = ""
}

