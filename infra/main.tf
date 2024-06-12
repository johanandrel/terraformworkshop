
# Lar oss hente ut subscription detaljer
data "azurerm_subscription" "current" {
}

resource "azurerm_resource_group" "resource_group" {
  name     = "${var.resource_group_name}-${random_pet.ressursgruppe.id}"
  location = var.resource_group_location
  tags     = merge(var.resource_group_tags, { Pet = random_pet.ressursgruppe.id })
}

# Bruker random provideren til Terraform (bruk .id for å hente ut verdien)
resource "random_pet" "ressursgruppe" {
  length = 3
}

# Bruker random provideren til Terraform (bruk .id for å hente ut verdien)
resource "random_pet" "storageaccount" {
  length    = 3
  separator = ""
}

resource "azurerm_storage_account" "storage_account" {
  name                     = random_pet.storageaccount.id
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = azurerm_resource_group.resource_group.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  tags                     = var.resource_group_tags
}

module "ramdomsa" {
  source              = "./modules/randomstorage"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  tags                = var.resource_group_tags
  create_random_name  = true
}

# module "containerapp" {
#   source                  = "./modules/containerapp"
#   resource_group_name     = azurerm_resource_group.resource_group.name
#   resource_group_location = azurerm_resource_group.resource_group.location
#   environment_name        = "<settinnmiljønavn>"
#   app_name                = "<settinnappnavn>"
# }

###
### Noen ekstra eksempler. Fjern kommentarene hvis du vil bruke de
###

# # Lar oss hente ut en ressursgruppe som noen andre har laget
# data "azurerm_resource_group" "myrgs" {
#     name = "sett_inn_navn_paa_gruppe"
# }