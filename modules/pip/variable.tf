# Required
variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "location" {
  type        = string
  description = "Location"
}

variable "pip_name" {
  type        = string
  description = "Public ip name"
}

variable "pip_allocation_method" {
  type        = string
  description = "Allocation Method"
}

variable "pip_sku" {
  type        = string
  description = "SKU"
}

variable "pip_av_zone" {
  type        = string
  description = "Public IP Availability Zone"
}
