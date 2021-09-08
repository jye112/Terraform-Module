data "azurerm_resource_group" "appgw" {
  name = var.resource_group_name
}

# Appgw
resource "azurerm_application_gateway" "appgw" {
  name                = var.appgw_name
  resource_group_name = data.azurerm_resource_group.appgw.name
  location            = coalesce(var.location, data.azurerm_resource_group.appgw.location)

  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    capacity = 0
  }

  autoscale_configuration {
    max_capacity = 10
    min_capacity = 0
  }

  gateway_ip_configuration {
    name      = var.gateway_ip_configuration_name
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = var.http_frontend_port_name
    port = var.http_frontend_port
  }

  frontend_ip_configuration {
    name                 = var.frontend_ip_configuration_name
    public_ip_address_id = var.appgw_pip_id
  }

  backend_address_pool {
    name = var.backend_address_pool_name
  }

  backend_http_settings {
    name                  = var.backend_http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = ""
    port                  = var.backend_http_setting_port
    protocol              = var.backend_http_setting_protocol
    request_timeout       = 20
  }

  http_listener {
    name                           = var.http_listener_name
    frontend_ip_configuration_name = var.frontend_ip_configuration_name
    frontend_port_name             = var.http_frontend_port_name
    protocol                       = var.http_listener_protocol
  }

  request_routing_rule {
    name                       = var.http_request_routing_rule_name
    rule_type                  = var.http_request_routing_rule_type
    http_listener_name         = var.http_listener_name
    backend_address_pool_name  = var.backend_address_pool_name
    backend_http_settings_name = var.backend_http_setting_name
  }
  
  # ssl_certificate {
  #   name                = var.ssl_certificate_name
  #   data                = ""
  # }
}


resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "appgw_backend" {
 count                   = var.backend_vm_num
 network_interface_id    = var.backend_vm_nic_id[count.index]
 ip_configuration_name   = "ipconfig1"
 backend_address_pool_id = azurerm_application_gateway.appgw.backend_address_pool[count.index].id
}

