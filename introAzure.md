# Intro til Azure

## Arkitektur

Vi skal jobbe i en egen *subscription* i Azure. En *subscription* er det høyeste abstraksjonslaget i Azure og når provisjonerer ressurser (eller besøker Azure portalen) så er det alltid i kontekst av en spesifikk *subscription*. Til kurset er det opprettet en egen *sandbox subscription* som er dedikert til å lære seg Terraform så ikke vær redd for å eksperimentere her. 

Husk imidlertid at når vi provisjonerer ressurser i Azure (og sky generelt) så koster det penger og enkelte ressurser er mere kostbare enn andre. Siden vi har infrastrukturen vår i kode kan vi raskt rive det ned og provisjonere det opp igjen en annen dag. 

For å skille ressursene fra hverandre og ha oversikt i vår subscription skal alle lage sin egen *resource group*. Dette er en logisk gruppering av ressurser som gjør at alle kan ha sine ting i hver sin gruppe og ha oversikt over sine ting. Vi skal selvfølgelig lage denne ved hjelp av Terraform!