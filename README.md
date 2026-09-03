# OS2sofd issues

Dette repository bruges til håndtering og dokumentation af ændringsønsker til OS2sofd.

Her samles ændringsønsker, issue-skabeloner, procesdokumentation og hjælpeværktøjer til den fælles behandling af ønsker fra kommuner, leverandører og øvrige bidragydere.

## Arbejdsgang for ændringsønsker

Nye ændringsønsker oprettes som GitHub Issues og behandles i det fælles GitHub Project:

**Fra idé til færdig løsning**

Projektet bruges til at følge ændringsønsker gennem bl.a.:

- Nye ændringsønsker
- Screening
- Afventer løsningsbeskrivelse
- Klar til prioritering
- Bestilt hos leverandør
- Igangværende opgaver
- Løsninger i test
- Løsninger i review
- Afsluttede løsninger

## Screening af nye ændringsønsker

Der er etableret en fast screeningsproces, som hjælper Product Owner med at vurdere, om et nyt ændringsønske er beskrevet godt nok til at gå videre til teknisk afklaring, løsningsforslag og estimering.

Dokumentation:

- [Screeningproces](docs/issue-screening/screening-proces.md)
- [PO-vejledning](docs/issue-screening/po-vejledning.md)
- [Oversigt over screening](docs/issue-screening/README.md)

Scripts:

- [Find nye ændringsønsker](scripts/issue-screening/OS2sofd-find-nye-aendringsoensker.ps1)
- [Deploy screeningsresultat](scripts/issue-screening/OS2sofd-screening-deploy-v17-fast-filnavn.ps1)

## Principper

Behandlingen af ændringsønsker bygger på nogle enkle principper:

- Behovet skal være forståeligt før løsningen designes.
- Opretter behøver ikke beskrive den tekniske løsning.
- Tekniske detaljer afklares sammen med udvikler i næste trin.
- Screeningen skal være ensartet, gennemsigtig og sporbar.
- Eksisterende kommentarer slettes som udgangspunkt ikke.
- Labels og Project-felter bruges til at skabe struktur og overblik.

## Bidrag

Alle med relevante ændringsønsker kan oprette et issue via de tilgængelige issue-skabeloner.

Ved spørgsmål til proces, prioritering eller screening henvises til Product Owner for OS2sofd.
