provider "azurerm" {
  features {}
}

resource "azurerm_container_registry" "acr" {
  name                     = "remixweatheracr"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  sku                      = var.container_registry_sku
}


resource "azurerm_redis_cache" "redis_test" {
  name                     = "remixweathertestredis"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  capacity                 = 1
  family                   = "C"
  sku_name                 = var.redis_sku
}

resource "azurerm_redis_cache" "redis_prod" {
  name                     = "remixweatherprodredis"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  capacity                 = 2
  family                   = "C"
  sku_name                 = var.redis_sku
}

