# PO-vejledning – screening af nye OS2sofd-ændringsønsker

Denne vejledning er den korte arbejdsgang for Product Owner.

---

## Før du starter – hver ny PowerShell-session

Når et nyt PowerShell-vindue åbnes, skal scriptkørsel først tillades for den aktuelle session:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
```

Kommandoen kræver ikke administratorrettigheder og gælder kun det aktuelle PowerShell-vindue. Når vinduet lukkes, nulstilles indstillingen. Den skal derfor køres igen næste gang et nyt PowerShell-vindue åbnes.

Scriptsene håndterer selv UTF-8/tegnsætning, så der er ikke behov for yderligere initialisering.

Gå derefter til den faste arbejdsmappe:

```powershell
cd "C:\Users\ehp\OneDrive - Syddjurs Kommune\Dokumenter\GitHub\Issues\issue-screening"
```

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

## Senere i processen

Når et issue senere flyttes til **Klar til prioritering**, notificeres koordinationsgruppen via en særskilt GitHub-automatisering. Det er ikke en del af screening-deploy-scriptet.

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
- De forretningsmæssige acceptkriterier bør være på plads, inden sagen går videre fra løsningsbeskrivelse til prioritering/bestilling.

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

Kør:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
```

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

Den samlede lokale kørevejledning findes i:

`docs/issue-screening/koerevejledning-screening.md`

Den faste lokale arbejdsmappe er:

`C:\Users\ehp\OneDrive - Syddjurs Kommune\Dokumenter\GitHub\Issues\issue-screening`
