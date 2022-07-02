resource "kubernetes_deployment_v1" "backend" {
  metadata {
    name = "yrapp"
    namespace = "${var.ns-vol}"
    labels = {
      app = "yrugapp"
    }
  }
  depends_on = [kubernetes_namespace_v1.yrugua]

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "yrugapp"
      }
    }

    template {
      metadata {
        labels = {
          app = "yrugapp"
        }
      }

      spec {
        container {
          image = "bulldrive/yrugua:dev"
          name  = "app"

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
          env_from {
            config_map_ref {
              name = kubernetes_config_map_v1.backend.metadata.0.name
            }
          }
          liveness_probe {
            http_get {
              path = "/"
              port = 9003

              http_header {
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}