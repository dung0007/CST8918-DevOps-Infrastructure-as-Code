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

resource "azurerm_container_registry" "acr" {
  name                = "remixweatheracr"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.container_registry_sku
}


resource "azurerm_redis_cache" "redis_test" {
  name                = "remixweather-redis-test"
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = 1
  family              = var.redis_family
  sku_name            = var.redis_sku
  subnet_id           = data.azurerm_subnet.test_subnet.id
}

resource "azurerm_redis_cache" "redis_prod" {
  name                = "remixweather-redis-prod"
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = 1
  family              = var.redis_family
  sku_name            = var.redis_sku
  subnet_id           = data.azurerm_subnet.prod_subnet.id

}

