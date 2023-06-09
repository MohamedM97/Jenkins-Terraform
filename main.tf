terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.59.0"
    }
  }
}

provider "azurerm" {
  # Configuration options

subscription_id = "393e3de3-0900-4b72-8f1b-fb3b1d6b97f1"
tenant_id = "77349d3b2-951f-41be-877e-d8ccd9f3e73c"
client_id = "cdd19e91-9b82-4a0b-8949-c70dd5e81328"
client_secret = "k9L8Q~j8i2V2wQvnSBrhHUgLsrbwinqJ1aaXkca_"
}

##Resource Group
resource "azurerm_resource_group" "rg" {
name = "Terraform-mm"
location = "france central"
}

##Avaibility Set
resource "azurerm_availability_set" "setMM" {
name = "setMM"
location = azurerm_resource_group.rg.location
resource_group_name = azurerm_resource_group.rg.name
}

##Virtual Network
resource "azurerm_virtual_network" "vnet" {
name = "tf-vNet"
address_space = ["10.0.0.0/16"]
location = azurerm_resource_group.rg.location
resource_group_name = azurerm_resource_group.rg.name
}

##Subnet
resource "azurerm_subnet" "subnet" {
name = "Internal"
resource_group_name = azurerm_resource_group.rg.name
virtual_network_name = azurerm_virtual_network.vnet.name
address_prefixes = ["10.0.2.0/24"]
}

##Network interface
resource "azurerm_network_interface" "example" {
name = "tf-vmwin-nic"
location = azurerm_resource_group.rg.location
resource_group_name = azurerm_resource_group.rg.name
}

ip_configuration {
name = "internal"
subnet_id = azurerm_subnet.subnet.id
private_ip_address_allocation = "Dynamic"
}

##Azure Virtual Machine
resource "azurerm_windows_virtual_machine" "mohamed" {
name = "tf-MM"
resource_group_name = azurerm_resource_group.rg.name
location = azurerm_resource_group.rg.location
size = "Standard_F2"
admin_username = "mohamed"
admin_password = "Mohameddu976"
availability_set_id = azurerm_availability_set.setMM.id
network_interface_ids = [
azurerm_network_interface.example.id,
]

os_disk {
caching = "ReadWrite"
storage_account_type = "Standard_LRS"
}

source_image_reference {
publisher = "MicrosoftWindowsServer"
offer = "WindowsServer"
sku = "2022-Datacenter"
version = "latest"
}