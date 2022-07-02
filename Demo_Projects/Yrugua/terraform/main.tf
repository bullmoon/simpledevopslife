resource "kubernetes_namespace_v1" "yrugua" {
  metadata {
    name = "${var.ns-vol}"
  }
}
