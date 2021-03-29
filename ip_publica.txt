# Crea 1 IP pública
resource "azurerm_public_ip" "ip_publica" {
    count                        = 1
    name                         = "${var.initiative}-ip-publica-${count.index + 1}"
    location                     = var.region
    resource_group_name          = azurerm_resource_group.rg.name
    allocation_method            = "Dynamic"

    tags = {
        environment = var.initiative
    }
}

