resource "civo_object_store" "this" {
  name          = var.name
  access_key_id = var.access_key_id
  max_size_gb   = var.max_size_gb
  region        = var.region
}

terraform {
  required_providers {
    civo = {
      source = "civo/civo"
    }
  }
}
