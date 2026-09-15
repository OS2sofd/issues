# Leverandøroverblik v1 – specifikation

## Formål

Et fælles, leverandørneutralt styringsblik på leverandørdelen af OS2sofd's ændringsproces.

V1 har kun to aktive perspektiver:

1. **Flow og omløbstid**
2. **Gennemsigtighed**

Målsætningen er, at ændringsønsker som udgangspunkt kan bevæge sig fra idé til færdig løsning inden for **6 måneder**.

## Statusser i v1

Følgende Project-statusser indgår:

- Afventer løsningsbeskrivelse
- Bestilt hos leverandør
- Igangværende opgaver
- Løsninger i test

Følgende indgår ikke:

- Klar til prioritering – ejes af koordinationsgruppen/PO-processen.
- Løsninger i review – afventer nærmere afklaring og definition af ansvar, test, accept og næste handling.

## 1. Flow og omløbstid

Rapporten viser:

- antal sager pr. leverandørstatus
- median observeret tid i status
- ældste observerede tid i status
- antal sager over 30 dage i samme status
- antal sager med samlet GitHub-alder 4,5–6 måneder
- antal sager med samlet GitHub-alder over 6 måneder

Signaler:

- 🟡 mere end 30 dage i samme leverandørstatus
- 🔴 mere end 45 dage i samme leverandørstatus
- 🟠 samlet GitHub-alder 4,5–6 måneder
- 🔴 samlet GitHub-alder over 6 måneder

## 2. Gennemsigtighed

Rapporten viser kun undtagelser.

V1-regler:

- Afventer løsningsbeskrivelse:
  - ingen registreret opdatering efter 14 dage
  - rødt efter 30 dage
  - manglende estimat markeres efter 14 dage i status
- Bestilt hos leverandør:
  - planlagt release skal være angivet
- Igangværende opgaver:
  - ingen registreret opdatering efter 14 dage
- Løsninger i test:
  - ingen registreret opdatering efter 14 dage

For hver undtagelse vises:

- issue
- status
- problem
- næste handling

## Datamæssige forbehold

- Samlet alder beregnes fra GitHub-issuets oprettelsesdato. Migrerede ønsker kan reelt være ældre.
- Tid i status baseres på `data/po-overblik-history.json`.
- Hvis historikken begyndte efter at en sag gik ind i status, vises tiden som minimumstid (`≥`).
- GitHubs `updated_at` bruges som indikator for seneste opdatering. Det er en proxy og er ikke nødvendigvis en faglig statusopdatering.
- Rapporten placerer ikke automatisk skyld eller ansvar for en forsinkelse.

## Senere perspektiver

Når v1 fungerer i praksis, planlægges:

3. Dokumentation
4. Test og accept

`Løsninger i review` forventes først indarbejdet, når ansvar og proces for test/review/accept er defineret.
