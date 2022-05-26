resource "azurerm_kubernetes_cluster" "app" {
  name                = "aks-proge-lectio-${var.environment}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aks-proge-lectio-${var.environment}"
  node_resource_group = "${azurerm_resource_group.rg.name}-mc"

  kubernetes_version = "1.21.9"

  network_profile {
    network_plugin = "kubenet"
  }

  default_node_pool {
    name                = "default"
    min_count           = 1
    max_count           = 4
    enable_auto_scaling = true
    vm_size             = "Standard_D2_v4"
    max_pods            = 250
  }

  identity {
    type = "SystemAssigned"
  }

  depends_on = []

  lifecycle {
  }

  tags = var.default_tags
}

resource "null_resource" "local_credentials" {
  triggers = {
    kid = azurerm_kubernetes_cluster.app.id
  }

  provisioner "local-exec" {
    command = "az aks get-credentials -g ${azurerm_resource_group.rg.name} -n ${azurerm_kubernetes_cluster.app.name} --overwrite-existing"
  }
}

