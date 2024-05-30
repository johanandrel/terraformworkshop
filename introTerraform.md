# Intro til Terraform

## Infrastruktur som kode (IaC)

Terraform er et verktøy for å håndtere infrastruktur som kode (IaC) på en deklarativ måte. Det lar oss styre infrastruktur med konfigurasjonsfiler istedenfor gjennom et grafisk brukergrensesnitt. Infrastruktur som kode lar oss bygge, endre og håndtere infrastruktur på en konsistent, sikker og repeterbar måte. Sannheten ligger alltid i konfigurasjonsfilene og ikke som et resultat av manuelt oppsett i et grensesnitt (ofte kalt click-ops). Terraform språket er deklarativt og beskriver dermed målet man vil oppnå, ikke hvordan man skal oppnå det. 

## State

Terraform skrives ved å lage konfigurasjonsfiler som har filendelsen ``.tf`` 
Når Terraform leser konfigurasjonsfilene og gjør endringer i infrastrukturen blir resultatet lagret i en såkalt *state* fil. Det er denne filen Terraform sammenlikner med når man gjør endringer i .tf filene. *State* filen til Terraform inneholder i så måte sannheten om hvordan infrastrukturen er satt opp. I dette kurset skal vi kjøre Terraform lokalt på egen maskin med lokal *state*. I et enterprise oppsett kobler man Terraform til en *backend* som håndterer *state* filen. På denne måten kan flere team/personer jobbe med Terraform og man hindrer at flere endrer infrastrukturen samtidig (når Terraform endrer infrastrukturen blir *state* filen låst). Husk også at *state* filen inneholder hemmeligheter og må regnes som sensitiv!

## Arbeidsmåte
 
 1. Finn riktig infrastruktur (Terraform *providers*)
 
 2. Initialiser Terraform (``terraform init``)
 
 3. Beskriv ressursene du trenger i Terraform (*.tf*-filer) 
 
 4. Kjør ``terraform plan``
 
 5. Kjør ``terraform apply``

Man kan starte med å ha én Terraform fil til infrastrukturen sin, men det er ofte vanlig å splitte opp ulike type ressurser i ulike filer hvis det blir mange ressurser. 

## Ressurser

[Terraform registry](https://registry.terraform.io/)

[Azure provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs) 