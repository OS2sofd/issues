# PO-overblik – dokumentation

Denne dokumentation beskriver formål, informationshierarki og signalregler for det automatiske PO-overblik i OS2sofd.

Den genererede rapport ligger i:

`docs/po-overblik.md`

Generatoren ligger i:

`scripts/po-overblik/generer-po-overblik.ps1`

Historik til afledt tid i status ligger i:

`data/po-overblik-history.json`

## Formål

PO-overblikket skal først og fremmest hjælpe Product Owner med at svare på:

> Hvad kræver min opmærksomhed nu?

Det er ikke meningen, at første skærm skal vise alle kendte oplysninger om alle issues. Detaljerne skal være tilgængelige, men skjult som standard.

Overblikket er derfor opbygget i tre lag:

1. **PO-cockpit** – konkrete handlinger og de vigtigste styringssignaler.
2. **Styringsbillede** – levering, flow og backlog-sundhed.
3. **Detaljer og analyse** – fulde tabeller og datagrundlag foldet sammen.

## 1. PO-cockpit

Første del af rapporten skal kunne aflæses hurtigt.

### PO-fokus lige nu

Kun forhold med et konkret handlingsbehov løftes til denne tabel.

Typiske signaler er:

- 🔴 rødt PO-review før prioritering
- 🔴 Kritisk/Høj uden opdatering i den aftalte periode
- 🔴 udløbet planlagt release
- 🔴 lukket GitHub-issue i aktiv Project-status
- 🟠 manglende prioritet
- 🟠 manglende estimat
- 🟠 manglende PO-review
- 🟠 manglende planlagt release
- 🟠 manglende assignee
- 🟡 test/review uden opdatering i den aftalte periode

Cockpit'et viser de konkrete issue-numre som links, så PO kan gå direkte til arbejdet.

## 2. Aktuel levering

Den aktuelle leverance vises kort med antal i:

- Bestilt hos leverandør
- Igangværende
- I test
- I review

Konkrete afvigelser fra leveranceflowet løftes til PO-fokus i stedet for at blive gentaget som lange tabeller øverst.

## 3. Flow

Flowdelen viser kun de vigtigste procesindikatorer:

- største aktuelle kø/flaskehals
- antal issues i `Klar til prioritering`
- samlet antal aktive ændringsønsker

`Klar til prioritering` er en normal processtatus og er **ikke i sig selv et PO-opmærksomhedssignal**.

Kun konkrete mangler eller afvigelser i disse issues løftes til PO-fokus, fx rødt review, manglende prioritet eller manglende estimat.

## 4. Backlog-sundhed og alder

Alder er et strategisk styringssignal, men ikke automatisk en konkret PO-handling.

Rapporten viser derfor bl.a.:

- antal aktive issues over 6 måneder
- antal issues mellem 4,5 og 6 måneder

Et issue løftes ikke til PO-fokus alene, fordi det er gammelt.

Alder bliver handlingsrelevant, når den kombineres med andre forhold, fx høj prioritet, manglende fremdrift eller leveranceproblemer.

### Begrænsning ved GitHub-alder

Alder beregnes fra GitHub-issuets oprettelsesdato. For ønsker migreret fra JIRA eller andre tidligere kilder kan den reelle alder være højere.

## 5. Detaljer og analyse

Alle detaljer bevares i rapporten, men ligger i sammenklappelige `<details>`-sektioner.

De omfatter bl.a.:

- PO-signaler og handlingsdetaljer
- omløbstid og kommunikation
- flow og flaskehalse
- Klar til prioritering
- review af løsningsbeskrivelser
- release-overblik
- hele pipeline
- proces- og datakvalitet
- datagrundlag og måleforbehold

Princippet er:

> Detaljer må gerne være omfattende, men de må ikke dominere det daglige PO-overblik.

## 6. Signalhierarki

| Signal | Betydning |
| --- | --- |
| 🔴 | Kræver konkret PO-afklaring eller handling nu |
| 🟠 | Manglende styringsdata eller procesopfølgning |
| 🟡 | Bør følges op, men er ikke nødvendigvis blokerende |
| ℹ️ | Styringsinformation uden direkte handling |

Et issue kan have flere underliggende signaler. Cockpit'et skal dog undgå at gentage samme issue unødigt.

## 7. PO-review og nye kommentarer

PO-review identificeres via de skjulte reviewmarkører i issue-kommentarerne.

Et nyt kommentarspor efter et review er kun et signal om, at relevansen bør vurderes. Det udløser ikke automatisk et nyt review.

Kun nye faglige oplysninger, der ændrer eller supplerer løsningsgrundlaget, bør føre til et opfølgende PO-review.

## 8. Datakilde og historik

GitHub Project **Fra idé til færdig løsning** er den autoritative datakilde.

`data/po-overblik-history.json` bruges til afledt status-historik.

Tid i status registreres fra automatiseringens første observation. Hvis et issue allerede stod i en status ved første observation, kan den reelle tid i status være længere end den viste.

## 9. Vedligeholdelsesprincipper

Når overblikket videreudvikles, skal følgende principper bevares:

1. Første skærm skal prioritere handling frem for information.
2. Normal processtatus må ikke behandles som fejl eller opmærksomhed i sig selv.
3. Alder må ikke alene gøre et issue rødt.
4. Detaljer skal bevares, men skjules som standard.
5. Samme information bør ikke gentages flere steder i den synlige top.
6. Nye signaler skal have en tydelig PO-handling eller et klart styringsformål.
7. Generatoren må kun læse fra GitHub og skrive den genererede rapport/historik gennem den eksisterende workflow-proces.

## 10. Kontrol efter ændringer i generatoren

Efter ændringer i `generer-po-overblik.ps1`:

1. kør GitHub Actions-workflowet manuelt
2. kontrollér, at jobbet gennemføres uden parser-/runtimefejl
3. åbn den genererede `docs/po-overblik.md`
4. kontrollér første skærm før de udfoldede detaljer
5. kontrollér at konkrete issue-links og antal stemmer med GitHub Project
6. kontrollér at normale `Klar til prioritering`-issues og ren alder ikke fylder PO-fokus unødigt
