resource "helm_release" "scylla_operator" {
  name = "scylla-operator"
  repository = "https://storage.googleapis.com/scylla-operator-charts"
  chart = "scylla-operator"
  version = "1.0.0"

  namespace = "scylla-operator"
  create_namespace = true

  set {
    name = "image.tag"
    value = "nightly"
  }

  depends_on = [helm_release.cert_manager]
}

resource "helm_release" "scylla" {
  name = "scylla"
  repository = "https://storage.googleapis.com/scylla-operator-charts"
  chart = "scylla"
  version = "1.0.0"

  namespace = "scylla"
  create_namespace = true

  values = [
    file("values/scylla.yaml")
  ]

  depends_on = [helm_release.scylla_operator, helm_release.local_volume_provisioner]
}
