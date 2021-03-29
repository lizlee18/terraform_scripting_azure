# Crea una cuenta de almacenamiento para diagnóstico en boot
resource "azurerm_storage_account" "almacenamiento" {
    name                        = var.storage_account_name
    resource_group_name         = azurerm_resource_group.rg.name
    location                    = var.region
    account_tier                = lookup(var.account_tier,"standard")
    account_replication_type    = lookup(var.account_replication_tier,"lrs")

    tags = {
        environment = var.initiative
    }
}
