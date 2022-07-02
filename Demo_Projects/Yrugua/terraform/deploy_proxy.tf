resource "kubernetes_deployment_v1" "proxy" {
  metadata {
    name = "yrproxy"
    namespace = "${var.ns-vol}"
    labels = {
      dproxy = "yrugapp"
    }
  }
  depends_on = [kubernetes_config_map_v1.proxy]

  spec {
    replicas = 1

    selector {
      match_labels = {
        dproxy = "yrugapp"
      }
    }

    template {
      metadata {
        labels = {
          dproxy = "yrugapp"
        }
      }

      spec {
        container {
          image = "lerenn/nginx-reverse-proxy"
          name  = "nginx"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
          volume_mount {
            name = "proxyconf"
            mount_path = "/etc/nginx/sites-available"
          }
        }
        restart_policy = "Always"
        volume {
          name = "proxyconf"
          config_map {
            name= kubernetes_config_map_v1.proxy.metadata.0.name
          }
        }
      }
    }
  }
}