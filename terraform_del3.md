# Gjenbruk av Terraform kode


## Modules
Inntil nå har vi sett på ``data`` og ``resource`` ressursene i Terraform. Og kanskje har du også fått testet en av de innebygde ressursene som ikke krever en egen provider f.eks. ``random``. En annnen type ressurs som blir mye brukt er ``module`` ressursen. Denne lar oss lage Terraform *moduler* som gjør at vi kan gjenbruke Terraform kode flere steder. En Terraform *modul* er ikke noe magisk i seg selv, det er en samling av Terraform filer som ligger i en navngitt mappe. Da har du typisk flere mapper med Terraform filer hvor navnet på mappen sier hvilken modul det er. 

## Lage en modul

La oss lage vår første modul ved å opprette en `modules` mappe på samme sted som du har dine andre Terraform filer. Inne i den mappen lager du en ny mappe som du kaller `randomstorage` 

```
main.tf
output.tf
provider.tf
variables.tf
dev.tfvars
modules/randomstorage <-- her er våre to nye mapper
```

### Inne i ``randomstorage`` mappen lager du følgende filer:

**variables.tf** 

```
variable "resource_group_name" {
  type        = string
  description = "Resource group name that is unique in your Azure subscription."
}

variable "location" {
  type        = string
  default     = "Norway East"
  description = "Location in your Azure subscription."
}

variable "tags" {
  type        = map(string)
  description = "Tags to put metadata on the resource."
}
```

**main.tf**
```
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
```

**output.tf**
```
output "azurerm_randomstorage_result" {
  value = "Wohoo, bra jobba! Din storage container heter ${azurerm_storage_account.storage_account.name}"
}
```

## Hva gjorde vi nå?

Her var det mye copy-paste, men som du ser er dette ganske likt det vi allerede har øvd oss på tidligere ved å lage en *storage account* i Azure. Forskjellen er at vi nå har laget en liten modul ved å lage noen Terraform filer i en spesifikk navngitt mappe. 

Koden i *main* lager en storage account hvor vi passer på at navnet på vår storage account får et unikt navn som ikke inneholder ugyldige verdier (bindestrek osv.) ved å bruke *random_pet* ressursen, kombinert med et "sg" prefix foran. I tillegg bruker i *merge* funksjonen i Terraform til å ta inn *tags* som en variabel, også legger vi på en ekstra tag slik at man kan se hvilken modul som faktisk ble brukt når man opprettet ressursen. På denne måten kan vi som lager modulen ha et standard sett med tags som alle storage accounts skal ha, også kan brukerne av modulen legge på sine tags i tillegg. 

## Ta i bruk vår nye modul

 La oss ta den nye modulen i bruk ved å åpne `main.tf` som vi har jobbet med tidligere (ikke `main.tf` i modulen vår):

```
main.tf <-- her skal vi ta i bruk i vår nye modul
output.tf
provider.tf
variables.tf
dev.tfvars
modules/randomstorage 
```

For å bruke en modul i Terraform bruker vi `module` ressursen. Merk at du her velger fritt hva du vil kalle din lokale *instans* av ressursen, det er *source* som sier hvilken modul du tar i (og hvor den ligger). 

```
module "<navn>" {
  source                  = "./modules/<modulnavn>"
  variabel_1              = "verdi1" 
}
```

Hvis modulen trenger variabler for å fungere så setter man de etter *source* slik som på eksempelet over. Fyll inn verdiene som kreves for å ta i bruk vår nye modul. Et komplett eksempel ser du under:

```
module "ramdomsa" {
  source              = "./modules/randomstorage"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  tags                = var.resource_group_tags
}
```

Kjør ``terraform plan var-file=dev.tfvars`` for å se hvilke endringer Terraform planlegger. Hva skjer? 

Du får sannsynligvis en `` Error: Module not installed`` feil. Siden vi har tatt i bruk en ny *modul* må vi kjøre ``terraform init`` for at Terraform skal *installere* modulen. Dette gjelder selv om koden til modulen ligger lokalt. Prøv å kjøre ``terraform plan var-file=dev.tfvars`` på nytt og se om planen ser fornuftig ut.

Kjør ``terraform apply var-file=dev.tfvars`` for å sette vår nye modul til verks!

## Hente ut data fra vår nye modul

Hvis du vil hente ut data/verdier fra vår nye modul kan du gå til ``output.tf``... 

```
main.tf 
output.tf <-- modifiser denne
provider.tf
variables.tf
dev.tfvars
modules/randomstorage 
```

...og legge til følgende:

```
output "module_output" {
  value = module.ramdomsa.storageaccount_name
}
```

Her henter vi ut *storageaccount_name* egenskapen til vår nye modul. Man kan kun hente ut egenskaper som modulen selv har definert i sin *output* 

Hvis du går inn i mappen til vår modul så kan du se i `output.tf` hvilke egenskaper vi har eksponert ut fra vår modul. 

Kjør ``terraform apply var-file=dev.tfvars`` for å se om vi får noe output fra modulen!

## Neste del

[I neste del](/terraform_del4.md) skal vi fokusere på sikkerhet og scanning av Terraform kode!

