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

  network_profile {
    network_plugin    = "kubenet"
    dns_service_ip    = "10.200.0.10"
    service_cidr      = "10.200.0.0/24"
    network_policy    = "azure"  // Enabling network policy for better security
  }

  api_server_authorized_ip_ranges = ["203.0.113.0/24"]  // Limit API access to specified IPs

  role_based_access_control {
    enabled = true
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

  network_profile {
    network_plugin    = "kubenet"
    dns_service_ip    = "10.100.0.10"
    service_cidr      = "10.100.0.0/24"
    network_policy    = "azure"  // Enabling network policy
  }

  api_server_authorized_ip_ranges = ["203.0.113.0/24"]  // Limit API access to specified IPs

  role_based_access_control {
    enabled = true
  }

  identity {
    type = "SystemAssigned"
  }

  kubernetes_version = "1.29.0"
}
