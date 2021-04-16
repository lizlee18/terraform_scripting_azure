# Crea red virtual
resource "azurerm_virtual_network" "vn" {
    name                = var.vnet_name
    address_space       = var.vnet_cidr
    location            = var.region
    resource_group_name = azurerm_resource_group.rg.name

    tags = {
        environment = var.initiative
    }
}

resource "azurerm_subnet" "subnet_1" {
    name                 = var.subnet_1_name
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vn.name
    address_prefixes     = var.subnet_1_ipam
}

resource "azurerm_subnet" "subnet_2" {
    name                 = var.subnet_2_name
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vn.name
    address_prefixes     = var.subnet_2_ipam
}

resource "azurerm_subnet" "subnet_3" {
    name                 = var.subnet_3_name
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vn.name
    address_prefixes     = var.subnet_3_ipam
}

resource "azurerm_subnet" "subnet_4" {
    name                 = var.subnet_4_name
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vn.name
    address_prefixes     = var.subnet_4_ipam
}
