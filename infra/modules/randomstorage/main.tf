# Bruker random provideren til Terraform (bruk .id for å hente ut verdien)
resource "random_pet" "storageaccount" {
  length    = 2
  separator = ""
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "sg${random_pet.storageaccount.id}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  tags                     = merge(var.tags, { Module = "RandomStorage" })
}