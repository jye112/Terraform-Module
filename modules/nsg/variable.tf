# Required
variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "location" {
  type        = string
  description = "location"
}

variable "nsg_name" {
  type        = string
  description = "NSG Name"
}

# Tags => source_address_prefix/destination_address_prefix
variable "rules" {
  type        = any
  description = "[name, priority, direction, access, protocol, ,source_address_prefix/es, source_port_range, destination_address_prefix/es, destination_port_range"
  default     = []
}

# true/false, subnet_id
variable "attach_to_subnet" {
  type        = list(any)
  description = "Are you attach this nsg to subnet? true or false"
  default     = []
}