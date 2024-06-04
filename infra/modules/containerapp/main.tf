resource "azurerm_container_app_environment" "containerappenvironment" {
  name                = var.environment_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}
resource "azurerm_container_app" "testcontainerapp" {
  name                         = var.app_name
  container_app_environment_id = azurerm_container_app_environment.containerappenvironment.id
  resource_group_name          = var.resource_group_name
  revision_mode                = "Single"

  template {
    container {
      name   = "examplecontainerapp"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }
  ingress {
    allow_insecure_connections = false
    target_port                = 80
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
    external_enabled = true
  }
}