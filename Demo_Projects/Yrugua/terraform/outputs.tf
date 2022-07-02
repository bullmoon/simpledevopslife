data "kubernetes_all_namespaces" "allns" {}
output "all-ns" {
  value = data.kubernetes_all_namespaces.allns.namespaces
}

output "cm_backend_data" {
    value = kubernetes_config_map_v1.backend.data
}

output "cm_proxy_data" {
    value = kubernetes_config_map_v1.proxy.data
}