# Provisjonere infrastruktur

## Ressursgruppe

I ``main.tf`` lager du din egen ressursgruppe for å ha alle ressursene dine i. Husk at navnet må være unikt! Referer til variablene du allerede har deklarert i ``variables.tf`` for å sette egenskapene til ressursgruppen din. F.eks:

``name = var.resource_group_name``
 
 Tips: Du kan bruke [random](https://registry.terraform.io/providers/hashicorp/random/latest/docs) provideren i Terraform hvis du vil være sikker på at navn osv. blir unike. Du kan for eksempel kombinere verdien fra variabelene din med en random variabel.

 - Når du har skrevet konfigurasjonen til ressursgruppen din kan du kjøre ``terraform fmt``for å sørge for at Terraform koden er riktig formatert

 - Du kan også kjøre ``terraform validate``for å sjekke at du ikke har noen ugyldige verdier

 - Kjør ``terraform plan -var-file=dev.tfvars``og se hva Terraform planlegger å opprette

 - Kjør ``terraform apply -var-file=dev.tfvars`` for å faktisk opprette din nye ressurs i Azure. Når du kjører ``apply`` vil Terraform planlegge endringene og be deg bekrefte at du er fornøyd med planen.  