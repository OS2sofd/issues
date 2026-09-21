# PO-vejledning – screening og review af OS2sofd-ændringsønsker

Denne vejledning er den korte arbejdsgang for Product Owner.

---

## Før du starter

PowerShell er sat til `RemoteSigned` for den aktuelle bruger. Derfor skal denne kommando normalt **ikke** længere køres i hver session:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
```

Hvis en ny downloadet `.ps1`-fil er blokeret af Windows, kan alle scripts i arbejds­mappen frigives med:

```powershell
Get-ChildItem *.ps1 | Unblock-File
```

Gå derefter til den faste arbejdsmappe:

```powershell
cd "C:\Users\ehp\OneDrive - Syddjurs Kommune\Dokumenter\GitHub\Issues\issue-screening"
```

Scriptsene håndterer selv UTF-8/tegnsætning.

---

## Når nye ændringsønsker skal behandles

### 1. Find nye ændringsønsker

Kør:

```powershell
.\OS2sofd-find-nye-aendringsoensker.ps1
```

Scriptet genererer:

`OS2sofd-nye-aendringsoensker.json`

Kontrollér, at scriptet viser det forventede antal nye ændringsønsker.

---

### 2. Upload filen til ChatGPT

Upload:

`OS2sofd-nye-aendringsoensker.json`

Bed om screening efter den aftalte OS2sofd-model.

Resultatet gemmes med dato, fx:

`OS2sofd-screening-resultat-20260918.json`

Den daterede fil beholdes som arkiv.

Kopiér derefter filen til det aktive filnavn, som deploy-scriptet læser:

```powershell
Copy-Item ".\OS2sofd-screening-resultat-20260918.json" ".\OS2sofd-screening-resultat-aktuel.json"
```

---

### 3. Kontrollér med DryRun

Kør:

```powershell
.\OS2sofd-screening-deploy-v17-fast-filnavn.ps1 -Mode DryRun
```

Kontrollér især:

- issue-nummer og titel
- ny status
- prioritet
- Kontakt
- Kommune
- JIRA-Id

DryRun ændrer ikke noget i GitHub.

---

### 4. Gennemfør opdateringen

Hvis DryRun ser korrekt ud:

```powershell
.\OS2sofd-screening-deploy-v17-fast-filnavn.ps1 -Mode Apply
```

Scriptet opdaterer derefter GitHub.

---

## Hvad sker der ved "Klar til afklaring"?

Issuet:

- flyttes til **Afventer løsningsbeskrivelse**
- får screeningskommentar
- får relevante labels
- mister label `ændringsønske`
- får Project-felter udfyldt
- får prioritet sat, hvis prioriteringsgrundlaget er grønt
- pinger opretter
- pinger leverandørteamet

PO skal normalt ikke gøre mere på dette trin.

---

## Hvad sker der ved "Returnér til opretter"?

Issuet:

- bliver i **Screening**
- får en screeningskommentar
- får konkrete spørgsmål til opretter
- pinger kun opretter
- får relevante labels
- mister label `ændringsønske`

Prioritet behandles ikke endnu.

Når opretter har svaret, skal issuet screenes igen.

---

## Når der foreligger en løsningsbeskrivelse

Når leverandøren har tilføjet en løsningsbeskrivelse og issuet står i **Klar til prioritering**, gennemføres PO-review efter `po-review-loesningsbeskrivelser-v1.md`.

Reviewet indfører ikke en ny status.

### 1. Opret review-input

Kør fx:

```powershell
.\OS2sofd-find-loesningsreview.ps1 -IssueNumber 105
```

Scriptet:

- henter det oprindelige issue
- identificerer den sandsynlige løsningsbeskrivelse
- medtager alle issue-kommentarer
- finder forfatteren til løsningsbeskrivelsen
- finder kontaktpersonen i ændringsønsket og forsøger sikkert at identificere kontaktens GitHub-bruger
- udlæser og normaliserer estimat, hvis det kan findes entydigt
- registrerer tidligere PO-reviews og nye kommentarer siden seneste review

Hvis issuet allerede er reviewet og der ikke er kommet nye kommentarer, stopper scriptet uden at oprette et nyt review-input.

### 2. Upload review-input til ChatGPT

Upload:

`OS2sofd-loesningsreview-input-<issue>.json`

Reviewet gennemføres efter de syv kriterier i `po-review-loesningsbeskrivelser-v1.md`.

Resultatet gemmes som:

`OS2sofd-loesningsreview-resultat-<issue>.json`

Brug samme filnavn igen ved senere opfølgende review. Reviewnummeret ligger i selve resultatfilen og i GitHub-kommentarens skjulte markør.

### 3. Kontrollér review med DryRun

Kør:

```powershell
.\OS2sofd-loesningsreview-deploy.ps1 `
  -ResultPath ".\OS2sofd-loesningsreview-resultat-105.json" `
  -Mode DryRun
```

Kontrollér især:

- ændringens karakter
- relevans og 🟢 / 🟡 / 🔴 pr. kriterium
- at opmærksomhedspunkterne er reelle og ikke spekulative
- eventuelle afklaringsspørgsmål
- `@mention` af løsningsforfatteren
- om kontaktpersonen kun nævnes, når dennes input er relevant
- estimatet

DryRun ændrer ikke GitHub.

### 4. Gennemfør reviewet

Hvis DryRun ser korrekt ud:

```powershell
.\OS2sofd-loesningsreview-deploy.ps1 `
  -ResultPath ".\OS2sofd-loesningsreview-resultat-105.json" `
  -Mode Apply
```

Ved `Apply`:

- Project-feltet **Estimat** udfyldes eller opdateres automatisk
- reviewkommentaren oprettes på issuet
- et eksisterende review overskrives ikke

### 5. Hvad sker der bagefter?

Den særskilte notifikationsautomatik vurderer issuet.

Koordinationsgruppen notificeres kun, når:

- status er **Klar til prioritering**
- **Estimat** er udfyldt
- seneste PO-review er 🟢 eller 🟡
- koordinationsgruppen ikke allerede er notificeret

Et 🔴 PO-review stopper automatisk KG-notifikationen. PO afgør derefter, om sagen skal afklares i samme status eller flyttes tilbage til **Afventer løsningsbeskrivelse**.

Et 🟡 review er ikke blokerende.

### 6. Nye kommentarer efter et review

Et issue reviewes ikke igen alene, fordi processen kører igen.

Hvis der kommer nye kommentarer efter seneste review:

- input-generatoren registrerer dem
- PO/AI vurderer, om de er relevante for beslutningsgrundlaget
- kun relevante nye oplysninger giver et opfølgende review
- opfølgende review skrives som en **ny GitHub-kommentar**
- gamle reviews redigeres ikke

Automatiske proceskommentarer skal ikke i sig selv udløse nyt review.

### 7. PO-overblikket

`docs/po-overblik.md` indeholder et særskilt afsnit **Review af løsningsbeskrivelser** med bl.a.:

- antal issues i **Klar til prioritering**
- antal reviewede issues
- issues der mangler PO-review
- gule/røde reviews
- estimat
- opmærksomhedspunkter
- nye kommentarer efter seneste review

---

## Kort fortolkning af screeningskriterierne

PO behøver ikke selv gennemføre hele vurderingen manuelt, men bør kende betydningen af kriterierne:

| Kriterium | Det centrale spørgsmål |
| --- | --- |
| Forretningsbehov | Er det forståeligt, hvilket problem eller behov der findes i dag? |
| Forretningsværdi | Er det forståeligt, hvilken nytte ændringen forventes at skabe? |
| Ønsket ændring | Er det forståeligt, hvad opretter ønsker ændret? |
| Behov vs. løsning | Kan behovet skelnes fra et eventuelt foreslået teknisk løsningsforslag? |
| Sammenhæng | Er der nok kontekst til at forstå, hvor og hvornår behovet opstår? |
| Klarhed / afklaringsgrad | Kan en udvikler begynde den tekniske afklaring uden først at få behovet genforklaret? |
| Omfang / afgrænsning | Er den centrale opgave tilstrækkeligt afgrænset til at kunne behandles? |
| Prioriteringsgrundlag | Virker den oplyste prioritet rimeligt underbygget? |

Et gult kriterium er ikke i sig selv grund til at returnere et ændringsønske. Den afgørende test er, om behovet og den ønskede ændring er forståelige nok til, at udvikleren kan gå videre med afklaring, løsningsforslag og estimat.

Den fulde definition af kriterierne findes i `screening-proces.md`.

---

## Acceptkriterier – hvem gør hvad?

Færdige acceptkriterier er ikke et krav for at bestå screeningen.

- **Opretter** beskriver behovet og gerne, hvordan man vil kunne se, at ændringen virker.
- **PO** formulerer de forretningsmæssige acceptkriterier.
- **Leverandøren** kvalificerer dem teknisk og kan supplere med tekniske testkriterier.
- PO-reviewet skal vurdere, om løsningsbeskrivelsen giver tilstrækkeligt grundlag for senere test og accept. De forretningsmæssige acceptkriterier bør være på plads, inden løsningen bestilles til udvikling.

---

## Hvornår skal PO reagere manuelt?

PO skal reagere, hvis:

- scriptet viser fejl
- prioriteringsgrundlaget ikke er grønt på et ellers klart issue
- en mulig dublet kræver vurdering
- en opgave ser ud til at være usædvanligt stor
- et returneret issue er blevet suppleret af opretter
- en label eller status ikke virker korrekt
- DryRun melder, at en foreslået repo-label mangler
- et PO-review er 🔴 og kræver afklaring før prioritering
- et allerede reviewet issue har fået nye fagligt relevante kommentarer
- kontaktpersonen i ændringsønsket ikke kan identificeres korrekt, når kontaktens input er nødvendigt

---

## Vigtige principper

1. Screeningen vurderer **ændringsønsket**, ikke personen der har oprettet det.
2. Der kræves ikke en færdig teknisk løsning før et issue kan gå videre.
3. Spørg kun opretter om oplysninger, der er nødvendige for at forstå behovet eller den ønskede ændring.
4. Tekniske løsningsspørgsmål hører normalt til dialogen med udvikleren.
5. Eksisterende kommentarer slettes som udgangspunkt ikke.
6. `wontfix` sættes aldrig automatisk.

---

## Hvis noget går galt

### "Kan ikke finde deployment-filen"

Kontrollér, at denne fil findes i den faste arbejdsmappe:

`C:\Users\ehp\OneDrive - Syddjurs Kommune\Dokumenter\GitHub\Issues\issue-screening\OS2sofd-screening-resultat-aktuel.json`

Deploy-scriptet læser som standard resultatfilen fra samme mappe som scriptet.

### "Manglende repo-labels"

Hvis DryRun stopper med fx:

`STOP/FEJL: Manglende repo-labels: ...`

skal `Apply` ikke køres.

Kontrollér først, om en eksisterende repo-label allerede dækker området. Genbrug eksisterende taksonomi frem for at oprette næsten ens labels. Opret kun en ny label, hvis kategorien reelt mangler.

### Scriptet må ikke køres

Hvis filen er downloadet og blokeret af Windows, kør:

```powershell
Get-ChildItem *.ps1 | Unblock-File
```

Kontrollér om nødvendigt brugerens policy:

```powershell
Get-ExecutionPolicy -List
```

`CurrentUser` bør normalt stå som `RemoteSigned`.

### API-rate-limit

Kontrollér GitHub-kvoten:

```powershell
$rl = gh api rate_limit | ConvertFrom-Json
$rl.resources.graphql | Format-List limit,remaining,used
[DateTimeOffset]::FromUnixTimeSeconds($rl.resources.graphql.reset).ToLocalTime()
```

Hvis kvoten er opbrugt, vent til reset og kør igen.

### Er du i tvivl?

Kør altid `-Mode DryRun` først. DryRun ændrer ikke GitHub.


---

## Relateret kørevejledning

Den samlede lokale kørevejledning for screening findes i:

`docs/issue-screening/koerevejledning-screening.md`

Kørevejledningen for PO-review af løsningsbeskrivelser findes i:

`docs/issue-screening/koerevejledning-loesningsreview.md`

Reviewkriterier og regler findes i:

`docs/issue-screening/po-review-loesningsbeskrivelser-v1.md`

Den faste lokale arbejdsmappe er:

`C:\Users\ehp\OneDrive - Syddjurs Kommune\Dokumenter\GitHub\Issues\issue-screening`
