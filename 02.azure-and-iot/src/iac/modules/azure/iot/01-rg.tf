resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = "rg-${var.customer}-${var.project}-${var.scope}-${var.environment}"
}

