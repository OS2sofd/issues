# OS2sofd – proces for screening af ændringsønsker

## Formål

Denne proces beskriver, hvordan nye ændringsønsker i OS2sofd håndteres fra de oprettes i GitHub, til de enten:

- går videre til **Afventer løsningsbeskrivelse**, eller
- returneres til opretter med spørgsmål til afklaring.

Målet er at sikre en ensartet, gennemsigtig og sporbar behandling af ændringsønsker.

---

## Overordnet proces

Processen består aktuelt af to manuelle trin og én automatisk GitHub-opdatering:

1. Nye ændringsønsker findes og eksporteres fra GitHub.
2. Ændringsønskerne screenes med AI efter den fastlagte screeningsmodel.
3. Resultatet anvendes af et deploy-script, som opdaterer GitHub.

### Faste filnavne

Eksport fra GitHub:

`OS2sofd-nye-aendringsoensker.json`

Resultat efter screening:

`OS2sofd-screening-resultat-aktuel.json`

De faste filnavne betyder, at PO ikke skal ændre parametre eller issue-numre mellem kørsler.

---

## Trin 1 – Find nye ændringsønsker

Kør:

```powershell
& "$env:USERPROFILE\Downloads\OS2sofd-find-nye-aendringsoensker.ps1"
```

Scriptet finder issues i Project-status:

**Nye ændringsønsker**

og opretter filen:

`Downloads\OS2sofd-nye-aendringsoensker.json`

Hvis der ikke er nye ændringsønsker, skal der ikke gennemføres screening.

---

## Trin 2 – Screening

Filen `OS2sofd-nye-aendringsoensker.json` uploades til ChatGPT.

Screeningen vurderer otte kriterier. Kriterierne skal ikke forstås som en kravspecifikation. Formålet er alene at vurdere, om ændringsønsket er beskrevet godt nok til at kunne gå videre til teknisk afklaring, løsningsforslag og estimering.

### Vurderingsskala

- 🟢 **Tilstrækkeligt** – oplysningerne er gode nok til, at ændringsønsket kan gå videre.
- 🟡 **Kræver afklaring** – der er usikkerheder eller mangler, men de behøver ikke nødvendigvis blokere for næste trin.
- 🔴 **Utilstrækkeligt** – der mangler så centrale oplysninger, at behovet eller den ønskede ændring ikke kan forstås godt nok.

Et eller flere gule kriterier betyder derfor **ikke automatisk**, at ændringsønsket skal returneres til opretter.

### De enkelte kriterier

#### 1. Forretningsbehov

**Hvad vurderes?**  
Om det fremgår, hvilket problem, behov eller hvilken udfordring der findes i dag.

Screeningen skal kunne forstå **hvorfor** ændringen ønskes. Det er ikke nok alene at skrive, hvad systemet skal gøre anderledes.

Eksempler på et tydeligt forretningsbehov:

- en arbejdsgang kræver unødvendigt manuelt arbejde
- bestemte oplysninger kan ikke anvendes af andre systemer
- brugere eller administratorer mangler mulighed for at udføre en konkret opgave
- den nuværende løsning giver fejl, usikkerhed eller uhensigtsmæssige arbejdsgange

🟢 når problemet eller behovet kan forstås.  
🟡 når behovet kan anes, men er upræcist beskrevet.  
🔴 når ændringsønsket primært beskriver en løsning uden at gøre det forståeligt, hvilket problem der skal løses.

---

#### 2. Forretningsværdi

**Hvad vurderes?**  
Om det fremgår, hvilken nytte ændringen forventes at skabe.

Forretningsværdi kan fx være:

- mindre manuelt arbejde
- bedre datakvalitet
- færre fejl
- højere sikkerhed
- enklere administration
- bedre brugeroplevelse
- mulighed for en arbejdsgang eller integration, som ikke fungerer i dag

Der kræves ikke en økonomisk business case eller dokumenterede gevinster. Det er tilstrækkeligt, at den forventede værdi kan forstås.

🟢 når værdien er tydelig eller kan udledes direkte af behovet.  
🟡 når værdien virker sandsynlig, men ikke er særlig tydeligt beskrevet.  
🔴 når det ikke er muligt at forstå, hvorfor ændringen vil være nyttig.

---

#### 3. Ønsket ændring

**Hvad vurderes?**  
Om det er forståeligt, hvad opretter ønsker ændret i OS2sofd eller en tilknyttet integration/funktion.

Der skal være en rimelig sammenhæng mellem det beskrevne problem og den ønskede ændring.

Der kræves **ikke** en teknisk løsningsbeskrivelse. Opretter behøver fx ikke beskrive:

- API-endpoints
- datamappings
- databasestruktur
- valideringsregler
- tekniske undtagelser
- konkret implementering

🟢 når udvikleren kan forstå retningen for den ønskede ændring.  
🟡 når retningen er forståelig, men enkelte dele er uklare.  
🔴 når det ikke kan afgøres, hvad der faktisk ønskes ændret.

---

#### 4. Behov vs. løsning

**Hvad vurderes?**  
Om ændringsønsket giver plads til teknisk afklaring og ikke låser sig unødigt til én bestemt løsning.

Opretter må gerne foreslå en konkret løsning. Et løsningsforslag er ofte nyttigt. Screeningen skal blot skelne mellem:

- **behovet** – det der skal kunne lade sig gøre
- **løsningsforslaget** – én mulig måde at gøre det på

Et meget detaljeret løsningsforslag må ikke i sig selv føre til en dårlig vurdering, hvis det underliggende behov er forståeligt.

🟢 når behovet kan identificeres, også selv om der foreslås en løsning.  
🟡 når behov og løsning er blandet sammen, men behovet stadig kan udledes.  
🔴 når beskrivelsen alene angiver en teknisk ændring, og det ikke er muligt at forstå formålet med den.

---

#### 5. Sammenhæng

**Hvad vurderes?**  
Om ændringsønsket indeholder nok kontekst til at forstå, hvor problemet opstår og hvilke dele af OS2sofd eller den omkringliggende løsning det vedrører.

Relevant sammenhæng kan fx være:

- berørt modul
- integration
- brugergruppe
- arbejdsgang
- datakilde
- konkret eksempel
- afhængighed til et andet system eller ændringsønske

Der kræves ikke komplet systemdokumentation.

🟢 når ændringsønsket kan placeres i en forståelig sammenhæng.  
🟡 når konteksten er begrænset, men behov og ændring stadig kan forstås.  
🔴 når det er uklart, hvor eller i hvilken arbejdsgang problemet opstår.

---

#### 6. Klarhed / afklaringsgrad

**Hvad vurderes?**  
Om beskrivelsen samlet set er konkret og entydig nok til, at en udvikler kan begynde den næste dialog.

Dette kriterium er **ikke** et mål for, om alle detaljer allerede er afklaret.

Spørgsmål som fx følgende hører normalt til den efterfølgende tekniske afklaring:

- præcis feltmapping
- håndtering af tomme værdier
- overwrite-regler
- API-adfærd
- tekniske undtagelser
- konfiguration
- detaljer i eksisterende kode

🟢 når en udvikler kan begynde afklaringen uden først at få genforklaret selve behovet.  
🟡 når der er enkelte uklarheder, som kan tages i den efterfølgende dialog.  
🔴 når behovet eller ønsket er så uklart, at opretter først må forklare det grundlæggende igen.

---

#### 7. Omfang / afgrænsning

**Hvad vurderes?**  
Om det er muligt nogenlunde at forstå, hvad ændringsønsket omfatter – og hvad den centrale opgave er.

Det handler ikke om at kende antal udviklingstimer eller have et færdigt estimat. Formålet er at opdage ønsker, der fx:

- indeholder flere forskellige behov i samme issue
- er så brede, at de bør opdeles
- reelt beskriver et større projekt frem for én ændring

🟢 når den centrale ændring er tilstrækkeligt afgrænset.  
🟡 når ønsket kan gå videre, men muligvis bør opdeles eller afgrænses under løsningsarbejdet.  
🔴 når det ikke er muligt at identificere en meningsfuld opgave uden først at få ønsket opdelt eller beskrevet nærmere.

---

#### 8. Prioriteringsgrundlag

**Hvad vurderes?**  
Om den oplyste prioritet virker rimeligt underbygget af beskrivelsen.

Der vurderes fx på:

- konsekvensen af problemet
- hvor mange der berøres
- driftsmæssig eller sikkerhedsmæssig betydning
- tidsmæssige afhængigheder
- manuelt merarbejde
- om en anden leverance er afhængig af ændringen

Ved **Høj** eller **Kritisk** forventes en tydeligere begrundelse end ved **Lav** eller **Mellem**.

🟢 når den oplyste prioritet virker forståelig og rimelig ud fra beskrivelsen.  
🟡 når prioriteten kan være rigtig, men grundlaget er usikkert.  
🔴 når den oplyste prioritet ikke hænger sammen med det beskrevne behov eller mangler nødvendig begrundelse.

Prioriteringsgrundlaget har en særlig rolle: kun ved 🟢 overføres den oplyste prioritet automatisk til GitHub Project.

### Kalibreringsprincip

Et ændringsønske er klart, når:

> behovet og den ønskede ændring er forståelige nok til, at en udvikler kan begynde teknisk afklaring, løsningsforslag og estimering.

Screeningen må derfor ikke kræve, at teknisk løsning, mappings, API-adfærd, undtagelser eller detaljer om implementeringen allerede er afklaret.

### Hvilke spørgsmål stilles hvornår?

Screeningen skelner mellem tre typer spørgsmål:

1. **Blokerende spørgsmål til opretter nu**  
   Kun spørgsmål der er nødvendige for at forstå selve behovet eller den ønskede ændring.

2. **Ikke-blokerende afklaringer senere**  
   Spørgsmål der kan tages mellem udvikler og opretter under løsningsbeskrivelse og estimering.

3. **Tekniske løsningsspørgsmål**  
   Hører normalt ikke til screeningen og skal som udgangspunkt ikke sendes tilbage til opretter på dette trin.

---

## Samlet vurdering

Der anvendes kun to samlede udfald:

### Klar til afklaring

Bruges når behov og ønsket ændring er tilstrækkeligt forståelige.

Issuet flyttes til:

**Afventer løsningsbeskrivelse**

### Returnér til opretter

Bruges kun når behovet eller den ønskede ændring ikke kan forstås tilstrækkeligt.

Issuet bliver i:

**Screening**

Opretter får konkrete spørgsmål i almindeligt, ikke-teknisk sprog.

---

## Prioritet

Prioritet overføres kun automatisk til GitHub Project, hvis:

**Prioriteringsgrundlag = 🟢 Tilstrækkeligt**

Hvis prioriteringsgrundlaget ikke er grønt:

- prioriteten sættes ikke automatisk
- PO får en særskilt kommentar om manuel vurdering

Undtagelse:

Hvis et issue **returneres til opretter**, behandles prioriteten ikke endnu. Den tages først op, når de nødvendige afklaringer foreligger.

---

## Kategorisering og labels

Der anvendes normalt:

- én primær faglig label
- højst én sekundær faglig label

En specifik label foretrækkes frem for den generelle label `funktionelle forbedringer`.

Proceslabels som fx:

- `duplicate`
- `særligt store opgaver`
- `wontfix`
- `ændringsønske`

betragtes ikke som faglige kategorier.

`ændringsønske` fjernes automatisk, når screeningen er gennemført.

`wontfix` må ikke sættes automatisk.

---

## GitHub-opdatering

Når screeningsresultatet er gemt som:

`OS2sofd-screening-resultat-aktuel.json`

køres først en DryRun:

```powershell
& "$env:USERPROFILE\Downloads\OS2sofd-screening-deploy-v17-fast-filnavn.ps1" `
  -Mode DryRun
```

Hvis resultatet ser korrekt ud, køres:

```powershell
& "$env:USERPROFILE\Downloads\OS2sofd-screening-deploy-v17-fast-filnavn.ps1" `
  -Mode Apply
```

Deploy-scriptet håndterer:

- screeningskommentar
- relevante labels
- fjernelse af `ændringsønske`
- status i GitHub Project
- prioritet efter gældende regler
- Kontakt
- Kommune
- JIRA-Id
- ping til opretter
- ping til leverandørteam ved klare ændringsønsker

---

## Pings

### Klar til afklaring

Opretter pinges.

Leverandørteamet pinges:

`@OS2sofd/leverandor-digital-identity`

Leverandøren kan derefter tage den nødvendige dialog med opretter om løsning og estimat.

### Returnér til opretter

Kun opretter pinges.

Leverandøren pinges ikke.

PO pinges ikke om prioritet på dette trin.

---

## Projektfelter

Følgende felter udfyldes automatisk fra issue-formularen, hvis feltet i Project er tomt:

- **Kontakt** ← `Navn`
- **Kommune** ← `Kommune`
- **JIRA-Id** ← `JIRA ID (hvis relevant)`

Eksisterende værdier overskrives ikke.

`No response` eller tomme værdier overføres ikke.

---

## Sporbarhed

Screeningskommentarer anvendes som dokumentation for vurderingen.

Eksisterende kommentarer slettes som udgangspunkt ikke.

Hvis en automatiseret kommentar viser sig at være forkert, bør den som udgangspunkt redigeres med en tydelig rettelse frem for at blive slettet.

---

## Teknisk forudsætning

PO-computeren skal have:

- GitHub CLI (`gh`)
- adgang til repo og GitHub Project
- nødvendige GitHub scopes
- PowerShell

Hvis PowerShell blokerer scripts i en ny session:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
```

Dette gælder kun den aktuelle PowerShell-session.

---

## Kendt begrænsning

AI-screeningen sker endnu ikke direkte fra PowerShell-scriptet.

Den aktuelle proces er derfor:

**GitHub → eksportfil → AI-screening → resultatfil → GitHub**

En senere automatisering kan koble en LLM/API direkte på processen, men det bør først ske, når den nuværende screeningsmodel er stabil og dokumenteret.
