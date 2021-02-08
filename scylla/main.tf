provider "helm" {
  version = ">= 2.0.2"
  kubernetes {
    config_path = "../cluster/kube_config"
  }
}
