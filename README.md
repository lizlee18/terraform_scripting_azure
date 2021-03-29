# Repositorio para aprender Terraform haciendo despliegues en Azure

* Elaborado por Hugo Aquino
* Abril 2021

-----

## Clona el repositorio 

* Desde la VM ejecuta los siguientes comandos para clonar el repositorio:

````
   git clone https://github.com/HugoAquinoNavarrete/terraform_scripting_azure
   cd terraform_scripting_azure
````

-----

## Instalación de Terraform

* Desde la VM ejecuta los siguientes comandos para instalar `Terraform 13.5`:

````
   wget https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_linux_amd64.zip
   sudo apt install unzip
   unzip terraform_0.13.5_linux_amd64.zip
   sudo mv terraform /usr/local/bin/
   terraform --version 
````

-----

## Instalación de calculadora IP

* Desde la VM ejecuta `sudo apt install ipcalc` para instalar una calculadora IP.

-----

## Instalación Azure CLI

* Desde la VM ejecuta `curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash` para instalar `Azure CLI`.

-----

## Conexión a Azure

* Ejecuta `az login` para habilitar la conexión con Azure y sigue las indicaciones.
* Sigue las instrucciones del sitio `https://microsoft.com/devicelogin` e ingresar el código

-----

## Configuraciones previas en Azure

* Desde la línea de comando ejecuta el siguiente comando para listar las suscripciones:
`az account list --output table`
* Para cambiar la suscripción, ejecuta este comando:
`az account set --subscription "<id-suscripción>"`

-----

## Llaves SSH (para servidores Linux)

* En el directorio `keys` se encuentran las llaves de acceso.
* Para generar las llaves rsa pública/privada
````
   ssh-keygen
````
   Sálvala en el directorio `keys`, esto es: `<ruta_absoluta>/key`, deja vacío `passphrase`

   Cambia los permisos al archivo `chmod 400 key`

* Para conectarse por SSH a la máquina virtual
````
   ssh -v -l <usuario> -i key <ip_instancia_creada>
````

-----

## Archivo `azure.txt` que se terminará llamando `azure.tf` 

* Contiene información de la versión del provisionador utilizado para Azure.

-----

## Archivo `main.txt` que se terminará llamando `main.tf`

* Contiene información de la versión mínima requerida de Terraform así como el nombre del `resource group` creado.

-----

## Archivo `network.txt` que se terminará llamando `network.tf`

* Contiene información de la `virtual network` creada, así como la definición de las `subredes`.

````
resource "azurerm_subnet" "subnet_<id_subnet>" {
    name                 = var.subnet_<id_subnet>_name
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vn.name
    address_prefixes     = var.subnet_<id_subnet>_ipam
}
````

  Donde `<id_subnet>` es el número de la subred a ser creada. Además hay que agregar la definición de las variables `subnet_<id_subnet>_name` y `subnet_<id_subred>_ipam` en el archivo `variables.tf`.

-----

## Archivo `network_interface.txt` que se terminará llamando `network_interfaces.tf`

* Contiene información de las `interfaces de red` asociadas a cada `subred` e inclusive a cada `vm`.


````
resource "azurerm_network_interface" "subnet_<id_subnet>" {
    count                     = 1
    name                      = "${var.subnet_<id_subnet>_name}-interfaz-red-${count.index + 1}"
    location                  = var.region
    resource_group_name       = azurerm_resource_group.rg.name

    ip_configuration {
        name                          = "${var.subnet_<id_subnet>_name}-interfaz-configuracion-${count.index + 1}"
        subnet_id                     = azurerm_subnet.subnet_<id_subnet>.id
        private_ip_address_allocation = "Dynamic"
    }

    tags = {
         environment = var.initiative
    }
}
````

  Donde `<id_subnet>` es el número de la subred creada. Además hay que agregar la definición de las variables `subnet_<id_subnet>_name` y `subnet_<id_subnet>` en el archivo `variables.tf`.

* Cuando se asocie una `vm` a una `interfaz de red`:

````
resource "azurerm_network_interface" "subnet_<id_subnet>_vm_<numero_vm>" {
    count                     = 1
    name                      = "${var.subnet_<id_subnet>_vm_<numero_vm>}-interfaz-red-${count.index + 1}"
    location                  = var.region
    resource_group_name       = azurerm_resource_group.rg.name

    ip_configuration {
        name                          = "${var.subnet_<id_subnet>_vm_<numero_vm>}-interfaz-configuracion-${count.index + 1}"
        subnet_id                     = azurerm_subnet.subnet_<id_subnet>.id
        private_ip_address_allocation = "Dynamic"
    }

    tags = {
         environment = var.initiative
    }
}
````

  Donde `<id_subnet>` es el número de la subred creada y `<numero_vm>` es el número de la VM creada en la subred en cuestión. Además hay que agregar la definición de las variables `subnet_<id_subnet>_vm_<numero_vm>` y `subnet_<id_subnet>` en el archivo `variables.tf`.

-----

## Archivo `ip_publica.txt` que se terminará llamando `ip_publica.tf`

* Contiene información de la IP pública que será asignada a una VM.

-----

## Archivo `security.txt` que se terminará llamando `security.tf`

* Contiene información del `security group` creado, así como la asociación a las `subredes` creadas.
* El `security group` permite acceso a: SSH (TCP 22), HTTP (TCP 80), HTTPS (TCP 443) e ICMP.


````
resource "azurerm_network_interface_security_group_association" "security-group_asociacion_subnet_<id_subnet>" {
    count                     = 1
    network_interface_id      = element(azurerm_network_interface.subnet_<id_subnet>.*.id, count.index)
    network_security_group_id = azurerm_network_security_group.security-group.id
}
````

  Donde `<id_subnet>` es el número de la subred a ser creada.

-----

## Archivo `storage.txt` que se terminará llamando `storage.tf`

* Contiene información del `storage account` creado para diagnóstico en el proceso de `boot`.

-----

## Archivo `variables.txt` que terminará llamando `variables.tf`

* Contiene la definición de las variables utilizadas.

* Si hay que crear un nueva `subred` estas son las variables a ser consideradas:

````
variable subnet_<id_subnet>_name {
  description = "subnet name"
  default     = "<nombre_subnet>"
}
````

  Donde `<id_subnet>` es el número de la subred creada y `<nombre_subnet>` el nombre de la iniciativa que identifique a la subred.


````
variable subnet_<id_subnet>_ipam {
  description = "subnet cidr range"
  default     = ["10.<numero_participante>.<id_subnet>.0/24"]
}
````

  Donde `<id_subnet>` es el número de la subred creada.


````
variable subnet_<id_subnet>_key {
  description = "key"
  default     = "keys/key.pub"
}
````

* Si hay que crear un nueva `vm` estas es la variable a ser considerada (1 variable por cada vm):

````
variable subnet_<id_subnet>_vm_<numero_vm> {
  description = "vm name"
  default     = "<nombre_completo_vm>"
}
````

  Donde `<id_subnet>` es el número de la subred creada, `<numero_vm>` es el número de la VM en la subred y `<nombre_completo_vm>` el nombre de la vm.


````
variable subnet_<id_subnet>_username {
  description = "admin ssh username"
  default     = "<nombre_usuario_ssh>"
}
````

  Donde `<id_subnet>` es el número de la subred creada y `<nombre_usuario_ssh>` el nombre del usuario para acceso SSH.

````

## Archivo `vm_linux.txt`

* Contiene información de la definición de una `VM tipo Linux` y su contenido se irá agregando a los archivos `vm_subred_<id_subnet>.tf`, donde `<id_subnet>` es el número de la subred creada.

-----

## Archivos `vm_subred_<id_subnet>.txt` que se terminará llamando `vm_subred_<id_subnet>.tf`

* Contiene información de cada VM a ser creada en la subred en cuestión, donde `<id_subnet>` es el número de la subred creada.

-----

## Inicializar Terraform

* Ejecuta el siguiente comando para inicializar Terraform `terraform init`.

````
Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/azurerm versions matching "~> 2.4"...
- Installing hashicorp/azurerm v2.48.0...
- Installed hashicorp/azurerm v2.48.0 (signed by HashiCorp)

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

````

-----

## Despliega la infraestructura

* Ejecuta el siguiente comando para revisar la sintaxis y posibles errores `terraform plan`, de haber algún error, aparecerá en pantalla el nombre del archivo y la línea para revisar y corregir.
* Ejecuta el siguiente comando para desplegar la infraestructura `terraform apply`, de haber algún error, aparecerá en pantalla el nombre del archivo y la línea para revisar y corregir.
* De no presentarse ningún error, a la siguiente pregunta contestar con `yes`

````
Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value:

````

  El script tomará unos minutos en ejecutarse y verifica que los recursos hayan sido creados.

-----

## Elimina la infraestructura

* Ejecuta el siguiente comando para eliminar la infraestructura `terraform destroy`.
  De haber algún error, aparecerá en pantalla el nombre del archivo y la línea para revisar y corregir.
  De no presentarse ningún error, a la siguiente pregunta contestar con `yes`

````
Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value:

````

  El script tomará unos minutos en ejecutarse y verifica que los recursos hayan sido eliminados.

-----
