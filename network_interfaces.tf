# Crea las interfaces de red para la subred 1
resource "azurerm_network_interface" "subnet_1" {
    count                     = 1
    name                      = "${var.subnet_1_name}-interfaz-red-${count.index + 1}"
    location                  = var.region
    resource_group_name       = azurerm_resource_group.rg.name

    ip_configuration {
        name                          = "${var.subnet_1_name}-interfaz-configuracion-${count.index + 1}"
        subnet_id                     = azurerm_subnet.subnet_1.id
        private_ip_address_allocation = "Dynamic"
    }

    tags = {
         environment = var.initiative
    }
}

resource "azurerm_network_interface" "subnet_2" {
    count                     = 1
    name                      = "${var.subnet_2_name}-interfaz-red-${count.index + 1}"
    location                  = var.region
    resource_group_name       = azurerm_resource_group.rg.name

    ip_configuration {
        name                          = "${var.subnet_2_name}-interfaz-configuracion-${count.index + 1}"
        subnet_id                     = azurerm_subnet.subnet_2.id
        private_ip_address_allocation = "Dynamic"
    }

    tags = {
         environment = var.initiative
    }
}


resource "azurerm_network_interface" "subnet_3" {
    count                     = 1
    name                      = "${var.subnet_3_name}-interfaz-red-${count.index + 1}"
    location                  = var.region
    resource_group_name       = azurerm_resource_group.rg.name

    ip_configuration {
        name                          = "${var.subnet_3_name}-interfaz-configuracion-${count.index + 1}"
        subnet_id                     = azurerm_subnet.subnet_3.id
        private_ip_address_allocation = "Dynamic"
    }

    tags = {
         environment = var.initiative
    }
}


resource "azurerm_network_interface" "subnet_4" {
    count                     = 1
    name                      = "${var.subnet_4_name}-interfaz-red-${count.index + 1}"
    location                  = var.region
    resource_group_name       = azurerm_resource_group.rg.name

    ip_configuration {
        name                          = "${var.subnet_4_name}-interfaz-configuracion-${count.index + 1}"
        subnet_id                     = azurerm_subnet.subnet_4.id
        private_ip_address_allocation = "Dynamic"
    }

    tags = {
         environment = var.initiative
    }
}

resource "azurerm_network_interface" "subnet_1_vm_1" {
    count                     = 1
    name                      = "${var.subnet_1_vm_1}-interfaz-red-${count.index + 1}"
    location                  = var.region
    resource_group_name       = azurerm_resource_group.rg.name

    ip_configuration {
        name                          = "${var.subnet_1_vm_1}-interfaz-configuracion-${count.index + 1}"
        subnet_id                     = azurerm_subnet.subnet_1.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = element(azurerm_public_ip.ip_publica.*.id, count.index)
    }

    tags = {
         environment = var.initiative
    }
}

resource "azurerm_network_interface" "subnet_1_vm_2" {
    count                     = 1
    name                      = "${var.subnet_1_vm_2}-interfaz-red-${count.index + 1}"
    location                  = var.region
    resource_group_name       = azurerm_resource_group.rg.name

    ip_configuration {
        name                          = "${var.subnet_1_vm_2}-interfaz-configuracion-${count.index + 1}"
        subnet_id                     = azurerm_subnet.subnet_1.id
        private_ip_address_allocation = "Dynamic"
    }

    tags = {
         environment = var.initiative
    }
}

