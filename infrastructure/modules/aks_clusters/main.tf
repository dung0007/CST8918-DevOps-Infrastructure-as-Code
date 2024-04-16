provider "azurerm" {
  features {}
}

data "azurerm_subnet" "test_subnet" {
  name                 = "test"
  virtual_network_name = "vnet"
  resource_group_name  = var.resource_group_name
}

data "azurerm_subnet" "prod_subnet" {
  name                 = "prod"
  virtual_network_name = "vnet"
  resource_group_name  = var.resource_group_name
}

resource "azurerm_kubernetes_cluster" "aks_test" {
  name                = "aks-test"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "akstest"

  default_node_pool {
    name           = "default"
    node_count     = 1
    vm_size        = "Standard_DS2_v2"
    vnet_subnet_id = data.azurerm_subnet.test_subnet.id
  }

  role_based_access_control {
    enabled = true
  }

  addon_profile {
    http_application_routing {
      enabled = true
    }
    kube_dashboard {
      enabled = true
    }
  }

  network_profile {
    network_plugin = "kubenet"
    dns_service_ip = "10.200.0.10"
    service_cidr   = "10.200.0.0/24"
  }

  identity {
    type = "SystemAssigned"
  }

  kubernetes_version = "1.29.0"
}

resource "azurerm_kubernetes_cluster" "aks_prod" {
  name                = "aks-prod"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "aksprod"

  default_node_pool {
    name                = "default"
    node_count          = 1
    vm_size             = "Standard_DS2_v2"
    min_count           = 1
    max_count           = 3
    enable_auto_scaling = true
    vnet_subnet_id      = data.azurerm_subnet.prod_subnet.id
  }

  role_based_access_control {
    enabled = true
  }

  addon_profile {
    http_application_routing {
      enabled = false  # Example: Disable HTTP routing for production
    }
    azure_policy {
      enabled = true
    }
  }

  network_profile {
    network_plugin = "kubenet"
    dns_service_ip = "10.100.0.10"
    service_cidr   = "10.100.0.0/24"
  }

  identity {
    type = "SystemAssigned"
  }

  kubernetes_version = "1.29.0"
}
