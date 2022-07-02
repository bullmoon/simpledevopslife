resource "kubernetes_service_v1" "backend" {
  metadata {
    name = "srv-back"
    namespace = "${var.ns-vol}"
  }
  depends_on = [kubernetes_deployment_v1.backend]
  spec {
    selector = {
      app = kubernetes_deployment_v1.backend.metadata.0.labels.app
    }
    session_affinity = "None"
    port {
      port        = 9003
      target_port = 9003
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_service_v1" "frontend" {
  metadata {
    name = "srv-front"
    namespace = "${var.ns-vol}"
  }
  depends_on = [kubernetes_deployment_v1.proxy]
  spec {
    selector = {
      dproxy = kubernetes_deployment_v1.proxy.metadata.0.labels.dproxy
    }
    session_affinity = "None"
    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}