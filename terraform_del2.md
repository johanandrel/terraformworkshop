# Provisjonere infrastruktur

## Ressursgruppe

I ``main.tf`` lager du din egen [ressursgruppe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) for å ha alle ressursene dine i. Husk at navnet må være unikt! Referer til variablene du allerede har deklarert i ``variables.tf`` for å sette egenskapene til ressursgruppen din. F.eks:

``name = var.resource_group_name``
 
 Tips: Du kan bruke [random](https://registry.terraform.io/providers/hashicorp/random/latest/docs) provideren i Terraform hvis du vil være sikker på at navn osv. blir unike. Du kan for eksempel kombinere verdien fra variabelene din med en random variabel.

 - Når du har skrevet konfigurasjonen til ressursgruppen din kan du kjøre ``terraform fmt`` for å sørge for at Terraform koden er riktig formatert

 - Du kan også kjøre ``terraform validate`` for å sjekke at du ikke har noen ugyldige verdier

 - Kjør ``terraform plan -var-file=dev.tfvars``og se hva Terraform planlegger å opprette

 - Kjør ``terraform apply -var-file=dev.tfvars`` for å faktisk opprette din nye ressurs i Azure. Når du kjører ``apply`` vil Terraform planlegge endringene og be deg bekrefte at du er fornøyd med planen.  

 ## Storage account

 Vi skal lage vår første ressurs inne i ressursgruppen vår. Dette blir en [storage account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)

 - Se på lenken over og legg inn en ``azurerm_storage_account`` ressurs i ``main.tf``

- På ``resource_group_name``og ``location``egenskapene kan du referere til ressursgruppen sitt ``name`` og ``location`` så du slipper å skrive disse inn manuelt for hver ressurs du lager.

Tips: For å referere til egenskapene til andre ressurser, f.eks. hente ut ``name``og ``location`` fra en ressursgruppe bruker du ``<type-ressurs>.<lokalt-navn>.<egenskap>``. F.eks:

```
azurerm_resource_group.resource_group.name
azurerm_resource_group.resource_group.location
```

## Storage container

For å kunne laste opp filer lager man en [storage container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) knyttet til storage account ressursen vi akkurat laget

- Opprett en storage container ressurs og sett ```storage_account_name``` ved å referere til storage account ressursen i forrige steg.

 - Kjør ``terraform plan -var-file=dev.tfvars``og se hva Terraform planlegger å opprette

 - Kjør ``terraform apply -var-file=dev.tfvars`` for å faktisk opprette din nye ressurs i Azure.

## Slette ressurser

Hvis du vil slette ressursene du har laget med Terraform kan du kjøre:

 ``terraform destroy -var-file=dev.tfvars``

 Dette gjør det motsatte av ``apply``, altså å rive ned alle ressursene du har beskrevet i Terraform koden din. Husk at du når som helst kan kjøre ``terraform apply -var-file=dev.tfvars`` for å opprette de igjen. Det er dette som er styrken med å ha infrastrukturen beskrevet som kode, du kan når som helst lage alle ressursene på nytt så lenge du har Terraform koden tilgjengelig. 
 
 Dette gjør det lettere og rimeligere å teste ut ressurser for man kan rive de ned istedenfor å ha de stående å gå fordi man vil fortsette en annen gang.

