# Lista de variables a ser utilizadas

variable "region" {
  type        = string  
  description = "azure region"
  default     = "eastus" 
}

variable "initiative" {
  type        = string
  description = "initiative name"
  default     = "terraform-azure-lizlee"
}

variable "vm_type" {
  type        = map
  description = "vm size"
  default     = {
    "micro"   = "Standard_DS1_v2"
    "small"   = "Standard_DS2_v2"
  }
}

variable "publisher" {
  type          = map
  description   = "source image publisher"
  default       = {
    "canonical"       = "Canonical"
  }
}

variable "offer" {
  type          = map
  description   = "source image offer"
  default       = {
    "offer_canonical_18"    = "UbuntuServer"
    "offer_canonical_20"    = "0001-com-ubuntu-server-focal"
  }
}

variable "sku" {
  type          = map
  description   = "source image sku"
  default       = {
    "18.04-lts"       = "18.04-LTS"
    "20.04-lts"       = "20_04-LTS-Gen2"
  }
}

variable "version_latest" {
  type        = string
  description = "source image version"
  default     = "latest"
}

variable "account_tier" {
  type         = map
  description  = "storage account tier type"
  default      = {
    "standard" = "Standard"
    "premium"  = "Premium"
  }
}

variable "account_replication_tier" {
  type        = map
  description = "storage account replication tier type"
  default     = {
    "lrs"     = "LRS"
    "grs"     = "GRS"
    "ragrs"   = "RAGRS"
    "zrs"     = "ZRS"
    "gzrs"    = "GZRS"
    "ragzrs"  = "RAGZRS"
  }
}

variable storage_account_name {
  type        = string
  description = "storage account name"
  default     = "terraform-lizlee"
}

variable "storage_account_type" {
  type              = map
  description       = "storage account type"
  default           = {
    "standard"      = "Standard_LRS"
    "standard_ssd"  = "StandardSSD_LRS"
    "premium"       = "Premium_LRS"
  }
}

variable "caching_mode" {
  type          = map
  description   = "caching requirements for the data disk"
  default       = {
    "none"      = "None"
    "readonly"  = "ReadOnly"
    "readwrite" = "ReadWrite"
  }
}

variable vnet_name {
  description = "vnet id where the nodes will be deployed"
  default     = "terraform-scripting-azure-lizlee"
}

variable vnet_cidr {
  description = "the vnet cidr range"
  default     = ["10.8.0.0/16"]
}

variable subnet_1_name {
  description = "subnet name"
  default     = "lizlee-1"
}

variable subnet_1_ipam {
  description = "subnet cidr range"
  default     = ["10.8.1.0/24"]
}

variable key {
  description = "key"
  default     = "keys/key.pub"
}

variable subnet_1_username {
  description = "admin ssh username"
  default     = "azureuser"
}

variable subnet_1_vm_1 {
  description = "vm name"
  default     = "AZR-SANDBOX-lizlee-01"
}

variable subnet_1_vm_2 {
  description = "vm name"
  default     = "AZR-SANDBOX-lizlee-02"
}


