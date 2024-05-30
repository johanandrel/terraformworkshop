
# Lar oss hente ut subscription detaljer
data "azurerm_subscription" "current" {
}

resource "azurerm_resource_group" "resource_group" {
  name     = "${var.resource_group_name}-${random_pet.ressursgruppe.id}"
  location = var.resource_group_location
  tags     = merge(var.resource_group_tags, { Pet = random_pet.ressursgruppe.id })
}

# Bruker random provideren til Terraform (husk å registrere den i providers.tf)
resource "random_pet" "ressursgruppe" {
  length = 3
}

###
### Noen ekstra eksempler. Fjern kommentarene hvis du vil bruke de
###

# # Lar oss hente ut en ressursgruppe som noen andre har laget
# data "azurerm_resource_group" "myrgs" {
#     name = "sett_inn_navn_paa_gruppe"
# }