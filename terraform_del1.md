# Terraform

## Struktur

Før vi lager vår første ressurs skal vi sørge for at vi har en minimum av struktur så det blir lettere når infrastrukturen vokser.

### variables.tf

- Lag en ``variables.tf`` fil som skal holde inneholde *definisjonene* på variabler vi trenger i Terraform filene våre. Vi setter ikke verdier på variablene her, men  definerer dem. 

- Legg inn følgende definisjoner for å få et utgangspunkt:

```
variable "resource_group_name" {
  type        = string
  description = "Resource group name that is unique in your Azure subscription."
}

variable "resource_group_location" {
  type        = string
  default     = "Norway East"
  description = "Location of the resource group in your Azure subscription."
}

variable "resource_group_tags" {
  type        = map(string)
  description = "Tags to put metadata on the resource group in your Azure subscription."
  default = {
    Owner = "<email.address>"
  }
}
```

- Se hva som skjer hvis du kjører ``terraform plan`` nå

- Vi har fortsatt ikke laget en ny ressurs, men utifra at en av variablene våre ikke har en *default* verdi vil Terraform be oss om en verdi for å gjøre konfigurasjonen gyldig

- Husk å sette inn riktig e-post (din egen) i ```resource_group_tags``` definisjonen før du går videre

### main.tf

- Lag en ``main.tf``fil. Her skal vi ha selve infrastrukturen vår. Vi starter med å ha én Terraform fil til dette, men det er ofte vanlig å splitte opp ulike type ressurser i ulike filer hvis det blir mange ressurser. 

- Legg til følgende kode i ``main.tf```

```
# Lar oss hente ut subscription detaljer
data "azurerm_subscription" "current" {
}
```

Dette er en *data* ressurs, dvs. at den leser ut data fra en eksisterende ressurs. Denne kan brukes til å lese ut info fra ressurser som du selv ikke har laget i dine Terraform filer

### output.tf

- Lag en ``output.tf``fil. Her legger man *outputs*, altså verdier man vil skrive ut som et resultat av at vi kjører Terraform. La oss hente ut en verdi fra *azurerm_subscription* som vi lagde i forrige steg:

- Legg følgende inn i ``output.tf``:

```
output "subscription_name" {
  value = data.azurerm_subscription.current.display_name
}
````

- Kjør ``terraform plan`` og se om du får skrevet ut noe

### dev.tfvars

En vanlig måte å faktisk gi variablene som er definert i ``variables.tf`` verdier er å ha én ``.tfvars`` fil som inneholder verdiene. Dermed kan man ha flere sett med verdier, men gjenbruke resten av Terraform koden. Det blir også lettere å håndtere eventuelle sensitive verdier når de ikke er blandet inn i de andre Terraform filene. 

- Lag en ``dev.tfvars``fil og *sett* variablene som er definert i ``variables.tf`` til fornuftige verdier.

```
resource_group_name     = "<ditt-unike-ressursgruppe-navn>"
resource_group_location = "Norway East"
resource_group_tags = {
  Owner = "din-epost"
}
```

- For å bruke våre nye verdier må vi fortelle til Terraform hvilken fil den skal bruke når vi kjører *plan* eller *apply*. Prøv dette ved å kjøre følgende: ``terraform plan -var-file=dev.tfvars``

Nå har du basic struktur på plass så [fortsett til neste del](/terraform_del2.md) for å faktisk lage noe!

