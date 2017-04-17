resource "kubernetes_namespace" "cicd" {
  metadata {
    name = "cicd"
    labels {
      env = "${var.environment}"
    }
  }
}
