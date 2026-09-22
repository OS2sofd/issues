# Kørevejledning – PO-review af løsningsbeskrivelser

Denne vejledning beskriver den praktiske kørsel af PO-review for OS2sofd-ændringsønsker i **Klar til prioritering**.

Den faglige reviewmodel findes i:

`docs/issue-screening/po-review-loesningsbeskrivelser-v1.md`

---

## 1. Start fra en frisk PowerShell

Kør:

```powershell
cd "C:\Users\ehp\OneDrive - Syddjurs Kommune\Dokumenter\GitHub\Issues\issue-screening"
Get-ChildItem *.ps1 | Unblock-File
```

`Set-ExecutionPolicy -Scope Process Bypass` skal normalt ikke bruges længere. `CurrentUser` er sat til `RemoteSigned`.

---

## 2. Find alle aktuelle reviewbehov

Kør:

```powershell
.\OS2sofd-find-loesningsreview-behov.ps1
```

Scriptet gennemgår alle issues i **Klar til prioritering**.

Det medtager:

- issues der mangler første PO-review
- allerede reviewede issues med nye kommentarer siden seneste review

Det springer over:

- allerede reviewede issues uden nye kommentarer
- automatiske proceskommentarer som ikke udgør nyt fagligt reviewgrundlag

Resultatet gemmes som:

`OS2sofd-loesningsreview-input.json`

---

## 3. Upload samlet input til ChatGPT

Upload:

`OS2sofd-loesningsreview-input.json`

Reviewet gennemføres efter:

`po-review-loesningsbeskrivelser-v1.md`

Det samlede resultat gemmes som:

`OS2sofd-loesningsreview-resultat.json`

Et item kan markeres som ikke-deploybart, fx hvis generatoren ikke har fundet en reel leverandør-løsningsbeskrivelse. Sådanne items springes over ved deploy.

---

## 4. DryRun af hele batchen

Kør:

```powershell
.\OS2sofd-loesningsreview-deploy-batch.ps1 -Mode DryRun
```

DryRun:

- gennemgår alle deploybare reviews
- viser reviewkommentaren pr. issue
- viser mål-estimat
- springer ikke-deploybare items over
- skriver intet til GitHub
- bruger ingen GraphQL-kald til estimatkontrol

Kontrollér især vurderinger, opmærksomhedspunkter, `@mentions`, estimater og hvilke sager der springes over.

---

## 5. Kontrollér GraphQL-kvote før Apply

GitHub Projects bruger GraphQL.

Brug ikke kun:

```powershell
gh api rate_limit
```

Det kan vise en anden eller forældet værdi end den kvote, `gh project` faktisk bruger.

Brug i stedet:

```powershell
$g = gh api graphql -f query='query { rateLimit { limit remaining used resetAt } }' | ConvertFrom-Json
$g.data.rateLimit
```

Kontrollér især:

- `remaining`
- `used`
- `resetAt`

Batch-scriptet laver også selv denne preflight før Apply og stopper, før noget skrives, hvis kvoten er for lav.

---

## 6. Apply af hele batchen

Når DryRun er godkendt og GraphQL-kvoten er tilstrækkelig:

```powershell
.\OS2sofd-loesningsreview-deploy-batch.ps1 -Mode Apply
```

Apply:

- henter Project-data én gang for hele batchen
- udfylder/opdaterer **Estimat**
- opretter reviewkommentarer
- springer ikke-deploybare sager over
- bevarer tidligere reviewkommentarer

Hvis Apply stopper undervejs, kan samme batch køres igen efter rettelse. Enkeltsags-deployet beskytter mod dublet-reviewkommentarer.

---

## 7. Kør KG-notifikation

Efter en vellykket Apply køres GitHub Actions-workflowet:

**Notificer Klar til prioritering**

Notifikation sendes kun, når:

- issue står i **Klar til prioritering**
- **Estimat** er udfyldt
- seneste PO-review er 🟢 eller 🟡
- koordinationsgruppen ikke allerede er notificeret

Ved 🔴 review sendes ingen KG-notifikation.

---

## 8. Opfølgende review

Ved næste batchkørsel:

```powershell
.\OS2sofd-find-loesningsreview-behov.ps1
```

kan allerede reviewede issues blive markeret som opfølgende kandidater, hvis der er kommet nye fagligt relevante kommentarer.

Et opfølgende review skrives som en **ny GitHub-kommentar**.

---

## 9. Enkeltsagskørsel ved behov

Hvis kun ét bestemt issue skal behandles:

```powershell
.\OS2sofd-find-loesningsreview.ps1 -IssueNumber <issue>
```

Efter review:

```powershell
.\OS2sofd-loesningsreview-deploy.ps1 `
  -ResultPath ".\OS2sofd-loesningsreview-resultat-<issue>.json" `
  -Mode DryRun
```

og derefter `Apply`.

---

## 10. Kontaktperson og løsningsforfatter

- Forfatteren til løsningsbeskrivelsen notificeres kun med `@mention`, når reviewet indeholder konkrete afklarende spørgsmål.
- Kontaktpersonen fra ændringsønsket notificeres kun med `@mention`, når et afklarende spørgsmål kræver kontaktpersonens input.
- GitHub-issueforfatteren er ikke automatisk lig med kontaktpersonen.
- Automatikken må ikke gætte et GitHub-brugernavn.

---

## 11. Estimat

Estimat skrives i Project-feltet uden mellemrum før `kr`.

Eksempel:

`16.000kr`

Betingede priser skal fremgå som opmærksomhedspunkt i reviewet.

---

## Kort huskeregel

**Frisk PowerShell → find reviewbehov → upload samlet JSON → DryRun batch → GraphQL-kvote → Apply batch → KG-notifikation**

Ved 🔴:

**afklar først – ingen KG-notifikation**.
