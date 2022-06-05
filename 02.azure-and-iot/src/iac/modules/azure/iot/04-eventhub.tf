resource "azurerm_eventhub_namespace" "ehns" {
  name                     = "ehnsprogelectureiot"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  sku                      = "Basic"
  capacity                 = 1
  maximum_throughput_units = 0
  network_rulesets = [
    {
      default_action                 = "Allow"
      ip_rule                        = []
      trusted_service_access_enabled = false
      virtual_network_rule           = []
    }
  ]

  zone_redundant = true
  timeouts {}
}

resource "azurerm_eventhub" "eh" {
  name                = "rpi-events"
  namespace_name      = azurerm_eventhub_namespace.ehns.name
  resource_group_name = azurerm_resource_group.rg.name
  partition_count     = 2
  message_retention   = 1
}
