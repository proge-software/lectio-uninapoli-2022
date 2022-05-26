resource "azurerm_resource_group" "rg" {
  name     = "rg-proge-lectio-${var.environment}"
  location = var.region

  tags = var.default_tags

  lifecycle {
    prevent_destroy = false
  }
}
