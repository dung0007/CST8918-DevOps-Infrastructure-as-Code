
variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  default     = "cst8918-final-project-group-3"
}

variable "location" {
  default     = "westus3"
  description = "location in which resources are created"

}

variable "container_registry_sku" {
  description = "SKU for Azure Container Registry"
  default     = "Standard"
}

variable "redis_sku" {
  description = "SKU for Azure Cache for Redis"
  default     = "Premium"
}

variable "redis_family" {
  description = "Family for Azure Cache for Redis"
  default     = "P"
}