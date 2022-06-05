resource "azurerm_cosmosdb_account" "db" {
  name                = "cosmos-unina-demo-iot"
  location            = var.cosmos_location
  resource_group_name = azurerm_resource_group.rg.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
  enable_free_tier    = true

  enable_automatic_failover = false

  backup {
    interval_in_minutes = 1440
    retention_in_hours  = 48
    storage_redundancy  = "Local"
    type                = "Periodic"
  }

  capacity {
    total_throughput_limit = 1000
  }

  consistency_policy {
    consistency_level       = "Session"
    max_interval_in_seconds = 5
    max_staleness_prefix    = 100
  }

  geo_location {
    location          = var.cosmos_location
    failover_priority = 0
    zone_redundant    = false
  }

  tags = {
    "defaultExperience"       = "Core (SQL)"
    "hidden-cosmos-mmspecial" = ""
  }
}

resource "azurerm_cosmosdb_sql_database" "rpiev" {
  name                = "rpi-events"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name

  autoscale_settings {
    max_throughput = 1000
  }
}

resource "azurerm_cosmosdb_sql_container" "rpiev" {
  name = "thevents"
  resource_group_name = azurerm_resource_group.rg.name
  account_name = azurerm_cosmosdb_account.db.name
  database_name = azurerm_cosmosdb_sql_database.rpiev.name
  partition_key_path = "/id"
}
