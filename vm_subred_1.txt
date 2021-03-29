# Template de VM linux

# VM 1
resource "azurerm_linux_virtual_machine" "subnet_1_vm_1" { # sustituye "<id_subnet>" con el número de la subred y "<numero_vm>" con el número de la vm en la subred
    count                 = 1
    name                  = var.subnet_1_vm_1 # sustituye "<id_subnet>" con el número de la subred y "<numero_vm>" con el número de la vm en la subred
    location              = var.region
    resource_group_name   = azurerm_resource_group.rg.name
    network_interface_ids = [element(azurerm_network_interface.subnet_1_vm_1.*.id, count.index)] # sustituye "<id_subnet>" con el número de la subred y "<numero_vm>" con el número de la vm en la subred
    size                  = lookup(var.vm_type,"micro") # los tamaños de vm pueden ser "micro", "small"

    os_disk {
        name                 = "${var.subnet_1_vm_1}-disco-${count.index + 1}" # sustituye "<id_subnet>" con el número de la subred y "<numero_vm>" con el número de la vm en la subred
        caching              = lookup(var.caching_mode,"readwrite") # los tipos de caching pueden ser "none", "readonly" o "readwrite"
        storage_account_type = lookup(var.storage_account_type,"standard") # los tipos de storage accounts pueden ser "standard", "standard_ssd" o "premium"
    }

    source_image_reference {
        publisher = lookup(var.publisher,"canonical")
        offer     = lookup(var.offer,"offer_canonical_20") # Para versión 20.04, si fuese versión 18.04 cambiaría a "offer_canonical_18"
        sku       = lookup(var.sku,"20.04-lts") # Para versión 20.04-lts, si fuese versión 18.04 cambiaría a "18.04-lts"
        version   = var.version_latest
    }

    computer_name                   = var.subnet_1_vm_1 # sustituye "<id_subnet>" con el número de la subred y "<numero_vm>" con el número de la vm en la subred
    admin_username                  = var.subnet_1_username # sustituye "<id_subnet>" con el número de la subred
    disable_password_authentication = true

    admin_ssh_key {
        username        = var.subnet_1_username 
        public_key      = file(var.key)
    }

    boot_diagnostics {
         storage_account_uri = azurerm_storage_account.almacenamiento.primary_blob_endpoint
    }

    tags = {
        environment = var.initiative
    }
}


#resource "azurerm_linux_virtual_machine" "subnet_1_vm_2" { # sustituye "<id_subnet>" con el número de la subred y "<numero_vm>" con el número de la vm en la subred
#    count                 = 1
#    name                  = var.subnet_1_vm_2 # sustituye "<id_subnet>" con el número de la subred y "<numero_vm>" con el número de la vm en la subred
#    location              = var.region
#    resource_group_name   = azurerm_resource_group.rg.name
#    network_interface_ids = [element(azurerm_network_interface.subnet_1_vm_2.*.id, count.index)] # sustituye "<id_subnet>" con el número de la subred y "<numero_vm>" con el número d>
#    size                  = lookup(var.vm_type,"micro") # los tamaños de vm pueden ser "micro", "small"

#    os_disk {
#        name                 = "${var.subnet_1_vm_2}-disco-${count.index + 1}" # sustituye "<id_subnet>" con el número de la subred y "<numero_vm>" con el número de la vm en la subr>
#        caching              = lookup(var.caching_mode,"readwrite") # los tipos de caching pueden ser "none", "readonly" o "readwrite"
#        storage_account_type = lookup(var.storage_account_type,"standard") # los tipos de storage accounts pueden ser "standard", "standard_ssd" o "premium"
#    }

#    source_image_reference {
#        publisher = lookup(var.publisher,"canonical")
#        offer     = lookup(var.offer,"offer_canonical_18") # Para versión 20.04, si fuese versión 18.04 cambiaría a "offer_canonical_18"
#        sku       = lookup(var.sku,"18.04-lts") # Para versión 20.04-lts, si fuese versión 18.04 cambiaría a "18.04-lts"
#        version   = var.version_latest
#    }

#    computer_name                   = var.subnet_1_vm_2 # sustituye "<id_subnet>" con el número de la subred y "<numero_vm>" con el número de la vm en la subred
#    admin_username                  = var.subnet_1_username # sustituye "<id_subnet>" con el número de la subred
#    disable_password_authentication = true

#    admin_ssh_key {
#        username        = var.subnet_1_username
#        public_key      = file(var.key)
#    }

#    boot_diagnostics {
#         storage_account_uri = azurerm_storage_account.almacenamiento.primary_blob_endpoint
#    }

#    tags = {
#        environment = var.initiative
#    }
#}                       
