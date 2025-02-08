terraform {
  required_providers {
    civo = {
      source = "civo/civo"
    }
  }
}

provider "civo" {
  region = var.region
}

variable "region" {
  description = "Civo region in which the project needs to be setup (LON1, etc)"
}