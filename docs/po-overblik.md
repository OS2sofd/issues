# PO-overblik – OS2sofd ændringsønsker

> **Formål:** PO-styring af ændringsønsker med særligt fokus på omløbstid, kommunikation, prioritering og releasefremdrift.

Senest genereret: **22-09-2026 02:40**  
Mål for omløbstid: **maks. 6 måneder fra idé til færdig løsning**  
Aktuel release: **3. kvartal 2026**

> **Om alder:** Alder beregnes fra GitHub-issuets oprettelsesdato. For ønsker, der er migreret fra JIRA eller andre tidligere kilder, kan den reelle alder fra idé til færdig løsning derfor være højere.

> **Om tid i status:** Statushistorikken registreres fra den dag denne automatisering tages i brug. ≥ betyder, at issuet allerede stod i status ved første observation, så den reelle tid i status kan være længere.

---

## 1. Kræver PO-opmærksomhed

### Samlet PO-signal

| Signal | Område | Antal |
| --- | --- | ---: |
| 🔴 | GitHub-alder over 6 måneder | 20 |
| 🔴 | Udløbet planlagt release | 0 |
| 🔴 | Kritisk/Høj uden opdatering i mindst 14 dage | 1 |
| 🔴 | Lukket GitHub-issue i aktiv Project-status | 0 |
| 🔵 | Klar til prioritering | 29 |
| 🔴 | Klar til prioritering uden prioritet | 7 |
| 🔴 | Klar til prioritering uden estimat | 17 |
| 🟡 | Klar til prioritering uden PO-review | 25 |
| 🔴 | PO-review kræver afklaring | 1 |
| ⚠️ | Reviewede issues med nye kommentarer | 0 |
| 🟡 | Bestilt/igangværende uden planlagt release | 3 |
| ℹ️ | Bestilt/igangværende uden assignee | 3 |
| 🟡 | Test/review uden opdatering i mindst 14 dage | 0 |
| ⚠️ | Kommunikation bør vurderes | 1 |
| 🟠 | GitHub-alder 4,5–6 måneder | 9 |

### Foreslåede næste PO-handlinger

- Følg op på **1** Kritisk/Høj-prioriteret issue(s) uden opdatering i mindst 14 dage.
- Fastlæg prioritet på **7** issue(s) i **Klar til prioritering**.
- Få estimat på **17** issue(s) i **Klar til prioritering**.
- Gennemfør PO-review af løsningsbeskrivelsen på **25** issue(s) i **Klar til prioritering**.
- Afklar **1** issue(s), hvor PO-reviewet er rødt, før koordinationsgruppens prioritering.
- Fastlæg planlagt release på **3** bestilt/igangværende issue(s).
- Vurder om der bør sættes assignee på **3** bestilt/igangværende issue(s).
- Vurder individuel statuskommunikation på **1** ældre issue(s).
- Forbered generel kommunikation om backlog, ekstra ressourcer og målet om højst 6 måneders omløbstid.

<details>
<summary>Vis konkrete issues, der kræver PO-opmærksomhed (72)</summary>

| Signal | Issue | Status | Prioritet | Alder | PO-opmærksomhed |
| --- | --- | --- | --- | ---: | --- |
| 🔴 🟡 | [#109 – Dobbelt hierarki: Lønhierarki og den administrative organisation. Oprettelse af det administrative hierarki foretages pba. LOS-koblinger og strukturerede valideringer.Ændringsønske](https://github.com/OS2sofd/issues/issues/109) | Afventer løsningsbeskrivelse | Høj | 39 dage / 1.3 mdr. | Høj-prioritet uden registreret opdatering i 18 dage; Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🔴 🟡 🔵 | [#17 – SOFD GUI: Udvidet overblik over tilhørsforhold og typer](https://github.com/OS2sofd/issues/issues/17) | Klar til prioritering | Mellem | 185 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler PO-review af løsningsbeskrivelsen |
| 🔴 🟡 | [#21 – SOFD indlæsning fra lønsystem: Mulighed for selv at administrere indlæsningsfiltre](https://github.com/OS2sofd/issues/issues/21) | Afventer løsningsbeskrivelse | Mellem | 185 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🔴 🟡 🔵 | [#9 – Person tilhørsforhold - Tilføj markering af primært tilhørsforhold](https://github.com/OS2sofd/issues/issues/9) | Klar til prioritering | Mellem | 185 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler PO-review af løsningsbeskrivelsen |
| 🔴 🟡 | [#23 – Samlet overblik over diverse opmærkninger/fravalg af enheder](https://github.com/OS2sofd/issues/issues/23) | Afventer løsningsbeskrivelse | Mellem | 185 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🔴 🟡 | [#19 – SOFD GUI: Bloker oprettelse af manuelle tilhørsforhold af typen "Medarbejder" når man kører med sync fra et lønsystem](https://github.com/OS2sofd/issues/issues/19) | Afventer løsningsbeskrivelse | Mellem | 185 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🔴 🟡 | [#13 – SofdCoreADReplicator - Handlinger ved grupper](https://github.com/OS2sofd/issues/issues/13) | Afventer løsningsbeskrivelse | Mellem | 185 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🔴 | [#22 – Brug af AD konto ved opsætning af 'manuelt valgt' leder på enhed](https://github.com/OS2sofd/issues/issues/22) | Screening | Mellem | 185 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes |
| 🔴 🟡 🔵 | [#11 – Tilføj information om en AD konto er i brug + understøtte LocalExtensions i Mail skabeloner](https://github.com/OS2sofd/issues/issues/11) | Klar til prioritering | Mellem | 185 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler PO-review af løsningsbeskrivelsen |
| 🔴 | [#10 – Udvid SOFDCoreADWritebackAgent til at understøtte forsk. OU'er](https://github.com/OS2sofd/issues/issues/10) | Screening | Mellem | 185 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes |
| 🔴 🟡 🔵 | [#25 – Brugertjek: Udvidelse af informationer i tilhørforholdstabellen](https://github.com/OS2sofd/issues/issues/25) | Klar til prioritering | Mellem | 184 dage / 6 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler PO-review af løsningsbeskrivelsen |
| 🔴 🟡 🔵 | [#27 – Oprettelse af KSP/CICS konti på baggrund af rolletildelinger](https://github.com/OS2sofd/issues/issues/27) | Klar til prioritering | Mellem | 184 dage / 6 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler PO-review af løsningsbeskrivelsen |
| 🔴 🟡 🔵 | [#36 – Auto-opdatere enheder i FK Organisation ved nye KLE emner](https://github.com/OS2sofd/issues/issues/36) | Klar til prioritering | Mellem | 179 dage / 5.9 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler estimat; Klar til prioritering, men mangler PO-review af løsningsbeskrivelsen |
| 🔴 🟡 🔵 | [#73 – OS2sofd Kommunikationsmodul - Ønsker til forbedringer](https://github.com/OS2sofd/issues/issues/73) | Klar til prioritering | Mellem | 95 dage / 3.1 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler estimat; Klar til prioritering, men mangler PO-review af løsningsbeskrivelsen |
| 🔴 🟡 🔵 | [#83 – At kunne gøre data felter obligatoriske ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/83) | Klar til prioritering | Mellem | 82 dage / 2.7 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler estimat; Klar til prioritering, men mangler PO-review af løsningsbeskrivelsen |
| 🔴 🟡 🔵 | [#97 – Vedligehold/rettidige opdateringer af Autorisationskoder](https://github.com/OS2sofd/issues/issues/97) | Klar til prioritering | Mellem | 63 dage / 2.1 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler estimat; Klar til prioritering, men mangler PO-review af løsningsbeskrivelsen |
| 🔴 🟡 🔵 | [#121 – Ændringsønske - Udfordring ved flere mobilnumre til samme person](https://github.com/OS2sofd/issues/issues/121) | Klar til prioritering | Mellem | 4 dage / 0.1 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler estimat; Klar til prioritering, men mangler PO-review af løsningsbeskrivelsen |
| 🔴 🟡 🔵 | [#15 – Behov for at kunne vise forskelligt displaynavn på ansatte med flere tilhørsforhold/AD-konti](https://github.com/OS2sofd/issues/issues/15) | Klar til prioritering | Lav | 185 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler estimat; Klar til prioritering, men mangler PO-review af løsningsbeskrivelsen |
| 🔴 🟡 | [#18 – Brugertjek: Uddybelse af Entra licenser](https://github.com/OS2sofd/issues/issues/18) | Afventer løsningsbeskrivelse | Lav | 185 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🔴 🟡 🔵 | [#24 – Prefix i AD Event Dispatcher](https://github.com/OS2sofd/issues/issues/24) | Klar til prioritering | Lav | 185 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler estimat; Klar til prioritering, men mangler PO-review af løsningsbeskrivelsen |
| 🔴 🟡 | [#29 – Brugertjek: Mulighed for genveje og dybe links](https://github.com/OS2sofd/issues/issues/29) | Afventer løsningsbeskrivelse | Lav | 184 dage / 6 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🔴 🟡 | [#26 – Brugertjek: Robot-flag for robotter](https://github.com/OS2sofd/issues/issues/26) | Afventer løsningsbeskrivelse | Lav | 184 dage / 6 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🔴 🟡 | [#28 – Brugertjek: Kontrol af lønsystem konto](https://github.com/OS2sofd/issues/issues/28) | Afventer løsningsbeskrivelse | Lav | 184 dage / 6 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🔴 🟡 🔵 | [#78 – Bjælke for oven og i venstre side, skal fryses fast](https://github.com/OS2sofd/issues/issues/78) | Klar til prioritering | Lav | 87 dage / 2.9 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler estimat; Klar til prioritering, men mangler PO-review af løsningsbeskrivelsen |
| 🔴 🟡 🔵 | [#93 – Berigelse af titelfelt for skoleelever med klassetrin](https://github.com/OS2sofd/issues/issues/93) | Klar til prioritering | Lav | 81 dage / 2.7 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler estimat; Klar til prioritering, men mangler PO-review af løsningsbeskrivelsen |
| 🔴 🟡 🔵 | [#91 – Opslag i MitID Erhverv ved for at se om bruger har et aktivt tildelt MitID Erhverv](https://github.com/OS2sofd/issues/issues/91) | Klar til prioritering | Lav | 81 dage / 2.7 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler estimat; Klar til prioritering, men mangler PO-review af løsningsbeskrivelsen |
| 🔴 🟡 🔵 | [#96 – Vis detaljer om hvem der har bestilt/oprettet en konto undrer ordre-detaljer](https://github.com/OS2sofd/issues/issues/96) | Klar til prioritering | Lav | 67 dage / 2.2 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler estimat; Klar til prioritering, men mangler PO-review af løsningsbeskrivelsen |
| 🔴 🟡 🔵 | [#113 – Indlæsning af Mit Erhverv status til OS2Sofd](https://github.com/OS2sofd/issues/issues/113) | Klar til prioritering | Lav | 18 dage / 0.6 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler estimat; Klar til prioritering, men mangler PO-review af løsningsbeskrivelsen |
| 🔴 🟡 🔵 | [#119 – Forbedret logning/dokumentation af ordredannelser.](https://github.com/OS2sofd/issues/issues/119) | Klar til prioritering | Lav | 6 dage / 0.2 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler estimat; Klar til prioritering, men mangler PO-review af løsningsbeskrivelsen |
| 🔴 🟡 🔵 | [#120 – Advarsel omkring bestilling af Brugerkonti når man anvender bindingsmodellen](https://github.com/OS2sofd/issues/issues/120) | Klar til prioritering | Lav | 6 dage / 0.2 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler estimat; Klar til prioritering, men mangler PO-review af løsningsbeskrivelsen |
| 🔴 | [#16 – Navne- og adressebeskyttelse:](https://github.com/OS2sofd/issues/issues/16) | Screening | – | 185 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes |
| 🔴 🟡 | [#12 – Forstå forskel på Ansatte, Eksterne, Byrøddet, Konsulenter, Vikarer, m.m. typer af AD konti](https://github.com/OS2sofd/issues/issues/12) | Afventer løsningsbeskrivelse | – | 185 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🔴 🟡 | [#30 – OS2sofd - ILM: Vedligeholdelse af Fortrolighedsaftale](https://github.com/OS2sofd/issues/issues/30) | Afventer løsningsbeskrivelse | – | 184 dage / 6 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🔴 🟡 🔵 | [#59 – OS2sofd - ilm: udfyld displayName ved oprettelse af konsulent](https://github.com/OS2sofd/issues/issues/59) | Klar til prioritering | – | 122 dage / 4 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler prioritet; PO-review har opmærksomhedspunkter |
| 🔴 🔵 | [#58 – OS2sofd - ilm - udfyld UPN ved oprettelse af konsulentkonto](https://github.com/OS2sofd/issues/issues/58) | Klar til prioritering | – | 122 dage / 4 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler prioritet; PO-review kræver afklaring før prioritering |
| 🔴 🟡 🔵 | [#62 – Udvidelse af Opus-integrationen med mulighed for at overføre flere brugerkontotyper](https://github.com/OS2sofd/issues/issues/62) | Klar til prioritering | – | 111 dage / 3.6 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler prioritet; Klar til prioritering, men mangler estimat; Klar til prioritering, men mangler PO-review af løsningsbeskrivelsen |
| 🔴 🟡 🔵 | [#86 – OS2Vikar mulighed for at angive tid ved oprettelse af vikar](https://github.com/OS2sofd/issues/issues/86) | Klar til prioritering | – | 81 dage / 2.7 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler prioritet; Klar til prioritering, men mangler estimat; Klar til prioritering, men mangler PO-review af løsningsbeskrivelsen |
| 🔴 🟡 🔵 | [#101 – OS2ILM: Tildeling af leder via Virksomhed](https://github.com/OS2sofd/issues/issues/101) | Klar til prioritering | – | 40 dage / 1.3 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler prioritet; Klar til prioritering, men mangler PO-review af løsningsbeskrivelsen |
| 🔴 🟡 🔵 | [#105 – OS2ILM: Flytning af ILM-oprettede konsulenter](https://github.com/OS2sofd/issues/issues/105) | Klar til prioritering | – | 40 dage / 1.3 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler prioritet; PO-review har opmærksomhedspunkter |
| 🔴 🟡 🔵 | [#112 – Migrering til Datafordeleren til CPR opslag](https://github.com/OS2sofd/issues/issues/112) | Klar til prioritering | – | 32 dage / 1.1 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler prioritet; Klar til prioritering, men mangler estimat; Klar til prioritering, men mangler PO-review af løsningsbeskrivelsen |
| 🟡 | [#51 – Migrér CVR-integration fra Datafordeler REST til GraphQL](https://github.com/OS2sofd/issues/issues/51) | Bestilt hos leverandør | Kritisk | 144 dage / 4.7 mdr. | Planlagt til 3. kvartal 2026, men endnu ikke igangværende |
| 🟡 | [#50 – Mulighed for at opsætte grænser for varigheden af OS2sofd tilhørsforhold](https://github.com/OS2sofd/issues/issues/50) | Bestilt hos leverandør | Høj | 145 dage / 4.8 mdr. | Planlagt til 3. kvartal 2026, men endnu ikke igangværende |
| 🟡 | [#53 – OS2sofd Lederside - Auditlogning af ændringer skal følge SOFD Core praksis](https://github.com/OS2sofd/issues/issues/53) | Bestilt hos leverandør | Høj | 132 dage / 4.3 mdr. | Planlagt til 3. kvartal 2026, men endnu ikke igangværende |
| 🟡 🔵 | [#65 – NexusSync - automatisk luk af konti udenfor "nexus organisationen"](https://github.com/OS2sofd/issues/issues/65) | Klar til prioritering | Høj | 103 dage / 3.4 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler PO-review af løsningsbeskrivelsen |
| 🟡 | [#100 – Brugerkontotyper - tilføjelse til skabelonbaseret navnekonvention](https://github.com/OS2sofd/issues/issues/100) | Bestilt hos leverandør | Høj | 54 dage / 1.8 mdr. | Planlagt til 3. kvartal 2026, men endnu ikke igangværende |
| 🟡 | [#35 – Forslag til rettelser i OS2SOFD Ledermodul](https://github.com/OS2sofd/issues/issues/35) | Afventer løsningsbeskrivelse | Mellem | 179 dage / 5.9 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🟡 | [#55 – Lederside - Forbedring af GUI for Pausemarkering ift. endusers](https://github.com/OS2sofd/issues/issues/55) | Afventer løsningsbeskrivelse | Mellem | 131 dage / 4.3 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🟡 | [#76 – Ny pladsholder og pladsholder funktion til mailskabelonen ”Digital post til medarbejder ved oprettelse af AD konto”](https://github.com/OS2sofd/issues/issues/76) | Afventer løsningsbeskrivelse | Mellem | 91 dage / 3 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🟡 | [#79 – Flere steps i godkendelsesflow i OS2Rollekatalog Anmod/Godkend](https://github.com/OS2sofd/issues/issues/79) | Afventer løsningsbeskrivelse | Mellem | 83 dage / 2.7 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🟡 🔵 | [#82 – ÆndringsønskeObligatorisk drop down menuer samt mulighed for a pre-definere værdier ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/82) | Klar til prioritering | Mellem | 82 dage / 2.7 mdr. | Klar til PO/koordinationsgruppens prioritering; PO-review har opmærksomhedspunkter |
| 🟡 🔵 | [#85 – Brugernavn generator ved oprettelse af vikar (OS2Vikar)](https://github.com/OS2sofd/issues/issues/85) | Klar til prioritering | Mellem | 81 dage / 2.7 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler PO-review af løsningsbeskrivelsen |
| 🟡 | [#98 – OS2sofd Telefoni-modul - Ønsker til forbedringer](https://github.com/OS2sofd/issues/issues/98) | Afventer løsningsbeskrivelse | Mellem | 62 dage / 2 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🟡 | [#104 – OS2ILM: Placering af medarbejdere i OU](https://github.com/OS2sofd/issues/issues/104) | Afventer løsningsbeskrivelse | Mellem | 40 dage / 1.3 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🟡 | [#110 – Frigørelse af kobling mellem it-brugerkonto og tilhørsforhold fra løndata. Tilhørsforhold skal afspejle den administrative organisation i OS2sofd.Ændringsønske](https://github.com/OS2sofd/issues/issues/110) | Afventer løsningsbeskrivelse | Mellem | 39 dage / 1.3 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🟡 | [#32 – Import af SOFD enheder til OS2Vikar modulet](https://github.com/OS2sofd/issues/issues/32) | Afventer løsningsbeskrivelse | Lav | 179 dage / 5.9 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🟡 | [#34 – ÆndringsønskeMulighed for at sende sms fra Vikarmodulet](https://github.com/OS2sofd/issues/issues/34) | Afventer løsningsbeskrivelse | Lav | 179 dage / 5.9 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🟡 | [#37 – Tilknytning af stillinger til enheder i Vikar modulet](https://github.com/OS2sofd/issues/issues/37) | Afventer løsningsbeskrivelse | Lav | 178 dage / 5.8 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🟡 | [#48 – Stoppet medarbejder slettes i Lederportalen/Tillidserhverv](https://github.com/OS2sofd/issues/issues/48) | Afventer løsningsbeskrivelse | Lav | 161 dage / 5.3 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🟡 | [#52 – Automatisk dannede flow-diagrammer til OS2sofd](https://github.com/OS2sofd/issues/issues/52) | Afventer løsningsbeskrivelse | Lav | 139 dage / 4.6 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🟡 | [#60 – SMS/Kodeordspåmindelse: understøttelse af flere kodeordspolitikker](https://github.com/OS2sofd/issues/issues/60) | Afventer løsningsbeskrivelse | Lav | 118 dage / 3.9 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🟡 | [#69 – Mulighed for at fravælge advis ved kontooprettelse](https://github.com/OS2sofd/issues/issues/69) | Afventer løsningsbeskrivelse | Lav | 103 dage / 3.4 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🟡 | [#70 – Mulighed for at redigere og flytte kolonner i oversigtsbillederne](https://github.com/OS2sofd/issues/issues/70) | Afventer løsningsbeskrivelse | Lav | 103 dage / 3.4 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🟡 | [#71 – Videreudvikling af SMS modul](https://github.com/OS2sofd/issues/issues/71) | Afventer løsningsbeskrivelse | Lav | 103 dage / 3.4 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🟡 | [#66 – Mulighed for at redigere allerede oprettet arbejdssted](https://github.com/OS2sofd/issues/issues/66) | Afventer løsningsbeskrivelse | Lav | 103 dage / 3.4 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🟡 | [#64 – Brugertjek : oplysninger om sidste kodeordsskifte og kodeordsløb i OS2faktor fanen](https://github.com/OS2sofd/issues/issues/64) | Afventer løsningsbeskrivelse | Lav | 103 dage / 3.4 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🟡 | [#67 – Kommunikationsmodul - Udviklingsønsker til email og log](https://github.com/OS2sofd/issues/issues/67) | Afventer løsningsbeskrivelse | Lav | 103 dage / 3.4 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🟡 | [#75 – Kommunikationsmodul i OS2sofd SMS/Email](https://github.com/OS2sofd/issues/issues/75) | Afventer løsningsbeskrivelse | Lav | 95 dage / 3.1 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🟡 | [#99 – Understøtte ny Skole/SFO opmærkning til KOMBIT](https://github.com/OS2sofd/issues/issues/99) | Afventer løsningsbeskrivelse | Lav | 54 dage / 1.8 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🟡 | [#111 – UI forbedringer til stillingskatalog](https://github.com/OS2sofd/issues/issues/111) | Afventer løsningsbeskrivelse | Lav | 35 dage / 1.1 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 18 dage |
| 🟡 ⚠️ | [#61 – Vil gerne selv kunne styre username, og navngivningen generelt i ILM](https://github.com/OS2sofd/issues/issues/61) | Igangværende opgaver | – | 117 dage / 3.8 mdr. | Igangværende opgaver, men mangler planlagt release; Igangværende opgaver, men mangler assignee; Kommunikation bør vurderes: seneste respons til opretter er 39 dage gammel |
| 🟡 | [#106 – OS2ILM: Det skal være muligt for en administrator at slette en konsulent helt.](https://github.com/OS2sofd/issues/issues/106) | Igangværende opgaver | – | 40 dage / 1.3 mdr. | Igangværende opgaver, men mangler planlagt release; Igangværende opgaver, men mangler assignee |
| 🟡 | [#107 – OS2ILM: Manglende e-mailnotifikationer ved konsulentgodkendelse](https://github.com/OS2sofd/issues/issues/107) | Igangværende opgaver | – | 40 dage / 1.3 mdr. | Igangværende opgaver, men mangler planlagt release; Igangværende opgaver, men mangler assignee |

</details>

> **Bemærk:** Kommunikationssignalet er en indikator. Det ser på seneste kommentar fra en anden end den oprindelige opretter. Det kan stadig ikke i sig selv afgøre, om opretter faktisk er tilstrækkeligt orienteret.

## 2. Omløbstid og kommunikation

| Nøgletal | Antal / værdi |
| --- | ---: |
| Aktive ændringsønsker | 90 |
| Gennemsnitlig alder | 107 dage / 3.5 mdr. |
| Median alder | 103 dage / 3.4 mdr. |
| 4,5–6 måneder gamle | 9 |
| Over 6 måneder | 20 |
| Over 12 måneder | 0 |
| Kommunikation bør vurderes | 1 |
| Aktive issues med JIRA-reference | 32 |

> ℹ️ **Målegrundlag:** 32 aktive issues har en JIRA-reference. For disse kan GitHub-alderen være lavere end den reelle alder på ændringsønsket.

> 📣 **Generel kommunikation anbefales:** 20 aktive ændringsønsker har en GitHub-alder over 6 måneder. For ønsker med historik før GitHub kan den reelle omløbstid være endnu længere.

> 👤 **Individuel kommunikation:** 1 ældre issues bør vurderes konkret i forhold til, om opretter har fået en tilstrækkelig og aktuel status.

### Kommunikationskø

| Issue | Alder | Status | Prioritet | Seneste respons til opretter |
| --- | ---: | --- | --- | ---: |
| [#61 – Vil gerne selv kunne styre username, og navngivningen generelt i ILM](https://github.com/OS2sofd/issues/issues/61) | 117 dage / 3.8 mdr. | Igangværende opgaver | – | 39 dage siden |

### Nærmer sig 6-månedersgrænsen

<details>
<summary>Vis alle 9 issues mellem 4,5 og 6 måneder</summary>

| Issue | Alder | Status | Prioritet | Kommune |
| --- | ---: | --- | --- | --- |
| [#32 – Import af SOFD enheder til OS2Vikar modulet](https://github.com/OS2sofd/issues/issues/32) | 179 dage / 5.9 mdr. | Afventer løsningsbeskrivelse | Lav | Hjørring |
| [#34 – ÆndringsønskeMulighed for at sende sms fra Vikarmodulet](https://github.com/OS2sofd/issues/issues/34) | 179 dage / 5.9 mdr. | Afventer løsningsbeskrivelse | Lav | Køge |
| [#35 – Forslag til rettelser i OS2SOFD Ledermodul](https://github.com/OS2sofd/issues/issues/35) | 179 dage / 5.9 mdr. | Afventer løsningsbeskrivelse | Mellem | Sønderborg |
| [#36 – Auto-opdatere enheder i FK Organisation ved nye KLE emner](https://github.com/OS2sofd/issues/issues/36) | 179 dage / 5.9 mdr. | Klar til prioritering | Mellem | Sønderborg |
| [#37 – Tilknytning af stillinger til enheder i Vikar modulet](https://github.com/OS2sofd/issues/issues/37) | 178 dage / 5.8 mdr. | Afventer løsningsbeskrivelse | Lav | Tårnby |
| [#48 – Stoppet medarbejder slettes i Lederportalen/Tillidserhverv](https://github.com/OS2sofd/issues/issues/48) | 161 dage / 5.3 mdr. | Afventer løsningsbeskrivelse | Lav | Odsherred |
| [#50 – Mulighed for at opsætte grænser for varigheden af OS2sofd tilhørsforhold](https://github.com/OS2sofd/issues/issues/50) | 145 dage / 4.8 mdr. | Bestilt hos leverandør | Høj | Bornholm |
| [#51 – Migrér CVR-integration fra Datafordeler REST til GraphQL](https://github.com/OS2sofd/issues/issues/51) | 144 dage / 4.7 mdr. | Bestilt hos leverandør | Kritisk | Ikke kommune |
| [#52 – Automatisk dannede flow-diagrammer til OS2sofd](https://github.com/OS2sofd/issues/issues/52) | 139 dage / 4.6 mdr. | Afventer løsningsbeskrivelse | Lav | Ikke kommune |

</details>

### Ældste aktive ændringsønsker

| Signal | Issue | Alder | Status | Prioritet | Senest opdateret |
| --- | --- | ---: | --- | --- | ---: |
| 🔴 | [#24 – Prefix i AD Event Dispatcher](https://github.com/OS2sofd/issues/issues/24) | 185 dage / 6.1 mdr. | Klar til prioritering | Lav | 6 dage siden |
| 🔴 | [#23 – Samlet overblik over diverse opmærkninger/fravalg af enheder](https://github.com/OS2sofd/issues/issues/23) | 185 dage / 6.1 mdr. | Afventer løsningsbeskrivelse | Mellem | 18 dage siden |
| 🔴 | [#22 – Brug af AD konto ved opsætning af 'manuelt valgt' leder på enhed](https://github.com/OS2sofd/issues/issues/22) | 185 dage / 6.1 mdr. | Screening | Mellem | 0 dage siden |
| 🔴 | [#21 – SOFD indlæsning fra lønsystem: Mulighed for selv at administrere indlæsningsfiltre](https://github.com/OS2sofd/issues/issues/21) | 185 dage / 6.1 mdr. | Afventer løsningsbeskrivelse | Mellem | 18 dage siden |
| 🔴 | [#19 – SOFD GUI: Bloker oprettelse af manuelle tilhørsforhold af typen "Medarbejder" når man kører med sync fra et lønsystem](https://github.com/OS2sofd/issues/issues/19) | 185 dage / 6.1 mdr. | Afventer løsningsbeskrivelse | Mellem | 18 dage siden |
| 🔴 | [#18 – Brugertjek: Uddybelse af Entra licenser](https://github.com/OS2sofd/issues/issues/18) | 185 dage / 6.1 mdr. | Afventer løsningsbeskrivelse | Lav | 18 dage siden |
| 🔴 | [#17 – SOFD GUI: Udvidet overblik over tilhørsforhold og typer](https://github.com/OS2sofd/issues/issues/17) | 185 dage / 6.1 mdr. | Klar til prioritering | Mellem | 0 dage siden |
| 🔴 | [#16 – Navne- og adressebeskyttelse:](https://github.com/OS2sofd/issues/issues/16) | 185 dage / 6.1 mdr. | Screening | – | 18 dage siden |
| 🔴 | [#13 – SofdCoreADReplicator - Handlinger ved grupper](https://github.com/OS2sofd/issues/issues/13) | 185 dage / 6.1 mdr. | Afventer løsningsbeskrivelse | Mellem | 18 dage siden |
| 🔴 | [#12 – Forstå forskel på Ansatte, Eksterne, Byrøddet, Konsulenter, Vikarer, m.m. typer af AD konti](https://github.com/OS2sofd/issues/issues/12) | 185 dage / 6.1 mdr. | Afventer løsningsbeskrivelse | – | 18 dage siden |

## 3. Flow og flaskehalse

> Største aktuelle kø er **Afventer løsningsbeskrivelse** med 34 issues (37.8 % af de aktive).

| Status | Antal | Andel af aktive | Median GitHub-alder | Median observeret tid i status | Ældste observerede tid i status | 4,5–6 mdr. GitHub-alder | >6 mdr. GitHub-alder |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| Nye ændringsønsker | 2 | 2.2 % | 0 dage / 0 mdr. | 0 dage / 0 mdr. | 0 dage / 0 mdr. | 0 | 0 |
| Screening | 17 | 18.9 % | 82 dage / 2.7 mdr. | 2 dage / 0.1 mdr. | 17 dage / 0.6 mdr. | 0 | 3 |
| Afventer løsningsbeskrivelse | 34 | 37.8 % | 124 dage / 4.1 mdr. | 17 dage / 0.6 mdr. | 17 dage / 0.6 mdr. | 6 | 10 |
| Klar til prioritering | 29 | 32.2 % | 82 dage / 2.7 mdr. | 2 dage / 0.1 mdr. | 17 dage / 0.6 mdr. | 1 | 7 |
| Bestilt hos leverandør | 4 | 4.4 % | 138 dage / 4.5 mdr. | 11 dage / 0.4 mdr. | 11 dage / 0.4 mdr. | 2 | 0 |
| Igangværende opgaver | 3 | 3.3 % | 40 dage / 1.3 mdr. | 6 dage / 0.2 mdr. | 6 dage / 0.2 mdr. | 0 | 0 |
| Løsninger i test | 1 | 1.1 % | 77 dage / 2.5 mdr. | 16 dage / 0.5 mdr. | 16 dage / 0.5 mdr. | 0 | 0 |

_Observeret tid i status tælles fra første registrering i historikfilen. For baseline-issues kan den reelle tid i status være længere._

## 4. Klar til prioritering

| Prioritet | Issue | Alder | Tid i status | Labels | Kommune | Estimat | Størrelse | Release |
| --- | --- | ---: | ---: | --- | --- | ---: | --- | --- |
| Høj | [#65 – NexusSync - automatisk luk af konti udenfor "nexus organisationen"](https://github.com/OS2sofd/issues/issues/65) | 103 dage / 3.4 mdr. | 7 dage / 0.2 mdr. | idm, middleware | Kalundborg | 6.000kr | – | – |
| Mellem | [#9 – Person tilhørsforhold - Tilføj markering af primært tilhørsforhold](https://github.com/OS2sofd/issues/issues/9) | 185 dage / 6.1 mdr. | 7 dage / 0.2 mdr. | ui, brugere og konti, datamodel og tilhørsforhold | Favrskov | 2.500kr | – | – |
| Mellem | [#11 – Tilføj information om en AD konto er i brug + understøtte LocalExtensions i Mail skabeloner](https://github.com/OS2sofd/issues/issues/11) | 185 dage / 6.1 mdr. | 0 dage / 0 mdr. | mailskabelon/advis, middleware, funktionelle forbedringer | Favrskov | 65.000kr | – | – |
| Mellem | [#17 – SOFD GUI: Udvidet overblik over tilhørsforhold og typer](https://github.com/OS2sofd/issues/issues/17) | 185 dage / 6.1 mdr. | 0 dage / 0 mdr. | ui, brugere og konti | Favrskov | 15.500kr | – | – |
| Mellem | [#25 – Brugertjek: Udvidelse af informationer i tilhørforholdstabellen](https://github.com/OS2sofd/issues/issues/25) | 184 dage / 6 mdr. | 7 dage / 0.2 mdr. | brugertjek, datamodel og tilhørsforhold | Bornholm | 2.500kr | – | – |
| Mellem | [#27 – Oprettelse af KSP/CICS konti på baggrund af rolletildelinger](https://github.com/OS2sofd/issues/issues/27) | 184 dage / 6 mdr. | 7 dage / 0.2 mdr. | idm, api, brugere og konti | Bornholm | 8.500kr | – | – |
| Mellem | [#36 – Auto-opdatere enheder i FK Organisation ved nye KLE emner](https://github.com/OS2sofd/issues/issues/36) | 179 dage / 5.9 mdr. | 7 dage / 0.2 mdr. | stamdata, middleware, datamodel og tilhørsforhold | Sønderborg | – | – | – |
| Mellem | [#73 – OS2sofd Kommunikationsmodul - Ønsker til forbedringer](https://github.com/OS2sofd/issues/issues/73) | 95 dage / 3.1 mdr. | 0 dage / 0 mdr. | middleware, funktionelle forbedringer | Favrskov | – | – | – |
| Mellem | [#83 – At kunne gøre data felter obligatoriske ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/83) | 82 dage / 2.7 mdr. | 7 dage / 0.2 mdr. | stamdata, vikar | Lyngby-Taarbæk | – | – | – |
| Mellem | [#82 – ÆndringsønskeObligatorisk drop down menuer samt mulighed for a pre-definere værdier ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/82) | 82 dage / 2.7 mdr. | 6 dage / 0.2 mdr. | stamdata, vikar | Lyngby-Taarbæk | 9.500kr | – | – |
| Mellem | [#85 – Brugernavn generator ved oprettelse af vikar (OS2Vikar)](https://github.com/OS2sofd/issues/issues/85) | 81 dage / 2.7 mdr. | 6 dage / 0.2 mdr. | vikar, brugere og konti | Lyngby-Taarbæk | 16.500kr | – | – |
| Mellem | [#97 – Vedligehold/rettidige opdateringer af Autorisationskoder](https://github.com/OS2sofd/issues/issues/97) | 63 dage / 2.1 mdr. | 7 dage / 0.2 mdr. | stamdata, drift og vedligehold | Bornholm | – | – | – |
| Mellem | [#121 – Ændringsønske - Udfordring ved flere mobilnumre til samme person](https://github.com/OS2sofd/issues/issues/121) | 4 dage / 0.1 mdr. | 2 dage / 0.1 mdr. | middleware, AD | Esbjerg | – | – | – |
| Lav | [#24 – Prefix i AD Event Dispatcher](https://github.com/OS2sofd/issues/issues/24) | 185 dage / 6.1 mdr. | 6 dage / 0.2 mdr. | stamdata, middleware, datamodel og tilhørsforhold | Bornholm | – | – | – |
| Lav | [#15 – Behov for at kunne vise forskelligt displaynavn på ansatte med flere tilhørsforhold/AD-konti](https://github.com/OS2sofd/issues/issues/15) | 185 dage / 6.1 mdr. | 6 dage / 0.2 mdr. | brugere og konti, datamodel og tilhørsforhold | Sønderborg | – | – | – |
| Lav | [#78 – Bjælke for oven og i venstre side, skal fryses fast](https://github.com/OS2sofd/issues/issues/78) | 87 dage / 2.9 mdr. | 2 dage / 0.1 mdr. | ui | Tønder | – | – | – |
| Lav | [#91 – Opslag i MitID Erhverv ved for at se om bruger har et aktivt tildelt MitID Erhverv](https://github.com/OS2sofd/issues/issues/91) | 81 dage / 2.7 mdr. | 2 dage / 0.1 mdr. | idm, brugertjek | Lyngby-Taarbæk | – | – | – |
| Lav | [#93 – Berigelse af titelfelt for skoleelever med klassetrin](https://github.com/OS2sofd/issues/issues/93) | 81 dage / 2.7 mdr. | 2 dage / 0.1 mdr. | stamdata, middleware | Kalundborg | – | – | – |
| Lav | [#96 – Vis detaljer om hvem der har bestilt/oprettet en konto undrer ordre-detaljer](https://github.com/OS2sofd/issues/issues/96) | 67 dage / 2.2 mdr. | 2 dage / 0.1 mdr. | log-data, idm | Allerød | – | – | – |
| Lav | [#113 – Indlæsning af Mit Erhverv status til OS2Sofd](https://github.com/OS2sofd/issues/issues/113) | 18 dage / 0.6 mdr. | 2 dage / 0.1 mdr. | idm, middleware | Kalundborg | – | – | – |
| Lav | [#120 – Advarsel omkring bestilling af Brugerkonti når man anvender bindingsmodellen](https://github.com/OS2sofd/issues/issues/120) | 6 dage / 0.2 mdr. | 2 dage / 0.1 mdr. | idm, ui | Bornholm | – | – | – |
| Lav | [#119 – Forbedret logning/dokumentation af ordredannelser.](https://github.com/OS2sofd/issues/issues/119) | 6 dage / 0.2 mdr. | 2 dage / 0.1 mdr. | log-data, idm | Bornholm | – | – | – |
| – | [#58 – OS2sofd - ilm - udfyld UPN ved oprettelse af konsulentkonto](https://github.com/OS2sofd/issues/issues/58) | 122 dage / 4 mdr. | ≥ 17 dage / 0.6 mdr. | ilm | Norddjurs | 3.250kr | – | – |
| – | [#59 – OS2sofd - ilm: udfyld displayName ved oprettelse af konsulent](https://github.com/OS2sofd/issues/issues/59) | 122 dage / 4 mdr. | ≥ 17 dage / 0.6 mdr. | ilm | Norddjurs | 1.000kr | – | – |
| – | [#62 – Udvidelse af Opus-integrationen med mulighed for at overføre flere brugerkontotyper](https://github.com/OS2sofd/issues/issues/62) | 111 dage / 3.6 mdr. | 2 dage / 0.1 mdr. | middleware, brugere og konti | Egedal | – | – | – |
| – | [#86 – OS2Vikar mulighed for at angive tid ved oprettelse af vikar](https://github.com/OS2sofd/issues/issues/86) | 81 dage / 2.7 mdr. | 2 dage / 0.1 mdr. | vikar | Lyngby-Taarbæk | – | – | – |
| – | [#101 – OS2ILM: Tildeling af leder via Virksomhed](https://github.com/OS2sofd/issues/issues/101) | 40 dage / 1.3 mdr. | 0 dage / 0 mdr. | ui, ilm | Norddjurs | 3.250kr | – | – |
| – | [#105 – OS2ILM: Flytning af ILM-oprettede konsulenter](https://github.com/OS2sofd/issues/issues/105) | 40 dage / 1.3 mdr. | ≥ 17 dage / 0.6 mdr. | ilm | Norddjurs | 2.250kr | – | – |
| – | [#112 – Migrering til Datafordeleren til CPR opslag](https://github.com/OS2sofd/issues/issues/112) | 32 dage / 1.1 mdr. | 2 dage / 0.1 mdr. | api, drift og vedligehold | Ikke kommune | – | – | – |

## 5. Review af løsningsbeskrivelser

> PO-reviewet er et kvalitetslag oven på det eksisterende flow. Reviewet baseres på issue, løsningsbeskrivelse og eksisterende kommentarer på reviewtidspunktet.

| Nøgletal | Antal |
| --- | ---: |
| Klar til prioritering | 29 |
| Reviewet | 4 |
| Mangler PO-review | 25 |
| Review med opmærksomhedspunkter | 3 |
| Review kræver afklaring | 1 |
| Reviewet med nye kommentarer siden seneste review | 0 |

| Issue | Estimat | PO-review | Opmærksomhed | Nye kommentarer siden review |
| --- | ---: | --- | --- | ---: |
| [#65 – NexusSync - automatisk luk af konti udenfor "nexus organisationen"](https://github.com/OS2sofd/issues/issues/65) | 6.000kr | Ikke reviewet | – | – |
| [#9 – Person tilhørsforhold - Tilføj markering af primært tilhørsforhold](https://github.com/OS2sofd/issues/issues/9) | 2.500kr | Ikke reviewet | – | – |
| [#11 – Tilføj information om en AD konto er i brug + understøtte LocalExtensions i Mail skabeloner](https://github.com/OS2sofd/issues/issues/11) | 65.000kr | Ikke reviewet | – | – |
| [#17 – SOFD GUI: Udvidet overblik over tilhørsforhold og typer](https://github.com/OS2sofd/issues/issues/17) | 15.500kr | Ikke reviewet | – | – |
| [#25 – Brugertjek: Udvidelse af informationer i tilhørforholdstabellen](https://github.com/OS2sofd/issues/issues/25) | 2.500kr | Ikke reviewet | – | – |
| [#27 – Oprettelse af KSP/CICS konti på baggrund af rolletildelinger](https://github.com/OS2sofd/issues/issues/27) | 8.500kr | Ikke reviewet | – | – |
| [#36 – Auto-opdatere enheder i FK Organisation ved nye KLE emner](https://github.com/OS2sofd/issues/issues/36) | – | Ikke reviewet | – | – |
| [#73 – OS2sofd Kommunikationsmodul - Ønsker til forbedringer](https://github.com/OS2sofd/issues/issues/73) | – | Ikke reviewet | – | – |
| [#83 – At kunne gøre data felter obligatoriske ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/83) | – | Ikke reviewet | – | – |
| [#82 – ÆndringsønskeObligatorisk drop down menuer samt mulighed for a pre-definere værdier ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/82) | 9.500kr | 🟡 Review 1 | Dokumentationsbehovet for den nye administrationsside og vedligeholdelse af vikarbureau-listen er ikke beskrevet. | 0 |
| [#85 – Brugernavn generator ved oprettelse af vikar (OS2Vikar)](https://github.com/OS2sofd/issues/issues/85) | 16.500kr | Ikke reviewet | – | – |
| [#97 – Vedligehold/rettidige opdateringer af Autorisationskoder](https://github.com/OS2sofd/issues/issues/97) | – | Ikke reviewet | – | – |
| [#121 – Ændringsønske - Udfordring ved flere mobilnumre til samme person](https://github.com/OS2sofd/issues/issues/121) | – | Ikke reviewet | – | – |
| [#24 – Prefix i AD Event Dispatcher](https://github.com/OS2sofd/issues/issues/24) | – | Ikke reviewet | – | – |
| [#15 – Behov for at kunne vise forskelligt displaynavn på ansatte med flere tilhørsforhold/AD-konti](https://github.com/OS2sofd/issues/issues/15) | – | Ikke reviewet | – | – |
| [#78 – Bjælke for oven og i venstre side, skal fryses fast](https://github.com/OS2sofd/issues/issues/78) | – | Ikke reviewet | – | – |
| [#91 – Opslag i MitID Erhverv ved for at se om bruger har et aktivt tildelt MitID Erhverv](https://github.com/OS2sofd/issues/issues/91) | – | Ikke reviewet | – | – |
| [#93 – Berigelse af titelfelt for skoleelever med klassetrin](https://github.com/OS2sofd/issues/issues/93) | – | Ikke reviewet | – | – |
| [#96 – Vis detaljer om hvem der har bestilt/oprettet en konto undrer ordre-detaljer](https://github.com/OS2sofd/issues/issues/96) | – | Ikke reviewet | – | – |
| [#113 – Indlæsning af Mit Erhverv status til OS2Sofd](https://github.com/OS2sofd/issues/issues/113) | – | Ikke reviewet | – | – |
| [#120 – Advarsel omkring bestilling af Brugerkonti når man anvender bindingsmodellen](https://github.com/OS2sofd/issues/issues/120) | – | Ikke reviewet | – | – |
| [#119 – Forbedret logning/dokumentation af ordredannelser.](https://github.com/OS2sofd/issues/issues/119) | – | Ikke reviewet | – | – |
| [#58 – OS2sofd - ilm - udfyld UPN ved oprettelse af konsulentkonto](https://github.com/OS2sofd/issues/issues/58) | 3.250kr | 🔴 Review 1 | Det oprindelige ændringsønske er ikke færdigbeskrevet: både begrundelsen for UPN-behovet og den forventede UPN-værdi står som '???'. Derfor kan løsningsforslaget ikke valideres sikkert mod behovet.; Den kommunespecifikke konfiguration af UPN-suffix medfører et mindre dokumentationsbehov, som ikke er beskrevet. | 0 |
| [#59 – OS2sofd - ilm: udfyld displayName ved oprettelse af konsulent](https://github.com/OS2sofd/issues/issues/59) | 1.000kr | 🟡 Review 1 | Det oprindelige forretningsbehov er ikke begrundet nærmere, men den ønskede funktion og den foreslåede løsning er konkrete.; Prisen er 1.000 kr. som enkeltstående ændring, men 0 kr. hvis ændringen gennemføres sammen med #58. | 0 |
| [#62 – Udvidelse af Opus-integrationen med mulighed for at overføre flere brugerkontotyper](https://github.com/OS2sofd/issues/issues/62) | – | Ikke reviewet | – | – |
| [#86 – OS2Vikar mulighed for at angive tid ved oprettelse af vikar](https://github.com/OS2sofd/issues/issues/86) | – | Ikke reviewet | – | – |
| [#101 – OS2ILM: Tildeling af leder via Virksomhed](https://github.com/OS2sofd/issues/issues/101) | 3.250kr | Ikke reviewet | – | – |
| [#105 – OS2ILM: Flytning af ILM-oprettede konsulenter](https://github.com/OS2sofd/issues/issues/105) | 2.250kr | 🟡 Review 1 | Ændringsønsket nævner også behov for afklaring af, om en konsulent skal kunne have flere tilhørsforhold. Det fremgår ikke af løsningsbeskrivelsen, om dette er vurderet eller bevidst holdt uden for løsningen. | 0 |
| [#112 – Migrering til Datafordeleren til CPR opslag](https://github.com/OS2sofd/issues/issues/112) | – | Ikke reviewet | – | – |

> **Nye kommentarer siden review:** Kendte automatiske proceskommentarer tælles ikke med. Et nyt kommentarspor er kun et signal om, at PO bør vurdere relevansen; det udløser ikke automatisk et nyt review.

## 6. Release-overblik – 3. kvartal 2026

| Status | Antal |
| --- | ---: |
| Bestilt hos leverandør | 4 |
| Løsninger i test | 1 |

| Prioritet | Issue | Alder | Status | Estimat | Assignee |
| --- | --- | ---: | --- | ---: | --- |
| Kritisk | [#51 – Migrér CVR-integration fra Datafordeler REST til GraphQL](https://github.com/OS2sofd/issues/issues/51) | 144 dage / 4.7 mdr. | Bestilt hos leverandør | 25.000kr | pso-digital-identity |
| Kritisk | [#94 – Understøttelse af Pre-hire-brugere i snitfladen mellem SOFD og Rollekatalog](https://github.com/OS2sofd/issues/issues/94) | 77 dage / 2.5 mdr. | Løsninger i test | 5.000kr | – |
| Høj | [#50 – Mulighed for at opsætte grænser for varigheden af OS2sofd tilhørsforhold](https://github.com/OS2sofd/issues/issues/50) | 145 dage / 4.8 mdr. | Bestilt hos leverandør | 25.000kr | pso-digital-identity |
| Høj | [#53 – OS2sofd Lederside - Auditlogning af ændringer skal følge SOFD Core praksis](https://github.com/OS2sofd/issues/issues/53) | 132 dage / 4.3 mdr. | Bestilt hos leverandør | 26.000kr | pso-digital-identity |
| Høj | [#100 – Brugerkontotyper - tilføjelse til skabelonbaseret navnekonvention](https://github.com/OS2sofd/issues/issues/100) | 54 dage / 1.8 mdr. | Bestilt hos leverandør | 15.000kr | pso-digital-identity |

### Release-efterslæb

Ingen aktive issues har en udløbet planlagt release.

### Kandidater uden planlagt release

| Prioritet | Issue | Alder | Status | Estimat | Assignee |
| --- | --- | ---: | --- | ---: | --- |
| Høj | [#65 – NexusSync - automatisk luk af konti udenfor "nexus organisationen"](https://github.com/OS2sofd/issues/issues/65) | 103 dage / 3.4 mdr. | Klar til prioritering | 6.000kr | – |
| Mellem | [#9 – Person tilhørsforhold - Tilføj markering af primært tilhørsforhold](https://github.com/OS2sofd/issues/issues/9) | 185 dage / 6.1 mdr. | Klar til prioritering | 2.500kr | – |
| Mellem | [#11 – Tilføj information om en AD konto er i brug + understøtte LocalExtensions i Mail skabeloner](https://github.com/OS2sofd/issues/issues/11) | 185 dage / 6.1 mdr. | Klar til prioritering | 65.000kr | – |
| Mellem | [#17 – SOFD GUI: Udvidet overblik over tilhørsforhold og typer](https://github.com/OS2sofd/issues/issues/17) | 185 dage / 6.1 mdr. | Klar til prioritering | 15.500kr | – |
| Mellem | [#25 – Brugertjek: Udvidelse af informationer i tilhørforholdstabellen](https://github.com/OS2sofd/issues/issues/25) | 184 dage / 6 mdr. | Klar til prioritering | 2.500kr | – |
| Mellem | [#27 – Oprettelse af KSP/CICS konti på baggrund af rolletildelinger](https://github.com/OS2sofd/issues/issues/27) | 184 dage / 6 mdr. | Klar til prioritering | 8.500kr | – |
| Mellem | [#36 – Auto-opdatere enheder i FK Organisation ved nye KLE emner](https://github.com/OS2sofd/issues/issues/36) | 179 dage / 5.9 mdr. | Klar til prioritering | – | – |
| Mellem | [#73 – OS2sofd Kommunikationsmodul - Ønsker til forbedringer](https://github.com/OS2sofd/issues/issues/73) | 95 dage / 3.1 mdr. | Klar til prioritering | – | – |
| Mellem | [#83 – At kunne gøre data felter obligatoriske ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/83) | 82 dage / 2.7 mdr. | Klar til prioritering | – | – |
| Mellem | [#82 – ÆndringsønskeObligatorisk drop down menuer samt mulighed for a pre-definere værdier ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/82) | 82 dage / 2.7 mdr. | Klar til prioritering | 9.500kr | – |
| Mellem | [#85 – Brugernavn generator ved oprettelse af vikar (OS2Vikar)](https://github.com/OS2sofd/issues/issues/85) | 81 dage / 2.7 mdr. | Klar til prioritering | 16.500kr | – |
| Mellem | [#97 – Vedligehold/rettidige opdateringer af Autorisationskoder](https://github.com/OS2sofd/issues/issues/97) | 63 dage / 2.1 mdr. | Klar til prioritering | – | – |
| Mellem | [#121 – Ændringsønske - Udfordring ved flere mobilnumre til samme person](https://github.com/OS2sofd/issues/issues/121) | 4 dage / 0.1 mdr. | Klar til prioritering | – | – |
| Lav | [#24 – Prefix i AD Event Dispatcher](https://github.com/OS2sofd/issues/issues/24) | 185 dage / 6.1 mdr. | Klar til prioritering | – | – |
| Lav | [#15 – Behov for at kunne vise forskelligt displaynavn på ansatte med flere tilhørsforhold/AD-konti](https://github.com/OS2sofd/issues/issues/15) | 185 dage / 6.1 mdr. | Klar til prioritering | – | – |
| Lav | [#78 – Bjælke for oven og i venstre side, skal fryses fast](https://github.com/OS2sofd/issues/issues/78) | 87 dage / 2.9 mdr. | Klar til prioritering | – | – |
| Lav | [#91 – Opslag i MitID Erhverv ved for at se om bruger har et aktivt tildelt MitID Erhverv](https://github.com/OS2sofd/issues/issues/91) | 81 dage / 2.7 mdr. | Klar til prioritering | – | – |
| Lav | [#93 – Berigelse af titelfelt for skoleelever med klassetrin](https://github.com/OS2sofd/issues/issues/93) | 81 dage / 2.7 mdr. | Klar til prioritering | – | – |
| Lav | [#96 – Vis detaljer om hvem der har bestilt/oprettet en konto undrer ordre-detaljer](https://github.com/OS2sofd/issues/issues/96) | 67 dage / 2.2 mdr. | Klar til prioritering | – | – |
| Lav | [#113 – Indlæsning af Mit Erhverv status til OS2Sofd](https://github.com/OS2sofd/issues/issues/113) | 18 dage / 0.6 mdr. | Klar til prioritering | – | – |
| Lav | [#120 – Advarsel omkring bestilling af Brugerkonti når man anvender bindingsmodellen](https://github.com/OS2sofd/issues/issues/120) | 6 dage / 0.2 mdr. | Klar til prioritering | – | – |
| Lav | [#119 – Forbedret logning/dokumentation af ordredannelser.](https://github.com/OS2sofd/issues/issues/119) | 6 dage / 0.2 mdr. | Klar til prioritering | – | – |
| – | [#59 – OS2sofd - ilm: udfyld displayName ved oprettelse af konsulent](https://github.com/OS2sofd/issues/issues/59) | 122 dage / 4 mdr. | Klar til prioritering | 1.000kr | – |
| – | [#58 – OS2sofd - ilm - udfyld UPN ved oprettelse af konsulentkonto](https://github.com/OS2sofd/issues/issues/58) | 122 dage / 4 mdr. | Klar til prioritering | 3.250kr | – |
| – | [#61 – Vil gerne selv kunne styre username, og navngivningen generelt i ILM](https://github.com/OS2sofd/issues/issues/61) | 117 dage / 3.8 mdr. | Igangværende opgaver | 19.500kr | – |
| – | [#62 – Udvidelse af Opus-integrationen med mulighed for at overføre flere brugerkontotyper](https://github.com/OS2sofd/issues/issues/62) | 111 dage / 3.6 mdr. | Klar til prioritering | – | – |
| – | [#86 – OS2Vikar mulighed for at angive tid ved oprettelse af vikar](https://github.com/OS2sofd/issues/issues/86) | 81 dage / 2.7 mdr. | Klar til prioritering | – | – |
| – | [#105 – OS2ILM: Flytning af ILM-oprettede konsulenter](https://github.com/OS2sofd/issues/issues/105) | 40 dage / 1.3 mdr. | Klar til prioritering | 2.250kr | – |
| – | [#106 – OS2ILM: Det skal være muligt for en administrator at slette en konsulent helt.](https://github.com/OS2sofd/issues/issues/106) | 40 dage / 1.3 mdr. | Igangværende opgaver | 8.750kr | – |
| – | [#107 – OS2ILM: Manglende e-mailnotifikationer ved konsulentgodkendelse](https://github.com/OS2sofd/issues/issues/107) | 40 dage / 1.3 mdr. | Igangværende opgaver | 4.000kr | – |
| – | [#101 – OS2ILM: Tildeling af leder via Virksomhed](https://github.com/OS2sofd/issues/issues/101) | 40 dage / 1.3 mdr. | Klar til prioritering | 3.250kr | – |
| – | [#112 – Migrering til Datafordeleren til CPR opslag](https://github.com/OS2sofd/issues/issues/112) | 32 dage / 1.1 mdr. | Klar til prioritering | – | – |

## 7. Hele pipeline – Fra idé til færdig løsning

| Status | Antal |
| --- | ---: |
| Nye ændringsønsker | 2 |
| Screening | 17 |
| Afventer løsningsbeskrivelse | 34 |
| Klar til prioritering | 29 |
| Bestilt hos leverandør | 4 |
| Igangværende opgaver | 3 |
| Løsninger i test | 1 |
| Løsninger i review | 0 |
| Afsluttede løsninger | 18 |
| Won't fix | 5 |

### Nye ændringsønsker

<details>
<summary>Vis 2 issue(s)</summary>

| Prioritet | Issue | Alder | Kommune | Labels | Senest opdateret |
| --- | --- | ---: | --- | --- | ---: |
| – | [#122 – Mulighed for at angive leder på institutioner](https://github.com/OS2sofd/issues/issues/122) | 0 dage / 0 mdr. | – | ændringsønske | 0 dage siden |
| – | [#123 – OS2ILM - Tilknytning af allerede oprettede brugere](https://github.com/OS2sofd/issues/issues/123) | 0 dage / 0 mdr. | – | ændringsønske | 0 dage siden |

</details>

### Screening

<details>
<summary>Vis 17 issue(s)</summary>

| Prioritet | Issue | Alder | Kommune | Labels | Senest opdateret |
| --- | --- | ---: | --- | --- | ---: |
| Mellem | [#10 – Udvid SOFDCoreADWritebackAgent til at understøtte forsk. OU'er](https://github.com/OS2sofd/issues/issues/10) | 185 dage / 6.1 mdr. | Favrskov | middleware, brugere og konti | 18 dage siden |
| Mellem | [#22 – Brug af AD konto ved opsætning af 'manuelt valgt' leder på enhed](https://github.com/OS2sofd/issues/issues/22) | 185 dage / 6.1 mdr. | Favrskov | ui, brugere og konti | 0 dage siden |
| Mellem | [#54 – Udvidet stillingskatalog og kodebaseret regelgrundlag i SOFD (og OS2Rollekatalog)](https://github.com/OS2sofd/issues/issues/54) | 131 dage / 4.3 mdr. | Hjørring | idm, datamodel og tilhørsforhold | 7 dage siden |
| Mellem | [#95 – Mulighed for at deaktivere en konto med udskudt dato](https://github.com/OS2sofd/issues/issues/95) | 74 dage / 2.4 mdr. | Tønder | idm, brugere og konti | 6 dage siden |
| Mellem | [#102 – OS2ILM: Mere specifik log](https://github.com/OS2sofd/issues/issues/102) | 40 dage / 1.3 mdr. | Norddjurs | log-data, ilm | 0 dage siden |
| Lav | [#72 – Ekstra data på skoleelever](https://github.com/OS2sofd/issues/issues/72) | 103 dage / 3.4 mdr. | Kalundborg | stamdata, middleware | 2 dage siden |
| Lav | [#80 – ÆndringsønskeUdvidet information ved anmodning om rolle i OS2Rolekatalog Anmod/Godkend](https://github.com/OS2sofd/issues/issues/80) | 83 dage / 2.7 mdr. | Lyngby-Taarbæk | idm, ui | 2 dage siden |
| Lav | [#81 – At kunne ændre afsendernavn på mails fra Rollekatalog](https://github.com/OS2sofd/issues/issues/81) | 82 dage / 2.7 mdr. | Lyngby-Taarbæk | ui, mailskabelon/advis | 2 dage siden |
| Lav | [#88 – Ny kolonne i rapporten 'Historiske rolleanmodninger', så man kan se hvilket IT-System de forskellige roller er tilknyttet](https://github.com/OS2sofd/issues/issues/88) | 81 dage / 2.7 mdr. | Lyngby-Taarbæk | rapporter, idm | 2 dage siden |
| Lav | [#89 – Udvide 'Status' typer for tildeling af rettigheder med 'Tildelt ved godkendt anmodning'.](https://github.com/OS2sofd/issues/issues/89) | 81 dage / 2.7 mdr. | Lyngby-Taarbæk | rapporter, idm | 2 dage siden |
| Lav | [#92 – Konfigurationsindstilling: Jobfunktionsroller og Rollebuketter listes samlet](https://github.com/OS2sofd/issues/issues/92) | 81 dage / 2.7 mdr. | Lyngby-Taarbæk | idm, ui | 2 dage siden |
| Lav | [#90 – At kunde (kommune) selv kan konfigurere i UI, i Brugertjek, hvilke data attributter der skal være synlige ved opslag i brugertjek](https://github.com/OS2sofd/issues/issues/90) | 81 dage / 2.7 mdr. | Lyngby-Taarbæk | ui, brugertjek | 2 dage siden |
| Lav | [#103 – OS2ILM: Visning af firma og navn](https://github.com/OS2sofd/issues/issues/103) | 40 dage / 1.3 mdr. | Norddjurs | ui, ilm | 0 dage siden |
| – | [#16 – Navne- og adressebeskyttelse:](https://github.com/OS2sofd/issues/issues/16) | 185 dage / 6.1 mdr. | Odsherred | stamdata, ui | 18 dage siden |
| – | [#68 – API-udvidelse til undtagelse/pausemarkering](https://github.com/OS2sofd/issues/issues/68) | 103 dage / 3.4 mdr. | Kalundborg | idm, api | 0 dage siden |
| – | [#74 – funktionelle forbedringer](https://github.com/OS2sofd/issues/issues/74) | 95 dage / 3.1 mdr. | Tønder | idm, middleware | 18 dage siden |
| – | [#87 – Begrænse en systemansvarlig's view af it-systemer i OS2Rollekatalog](https://github.com/OS2sofd/issues/issues/87) | 81 dage / 2.7 mdr. | Lyngby-Taarbæk | idm, ui | 2 dage siden |

</details>

### Afventer løsningsbeskrivelse

<details>
<summary>Vis 34 issue(s)</summary>

| Prioritet | Issue | Alder | Labels | Kommune | Assignee | Senest opdateret |
| --- | --- | ---: | --- | --- | --- | ---: |
| Høj | [#108 – Ændringsønske: Fremtidige ændringer: Organisationsændringer og- håndtering fødes i OS2sofd og matches efterfølgende med LOSid i KMD LOS integration mod sofd.](https://github.com/OS2sofd/issues/issues/108) | 39 dage / 1.3 mdr. | stamdata, datamodel og tilhørsforhold | Horsens | – | 7 dage siden |
| Høj | [#109 – Dobbelt hierarki: Lønhierarki og den administrative organisation. Oprettelse af det administrative hierarki foretages pba. LOS-koblinger og strukturerede valideringer.Ændringsønske](https://github.com/OS2sofd/issues/issues/109) | 39 dage / 1.3 mdr. | stamdata, datamodel og tilhørsforhold | Horsens | – | 18 dage siden |
| Mellem | [#13 – SofdCoreADReplicator - Handlinger ved grupper](https://github.com/OS2sofd/issues/issues/13) | 185 dage / 6.1 mdr. | drift og vedligehold, middleware | Favrskov | – | 18 dage siden |
| Mellem | [#19 – SOFD GUI: Bloker oprettelse af manuelle tilhørsforhold af typen "Medarbejder" når man kører med sync fra et lønsystem](https://github.com/OS2sofd/issues/issues/19) | 185 dage / 6.1 mdr. | idm, ui | Favrskov | – | 18 dage siden |
| Mellem | [#21 – SOFD indlæsning fra lønsystem: Mulighed for selv at administrere indlæsningsfiltre](https://github.com/OS2sofd/issues/issues/21) | 185 dage / 6.1 mdr. | ui, middleware, brugere og konti | Favrskov | – | 18 dage siden |
| Mellem | [#23 – Samlet overblik over diverse opmærkninger/fravalg af enheder](https://github.com/OS2sofd/issues/issues/23) | 185 dage / 6.1 mdr. | rapporter, ui, brugere og konti | Favrskov | – | 18 dage siden |
| Mellem | [#35 – Forslag til rettelser i OS2SOFD Ledermodul](https://github.com/OS2sofd/issues/issues/35) | 179 dage / 5.9 mdr. | idm, lederside | Sønderborg | – | 18 dage siden |
| Mellem | [#55 – Lederside - Forbedring af GUI for Pausemarkering ift. endusers](https://github.com/OS2sofd/issues/issues/55) | 131 dage / 4.3 mdr. | ui, lederside | Favrskov | – | 18 dage siden |
| Mellem | [#76 – Ny pladsholder og pladsholder funktion til mailskabelonen ”Digital post til medarbejder ved oprettelse af AD konto”](https://github.com/OS2sofd/issues/issues/76) | 91 dage / 3 mdr. | mailskabelon/advis, funktionelle forbedringer | Vallensbæk | – | 18 dage siden |
| Mellem | [#79 – Flere steps i godkendelsesflow i OS2Rollekatalog Anmod/Godkend](https://github.com/OS2sofd/issues/issues/79) | 83 dage / 2.7 mdr. | idm, ui | Lyngby-Taarbæk | – | 18 dage siden |
| Mellem | [#98 – OS2sofd Telefoni-modul - Ønsker til forbedringer](https://github.com/OS2sofd/issues/issues/98) | 62 dage / 2 mdr. | ui, funktionelle forbedringer | Favrskov | – | 18 dage siden |
| Mellem | [#104 – OS2ILM: Placering af medarbejdere i OU](https://github.com/OS2sofd/issues/issues/104) | 40 dage / 1.3 mdr. | idm, ilm | Norddjurs | – | 18 dage siden |
| Mellem | [#110 – Frigørelse af kobling mellem it-brugerkonto og tilhørsforhold fra løndata. Tilhørsforhold skal afspejle den administrative organisation i OS2sofd.Ændringsønske](https://github.com/OS2sofd/issues/issues/110) | 39 dage / 1.3 mdr. | brugere og konti, datamodel og tilhørsforhold | Horsens | – | 18 dage siden |
| Lav | [#18 – Brugertjek: Uddybelse af Entra licenser](https://github.com/OS2sofd/issues/issues/18) | 185 dage / 6.1 mdr. | ui, brugertjek | Bornholm | – | 18 dage siden |
| Lav | [#29 – Brugertjek: Mulighed for genveje og dybe links](https://github.com/OS2sofd/issues/issues/29) | 184 dage / 6 mdr. | ui, brugertjek | Bornholm | – | 18 dage siden |
| Lav | [#26 – Brugertjek: Robot-flag for robotter](https://github.com/OS2sofd/issues/issues/26) | 184 dage / 6 mdr. | ui, brugertjek | Bornholm | – | 18 dage siden |
| Lav | [#28 – Brugertjek: Kontrol af lønsystem konto](https://github.com/OS2sofd/issues/issues/28) | 184 dage / 6 mdr. | idm, brugertjek | Bornholm | – | 18 dage siden |
| Lav | [#32 – Import af SOFD enheder til OS2Vikar modulet](https://github.com/OS2sofd/issues/issues/32) | 179 dage / 5.9 mdr. | vikar, middleware | Hjørring | – | 18 dage siden |
| Lav | [#34 – ÆndringsønskeMulighed for at sende sms fra Vikarmodulet](https://github.com/OS2sofd/issues/issues/34) | 179 dage / 5.9 mdr. | vikar, mailskabelon/advis | Køge | – | 18 dage siden |
| Lav | [#37 – Tilknytning af stillinger til enheder i Vikar modulet](https://github.com/OS2sofd/issues/issues/37) | 178 dage / 5.8 mdr. | vikar, ui | Tårnby | – | 18 dage siden |
| Lav | [#48 – Stoppet medarbejder slettes i Lederportalen/Tillidserhverv](https://github.com/OS2sofd/issues/issues/48) | 161 dage / 5.3 mdr. | lederside, brugere og konti | Odsherred | – | 18 dage siden |
| Lav | [#52 – Automatisk dannede flow-diagrammer til OS2sofd](https://github.com/OS2sofd/issues/issues/52) | 139 dage / 4.6 mdr. | dokumentation, log-data | Ikke kommune | – | 18 dage siden |
| Lav | [#60 – SMS/Kodeordspåmindelse: understøttelse af flere kodeordspolitikker](https://github.com/OS2sofd/issues/issues/60) | 118 dage / 3.9 mdr. | mailskabelon/advis, middleware | Bornholm | – | 18 dage siden |
| Lav | [#69 – Mulighed for at fravælge advis ved kontooprettelse](https://github.com/OS2sofd/issues/issues/69) | 103 dage / 3.4 mdr. | idm, mailskabelon/advis | Kalundborg | – | 18 dage siden |
| Lav | [#70 – Mulighed for at redigere og flytte kolonner i oversigtsbillederne](https://github.com/OS2sofd/issues/issues/70) | 103 dage / 3.4 mdr. | ui | Kalundborg | – | 18 dage siden |
| Lav | [#71 – Videreudvikling af SMS modul](https://github.com/OS2sofd/issues/issues/71) | 103 dage / 3.4 mdr. | mailskabelon/advis, middleware | Kalundborg | – | 18 dage siden |
| Lav | [#66 – Mulighed for at redigere allerede oprettet arbejdssted](https://github.com/OS2sofd/issues/issues/66) | 103 dage / 3.4 mdr. | ui, funktionelle forbedringer | Kalundborg | – | 18 dage siden |
| Lav | [#64 – Brugertjek : oplysninger om sidste kodeordsskifte og kodeordsløb i OS2faktor fanen](https://github.com/OS2sofd/issues/issues/64) | 103 dage / 3.4 mdr. | api, brugertjek | Kalundborg | – | 18 dage siden |
| Lav | [#67 – Kommunikationsmodul - Udviklingsønsker til email og log](https://github.com/OS2sofd/issues/issues/67) | 103 dage / 3.4 mdr. | log-data, mailskabelon/advis | Kalundborg | – | 18 dage siden |
| Lav | [#75 – Kommunikationsmodul i OS2sofd SMS/Email](https://github.com/OS2sofd/issues/issues/75) | 95 dage / 3.1 mdr. | stamdata, mailskabelon/advis | Tønder | – | 18 dage siden |
| Lav | [#99 – Understøtte ny Skole/SFO opmærkning til KOMBIT](https://github.com/OS2sofd/issues/issues/99) | 54 dage / 1.8 mdr. | stamdata, middleware | Ikke kommune | – | 18 dage siden |
| Lav | [#111 – UI forbedringer til stillingskatalog](https://github.com/OS2sofd/issues/issues/111) | 35 dage / 1.1 mdr. | ui, funktionelle forbedringer | Allerød | – | 18 dage siden |
| – | [#12 – Forstå forskel på Ansatte, Eksterne, Byrøddet, Konsulenter, Vikarer, m.m. typer af AD konti](https://github.com/OS2sofd/issues/issues/12) | 185 dage / 6.1 mdr. | idm, brugere og konti | Sønderborg | – | 18 dage siden |
| – | [#30 – OS2sofd - ILM: Vedligeholdelse af Fortrolighedsaftale](https://github.com/OS2sofd/issues/issues/30) | 184 dage / 6 mdr. | idm, ilm | Bornholm | – | 18 dage siden |

</details>

### Klar til prioritering

| Prioritet | Issue | Alder | Estimat | Størrelse | Release | Kommune |
| --- | --- | ---: | ---: | --- | --- | --- |
| Høj | [#65 – NexusSync - automatisk luk af konti udenfor "nexus organisationen"](https://github.com/OS2sofd/issues/issues/65) | 103 dage / 3.4 mdr. | 6.000kr | – | – | Kalundborg |
| Mellem | [#9 – Person tilhørsforhold - Tilføj markering af primært tilhørsforhold](https://github.com/OS2sofd/issues/issues/9) | 185 dage / 6.1 mdr. | 2.500kr | – | – | Favrskov |
| Mellem | [#11 – Tilføj information om en AD konto er i brug + understøtte LocalExtensions i Mail skabeloner](https://github.com/OS2sofd/issues/issues/11) | 185 dage / 6.1 mdr. | 65.000kr | – | – | Favrskov |
| Mellem | [#17 – SOFD GUI: Udvidet overblik over tilhørsforhold og typer](https://github.com/OS2sofd/issues/issues/17) | 185 dage / 6.1 mdr. | 15.500kr | – | – | Favrskov |
| Mellem | [#25 – Brugertjek: Udvidelse af informationer i tilhørforholdstabellen](https://github.com/OS2sofd/issues/issues/25) | 184 dage / 6 mdr. | 2.500kr | – | – | Bornholm |
| Mellem | [#27 – Oprettelse af KSP/CICS konti på baggrund af rolletildelinger](https://github.com/OS2sofd/issues/issues/27) | 184 dage / 6 mdr. | 8.500kr | – | – | Bornholm |
| Mellem | [#36 – Auto-opdatere enheder i FK Organisation ved nye KLE emner](https://github.com/OS2sofd/issues/issues/36) | 179 dage / 5.9 mdr. | – | – | – | Sønderborg |
| Mellem | [#73 – OS2sofd Kommunikationsmodul - Ønsker til forbedringer](https://github.com/OS2sofd/issues/issues/73) | 95 dage / 3.1 mdr. | – | – | – | Favrskov |
| Mellem | [#83 – At kunne gøre data felter obligatoriske ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/83) | 82 dage / 2.7 mdr. | – | – | – | Lyngby-Taarbæk |
| Mellem | [#82 – ÆndringsønskeObligatorisk drop down menuer samt mulighed for a pre-definere værdier ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/82) | 82 dage / 2.7 mdr. | 9.500kr | – | – | Lyngby-Taarbæk |
| Mellem | [#85 – Brugernavn generator ved oprettelse af vikar (OS2Vikar)](https://github.com/OS2sofd/issues/issues/85) | 81 dage / 2.7 mdr. | 16.500kr | – | – | Lyngby-Taarbæk |
| Mellem | [#97 – Vedligehold/rettidige opdateringer af Autorisationskoder](https://github.com/OS2sofd/issues/issues/97) | 63 dage / 2.1 mdr. | – | – | – | Bornholm |
| Mellem | [#121 – Ændringsønske - Udfordring ved flere mobilnumre til samme person](https://github.com/OS2sofd/issues/issues/121) | 4 dage / 0.1 mdr. | – | – | – | Esbjerg |
| Lav | [#24 – Prefix i AD Event Dispatcher](https://github.com/OS2sofd/issues/issues/24) | 185 dage / 6.1 mdr. | – | – | – | Bornholm |
| Lav | [#15 – Behov for at kunne vise forskelligt displaynavn på ansatte med flere tilhørsforhold/AD-konti](https://github.com/OS2sofd/issues/issues/15) | 185 dage / 6.1 mdr. | – | – | – | Sønderborg |
| Lav | [#78 – Bjælke for oven og i venstre side, skal fryses fast](https://github.com/OS2sofd/issues/issues/78) | 87 dage / 2.9 mdr. | – | – | – | Tønder |
| Lav | [#91 – Opslag i MitID Erhverv ved for at se om bruger har et aktivt tildelt MitID Erhverv](https://github.com/OS2sofd/issues/issues/91) | 81 dage / 2.7 mdr. | – | – | – | Lyngby-Taarbæk |
| Lav | [#93 – Berigelse af titelfelt for skoleelever med klassetrin](https://github.com/OS2sofd/issues/issues/93) | 81 dage / 2.7 mdr. | – | – | – | Kalundborg |
| Lav | [#96 – Vis detaljer om hvem der har bestilt/oprettet en konto undrer ordre-detaljer](https://github.com/OS2sofd/issues/issues/96) | 67 dage / 2.2 mdr. | – | – | – | Allerød |
| Lav | [#113 – Indlæsning af Mit Erhverv status til OS2Sofd](https://github.com/OS2sofd/issues/issues/113) | 18 dage / 0.6 mdr. | – | – | – | Kalundborg |
| Lav | [#120 – Advarsel omkring bestilling af Brugerkonti når man anvender bindingsmodellen](https://github.com/OS2sofd/issues/issues/120) | 6 dage / 0.2 mdr. | – | – | – | Bornholm |
| Lav | [#119 – Forbedret logning/dokumentation af ordredannelser.](https://github.com/OS2sofd/issues/issues/119) | 6 dage / 0.2 mdr. | – | – | – | Bornholm |
| – | [#58 – OS2sofd - ilm - udfyld UPN ved oprettelse af konsulentkonto](https://github.com/OS2sofd/issues/issues/58) | 122 dage / 4 mdr. | 3.250kr | – | – | Norddjurs |
| – | [#59 – OS2sofd - ilm: udfyld displayName ved oprettelse af konsulent](https://github.com/OS2sofd/issues/issues/59) | 122 dage / 4 mdr. | 1.000kr | – | – | Norddjurs |
| – | [#62 – Udvidelse af Opus-integrationen med mulighed for at overføre flere brugerkontotyper](https://github.com/OS2sofd/issues/issues/62) | 111 dage / 3.6 mdr. | – | – | – | Egedal |
| – | [#86 – OS2Vikar mulighed for at angive tid ved oprettelse af vikar](https://github.com/OS2sofd/issues/issues/86) | 81 dage / 2.7 mdr. | – | – | – | Lyngby-Taarbæk |
| – | [#101 – OS2ILM: Tildeling af leder via Virksomhed](https://github.com/OS2sofd/issues/issues/101) | 40 dage / 1.3 mdr. | 3.250kr | – | – | Norddjurs |
| – | [#105 – OS2ILM: Flytning af ILM-oprettede konsulenter](https://github.com/OS2sofd/issues/issues/105) | 40 dage / 1.3 mdr. | 2.250kr | – | – | Norddjurs |
| – | [#112 – Migrering til Datafordeleren til CPR opslag](https://github.com/OS2sofd/issues/issues/112) | 32 dage / 1.1 mdr. | – | – | – | Ikke kommune |

### Bestilt hos leverandør

<details>
<summary>Vis 4 issue(s)</summary>

| Prioritet | Issue | Alder | Assignee | Estimat | Release | Senest opdateret |
| --- | --- | ---: | --- | ---: | --- | ---: |
| Kritisk | [#51 – Migrér CVR-integration fra Datafordeler REST til GraphQL](https://github.com/OS2sofd/issues/issues/51) | 144 dage / 4.7 mdr. | pso-digital-identity | 25.000kr | 3. kvartal 2026 | 11 dage siden |
| Høj | [#50 – Mulighed for at opsætte grænser for varigheden af OS2sofd tilhørsforhold](https://github.com/OS2sofd/issues/issues/50) | 145 dage / 4.8 mdr. | pso-digital-identity | 25.000kr | 3. kvartal 2026 | 11 dage siden |
| Høj | [#53 – OS2sofd Lederside - Auditlogning af ændringer skal følge SOFD Core praksis](https://github.com/OS2sofd/issues/issues/53) | 132 dage / 4.3 mdr. | pso-digital-identity | 26.000kr | 3. kvartal 2026 | 11 dage siden |
| Høj | [#100 – Brugerkontotyper - tilføjelse til skabelonbaseret navnekonvention](https://github.com/OS2sofd/issues/issues/100) | 54 dage / 1.8 mdr. | pso-digital-identity | 15.000kr | 3. kvartal 2026 | 11 dage siden |

</details>

### Igangværende opgaver

<details>
<summary>Vis 3 issue(s)</summary>

| Prioritet | Issue | Alder | Assignee | Estimat | Release | Senest opdateret |
| --- | --- | ---: | --- | ---: | --- | ---: |
| – | [#61 – Vil gerne selv kunne styre username, og navngivningen generelt i ILM](https://github.com/OS2sofd/issues/issues/61) | 117 dage / 3.8 mdr. | – | 19.500kr | – | 35 dage siden |
| – | [#106 – OS2ILM: Det skal være muligt for en administrator at slette en konsulent helt.](https://github.com/OS2sofd/issues/issues/106) | 40 dage / 1.3 mdr. | – | 8.750kr | – | 35 dage siden |
| – | [#107 – OS2ILM: Manglende e-mailnotifikationer ved konsulentgodkendelse](https://github.com/OS2sofd/issues/issues/107) | 40 dage / 1.3 mdr. | – | 4.000kr | – | 35 dage siden |

</details>

### Løsninger i test

<details>
<summary>Vis 1 issue(s)</summary>

| Issue | Alder | Release | Assignee | Senest opdateret |
| --- | ---: | --- | --- | ---: |
| [#94 – Understøttelse af Pre-hire-brugere i snitfladen mellem SOFD og Rollekatalog](https://github.com/OS2sofd/issues/issues/94) | 77 dage / 2.5 mdr. | 3. kvartal 2026 | – | 5 dage siden |

</details>

### Afsluttede løsninger

> Gennemløbstid vises kun, når der findes en registreret afslutningsdato. Fremadrettet kan automatiseringen opbygge status-historik og dermed måle gennemløbstid mere præcist.

<details>
<summary>Vis 18 issue(s)</summary>

| Issue | Gennemløbstid | Prioritet | Release | Afsluttet |
| --- | ---: | --- | --- | --- |
| [#7 – Mulighed for at overskrive medarbejders stillingsbetegnelse fra lønsystemet](https://github.com/OS2sofd/issues/issues/7) | 172 dage / 5.7 mdr. | Mellem | – | 08-09-2026 |
| [#77 – Ændring af dannede kodeord i forbindelse med kontooprettelser i Sofd Account Agent](https://github.com/OS2sofd/issues/issues/77) | 73 dage / 2.4 mdr. | Lav | – | 04-09-2026 |
| [#20 – SOFD Replikator: Undtage eksterne fra gruppe sync](https://github.com/OS2sofd/issues/issues/20) | 101 dage / 3.3 mdr. | – | 2. kvartal 2026 | 30-06-2026 |
| [#8 – OS2sofd Lederside - fixes + ønsker til forbedringer](https://github.com/OS2sofd/issues/issues/8) | 168 dage / 5.5 mdr. | – | 2. kvartal 2026 | 04-09-2026 |
| [#45 – IDM: OPUS-konto brugernavn præfiks-validering](https://github.com/OS2sofd/issues/issues/45) | 82 dage / 2.7 mdr. | – | 2. kvartal 2026 | 30-06-2026 |
| [#47 – IDM: Dokumentation af alle IDM-flows](https://github.com/OS2sofd/issues/issues/47) | 82 dage / 2.7 mdr. | – | 2. kvartal 2026 | 30-06-2026 |
| [#40 – IDM: Undgå utilsigtet genbrug af gamle konti](https://github.com/OS2sofd/issues/issues/40) | 82 dage / 2.7 mdr. | – | 2. kvartal 2026 | 30-06-2026 |
| [#41 – IDM: Nyt Cleanup-trin i IDM-livscyklus](https://github.com/OS2sofd/issues/issues/41) | 82 dage / 2.7 mdr. | – | 2. kvartal 2026 | 30-06-2026 |
| [#44 – IDM: Per-afdeling konfiguration af dage for kontooprettelse](https://github.com/OS2sofd/issues/issues/44) | 82 dage / 2.7 mdr. | – | 2. kvartal 2026 | 30-06-2026 |
| [#38 – IDM: Ny ordretype REACTIVATE i IDM-flow](https://github.com/OS2sofd/issues/issues/38) | 82 dage / 2.7 mdr. | – | 2. kvartal 2026 | 30-06-2026 |
| [#42 – IDM: Opret konto-ordre straks ved kendskab til ansættelse](https://github.com/OS2sofd/issues/issues/42) | 82 dage / 2.7 mdr. | – | 2. kvartal 2026 | 30-06-2026 |
| [#46 – IDM: Bedre håndtering af personinaktivering](https://github.com/OS2sofd/issues/issues/46) | 82 dage / 2.7 mdr. | – | 2. kvartal 2026 | 30-06-2026 |
| [#43 – IDM: Understøt AD-kontooprettelse fra flere tilhørsforholdskilder end for andre kontotyper](https://github.com/OS2sofd/issues/issues/43) | 82 dage / 2.7 mdr. | – | 2. kvartal 2026 | 30-06-2026 |
| [#39 – IDM: Opret nye AD-konti i disabled tilstand indtil ansættelsesstart](https://github.com/OS2sofd/issues/issues/39) | 82 dage / 2.7 mdr. | – | 2. kvartal 2026 | 30-06-2026 |
| [#56 – Bestilling af mail-adresser via ILM modulet](https://github.com/OS2sofd/issues/issues/56) | 107 dage / 3.5 mdr. | – | – | 04-09-2026 |
| [#57 – Tilføjelse i OS2sofd - ILM af e-mailinvitation til konsulent så chancen for selv-registrering øges](https://github.com/OS2sofd/issues/issues/57) | 107 dage / 3.5 mdr. | – | – | 04-09-2026 |
| [#63 – Opdatering af OS2sofd STIL integration til WS17-V7](https://github.com/OS2sofd/issues/issues/63) | 94 dage / 3.1 mdr. | – | – | 04-09-2026 |
| [#118 – TEST - Ændringsønske](https://github.com/OS2sofd/issues/issues/118) | – | – | – | – |

</details>

### Won't fix

<details>
<summary>Vis 5 issue(s)</summary>

| Issue | Alder | Kommune | Senest opdateret |
| --- | ---: | --- | --- |
| [#49 – Ændring af synkronisering af data ind i Nexus](https://github.com/OS2sofd/issues/issues/49) | 157 dage / 5.2 mdr. | Tønder | 15-09-2026 |
| [#6 – Visning af mailadresse i listevisning/SOFD](https://github.com/OS2sofd/issues/issues/6) | 403 dage / 13.2 mdr. | – | 18-08-2025 |
| [#14 – Nye hændelse til IDM proces: Reaktivering - Oprydning](https://github.com/OS2sofd/issues/issues/14) | 185 dage / 6.1 mdr. | Sønderborg | 19-05-2026 |
| [#33 – Foretræk kendte spærrede konti fremfor at danne et nyt brugernavn](https://github.com/OS2sofd/issues/issues/33) | 179 dage / 5.9 mdr. | Sønderborg | 19-05-2026 |
| [#84 – At kunne skrive data attribut værdier fra OS2Vikar oprettelse til Data attribut i Active Directory](https://github.com/OS2sofd/issues/issues/84) | 81 dage / 2.7 mdr. | Lyngby-Taarbæk | 17-09-2026 |

</details>

## 8. Proces- og datakvalitet

| Issue | Status | Alder | Problem |
| --- | --- | ---: | --- |
| [#24 – Prefix i AD Event Dispatcher](https://github.com/OS2sofd/issues/issues/24) | Klar til prioritering | 185 dage / 6.1 mdr. | Mangler estimat; Mangler PO-review af løsningsbeskrivelsen |
| [#15 – Behov for at kunne vise forskelligt displaynavn på ansatte med flere tilhørsforhold/AD-konti](https://github.com/OS2sofd/issues/issues/15) | Klar til prioritering | 185 dage / 6.1 mdr. | Mangler estimat; Mangler PO-review af løsningsbeskrivelsen |
| [#17 – SOFD GUI: Udvidet overblik over tilhørsforhold og typer](https://github.com/OS2sofd/issues/issues/17) | Klar til prioritering | 185 dage / 6.1 mdr. | Mangler PO-review af løsningsbeskrivelsen |
| [#12 – Forstå forskel på Ansatte, Eksterne, Byrøddet, Konsulenter, Vikarer, m.m. typer af AD konti](https://github.com/OS2sofd/issues/issues/12) | Afventer løsningsbeskrivelse | 185 dage / 6.1 mdr. | Mangler prioritet |
| [#11 – Tilføj information om en AD konto er i brug + understøtte LocalExtensions i Mail skabeloner](https://github.com/OS2sofd/issues/issues/11) | Klar til prioritering | 185 dage / 6.1 mdr. | Mangler PO-review af løsningsbeskrivelsen |
| [#9 – Person tilhørsforhold - Tilføj markering af primært tilhørsforhold](https://github.com/OS2sofd/issues/issues/9) | Klar til prioritering | 185 dage / 6.1 mdr. | Mangler PO-review af løsningsbeskrivelsen |
| [#30 – OS2sofd - ILM: Vedligeholdelse af Fortrolighedsaftale](https://github.com/OS2sofd/issues/issues/30) | Afventer løsningsbeskrivelse | 184 dage / 6 mdr. | Mangler prioritet |
| [#27 – Oprettelse af KSP/CICS konti på baggrund af rolletildelinger](https://github.com/OS2sofd/issues/issues/27) | Klar til prioritering | 184 dage / 6 mdr. | Mangler PO-review af løsningsbeskrivelsen |
| [#25 – Brugertjek: Udvidelse af informationer i tilhørforholdstabellen](https://github.com/OS2sofd/issues/issues/25) | Klar til prioritering | 184 dage / 6 mdr. | Mangler PO-review af løsningsbeskrivelsen |
| [#36 – Auto-opdatere enheder i FK Organisation ved nye KLE emner](https://github.com/OS2sofd/issues/issues/36) | Klar til prioritering | 179 dage / 5.9 mdr. | Mangler estimat; Mangler PO-review af løsningsbeskrivelsen |
| [#59 – OS2sofd - ilm: udfyld displayName ved oprettelse af konsulent](https://github.com/OS2sofd/issues/issues/59) | Klar til prioritering | 122 dage / 4 mdr. | Mangler prioritet |
| [#58 – OS2sofd - ilm - udfyld UPN ved oprettelse af konsulentkonto](https://github.com/OS2sofd/issues/issues/58) | Klar til prioritering | 122 dage / 4 mdr. | Mangler prioritet |
| [#61 – Vil gerne selv kunne styre username, og navngivningen generelt i ILM](https://github.com/OS2sofd/issues/issues/61) | Igangværende opgaver | 117 dage / 3.8 mdr. | Mangler prioritet; Mangler planlagt release |
| [#62 – Udvidelse af Opus-integrationen med mulighed for at overføre flere brugerkontotyper](https://github.com/OS2sofd/issues/issues/62) | Klar til prioritering | 111 dage / 3.6 mdr. | Mangler prioritet; Mangler estimat; Mangler PO-review af løsningsbeskrivelsen |
| [#65 – NexusSync - automatisk luk af konti udenfor "nexus organisationen"](https://github.com/OS2sofd/issues/issues/65) | Klar til prioritering | 103 dage / 3.4 mdr. | Mangler PO-review af løsningsbeskrivelsen |
| [#73 – OS2sofd Kommunikationsmodul - Ønsker til forbedringer](https://github.com/OS2sofd/issues/issues/73) | Klar til prioritering | 95 dage / 3.1 mdr. | Mangler estimat; Mangler PO-review af løsningsbeskrivelsen |
| [#78 – Bjælke for oven og i venstre side, skal fryses fast](https://github.com/OS2sofd/issues/issues/78) | Klar til prioritering | 87 dage / 2.9 mdr. | Mangler estimat; Mangler PO-review af løsningsbeskrivelsen |
| [#83 – At kunne gøre data felter obligatoriske ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/83) | Klar til prioritering | 82 dage / 2.7 mdr. | Mangler estimat; Mangler PO-review af løsningsbeskrivelsen |
| [#93 – Berigelse af titelfelt for skoleelever med klassetrin](https://github.com/OS2sofd/issues/issues/93) | Klar til prioritering | 81 dage / 2.7 mdr. | Mangler estimat; Mangler PO-review af løsningsbeskrivelsen |
| [#85 – Brugernavn generator ved oprettelse af vikar (OS2Vikar)](https://github.com/OS2sofd/issues/issues/85) | Klar til prioritering | 81 dage / 2.7 mdr. | Mangler PO-review af løsningsbeskrivelsen |
| [#91 – Opslag i MitID Erhverv ved for at se om bruger har et aktivt tildelt MitID Erhverv](https://github.com/OS2sofd/issues/issues/91) | Klar til prioritering | 81 dage / 2.7 mdr. | Mangler estimat; Mangler PO-review af løsningsbeskrivelsen |
| [#86 – OS2Vikar mulighed for at angive tid ved oprettelse af vikar](https://github.com/OS2sofd/issues/issues/86) | Klar til prioritering | 81 dage / 2.7 mdr. | Mangler prioritet; Mangler estimat; Mangler PO-review af løsningsbeskrivelsen |
| [#96 – Vis detaljer om hvem der har bestilt/oprettet en konto undrer ordre-detaljer](https://github.com/OS2sofd/issues/issues/96) | Klar til prioritering | 67 dage / 2.2 mdr. | Mangler estimat; Mangler PO-review af løsningsbeskrivelsen |
| [#97 – Vedligehold/rettidige opdateringer af Autorisationskoder](https://github.com/OS2sofd/issues/issues/97) | Klar til prioritering | 63 dage / 2.1 mdr. | Mangler estimat; Mangler PO-review af løsningsbeskrivelsen |
| [#101 – OS2ILM: Tildeling af leder via Virksomhed](https://github.com/OS2sofd/issues/issues/101) | Klar til prioritering | 40 dage / 1.3 mdr. | Mangler prioritet; Mangler PO-review af løsningsbeskrivelsen |
| [#105 – OS2ILM: Flytning af ILM-oprettede konsulenter](https://github.com/OS2sofd/issues/issues/105) | Klar til prioritering | 40 dage / 1.3 mdr. | Mangler prioritet |
| [#107 – OS2ILM: Manglende e-mailnotifikationer ved konsulentgodkendelse](https://github.com/OS2sofd/issues/issues/107) | Igangværende opgaver | 40 dage / 1.3 mdr. | Mangler prioritet; Mangler planlagt release |
| [#106 – OS2ILM: Det skal være muligt for en administrator at slette en konsulent helt.](https://github.com/OS2sofd/issues/issues/106) | Igangværende opgaver | 40 dage / 1.3 mdr. | Mangler prioritet; Mangler planlagt release |
| [#112 – Migrering til Datafordeleren til CPR opslag](https://github.com/OS2sofd/issues/issues/112) | Klar til prioritering | 32 dage / 1.1 mdr. | Mangler prioritet; Mangler estimat; Mangler PO-review af løsningsbeskrivelsen |
| [#113 – Indlæsning af Mit Erhverv status til OS2Sofd](https://github.com/OS2sofd/issues/issues/113) | Klar til prioritering | 18 dage / 0.6 mdr. | Mangler estimat; Mangler PO-review af løsningsbeskrivelsen |
| [#119 – Forbedret logning/dokumentation af ordredannelser.](https://github.com/OS2sofd/issues/issues/119) | Klar til prioritering | 6 dage / 0.2 mdr. | Mangler estimat; Mangler PO-review af løsningsbeskrivelsen |
| [#120 – Advarsel omkring bestilling af Brugerkonti når man anvender bindingsmodellen](https://github.com/OS2sofd/issues/issues/120) | Klar til prioritering | 6 dage / 0.2 mdr. | Mangler estimat; Mangler PO-review af løsningsbeskrivelsen |
| [#121 – Ændringsønske - Udfordring ved flere mobilnumre til samme person](https://github.com/OS2sofd/issues/issues/121) | Klar til prioritering | 4 dage / 0.1 mdr. | Mangler estimat; Mangler PO-review af løsningsbeskrivelsen |

---

_Denne fil er automatisk genereret fra GitHub Project **Fra idé til færdig løsning** og issue-kommentarer. GitHub Project er den autoritative datakilde; data/po-overblik-history.json bruges alene til afledt status-historik. PO-review identificeres via skjulte reviewmarkører i issue-kommentarerne. Kommunikations- og reviewsignaler er indikatorer og skal vurderes af PO._
