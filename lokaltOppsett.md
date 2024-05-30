# Lokalt oppsett

## Verifisere Terraform og Azure tilgang

- Åpne vscode

- Lag en mappe som heter *terraformworkshop*

- Åpne terminalen i vscode og skriv ``terraform``for å verifisere at Terraform er installert

- Kjør ``az login`` for å logge inn (du vil da bli tatt igjennom login flyten i nettleseren)

- Kjør ``az account show`` for å verifisere at du er logget inn og er under riktig subscription (*name* egenskapen)

- *Hvis* du er under en annen subscription enn den vi skal bruke kan du kjøre ``az account set --subscription "<navn-på-subcription>"`` for å velge riktig subscription

## Oppsett av Azure provider

- Opprett en fil ``provider.tf``

- Kjør ``terraform init``

- Siden vi ikke har satt opp hvilken/hvilke providere vi vil bruke skjer det ingenting foreløpig

- Gå til [dokumentasjonen til Azure provideren](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs), klikk på den blå "Use provider" knappen og kopier koden inn i ``provider.tf`` filen du lagde tidligere

- Kjør ``terraform init`` igjen for å laste ned provideren

- Kjør ``terraform plan`` for å sammenlikne din konfigurasjon med infrastrukturen i skyen (her forventer vi ingen endringer siden vi ikke har beskrevet noen ressurser enda)

Gå videre til neste del for å lage vår første ressurs!
