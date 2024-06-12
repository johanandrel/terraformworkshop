# Sikkerhetscanning

Ved å definere infrastrukturen vår som kode i Terraform kan vi bygge, endre og håndtere dette på en konsistent, *sikker* og repeterbar måte. Det er imidlertid viktig å være klar over at mange ressurser i Azure er i sitt *standard-oppsett* ikke regnet for å være sikkert nok til bruk i produksjon. En måte å lære seg hva god praksis er på de forskjellige ressursene er å lese på dokumentasjon i Azure. Men siden vi har infrastrukturen vår definert som kode kan vi kombinere dette med verktøy som går igjennom koden vår og se på konfigurasjonen opp mot det som er definert som god praksis på det forskjellige ressursene. Det finnes flere verktøy (checkov, trivy, terrascan, snyk etc.) for dette og de vil gi litt ulike resultater. Her skal vi teste *checkov* ved å installere det og kjøre det på vår Terraform kode.

## Checkov

- Installer *checkov* ved å gå til [checkov sitt Github repo](https://github.com/bridgecrewio/checkov?tab=readme-ov-file#getting-started)

- Kjør en scan av Terraform ved å kjøre ``checkov -f main.tf``(vær oppmerksom på at en scan kan ta litt tid)

- Hva ble resultatet?

- Er det noe vi kan gjøre med vår Terraform kode for å få et bedre resultat?