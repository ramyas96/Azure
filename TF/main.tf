terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features = {}
}

resource "azurerm_virtual_network" "vnet" {
  name                = "ramya-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "East US"
  resource_group_name = "ramyarg"
}

resource "azurerm_subnet" "subnet" {
  name                 = "ramya-subnet"
  resource_group_name  = "ramyarg"
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "nic" {
  name                = "ramya-nic"
  location            = "East US"
  resource_group_name = "ramyarg"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "ramya-vm"
  resource_group_name   = "ramyarg"
  location              = "East US"
  size                  = "Standard_B1s"
  admin_username        = "azureuser"
  network_interface_ids = [azurerm_network_interface.nic.id]

  admin_password        = "P@ssword1234!"  # for demo only, not production-safe
  disable_password_authentication = false

  os_disk {
    name              = "ramya-osdisk"
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "20_04-lts"
    version   = "latest"
  }
}

resource "azurerm_storage_account" "storage" {
  name                     = "ramyastorageacct"
  resource_group_name      = "ramyarg"
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
