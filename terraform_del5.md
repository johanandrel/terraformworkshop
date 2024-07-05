# Ekstra oppgaver

Nå som du har fått litt introduksjon til grunnleggende Terraform er det fint å øve seg litt på å lage noen ressurser. Her finner du noen oppgaver som er relevante. Lykke til!

## Key Vault

### Opprettelse
Key Vault brukes til å lagre hemmeligheter, nøkler og sertifikater i Azure. Vi skal derfor lage et Key Vault ved å bruke ```azurerm_key_vault``` ressursen. Det er noen spesifikke krav til hvordan navnet til Key Vaults kan se ut så ta i bruk ```random_string``` ressursen i Terraform til å generere et unikt navn på ditt Key Vault som tilfredstiller kravene. 

Sett alle de nødvendige egenskapene som `resource_group` og `location`. 

**Tips:** For å sette `tenant` kan vi bruke en av `data` ressursene i Terraform (`azurerm_subscription`) for å *hente* ut hvilken `tenant` vi bruker nå.

Husk at du godt kan bruke `sku_name = "standard"` for å holde kostnadene nede.

- Kjør `terraform apply -var-file=dev.tfvars` for å lage ditt nye Key Vault

- Gå inn i Azure portalen og finn ditt nye Key Vault. I menyen til venste klikker du på `Objects`. Her ser du `Keys`, `Secrets` og `Certificates`

Hva skjer når du f.eks. går inn på `Secrets`? Får du følgende feilmelding: 

`The operation "List" is not enabled in this key vault's access policy.`  

Dette er i så fall fordi vi ikke har gitt noen rettigheter til vårt nye Key Vault. Fortsett til neste seksjon så skal vi sette opp tilgangsstyring.

### Tilgangsstyring (RBAC)

Det er to måter å tilgangsstyre et Key Vault på, med Access Control List (ACL) eller Role Based Access Control (RBAC). Sistnevnte er den anbefalte måten å gjøre det på fordi denne måten er standard på tvers av ulike ressurser i Azure. I denne øvelsen skal vi sette opp RBAC fra deg som bruker mot ditt Key Vault, men RBAC er laget for å fungere mot Entra ID grupper eller andre identiteter også. 

En innføring i RBAC finnes [her](https://learn.microsoft.com/en-us/azure/role-based-access-control/overview) 

- Det første vi skal gjøre er å skru på RBAC ved å sette `enable_rbac_authorization = true` i Terraform definisjonen til vårt Key Vault

- Kjør `terraform apply -var-file=dev.tfvars` for å oppdatere ditt Key Vault (merk: hvis dette feiler kan det hende du ikke har nok rettigheter i din sandbox/din ressursgruppe. Da vil du ikke kunne fortsette oppgaven)

Hva skjer når du går inn på `Secrets` på ditt Key Vault i Azure portalen nå? Får du samme feilmelding som tidligere? 

Hvis du ser følgende melding (`The operation is not allowed by RBAC`) er du på riktig vei! For å kunne gi deg selv rettigheter skal vi gi din bruker en RBAC-rolle som gir tilgang til å lese `secrets` fra ditt Key Vault. RBAC roller gis ved å bruke [role assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) ressursen i Terraform. 

- Se på **Example Usage (using a built-in Role)" eksempelet.** i lenken over. Legg dette inn i din Terraform kode ved å bruke `"azurerm_role_assignment"` ressursen.

- `scope` skal være satt til ditt Key Vault ved å hente ut IDen

- `principal_id` er IDen til din innloggede bruker i Entra. 

**Tips:** For å sette `principal_id` kan vi bruke en av `data` ressursene i Terraform (`zurerm_client_config`) for å *hente* ut detaljer til brukeren som er logget inn. Bruk `object_id` for å hente ut IDen til **din** bruker

I dette tilfellet skal vi bruke en RBAC-rolle for å kunne se og endre `secrets` i vårt Key Vault. RBAC-rollen for dette er **Key Vault Secrets Officer**: 

- `role_definition_name` = "Key Vault Secrets Officer"

- Kjør `terraform apply -var-file=dev.tfvars` for å oppdatere ditt Key Vault

- Hva skjer når du går inn på `Secrets` på ditt Key Vault i Azure portalen nå? 

- Hva skjer når du går inn på `Keys` eller `Certificates` på ditt Key Vault? 

Det finness egne roller for de de forskjellige funksjone i Key Vault. Se her for alle rollene som kan brukes [Azure built-in roles for Key Vault data plane operations](https://learn.microsoft.com/en-us/azure/key-vault/general/rbac-guide?tabs=azure-cli#azure-built-in-roles-for-key-vault-data-plane-operations)

For å se på allerollene som er effektive på ditt Key Vault kan du gå inn på `Access control (IAM)` i menyen til venste i ditt Key Vault også velge `Role assignments`, også velge `Scope: This resource`

Nå har du fått prøvd deg på RBAC mot et Key Vault i Azure. Hvis du vil prøve å gjøre det samme på en `Storage Account` så følg med videre til neste del...

## terraform_data (null_resource)

Noen ganger støter man på ressurser som ikke har funksjonalitet for det man trenger i Terraform direkte. Det kan være at det finnes en Terreform modul for å provisjonere opp en ressurs, men at modulen har begrenset med funksjoner eller at man vil automatisere oppsett av en ressurs videre etter å ha laget den i Terraform. For å støtte slike scenarier kan man bruke `terraform_data` ressursen i Terraform. Dette er en ressurs som ikke provisjonerer noe, men som kaller et et annet verktøy/script for å gjøre det man trenger. Fordelen med dette er at vi bruke Terraform til å styre når vi skal kalle scriptet og at vi kan sørge for at noe blir gjort i sammenheng med at en annen ressurs har blitt laget i Terraform. Inne i `terraform_data` ressursen kan vi bruke ulike `provisioners` som faktisk kjører kode. La oss prøve dette!

**Merk:** før Terraform versjon 1.4 brukte man `null_resource` ressursen, men `terraform _data` er den anbefalte ressusen med mindre man har en gammel Terraform versjon

- Lag en `terraform_data` ressurs i Terraform filen din. 

- Inne i `terraform_data` ressursen skal vi bruke `local_exec` provisioner til å kjøre noe kode

- Legg inn `command = "echo Bra jobba!"` som en enkel test

- Kjør `terraform apply -var-file=dev.tfvars` 

Hvis alt går som det skal vil du se i terminalen at det blir skrevet ut "Bra jobba!" når Terraform kjører :)

- Prøv å endre til `command = "echo Ha en fin dag"` og kjør `terraform apply -var-file=dev.tfvars` på nytt

Hva skjedde, fikk du skrevet ut "Ha en fin dag"?

**Hint:** Siden dette er en `terraform_data` ressurs og har blitt kjørt én gang allerede blir den ikke kjørt igjen for Terraform vet ikke at noe har endret seg i `command` teksten. Men dette kan vi styre og ved å selv legge inn hva som skal trigge en kjøring med `terraform_data` ressursen vår ved å bruke `triggers_replace`. Her kan vi velge å legge inn en avhengighet til en egenskap i en annen ressurs eller i kan tvinge den til å kjøre koden hver gang ved å bruke `triggers_replace` sammen med `timestamp()` metoden i Terraform. Sistnevnte vil alltid trigge fordi `timestamp()` vil gi forskjellig resultat hver gang Terraform kjører. 

- Legg inn `triggers_replace` og bruk `timestamp()` og kjør `terraform apply -var-file=dev.tfvars` på nytt for å verifisere at du får skrevet ut riktig melding

- For å forbedre koden vår litt skal vi lage en mappe som heter `scripts` også legger vi en fil inn der som vi skal trigge (f.eks. `hello.ps1` hvis du vil ha en PowerShell fil)

- Skriv ut litt tekst eller noe annet gøy i filen du lagde, f.eks. `Write-Output "Hello world!"` eller noe annet spennende

- Prøv å endre `command` til å trigge den nye filen som ligger i `scripts` 

**Hint:** I tillegg til å endre `command` må du trolig legge inn en `interpreter` for å fortelle Terraform hva slags process som skal kjøre filen

- Kjør `terraform apply -var-file=dev.tfvars` og se om du får trigger filen og skrevet ut noe

`local_exec` kjører lokalt der hvor Terraform kjører. Du kan også kjøre scripts på en ressurs et annet sted, f.eks. på en ressurs som du har opprettet via Terraform. For å gjøre dette kan ma bruke `remove_exec` provisioneren som du kan lese mere om [her](https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec) 

