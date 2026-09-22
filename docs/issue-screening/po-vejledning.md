# PO-vejledning – screening og review af OS2sofd-ændringsønsker

Denne vejledning er den korte arbejdsgang for Product Owner.

---

## Før du starter

Fra en frisk PowerShell-session:

```powershell
cd "C:\Users\ehp\OneDrive - Syddjurs Kommune\Dokumenter\GitHub\Issues\issue-screening"
Get-ChildItem *.ps1 | Unblock-File
```

`Set-ExecutionPolicy -Scope Process Bypass` skal normalt **ikke** længere køres. PowerShell er sat til `RemoteSigned` for den aktuelle bruger.

Scriptsene håndterer selv UTF-8/tegnsætning.

### Kontrollér GraphQL-kvote før større Apply-kørsler

GitHub Projects bruger GraphQL. REST-kaldet `gh api rate_limit` kan vise en misvisende værdi for GraphQL-kvoten og skal derfor ikke bruges som kontrol før batch-Apply.

Brug i stedet GraphQLs egen `rateLimit`:

```powershell
$g = gh api graphql -f query='query { rateLimit { limit remaining used resetAt } }' | ConvertFrom-Json
$g.data.rateLimit
```

Kontrollér især `remaining` og `resetAt`.

Batch-deploy-scriptet laver desuden selv en GraphQL-preflight før `Apply` og stopper, før noget skrives, hvis kvoten er for lav.

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

## Når der foreligger løsningsbeskrivelser

Når issues står i **Klar til prioritering**, gennemføres PO-review efter `po-review-loesningsbeskrivelser-v1.md`.

Reviewet indfører ikke en ny status.

### Standardproces – find alle aktuelle reviewbehov

Kør:

```powershell
.\OS2sofd-find-loesningsreview-behov.ps1
```

Scriptet gennemgår alle issues i **Klar til prioritering** og opdeler dem i:

- mangler første PO-review
- mulige opfølgende reviews pga. nye relevante kommentarer
- ingen handling nødvendig

Automatiske proceskommentarer som screening, tidligere PO-review og KG-notifikation tæller ikke som nyt fagligt reviewgrundlag.

Scriptet opretter én samlet fil:

`OS2sofd-loesningsreview-input.json`

### Upload samlet review-input til ChatGPT

Upload:

`OS2sofd-loesningsreview-input.json`

Reviewet gennemføres efter de syv kriterier i `po-review-loesningsbeskrivelser-v1.md`.

Resultatet gemmes som:

`OS2sofd-loesningsreview-resultat.json`

Resultatfilen kan indeholde både deploybare reviews og sager, der skal springes over, fx hvis der endnu ikke findes en reel leverandør-løsningsbeskrivelse.

### Kontrollér hele batchen med DryRun

Kør:

```powershell
.\OS2sofd-loesningsreview-deploy-batch.ps1 -Mode DryRun
```

DryRun:

- gennemgår alle deploybare reviews
- viser reviewkommentar og samlet vurdering pr. issue
- viser mål-estimat
- springer markerede ikke-deploybare sager over
- skriver intet til GitHub
- bruger ikke GraphQL til estimatkontrol

Kontrollér især:

- ændringens karakter
- relevans og 🟢 / 🟡 / 🔴 pr. kriterium
- at opmærksomhedspunkterne er dokumenterede og ikke spekulative
- eventuelle afklaringsspørgsmål
- `@mention` af løsningsforfatteren
- om kontaktpersonen kun nævnes, når input fra kontaktpersonen er relevant
- estimatet
- hvilke issues der springes over

### Gennemfør hele batchen

Før `Apply` kan GraphQL-kvoten kontrolleres manuelt:

```powershell
$g = gh api graphql -f query='query { rateLimit { limit remaining used resetAt } }' | ConvertFrom-Json
$g.data.rateLimit
```

Kør derefter:

```powershell
.\OS2sofd-loesningsreview-deploy-batch.ps1 -Mode Apply
```

Batch-scriptet laver selv preflight og stopper **før noget skrives**, hvis GraphQL-kvoten er for lav.

Ved `Apply`:

- Project-feltet **Estimat** udfyldes eller opdateres automatisk
- reviewkommentaren oprettes på hvert deploybart issue
- tidligere reviewkommentarer overskrives ikke
- ikke-deploybare sager springes over

Hvis batchen stopper midt i en Apply-kørsel, kan den samme resultatfil køres igen efter rettelse. Enkeltsags-deployet beskytter mod dublet-reviewkommentarer.

### Notifikation til koordinationsgruppen

Efter Apply køres workflowet **Notificer Klar til prioritering**.

Koordinationsgruppen notificeres kun, når:

- status er **Klar til prioritering**
- **Estimat** er udfyldt
- seneste PO-review er 🟢 eller 🟡
- koordinationsgruppen ikke allerede er notificeret

Et 🔴 review stopper automatisk KG-notifikationen.

### Opfølgende review

Ved næste kørsel af:

```powershell
.\OS2sofd-find-loesningsreview-behov.ps1
```

medtages et allerede reviewet issue kun som opfølgende kandidat, hvis der er kommet nye kommentarer efter seneste review.

Kun fagligt relevante nye oplysninger skal føre til et nyt review. Et opfølgende review skrives som en **ny GitHub-kommentar**, så historikken bevares.

### Enkeltsagskørsel ved behov

Hvis PO ønsker at behandle ét bestemt issue uden batch, kan den eksisterende enkeltsagsproces fortsat bruges:

```powershell
.\OS2sofd-find-loesningsreview.ps1 -IssueNumber 105
```

og efter review:

```powershell
.\OS2sofd-loesningsreview-deploy.ps1 `
  -ResultPath ".\OS2sofd-loesningsreview-resultat-105.json" `
  -Mode DryRun
```

Efter kontrol ændres `DryRun` til `Apply`.

### PO-overblikket

`docs/po-overblik.md` indeholder et særskilt afsnit **Review af løsningsbeskrivelser** med bl.a.:

- antal issues i **Klar til prioritering**
- manglende PO-review
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

### GraphQL-rate-limit

GitHub Projects bruger GraphQL. Kontrollér derfor kvoten direkte via GraphQL:

```powershell
$g = gh api graphql -f query='query { rateLimit { limit remaining used resetAt } }' | ConvertFrom-Json
$g.data.rateLimit
```

Hvis `remaining` er lav, vent til `resetAt` før en større `Apply`.

Brug ikke `gh api rate_limit` som eneste kontrol for Project-batchkørsler, da den kan vise en anden eller forældet GraphQL-værdi.

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
