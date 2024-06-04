output "azurerm_container_app_url" {
  value = "Wohoo, bra jobba! Ta en kikk på: ${azurerm_container_app.testcontainerapp.latest_revision_fqdn}"
}