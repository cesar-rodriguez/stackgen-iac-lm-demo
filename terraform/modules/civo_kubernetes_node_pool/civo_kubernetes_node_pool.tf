resource "civo_kubernetes_node_pool" "this" {
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

  cluster_id = var.cluster_id
}

terraform {
  required_providers {
    civo = {
      source = "civo/civo"
    }
  }
}
