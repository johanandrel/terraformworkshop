# Sikkerhetscanning

Ved å definere infrastrukturen vår som kode i Terraform kan vi bygge, endre og håndtere dette på en konsistent, *sikker* og repeterbar måte. Det er imidlertid viktig å være klar over at mange ressurser i Azure er i sitt *standard-oppsett* ikke regnet for å være sikkert nok til bruk i produksjon. En måte å lære seg hva god praksis er på de forskjellige ressursene er å lese på dokumentasjon i Azure. Men siden vi har infrastrukturen vår definert som kode kan vi kombinere dette med verktøy som går igjennom koden vår og ser på konfigurasjonen opp mot det som er definert som god praksis på det forskjellige ressursene. 

Det finnes flere verktøy (checkov, trivy, terrascan, snyk etc.) for dette og de vil gi litt ulike resultater. Her skal vi teste **checkov** og/eller **Trivy** ved å installere det og kjøre det på vår Terraform kode.

## Checkov

- [Checkov](https://github.com/bridgecrewio/checkov) er et av de mest omfattende verktøyene for scanning av kode da det ofte gir det bredeste spekteret med tips og anbefalinger. Vær i midlertid klar over at det tar litt tid å kjøre en scan med dette verktøyet.

### Installering

- Hvis du buker Windows kan du bruke ``pip3 install checkov``

- Hvis du bruker Mac kan du bruke ``brew install checkov``

### Scan

- Kjør en scan av Terraform ved å kjøre ``checkov -f main.tf`` (vær oppmerksom på at en scan kan ta litt tid)

- Hva ble resultatet?

- Er det noe vi kan gjøre med vår Terraform kode for å få et bedre resultat?

## Trivy

Hvis du ikke får installert checkov kan du prøve [Trivy](https://github.com/aquasecurity/trivy)

### Installering

- Hvis du buker Windows kan du bruke ``winget install Trivy``

- Hvis du bruker Mac kan du bruke ``brew install trivy``

- Se ellers [her](https://github.com/aquasecurity/trivy?tab=readme-ov-file#get-trivy) hvis du vil f.eks. kjøre det som et *Docker image* eller som en *vscode extension*

### Scan

Hvis du har installert *trivy* lokalt kan du kjøre en scan ved å kjøre ``trivy config ./`` Da vil trivy scanne den folderen du står i (f.eks. *infra* folderen)

- Hva ble resultatet?

- Er det noe vi kan gjøre med vår Terraform kode for å få et bedre resultat?

