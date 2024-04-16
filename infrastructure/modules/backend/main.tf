terraform {
  required_version = ">= 1.1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "backend_rg" {
  name     = "cst8918-final-project-group-3-backend-rg"
  location = "westus3"
}

resource "azurerm_storage_account" "backend_sa" {
  name                     = "cst8919backendstorage"
  resource_group_name      = azurerm_resource_group.backend_rg.name
  location                 = azurerm_resource_group.backend_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  tags = {
    environment = "backend"
  }
}

resource "azurerm_storage_container" "terraform_state" {
  name                  = "terraform-state"
  storage_account_name  = azurerm_storage_account.backend_sa.name
  container_access_type = "private"
}

output "backend_rg_name" {
  value = azurerm_resource_group.backend_rg.name
}

output "storage_account_name" {
  value = azurerm_storage_account.backend_sa.name
}

output "container_name" {
  value = azurerm_storage_container.terraform_state.name
}

output "primary_access_key" {
  value     = azurerm_storage_account.backend_sa.primary_access_key
  sensitive = true
}
