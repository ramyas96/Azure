# Common variables
variable "resource_group_name" {}
variable "location" {}
variable "vnet_name" {}
variable "vnet_address_space" {}
variable "subnet_name" {}
variable "subnet_address_prefix" {}
variable "nic_name" {}
variable "vm_name" {}
variable "vm_size" {}
variable "admin_username" {}
variable "admin_password" {
  description = "Admin password for the VM"
  type        = string
  sensitive   = true
}
variable "storage_account_name" {}

# Backend variables
variable "backend_rg" {}
variable "backend_storage_account" {}
variable "backend_container" {}
variable "backend_key" {}
