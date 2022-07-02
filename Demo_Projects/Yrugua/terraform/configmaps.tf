resource "kubernetes_config_map_v1" "backend" {
  depends_on = [kubernetes_namespace_v1.yrugua]
  metadata {
    name = "appconf"
    namespace = "${var.ns-vol}"
  }
  data = {
    "VARYRUGUA" = "MY_ENVIRONMENT_VARIABLE"
  }
}

resource "kubernetes_config_map_v1" "proxy" {
  depends_on = [kubernetes_namespace_v1.yrugua]
  metadata {
    name = "proxyconf"
    namespace = "${var.ns-vol}"
  }
  data = {
    "default" = "${file("nginx.conf")}"
  }
}
