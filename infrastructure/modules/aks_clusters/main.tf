provider "azurerm" {
  features {}
}

resource "azurerm_kubernetes_cluster" "aks_test" {
  name                = "aks-test"
  location            = "Canada Central"
  resource_group_name = "cst8918-final-project-group-3"
  dns_prefix          = "akstest"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  kubernetes_version = "1.29.0"
}

resource "azurerm_kubernetes_cluster" "aks_prod" {
  name                = "aks-prod"
  location            = "Canada Central"
  resource_group_name = "cst8918-final-project-group-3"
  dns_prefix          = "aksprod"

  default_node_pool {
    name                = "default"
    node_count          = 1
    vm_size             = "Standard_DS2_v2"
    min_count           = 1
    max_count           = 3
    enable_auto_scaling = true
  }

  identity {
    type = "SystemAssigned"
  }

  kubernetes_version = "1.29.0"
}