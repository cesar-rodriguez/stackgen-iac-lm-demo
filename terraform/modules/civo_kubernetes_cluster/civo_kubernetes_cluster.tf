resource "civo_kubernetes_cluster" "this" {
  firewall_id = var.firewall_id
  pools {
    node_count          = var.node_count
    size                = var.size
    label               = var.label
    labels              = var.labels
    public_ip_node_pool = var.public_ip_node_pool

    dynamic "taint" {
      for_each = var.taint

      content {
        key    = taint.value.key
        value  = taint.value.value
        effect = taint.value.effect
      }
    }
  }
  cluster_type     = var.cluster_type
  name             = var.name
  network_id       = var.network_id
  write_kubeconfig = var.write_kubeconfig
  cni              = var.cni
  applications     = var.applications
  tags             = var.tags
}

terraform {
  required_providers {
    civo = {
      source = "civo/civo"
    }
  }
}
