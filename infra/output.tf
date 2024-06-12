output "subscription_name" {
  value = data.azurerm_subscription.current.display_name
}

output "module_output" {
  value = module.ramdomsa.storageaccount_name
}

##
## Hvis vi vil hente ut en egenskap fra en annen ressursgruppe
##
# output "my_resource_groups" {
#     value = data.azurerm_resource_group.myrgs.tags["Owner"]
# }