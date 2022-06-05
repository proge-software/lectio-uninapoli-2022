resource "azurerm_stream_analytics_job" "rpievtocosmos" {
  name                = "rpi4-events"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  compatibility_level = "1.2"
  data_locale         = "en-US"
  streaming_units     = 1
  output_error_policy = "Stop"

  tags = {
    "hidden-link:/Microsoft.StreamAnalytics/streamingDataFlow/resource" = "https://ehnsprogelectureiot.servicebus.windows.net:443/rpi-events"
    "hidden-link:/Microsoft.StreamAnalytics/streamingjobs/settings" = jsonencode(
      {
        streamDataFlowJob           = true
        streamDataFlowJobWizardType = "wizardCosmosDBOutput"
      }
    )
  }
  transformation_query = <<-EOT
           WITH
          
           [data] AS (
           SELECT
               TRY_CAST([eventhub-stream-input].[Temperature] AS bigint) AS [Temperature],
               TRY_CAST([eventhub-stream-input].[Humidity] AS bigint) AS [Humidity],
               TRY_CAST([eventhub-stream-input].[EventProcessedUtcTime] AS nvarchar(max)) AS [EventProcessedUtcTime],
               TRY_CAST([eventhub-stream-input].[PartitionId] AS bigint) AS [PartitionId],
               TRY_CAST([eventhub-stream-input].[EventEnqueuedUtcTime] AS nvarchar(max)) AS [EventEnqueuedUtcTime]
           FROM [eventhub-stream-input]
           )
          
           SELECT
               [data].[Temperature],
               [data].[Humidity],
               [data].[EventProcessedUtcTime],
               [data].[PartitionId],
               [data].[EventEnqueuedUtcTime]
           INTO [output-to-cosmosdb]
           FROM [data]
          
        EOT

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [
      transformation_query
    ]
  }

}



resource "azurerm_stream_analytics_stream_input_eventhub" "ehinput" {
  name                         = "eventhub-stream-input"
  stream_analytics_job_name    = "rpi4-events"
  resource_group_name          = azurerm_resource_group.rg.name
  eventhub_consumer_group_name = "$Default"
  eventhub_name                = azurerm_eventhub.eh.name
  servicebus_namespace         = azurerm_eventhub_namespace.ehns.name
  shared_access_policy_key     = azurerm_eventhub_namespace.ehns.default_primary_key
  shared_access_policy_name    = "RootManageSharedAccessKey"

  serialization {
    type     = "Json"
    encoding = "UTF8"
  }
}

resource "azurerm_stream_analytics_output_cosmosdb" "tocosmos" {
  name                     = "output-to-cosmosdb"
  stream_analytics_job_id  = azurerm_stream_analytics_job.rpievtocosmos.id
  cosmosdb_account_key     = azurerm_cosmosdb_account.db.primary_key
  cosmosdb_sql_database_id = azurerm_cosmosdb_sql_database.rpiev.id
  container_name           = azurerm_cosmosdb_sql_container.rpiev.name
  document_id              = "exampledocumentid"
}

