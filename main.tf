terraform {
  required_version = ">= 0.12"
}

resource "azurerm_resource_group" "rg" {
    name     = "${var.initiative}-rg"
    location = var.region

    tags = {
        environment = var.initiative
    }
}
