# Crea Security Group
resource "azurerm_network_security_group" "security-group" {
    name                = "${var.initiative}-sg"
    location            = var.region
    resource_group_name = azurerm_resource_group.rg.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "HTTP"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "HTTPS"
        priority                   = 1003
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "ICMP"
        priority                   = 1005
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Icmp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = var.initiative
    }
}


resource "azurerm_network_interface_security_group_association" "security-group_asociacion_subnet_1" {
    count                     = 1
    network_interface_id      = element(azurerm_network_interface.subnet_1.*.id, count.index)
    network_security_group_id = azurerm_network_security_group.security-group.id
}

resource "azurerm_network_interface_security_group_association" "security-group_asociacion_subnet_2" {
    count                     = 1
    network_interface_id      = element(azurerm_network_interface.subnet_2.*.id, count.index)
    network_security_group_id = azurerm_network_security_group.security-group.id
}

resource "azurerm_network_interface_security_group_association" "security-group_asociacion_subnet_3" {
    count                     = 1
    network_interface_id      = element(azurerm_network_interface.subnet_3.*.id, count.index)
    network_security_group_id = azurerm_network_security_group.security-group.id
}

resource "azurerm_network_interface_security_group_association" "security-group_asociacion_subnet_4" {
    count                     = 1
    network_interface_id      = element(azurerm_network_interface.subnet_4.*.id, count.index)
    network_security_group_id = azurerm_network_security_group.security-group.id
}

