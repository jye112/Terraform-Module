# Required
variable "resource_group_name" {
  type        = string
  description = "rg name"
}

variable "location" {
  type        = string
  description = "location"
}

# Appgw 
variable "appgw_name" {
    type = string
    description = "appgw name"
}

variable "sku_name" {
    type = string
    description = "appgw sku name"
}

variable "sku_tier" {
    type = string 
    description = "appgw sku tier"
}

variable "gateway_ip_configuration_name" {
    type = string
    description = "appgw gateway"
}

variable "http_frontend_port_name" {
    type = string
    description = "appgw http frontend port name"
}

variable "http_frontend_port" {
    type = number
    description = "appgw http frontend port"
}

variable "frontend_ip_configuration_name" {
    type = string
    description = "appgw frontned ip configuration name"
}

variable "backend_address_pool" {
    type = string
    description = "appgw backend address pool"
}

variable "backend_http_setting_name" {
    type = string
    description = "appgw backend http setting name"
}

variable "backend_http_setting_port" {
    type = number
    description = "appgw backend http setting port"
}

variable "backend_http_setting_protocol" {
    type = string
    description = "appgw backend http setting protocol"
}

variable "http_listener_name" {
    type = string
    description = "appgw http listener name"
}

variable "http_listener_protocol" {
    type = string
    description = "appgw http listener protocol"
}

variable "http_request_routing_rule_name" {
    type = string
    description = "appgw http request routing rule name"
}

variable "http_request_routing_rule_type" {
    type = string
    description = "appgw http request routing rule type"
}

variable "ssl_certificate" {
    type = string
    description = "appgw ssl certificate"
}
