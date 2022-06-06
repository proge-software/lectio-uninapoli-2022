resource "azurerm_iothub" "iot" {
  location            = var.location
  name                = "iot-${var.customer}-${var.project}-${var.scope}-${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    capacity = 1
    name     = "S1"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.default_tags
}
