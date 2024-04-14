output "kube_config_test" {
  value     = azurerm_kubernetes_cluster.aks_test.kube_config_raw
  sensitive = true
}

output "kube_config_prod" {
  value     = azurerm_kubernetes_cluster.aks_prod.kube_config_raw
  sensitive = true
}
