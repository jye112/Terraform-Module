output "client_key" {
  value = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_key
  sentsitive = true
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_certificate
  sentsitive = true
}

output "cluster_ca_certificate" {
  value = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.cluster_ca_certificate
}

output "cluster_username" {
  value = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.username
}

output "cluster_password" {
  value = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.password
  sentsitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
  sentsitive = true
}

output "host" {
  value = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.host
}
