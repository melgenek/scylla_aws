resource "helm_release" "cert_manager" {
  name = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart = "cert-manager"
  version = "1.1.0"

  namespace = "cert-manager"
  create_namespace = true

  set {
    name = "installCRDs"
    value = "true"
  }

  depends_on = [module.my-cluster]
}

resource "helm_release" "local_volume_provisioner" {
  name = "local-volume-provisioner"
  chart = "../helm/local-volume-provisioner"

  namespace = "local-volume-provisioner"
  create_namespace = true

  force_update = true
  cleanup_on_fail = true

  depends_on = [module.my-cluster]
}
