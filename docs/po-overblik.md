# PO-overblik – OS2sofd ændringsønsker

> **Formål:** PO-styring af ændringsønsker med særligt fokus på omløbstid, kommunikation, prioritering og releasefremdrift.

Senest genereret: **24-09-2026 02:20**  
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
| 🔵 | Klar til prioritering | 27 |
| 🔴 | Klar til prioritering uden prioritet | 1 |
| 🔴 | Klar til prioritering uden estimat | 2 |
| 🟡 | Klar til prioritering uden PO-review | 2 |
| 🔴 | PO-review kræver afklaring | 4 |
| ⚠️ | Reviewede issues med nye kommentarer | 7 |
| 🟡 | Bestilt/igangværende uden planlagt release | 1 |
| ℹ️ | Bestilt/igangværende uden assignee | 1 |
| 🟡 | Test/review uden opdatering i mindst 14 dage | 0 |
| ⚠️ | Kommunikation bør vurderes | 0 |
| 🟠 | GitHub-alder 4,5–6 måneder | 9 |

### Foreslåede næste PO-handlinger

- Følg op på **1** Kritisk/Høj-prioriteret issue(s) uden opdatering i mindst 14 dage.
- Fastlæg prioritet på **1** issue(s) i **Klar til prioritering**.
- Få estimat på **2** issue(s) i **Klar til prioritering**.
- Gennemfør PO-review af løsningsbeskrivelsen på **2** issue(s) i **Klar til prioritering**.
- Afklar **4** issue(s), hvor PO-reviewet er rødt, før koordinationsgruppens prioritering.
- Vurder nye kommentarer på **7** allerede reviewet/reviewede issue(s) og afgør, om der er behov for opfølgende review.
- Fastlæg planlagt release på **1** bestilt/igangværende issue(s).
- Vurder om der bør sættes assignee på **1** bestilt/igangværende issue(s).
- Forbered generel kommunikation om backlog, ekstra ressourcer og målet om højst 6 måneders omløbstid.

<details>
<summary>Vis konkrete issues, der kræver PO-opmærksomhed (64)</summary>

| Signal | Issue | Status | Prioritet | Alder | PO-opmærksomhed |
| --- | --- | --- | --- | ---: | --- |
| 🔴 🟡 | [#109 – Dobbelt hierarki: Lønhierarki og den administrative organisation. Oprettelse af det administrative hierarki foretages pba. LOS-koblinger og strukturerede valideringer.Ændringsønske](https://github.com/OS2sofd/issues/issues/109) | Afventer løsningsbeskrivelse | Høj | 41 dage / 1.3 mdr. | Høj-prioritet uden registreret opdatering i 20 dage; Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🔴 🟡 🔵 | [#108 – Ændringsønske: Fremtidige ændringer: Organisationsændringer og- håndtering fødes i OS2sofd og matches efterfølgende med LOSid i KMD LOS integration mod sofd.](https://github.com/OS2sofd/issues/issues/108) | Klar til prioritering | Høj | 41 dage / 1.3 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler estimat; Klar til prioritering, men mangler PO-review af løsningsbeskrivelsen |
| 🔴 🟡 🔵 | [#112 – Migrering til Datafordeleren til CPR opslag](https://github.com/OS2sofd/issues/issues/112) | Klar til prioritering | Høj | 34 dage / 1.1 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler estimat; Klar til prioritering, men mangler PO-review af løsningsbeskrivelsen |
| 🔴 🟡 | [#21 – SOFD indlæsning fra lønsystem: Mulighed for selv at administrere indlæsningsfiltre](https://github.com/OS2sofd/issues/issues/21) | Afventer løsningsbeskrivelse | Mellem | 187 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🔴 🟡 ⚠️ 🔵 | [#11 – Tilføj information om en AD konto er i brug + understøtte LocalExtensions i Mail skabeloner](https://github.com/OS2sofd/issues/issues/11) | Klar til prioritering | Mellem | 187 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Klar til PO/koordinationsgruppens prioritering; PO-review har opmærksomhedspunkter; 2 ny(e) kommentar(er) siden seneste PO-review – relevans for opfølgende review bør vurderes |
| 🔴 | [#22 – Brug af AD konto ved opsætning af 'manuelt valgt' leder på enhed](https://github.com/OS2sofd/issues/issues/22) | Screening | Mellem | 187 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes |
| 🔴 | [#10 – Udvid SOFDCoreADWritebackAgent til at understøtte forsk. OU'er](https://github.com/OS2sofd/issues/issues/10) | Screening | Mellem | 187 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes |
| 🔴 🟡 | [#13 – SofdCoreADReplicator - Handlinger ved grupper](https://github.com/OS2sofd/issues/issues/13) | Afventer løsningsbeskrivelse | Mellem | 187 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🔴 🟡 | [#19 – SOFD GUI: Bloker oprettelse af manuelle tilhørsforhold af typen "Medarbejder" når man kører med sync fra et lønsystem](https://github.com/OS2sofd/issues/issues/19) | Afventer løsningsbeskrivelse | Mellem | 187 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🔴 🔵 | [#9 – Person tilhørsforhold - Tilføj markering af primært tilhørsforhold](https://github.com/OS2sofd/issues/issues/9) | Klar til prioritering | Mellem | 187 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Klar til PO/koordinationsgruppens prioritering |
| 🔴 ⚠️ 🔵 | [#17 – SOFD GUI: Udvidet overblik over tilhørsforhold og typer](https://github.com/OS2sofd/issues/issues/17) | Klar til prioritering | Mellem | 187 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Klar til PO/koordinationsgruppens prioritering; PO-review kræver afklaring før prioritering; 2 ny(e) kommentar(er) siden seneste PO-review – relevans for opfølgende review bør vurderes |
| 🔴 🟡 | [#12 – Forstå forskel på Ansatte, Eksterne, Byrøddet, Konsulenter, Vikarer, m.m. typer af AD konti](https://github.com/OS2sofd/issues/issues/12) | Afventer løsningsbeskrivelse | Mellem | 187 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🔴 🟡 | [#23 – Samlet overblik over diverse opmærkninger/fravalg af enheder](https://github.com/OS2sofd/issues/issues/23) | Afventer løsningsbeskrivelse | Mellem | 187 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🔴 ⚠️ 🔵 | [#27 – Oprettelse af KSP/CICS konti på baggrund af rolletildelinger](https://github.com/OS2sofd/issues/issues/27) | Klar til prioritering | Mellem | 186 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Klar til PO/koordinationsgruppens prioritering; PO-review kræver afklaring før prioritering; 2 ny(e) kommentar(er) siden seneste PO-review – relevans for opfølgende review bør vurderes |
| 🔴 🟡 🔵 | [#25 – Brugertjek: Udvidelse af informationer i tilhørforholdstabellen](https://github.com/OS2sofd/issues/issues/25) | Klar til prioritering | Mellem | 186 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Klar til PO/koordinationsgruppens prioritering; PO-review har opmærksomhedspunkter |
| 🔴 ⚠️ 🔵 | [#121 – Ændringsønske - Udfordring ved flere mobilnumre til samme person](https://github.com/OS2sofd/issues/issues/121) | Klar til prioritering | Mellem | 6 dage / 0.2 mdr. | Klar til PO/koordinationsgruppens prioritering; PO-review kræver afklaring før prioritering; 1 ny(e) kommentar(er) siden seneste PO-review – relevans for opfølgende review bør vurderes |
| 🔴 🔵 | [#15 – Behov for at kunne vise forskelligt displaynavn på ansatte med flere tilhørsforhold/AD-konti](https://github.com/OS2sofd/issues/issues/15) | Klar til prioritering | Lav | 187 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Klar til PO/koordinationsgruppens prioritering |
| 🔴 🔵 | [#24 – Prefix i AD Event Dispatcher](https://github.com/OS2sofd/issues/issues/24) | Klar til prioritering | Lav | 187 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Klar til PO/koordinationsgruppens prioritering |
| 🔴 🟡 | [#18 – Brugertjek: Uddybelse af Entra licenser](https://github.com/OS2sofd/issues/issues/18) | Afventer løsningsbeskrivelse | Lav | 187 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🔴 🟡 | [#26 – Brugertjek: Robot-flag for robotter](https://github.com/OS2sofd/issues/issues/26) | Afventer løsningsbeskrivelse | Lav | 186 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🔴 🟡 | [#28 – Brugertjek: Kontrol af lønsystem konto](https://github.com/OS2sofd/issues/issues/28) | Afventer løsningsbeskrivelse | Lav | 186 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🔴 🟡 | [#30 – OS2sofd - ILM: Vedligeholdelse af Fortrolighedsaftale](https://github.com/OS2sofd/issues/issues/30) | Afventer løsningsbeskrivelse | Lav | 186 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🔴 🟡 | [#29 – Brugertjek: Mulighed for genveje og dybe links](https://github.com/OS2sofd/issues/issues/29) | Afventer løsningsbeskrivelse | Lav | 186 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes; Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🔴 🔵 | [#91 – Opslag i MitID Erhverv ved for at se om bruger har et aktivt tildelt MitID Erhverv](https://github.com/OS2sofd/issues/issues/91) | Klar til prioritering | Lav | 83 dage / 2.7 mdr. | Klar til PO/koordinationsgruppens prioritering; PO-review kræver afklaring før prioritering |
| 🔴 | [#16 – Navne- og adressebeskyttelse:](https://github.com/OS2sofd/issues/issues/16) | Screening | – | 187 dage / 6.1 mdr. | GitHub-alderen er over 6 måneder – reel omløbstid bør vurderes |
| 🔴 🟡 ⚠️ 🔵 | [#105 – OS2ILM: Flytning af ILM-oprettede konsulenter](https://github.com/OS2sofd/issues/issues/105) | Klar til prioritering | – | 42 dage / 1.4 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler prioritet; PO-review har opmærksomhedspunkter; 1 ny(e) kommentar(er) siden seneste PO-review – relevans for opfølgende review bør vurderes |
| 🟡 | [#51 – Migrér CVR-integration fra Datafordeler REST til GraphQL](https://github.com/OS2sofd/issues/issues/51) | Bestilt hos leverandør | Kritisk | 146 dage / 4.8 mdr. | Planlagt til 3. kvartal 2026, men endnu ikke igangværende |
| 🟡 🔵 | [#62 – Udvidelse af Opus-integrationen med mulighed for at overføre flere brugerkontotyper](https://github.com/OS2sofd/issues/issues/62) | Klar til prioritering | Høj | 113 dage / 3.7 mdr. | Klar til PO/koordinationsgruppens prioritering; PO-review har opmærksomhedspunkter |
| 🟡 🔵 | [#65 – NexusSync - automatisk luk af konti udenfor "nexus organisationen"](https://github.com/OS2sofd/issues/issues/65) | Klar til prioritering | Høj | 105 dage / 3.4 mdr. | Klar til PO/koordinationsgruppens prioritering; PO-review har opmærksomhedspunkter |
| 🟡 | [#35 – Forslag til rettelser i OS2SOFD Ledermodul](https://github.com/OS2sofd/issues/issues/35) | Afventer løsningsbeskrivelse | Mellem | 181 dage / 5.9 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🟡 | [#55 – Lederside - Forbedring af GUI for Pausemarkering ift. endusers](https://github.com/OS2sofd/issues/issues/55) | Afventer løsningsbeskrivelse | Mellem | 133 dage / 4.4 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🟡 ⚠️ 🔵 | [#73 – OS2sofd Kommunikationsmodul - Ønsker til forbedringer](https://github.com/OS2sofd/issues/issues/73) | Klar til prioritering | Mellem | 97 dage / 3.2 mdr. | Klar til PO/koordinationsgruppens prioritering; PO-review har opmærksomhedspunkter; 1 ny(e) kommentar(er) siden seneste PO-review – relevans for opfølgende review bør vurderes |
| 🟡 | [#76 – Ny pladsholder og pladsholder funktion til mailskabelonen ”Digital post til medarbejder ved oprettelse af AD konto”](https://github.com/OS2sofd/issues/issues/76) | Afventer løsningsbeskrivelse | Mellem | 93 dage / 3.1 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🟡 🔵 | [#83 – At kunne gøre data felter obligatoriske ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/83) | Klar til prioritering | Mellem | 84 dage / 2.8 mdr. | Klar til PO/koordinationsgruppens prioritering; PO-review har opmærksomhedspunkter |
| 🟡 ⚠️ 🔵 | [#82 – ÆndringsønskeObligatorisk drop down menuer samt mulighed for a pre-definere værdier ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/82) | Klar til prioritering | Mellem | 84 dage / 2.8 mdr. | Klar til PO/koordinationsgruppens prioritering; PO-review har opmærksomhedspunkter; 1 ny(e) kommentar(er) siden seneste PO-review – relevans for opfølgende review bør vurderes |
| 🟡 🔵 | [#86 – OS2Vikar mulighed for at angive tid ved oprettelse af vikar](https://github.com/OS2sofd/issues/issues/86) | Klar til prioritering | Mellem | 83 dage / 2.7 mdr. | Klar til PO/koordinationsgruppens prioritering; PO-review har opmærksomhedspunkter |
| 🟡 🔵 | [#85 – Brugernavn generator ved oprettelse af vikar (OS2Vikar)](https://github.com/OS2sofd/issues/issues/85) | Klar til prioritering | Mellem | 83 dage / 2.7 mdr. | Klar til PO/koordinationsgruppens prioritering; PO-review har opmærksomhedspunkter |
| 🟡 | [#98 – OS2sofd Telefoni-modul - Ønsker til forbedringer](https://github.com/OS2sofd/issues/issues/98) | Afventer løsningsbeskrivelse | Mellem | 64 dage / 2.1 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🟡 | [#104 – OS2ILM: Placering af medarbejdere i OU](https://github.com/OS2sofd/issues/issues/104) | Afventer løsningsbeskrivelse | Mellem | 42 dage / 1.4 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🟡 | [#110 – Frigørelse af kobling mellem it-brugerkonto og tilhørsforhold fra løndata. Tilhørsforhold skal afspejle den administrative organisation i OS2sofd.Ændringsønske](https://github.com/OS2sofd/issues/issues/110) | Afventer løsningsbeskrivelse | Mellem | 41 dage / 1.3 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🟡 | [#32 – Import af SOFD enheder til OS2Vikar modulet](https://github.com/OS2sofd/issues/issues/32) | Afventer løsningsbeskrivelse | Lav | 181 dage / 5.9 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🟡 | [#34 – ÆndringsønskeMulighed for at sende sms fra Vikarmodulet](https://github.com/OS2sofd/issues/issues/34) | Afventer løsningsbeskrivelse | Lav | 181 dage / 5.9 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🟡 | [#37 – Tilknytning af stillinger til enheder i Vikar modulet](https://github.com/OS2sofd/issues/issues/37) | Afventer løsningsbeskrivelse | Lav | 180 dage / 5.9 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🟡 | [#48 – Stoppet medarbejder slettes i Lederportalen/Tillidserhverv](https://github.com/OS2sofd/issues/issues/48) | Afventer løsningsbeskrivelse | Lav | 163 dage / 5.4 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🟡 | [#52 – Automatisk dannede flow-diagrammer til OS2sofd](https://github.com/OS2sofd/issues/issues/52) | Afventer løsningsbeskrivelse | Lav | 141 dage / 4.6 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🟡 | [#60 – SMS/Kodeordspåmindelse: understøttelse af flere kodeordspolitikker](https://github.com/OS2sofd/issues/issues/60) | Afventer løsningsbeskrivelse | Lav | 120 dage / 3.9 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🟡 | [#70 – Mulighed for at redigere og flytte kolonner i oversigtsbillederne](https://github.com/OS2sofd/issues/issues/70) | Afventer løsningsbeskrivelse | Lav | 105 dage / 3.4 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🟡 | [#67 – Kommunikationsmodul - Udviklingsønsker til email og log](https://github.com/OS2sofd/issues/issues/67) | Afventer løsningsbeskrivelse | Lav | 105 dage / 3.4 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🟡 | [#69 – Mulighed for at fravælge advis ved kontooprettelse](https://github.com/OS2sofd/issues/issues/69) | Afventer løsningsbeskrivelse | Lav | 105 dage / 3.4 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🟡 | [#66 – Mulighed for at redigere allerede oprettet arbejdssted](https://github.com/OS2sofd/issues/issues/66) | Afventer løsningsbeskrivelse | Lav | 105 dage / 3.4 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🟡 | [#71 – Videreudvikling af SMS modul](https://github.com/OS2sofd/issues/issues/71) | Afventer løsningsbeskrivelse | Lav | 105 dage / 3.4 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🟡 | [#64 – Brugertjek : oplysninger om sidste kodeordsskifte og kodeordsløb i OS2faktor fanen](https://github.com/OS2sofd/issues/issues/64) | Afventer løsningsbeskrivelse | Lav | 105 dage / 3.4 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🟡 | [#75 – Kommunikationsmodul i OS2sofd SMS/Email](https://github.com/OS2sofd/issues/issues/75) | Afventer løsningsbeskrivelse | Lav | 97 dage / 3.2 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🟡 | [#99 – Understøtte ny Skole/SFO opmærkning til KOMBIT](https://github.com/OS2sofd/issues/issues/99) | Afventer løsningsbeskrivelse | Lav | 56 dage / 1.8 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🟡 | [#111 – UI forbedringer til stillingskatalog](https://github.com/OS2sofd/issues/issues/111) | Afventer løsningsbeskrivelse | Lav | 37 dage / 1.2 mdr. | Afventer løsningsbeskrivelse uden registreret opdatering i 20 dage |
| 🟡 🔵 | [#113 – Indlæsning af Mit Erhverv status til OS2Sofd](https://github.com/OS2sofd/issues/issues/113) | Klar til prioritering | Lav | 20 dage / 0.7 mdr. | Klar til PO/koordinationsgruppens prioritering; PO-review har opmærksomhedspunkter |
| 🟡 🔵 | [#119 – Forbedret logning/dokumentation af ordredannelser.](https://github.com/OS2sofd/issues/issues/119) | Klar til prioritering | Lav | 8 dage / 0.3 mdr. | Klar til PO/koordinationsgruppens prioritering; PO-review har opmærksomhedspunkter |
| 🟡 | [#101 – OS2ILM: Tildeling af leder via Virksomhed](https://github.com/OS2sofd/issues/issues/101) | Bestilt hos leverandør | – | 42 dage / 1.4 mdr. | Bestilt hos leverandør, men mangler planlagt release; Bestilt hos leverandør, men mangler assignee |
| 🔵 | [#36 – Auto-opdatere enheder i FK Organisation ved nye KLE emner](https://github.com/OS2sofd/issues/issues/36) | Klar til prioritering | Mellem | 181 dage / 5.9 mdr. | Klar til PO/koordinationsgruppens prioritering |
| 🔵 | [#97 – Vedligehold/rettidige opdateringer af Autorisationskoder](https://github.com/OS2sofd/issues/issues/97) | Klar til prioritering | Mellem | 65 dage / 2.1 mdr. | Klar til PO/koordinationsgruppens prioritering |
| 🔵 | [#78 – Bjælke for oven og i venstre side, skal fryses fast](https://github.com/OS2sofd/issues/issues/78) | Klar til prioritering | Lav | 89 dage / 2.9 mdr. | Klar til PO/koordinationsgruppens prioritering |
| 🔵 | [#93 – Berigelse af titelfelt for skoleelever med klassetrin](https://github.com/OS2sofd/issues/issues/93) | Klar til prioritering | Lav | 83 dage / 2.7 mdr. | Klar til PO/koordinationsgruppens prioritering |
| 🔵 | [#96 – Vis detaljer om hvem der har bestilt/oprettet en konto undrer ordre-detaljer](https://github.com/OS2sofd/issues/issues/96) | Klar til prioritering | Lav | 69 dage / 2.3 mdr. | Klar til PO/koordinationsgruppens prioritering |
| 🔵 | [#120 – Advarsel omkring bestilling af Brugerkonti når man anvender bindingsmodellen](https://github.com/OS2sofd/issues/issues/120) | Klar til prioritering | Lav | 8 dage / 0.3 mdr. | Klar til PO/koordinationsgruppens prioritering |

</details>

> **Bemærk:** Kommunikationssignalet er en indikator. Det ser på seneste kommentar fra en anden end den oprindelige opretter. Det kan stadig ikke i sig selv afgøre, om opretter faktisk er tilstrækkeligt orienteret.

## 2. Omløbstid og kommunikation

| Nøgletal | Antal / værdi |
| --- | ---: |
| Aktive ændringsønsker | 79 |
| Gennemsnitlig alder | 111 dage / 3.6 mdr. |
| Median alder | 105 dage / 3.4 mdr. |
| 4,5–6 måneder gamle | 9 |
| Over 6 måneder | 20 |
| Over 12 måneder | 0 |
| Kommunikation bør vurderes | 0 |
| Aktive issues med JIRA-reference | 32 |

> ℹ️ **Målegrundlag:** 32 aktive issues har en JIRA-reference. For disse kan GitHub-alderen være lavere end den reelle alder på ændringsønsket.

> 📣 **Generel kommunikation anbefales:** 20 aktive ændringsønsker har en GitHub-alder over 6 måneder. For ønsker med historik før GitHub kan den reelle omløbstid være endnu længere.

### Kommunikationskø

Ingen ældre aktive issues rammer den aktuelle kommunikationsregel.

### Nærmer sig 6-månedersgrænsen

<details>
<summary>Vis alle 9 issues mellem 4,5 og 6 måneder</summary>

| Issue | Alder | Status | Prioritet | Kommune |
| --- | ---: | --- | --- | --- |
| [#32 – Import af SOFD enheder til OS2Vikar modulet](https://github.com/OS2sofd/issues/issues/32) | 181 dage / 5.9 mdr. | Afventer løsningsbeskrivelse | Lav | Hjørring |
| [#34 – ÆndringsønskeMulighed for at sende sms fra Vikarmodulet](https://github.com/OS2sofd/issues/issues/34) | 181 dage / 5.9 mdr. | Afventer løsningsbeskrivelse | Lav | Køge |
| [#35 – Forslag til rettelser i OS2SOFD Ledermodul](https://github.com/OS2sofd/issues/issues/35) | 181 dage / 5.9 mdr. | Afventer løsningsbeskrivelse | Mellem | Sønderborg |
| [#36 – Auto-opdatere enheder i FK Organisation ved nye KLE emner](https://github.com/OS2sofd/issues/issues/36) | 181 dage / 5.9 mdr. | Klar til prioritering | Mellem | Sønderborg |
| [#37 – Tilknytning af stillinger til enheder i Vikar modulet](https://github.com/OS2sofd/issues/issues/37) | 180 dage / 5.9 mdr. | Afventer løsningsbeskrivelse | Lav | Tårnby |
| [#48 – Stoppet medarbejder slettes i Lederportalen/Tillidserhverv](https://github.com/OS2sofd/issues/issues/48) | 163 dage / 5.4 mdr. | Afventer løsningsbeskrivelse | Lav | Odsherred |
| [#50 – Mulighed for at opsætte grænser for varigheden af OS2sofd tilhørsforhold](https://github.com/OS2sofd/issues/issues/50) | 147 dage / 4.8 mdr. | Igangværende opgaver | Høj | Bornholm |
| [#51 – Migrér CVR-integration fra Datafordeler REST til GraphQL](https://github.com/OS2sofd/issues/issues/51) | 146 dage / 4.8 mdr. | Bestilt hos leverandør | Kritisk | Ikke kommune |
| [#52 – Automatisk dannede flow-diagrammer til OS2sofd](https://github.com/OS2sofd/issues/issues/52) | 141 dage / 4.6 mdr. | Afventer løsningsbeskrivelse | Lav | Ikke kommune |

</details>

### Ældste aktive ændringsønsker

| Signal | Issue | Alder | Status | Prioritet | Senest opdateret |
| --- | --- | ---: | --- | --- | ---: |
| 🔴 | [#11 – Tilføj information om en AD konto er i brug + understøtte LocalExtensions i Mail skabeloner](https://github.com/OS2sofd/issues/issues/11) | 187 dage / 6.1 mdr. | Klar til prioritering | Mellem | 1 dage siden |
| 🔴 | [#12 – Forstå forskel på Ansatte, Eksterne, Byrøddet, Konsulenter, Vikarer, m.m. typer af AD konti](https://github.com/OS2sofd/issues/issues/12) | 187 dage / 6.1 mdr. | Afventer løsningsbeskrivelse | Mellem | 20 dage siden |
| 🔴 | [#17 – SOFD GUI: Udvidet overblik over tilhørsforhold og typer](https://github.com/OS2sofd/issues/issues/17) | 187 dage / 6.1 mdr. | Klar til prioritering | Mellem | 1 dage siden |
| 🔴 | [#10 – Udvid SOFDCoreADWritebackAgent til at understøtte forsk. OU'er](https://github.com/OS2sofd/issues/issues/10) | 187 dage / 6.1 mdr. | Screening | Mellem | 20 dage siden |
| 🔴 | [#9 – Person tilhørsforhold - Tilføj markering af primært tilhørsforhold](https://github.com/OS2sofd/issues/issues/9) | 187 dage / 6.1 mdr. | Klar til prioritering | Mellem | 1 dage siden |
| 🔴 | [#18 – Brugertjek: Uddybelse af Entra licenser](https://github.com/OS2sofd/issues/issues/18) | 187 dage / 6.1 mdr. | Afventer løsningsbeskrivelse | Lav | 20 dage siden |
| 🔴 | [#19 – SOFD GUI: Bloker oprettelse af manuelle tilhørsforhold af typen "Medarbejder" når man kører med sync fra et lønsystem](https://github.com/OS2sofd/issues/issues/19) | 187 dage / 6.1 mdr. | Afventer løsningsbeskrivelse | Mellem | 20 dage siden |
| 🔴 | [#21 – SOFD indlæsning fra lønsystem: Mulighed for selv at administrere indlæsningsfiltre](https://github.com/OS2sofd/issues/issues/21) | 187 dage / 6.1 mdr. | Afventer løsningsbeskrivelse | Mellem | 20 dage siden |
| 🔴 | [#22 – Brug af AD konto ved opsætning af 'manuelt valgt' leder på enhed](https://github.com/OS2sofd/issues/issues/22) | 187 dage / 6.1 mdr. | Screening | Mellem | 2 dage siden |
| 🔴 | [#23 – Samlet overblik over diverse opmærkninger/fravalg af enheder](https://github.com/OS2sofd/issues/issues/23) | 187 dage / 6.1 mdr. | Afventer løsningsbeskrivelse | Mellem | 20 dage siden |

## 3. Flow og flaskehalse

> Største aktuelle kø er **Afventer løsningsbeskrivelse** med 32 issues (40.5 % af de aktive).

| Status | Antal | Andel af aktive | Median GitHub-alder | Median observeret tid i status | Ældste observerede tid i status | 4,5–6 mdr. GitHub-alder | >6 mdr. GitHub-alder |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| Nye ændringsønsker | 3 | 3.8 % | 2 dage / 0.1 mdr. | 2 dage / 0.1 mdr. | 2 dage / 0.1 mdr. | 0 | 0 |
| Screening | 11 | 13.9 % | 105 dage / 3.4 mdr. | 4 dage / 0.1 mdr. | 19 dage / 0.6 mdr. | 0 | 3 |
| Afventer løsningsbeskrivelse | 32 | 40.5 % | 137 dage / 4.5 mdr. | 19 dage / 0.6 mdr. | 19 dage / 0.6 mdr. | 6 | 10 |
| Klar til prioritering | 27 | 34.2 % | 84 dage / 2.8 mdr. | 4 dage / 0.1 mdr. | 19 dage / 0.6 mdr. | 1 | 7 |
| Bestilt hos leverandør | 2 | 2.5 % | 94 dage / 3.1 mdr. | 7 dage / 0.2 mdr. | 13 dage / 0.4 mdr. | 1 | 0 |
| Igangværende opgaver | 1 | 1.3 % | 147 dage / 4.8 mdr. | 0 dage / 0 mdr. | 0 dage / 0 mdr. | 1 | 0 |
| Løsninger i test | 3 | 3.8 % | 79 dage / 2.6 mdr. | 0 dage / 0 mdr. | 18 dage / 0.6 mdr. | 0 | 0 |

_Observeret tid i status tælles fra første registrering i historikfilen. For baseline-issues kan den reelle tid i status være længere._

## 4. Klar til prioritering

| Prioritet | Issue | Alder | Tid i status | Labels | Kommune | Estimat | Størrelse | Release |
| --- | --- | ---: | ---: | --- | --- | ---: | --- | --- |
| Høj | [#62 – Udvidelse af Opus-integrationen med mulighed for at overføre flere brugerkontotyper](https://github.com/OS2sofd/issues/issues/62) | 113 dage / 3.7 mdr. | 4 dage / 0.1 mdr. | middleware, brugere og konti | Egedal | 2.500kr | – | – |
| Høj | [#65 – NexusSync - automatisk luk af konti udenfor "nexus organisationen"](https://github.com/OS2sofd/issues/issues/65) | 105 dage / 3.4 mdr. | 8 dage / 0.3 mdr. | idm, middleware | Kalundborg | 6.000kr | – | – |
| Høj | [#108 – Ændringsønske: Fremtidige ændringer: Organisationsændringer og- håndtering fødes i OS2sofd og matches efterfølgende med LOSid i KMD LOS integration mod sofd.](https://github.com/OS2sofd/issues/issues/108) | 41 dage / 1.3 mdr. | 1 dage / 0 mdr. | stamdata, datamodel og tilhørsforhold | Horsens | – | – | – |
| Høj | [#112 – Migrering til Datafordeleren til CPR opslag](https://github.com/OS2sofd/issues/issues/112) | 34 dage / 1.1 mdr. | 4 dage / 0.1 mdr. | api, drift og vedligehold | Ikke kommune | – | – | – |
| Mellem | [#9 – Person tilhørsforhold - Tilføj markering af primært tilhørsforhold](https://github.com/OS2sofd/issues/issues/9) | 187 dage / 6.1 mdr. | 8 dage / 0.3 mdr. | ui, brugere og konti, datamodel og tilhørsforhold | Favrskov | 2.500kr | – | – |
| Mellem | [#11 – Tilføj information om en AD konto er i brug + understøtte LocalExtensions i Mail skabeloner](https://github.com/OS2sofd/issues/issues/11) | 187 dage / 6.1 mdr. | 2 dage / 0.1 mdr. | mailskabelon/advis, middleware, funktionelle forbedringer | Favrskov | 65.000kr | – | – |
| Mellem | [#17 – SOFD GUI: Udvidet overblik over tilhørsforhold og typer](https://github.com/OS2sofd/issues/issues/17) | 187 dage / 6.1 mdr. | 2 dage / 0.1 mdr. | ui, brugere og konti | Favrskov | 15.500kr | – | – |
| Mellem | [#25 – Brugertjek: Udvidelse af informationer i tilhørforholdstabellen](https://github.com/OS2sofd/issues/issues/25) | 186 dage / 6.1 mdr. | 8 dage / 0.3 mdr. | brugertjek, datamodel og tilhørsforhold | Bornholm | 2.500kr | – | – |
| Mellem | [#27 – Oprettelse af KSP/CICS konti på baggrund af rolletildelinger](https://github.com/OS2sofd/issues/issues/27) | 186 dage / 6.1 mdr. | 8 dage / 0.3 mdr. | idm, api, brugere og konti | Bornholm | 8.500kr | – | – |
| Mellem | [#36 – Auto-opdatere enheder i FK Organisation ved nye KLE emner](https://github.com/OS2sofd/issues/issues/36) | 181 dage / 5.9 mdr. | 8 dage / 0.3 mdr. | stamdata, middleware, datamodel og tilhørsforhold | Sønderborg | 4.500kr | – | – |
| Mellem | [#73 – OS2sofd Kommunikationsmodul - Ønsker til forbedringer](https://github.com/OS2sofd/issues/issues/73) | 97 dage / 3.2 mdr. | 2 dage / 0.1 mdr. | middleware, funktionelle forbedringer | Favrskov | 27.500kr | – | – |
| Mellem | [#82 – ÆndringsønskeObligatorisk drop down menuer samt mulighed for a pre-definere værdier ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/82) | 84 dage / 2.8 mdr. | 8 dage / 0.3 mdr. | stamdata, vikar | Lyngby-Taarbæk | 9.500kr | – | – |
| Mellem | [#83 – At kunne gøre data felter obligatoriske ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/83) | 84 dage / 2.8 mdr. | 8 dage / 0.3 mdr. | stamdata, vikar | Lyngby-Taarbæk | 3.500kr | – | – |
| Mellem | [#85 – Brugernavn generator ved oprettelse af vikar (OS2Vikar)](https://github.com/OS2sofd/issues/issues/85) | 83 dage / 2.7 mdr. | 8 dage / 0.3 mdr. | vikar, brugere og konti | Lyngby-Taarbæk | 16.500kr | – | – |
| Mellem | [#86 – OS2Vikar mulighed for at angive tid ved oprettelse af vikar](https://github.com/OS2sofd/issues/issues/86) | 83 dage / 2.7 mdr. | 4 dage / 0.1 mdr. | vikar | Lyngby-Taarbæk | 17.500kr | – | – |
| Mellem | [#97 – Vedligehold/rettidige opdateringer af Autorisationskoder](https://github.com/OS2sofd/issues/issues/97) | 65 dage / 2.1 mdr. | 8 dage / 0.3 mdr. | stamdata, drift og vedligehold | Bornholm | 6.500kr | – | – |
| Mellem | [#121 – Ændringsønske - Udfordring ved flere mobilnumre til samme person](https://github.com/OS2sofd/issues/issues/121) | 6 dage / 0.2 mdr. | 4 dage / 0.1 mdr. | middleware, AD | Esbjerg | 12.500kr | – | – |
| Lav | [#15 – Behov for at kunne vise forskelligt displaynavn på ansatte med flere tilhørsforhold/AD-konti](https://github.com/OS2sofd/issues/issues/15) | 187 dage / 6.1 mdr. | 8 dage / 0.3 mdr. | brugere og konti, datamodel og tilhørsforhold | Sønderborg | 17.500kr | – | – |
| Lav | [#24 – Prefix i AD Event Dispatcher](https://github.com/OS2sofd/issues/issues/24) | 187 dage / 6.1 mdr. | 8 dage / 0.3 mdr. | stamdata, middleware, datamodel og tilhørsforhold | Bornholm | 4.500kr | – | – |
| Lav | [#78 – Bjælke for oven og i venstre side, skal fryses fast](https://github.com/OS2sofd/issues/issues/78) | 89 dage / 2.9 mdr. | 4 dage / 0.1 mdr. | ui | Tønder | 6.500kr | – | – |
| Lav | [#91 – Opslag i MitID Erhverv ved for at se om bruger har et aktivt tildelt MitID Erhverv](https://github.com/OS2sofd/issues/issues/91) | 83 dage / 2.7 mdr. | 4 dage / 0.1 mdr. | idm, brugertjek | Lyngby-Taarbæk | 8.500kr | – | – |
| Lav | [#93 – Berigelse af titelfelt for skoleelever med klassetrin](https://github.com/OS2sofd/issues/issues/93) | 83 dage / 2.7 mdr. | 4 dage / 0.1 mdr. | stamdata, middleware | Kalundborg | 6.500kr | – | – |
| Lav | [#96 – Vis detaljer om hvem der har bestilt/oprettet en konto undrer ordre-detaljer](https://github.com/OS2sofd/issues/issues/96) | 69 dage / 2.3 mdr. | 4 dage / 0.1 mdr. | log-data, idm | Allerød | 5.500kr | – | – |
| Lav | [#113 – Indlæsning af Mit Erhverv status til OS2Sofd](https://github.com/OS2sofd/issues/issues/113) | 20 dage / 0.7 mdr. | 4 dage / 0.1 mdr. | idm, middleware | Kalundborg | 9.500kr | – | – |
| Lav | [#120 – Advarsel omkring bestilling af Brugerkonti når man anvender bindingsmodellen](https://github.com/OS2sofd/issues/issues/120) | 8 dage / 0.3 mdr. | 4 dage / 0.1 mdr. | idm, ui | Bornholm | 6.500kr | – | – |
| Lav | [#119 – Forbedret logning/dokumentation af ordredannelser.](https://github.com/OS2sofd/issues/issues/119) | 8 dage / 0.3 mdr. | 4 dage / 0.1 mdr. | log-data, idm | Bornholm | 6.500kr | – | – |
| – | [#105 – OS2ILM: Flytning af ILM-oprettede konsulenter](https://github.com/OS2sofd/issues/issues/105) | 42 dage / 1.4 mdr. | ≥ 19 dage / 0.6 mdr. | ilm | Norddjurs | 2.250kr | – | – |

## 5. Review af løsningsbeskrivelser

> PO-reviewet er et kvalitetslag oven på det eksisterende flow. Reviewet baseres på issue, løsningsbeskrivelse og eksisterende kommentarer på reviewtidspunktet.

| Nøgletal | Antal |
| --- | ---: |
| Klar til prioritering | 27 |
| Reviewet | 25 |
| Mangler PO-review | 2 |
| Review med opmærksomhedspunkter | 12 |
| Review kræver afklaring | 4 |
| Reviewet med nye kommentarer siden seneste review | 7 |

| Issue | Estimat | PO-review | Opmærksomhed | Nye kommentarer siden review |
| --- | ---: | --- | --- | ---: |
| [#62 – Udvidelse af Opus-integrationen med mulighed for at overføre flere brugerkontotyper](https://github.com/OS2sofd/issues/issues/62) | 2.500kr | 🟡 Review 1 | Løsningsforslaget hardcoder prioriteten Exchange > Skole Email i det konkrete infotype 105-job, mens ændringsønsket beskriver en mere generel konfigurerbar prioritering mellem kontotyper. | 0 |
| [#65 – NexusSync - automatisk luk af konti udenfor "nexus organisationen"](https://github.com/OS2sofd/issues/issues/65) | 6.000kr | 🟡 Review 1 | Funktionen kan ifølge løsningsbeskrivelsen spærre mange Nexus-konti, hvis organisationen ikke er korrekt opmærket med Nexus-tags. Det er et væsentligt idriftsættelses- og testpunkt. | 0 |
| [#108 – Ændringsønske: Fremtidige ændringer: Organisationsændringer og- håndtering fødes i OS2sofd og matches efterfølgende med LOSid i KMD LOS integration mod sofd.](https://github.com/OS2sofd/issues/issues/108) | – | Ikke reviewet | – | – |
| [#112 – Migrering til Datafordeleren til CPR opslag](https://github.com/OS2sofd/issues/issues/112) | – | Ikke reviewet | – | – |
| [#9 – Person tilhørsforhold - Tilføj markering af primært tilhørsforhold](https://github.com/OS2sofd/issues/issues/9) | 2.500kr | 🟢 Review 1 | – | 0 |
| [#11 – Tilføj information om en AD konto er i brug + understøtte LocalExtensions i Mail skabeloner](https://github.com/OS2sofd/issues/issues/11) | 65.000kr | 🟡 Review 1 | Løsningsforslaget vælger LocalExtensions som vej frem, fordi AD-login-timestamp ikke vurderes retvisende. Koordinationsgruppen bør være opmærksom på, at løsningen derfor ikke i sig selv leverer et autoritativt mål for, om en konto faktisk er i brug.; Ændringen påvirker 32 eksisterende mail-parsere og er derfor bredere end et enkelt nyt flettefelt. | 2 |
| [#17 – SOFD GUI: Udvidet overblik over tilhørsforhold og typer](https://github.com/OS2sofd/issues/issues/17) | 15.500kr | 🔴 Review 1 | Leverandøren skriver, at prisen kun gælder, hvis den eksisterende SQL View/DataTables-model kan udvides som antaget; dette er endnu ikke afklaret.; Kontaktpersonen har efter løsningsforslaget præciseret ønske om tilhørsforholdstype som mulig kolonne og foretrækker ved ét CSV-valg en fuld normaliseret eksport med én række pr. ansættelse. | 2 |
| [#25 – Brugertjek: Udvidelse af informationer i tilhørforholdstabellen](https://github.com/OS2sofd/issues/issues/25) | 2.500kr | 🟡 Review 1 | Det oprindelige ønske nævner både kildesystem, ekstern-type og leverandør. Løsningsbeskrivelsen beskriver kun Master og EXTERNAL. | 0 |
| [#27 – Oprettelse af KSP/CICS konti på baggrund af rolletildelinger](https://github.com/OS2sofd/issues/issues/27) | 8.500kr | 🔴 Review 1 | Der er en væsentlig forskel mellem ønskets 'umiddelbart herefter' og en service, der kun kører en håndfuld gange om dagen.; Løsningen introducerer en ny tværgående integration mellem OS2rollekatalog og OS2sofd. | 2 |
| [#36 – Auto-opdatere enheder i FK Organisation ved nye KLE emner](https://github.com/OS2sofd/issues/issues/36) | 4.500kr | 🟢 Review 1 | – | 0 |
| [#73 – OS2sofd Kommunikationsmodul - Ønsker til forbedringer](https://github.com/OS2sofd/issues/issues/73) | 27.500kr | 🟡 Review 1 | Kontaktpersonen har efter løsningsforslaget spurgt, om UUID bevidst er udeladt fra filimporten; spørgsmålet er endnu ubesvaret.; Funktionen 'send ny besked til samme modtagere' kan sende til tidligere modtagere, som ikke længere er ansatte; leverandøren fremhæver selv denne risiko.; Direkte AD-gruppemedlemskab er ikke valgt; løsningen bruger i stedet OS2rollekatalog eller importerede lister. | 1 |
| [#82 – ÆndringsønskeObligatorisk drop down menuer samt mulighed for a pre-definere værdier ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/82) | 9.500kr | 🟡 Review 1 | Dokumentationsbehovet for den nye administrationsside og vedligeholdelse af vikarbureau-listen er ikke beskrevet. | 1 |
| [#83 – At kunne gøre data felter obligatoriske ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/83) | 3.500kr | 🟡 Review 1 | Løsningsbeskrivelsen antager, at det er email, telefonnummer og bureau, der skal kunne gøres obligatoriske. Det er ikke specificeret i ændringsønsket. | 0 |
| [#85 – Brugernavn generator ved oprettelse af vikar (OS2Vikar)](https://github.com/OS2sofd/issues/issues/85) | 16.500kr | 🟡 Review 1 | Løsningen er afhængig af #82 og ændrer en central arkitektur i OS2Vikar fra forhåndsoprettede konti til just-in-time-oprettelse.; Den nye navnestandard skal fortsat kunne genkendes af eksisterende OS2sofd-processer for vikarer. | 0 |
| [#86 – OS2Vikar mulighed for at angive tid ved oprettelse af vikar](https://github.com/OS2sofd/issues/issues/86) | 17.500kr | 🟡 Review 1 | Kun AD-kontoen får reel tidsmæssig aktivering. OS2sofd, FK Organisation og afledte systemer vil fortsat kunne opfatte tilhørsforholdet som gyldigt hele dagen.; Ved to vagter samme dag kan en vikar ifølge løsningsbeskrivelsen fremstå med begge organisatoriske tilhørsforhold/rettigheder hele dagen. | 0 |
| [#97 – Vedligehold/rettidige opdateringer af Autorisationskoder](https://github.com/OS2sofd/issues/issues/97) | 6.500kr | 🟢 Review 1 | – | 0 |
| [#121 – Ændringsønske - Udfordring ved flere mobilnumre til samme person](https://github.com/OS2sofd/issues/issues/121) | 12.500kr | 🔴 Review 1 | Kontaktpersonen har efter løsningsforslaget præciseret, at sammenhængen mellem telefonnummer og tilhørsforhold kommer fra HR-ON og skal kunne indlæses via OS2sofds API.; Det foreslåede natlige oprydningsjob konflikter med, at HR-ON skal være styrende kilde, medmindre oprydningen gøres valgfri.; Kontaktpersonen ønsker at fastholde koblingen til tilhørsforholdet og fravælger den alternative direkte binding til AD-konto. | 1 |
| [#15 – Behov for at kunne vise forskelligt displaynavn på ansatte med flere tilhørsforhold/AD-konti](https://github.com/OS2sofd/issues/issues/15) | 17.500kr | 🟢 Review 1 | – | 0 |
| [#24 – Prefix i AD Event Dispatcher](https://github.com/OS2sofd/issues/issues/24) | 4.500kr | 🟢 Review 1 | – | 0 |
| [#78 – Bjælke for oven og i venstre side, skal fryses fast](https://github.com/OS2sofd/issues/issues/78) | 6.500kr | 🟢 Review 1 | – | 0 |
| [#91 – Opslag i MitID Erhverv ved for at se om bruger har et aktivt tildelt MitID Erhverv](https://github.com/OS2sofd/issues/issues/91) | 8.500kr | 🔴 Review 1 | Løsningsbeskrivelsen nævner UUID, tilstand og RID, men ikke de roller og identifikationsmidler som ændringsønsket udtrykkeligt efterspørger.; Der etableres direkte integration til MitID Erhverv og certifikatbaseret adgang. | 0 |
| [#93 – Berigelse af titelfelt for skoleelever med klassetrin](https://github.com/OS2sofd/issues/issues/93) | 6.500kr | 🟢 Review 1 | – | 0 |
| [#96 – Vis detaljer om hvem der har bestilt/oprettet en konto undrer ordre-detaljer](https://github.com/OS2sofd/issues/issues/96) | 5.500kr | 🟢 Review 1 | – | 0 |
| [#113 – Indlæsning af Mit Erhverv status til OS2Sofd](https://github.com/OS2sofd/issues/issues/113) | 9.500kr | 🟡 Review 1 | Løsningen er en bevidst bredere arkitekturændring: OS2sofd kan hente MitID Erhverv-data direkte i stedet for via AD/OS2faktor.; Direkte indlæsning kræver certifikat/adgang pr. kommune og ændrer hvilken kilde der er autoritativ. | 0 |
| [#120 – Advarsel omkring bestilling af Brugerkonti når man anvender bindingsmodellen](https://github.com/OS2sofd/issues/issues/120) | 6.500kr | 🟢 Review 1 | – | 0 |
| [#119 – Forbedret logning/dokumentation af ordredannelser.](https://github.com/OS2sofd/issues/issues/119) | 6.500kr | 🟡 Review 1 | Løsningsforslaget flytter tyngden over i auditloggen. Det oprindelige ønske nævner også oprettelsestidspunkt og ordregrundlag direkte i ordrestatus/detaljevisningen. | 0 |
| [#105 – OS2ILM: Flytning af ILM-oprettede konsulenter](https://github.com/OS2sofd/issues/issues/105) | 2.250kr | 🟡 Review 1 | Ændringsønsket nævner også behov for afklaring af, om en konsulent skal kunne have flere tilhørsforhold. Det fremgår ikke af løsningsbeskrivelsen, om dette er vurderet eller bevidst holdt uden for løsningen. | 1 |

> **Nye kommentarer siden review:** Kendte automatiske proceskommentarer tælles ikke med. Et nyt kommentarspor er kun et signal om, at PO bør vurdere relevansen; det udløser ikke automatisk et nyt review.

## 6. Release-overblik – 3. kvartal 2026

| Status | Antal |
| --- | ---: |
| Bestilt hos leverandør | 1 |
| Igangværende opgaver | 1 |
| Løsninger i test | 3 |

| Prioritet | Issue | Alder | Status | Estimat | Assignee |
| --- | --- | ---: | --- | ---: | --- |
| Kritisk | [#51 – Migrér CVR-integration fra Datafordeler REST til GraphQL](https://github.com/OS2sofd/issues/issues/51) | 146 dage / 4.8 mdr. | Bestilt hos leverandør | 25.000kr | pso-digital-identity |
| Kritisk | [#94 – Understøttelse af Pre-hire-brugere i snitfladen mellem SOFD og Rollekatalog](https://github.com/OS2sofd/issues/issues/94) | 79 dage / 2.6 mdr. | Løsninger i test | 5.000kr | – |
| Høj | [#50 – Mulighed for at opsætte grænser for varigheden af OS2sofd tilhørsforhold](https://github.com/OS2sofd/issues/issues/50) | 147 dage / 4.8 mdr. | Igangværende opgaver | 25.000kr | pso-digital-identity |
| Høj | [#53 – OS2sofd Lederside - Auditlogning af ændringer skal følge SOFD Core praksis](https://github.com/OS2sofd/issues/issues/53) | 134 dage / 4.4 mdr. | Løsninger i test | 26.000kr | pso-digital-identity |
| Høj | [#100 – Brugerkontotyper - tilføjelse til skabelonbaseret navnekonvention](https://github.com/OS2sofd/issues/issues/100) | 56 dage / 1.8 mdr. | Løsninger i test | 15.000kr | pso-digital-identity |

### Release-efterslæb

Ingen aktive issues har en udløbet planlagt release.

### Kandidater uden planlagt release

| Prioritet | Issue | Alder | Status | Estimat | Assignee |
| --- | --- | ---: | --- | ---: | --- |
| Høj | [#62 – Udvidelse af Opus-integrationen med mulighed for at overføre flere brugerkontotyper](https://github.com/OS2sofd/issues/issues/62) | 113 dage / 3.7 mdr. | Klar til prioritering | 2.500kr | – |
| Høj | [#65 – NexusSync - automatisk luk af konti udenfor "nexus organisationen"](https://github.com/OS2sofd/issues/issues/65) | 105 dage / 3.4 mdr. | Klar til prioritering | 6.000kr | – |
| Høj | [#108 – Ændringsønske: Fremtidige ændringer: Organisationsændringer og- håndtering fødes i OS2sofd og matches efterfølgende med LOSid i KMD LOS integration mod sofd.](https://github.com/OS2sofd/issues/issues/108) | 41 dage / 1.3 mdr. | Klar til prioritering | – | – |
| Høj | [#112 – Migrering til Datafordeleren til CPR opslag](https://github.com/OS2sofd/issues/issues/112) | 34 dage / 1.1 mdr. | Klar til prioritering | – | – |
| Mellem | [#9 – Person tilhørsforhold - Tilføj markering af primært tilhørsforhold](https://github.com/OS2sofd/issues/issues/9) | 187 dage / 6.1 mdr. | Klar til prioritering | 2.500kr | – |
| Mellem | [#11 – Tilføj information om en AD konto er i brug + understøtte LocalExtensions i Mail skabeloner](https://github.com/OS2sofd/issues/issues/11) | 187 dage / 6.1 mdr. | Klar til prioritering | 65.000kr | – |
| Mellem | [#17 – SOFD GUI: Udvidet overblik over tilhørsforhold og typer](https://github.com/OS2sofd/issues/issues/17) | 187 dage / 6.1 mdr. | Klar til prioritering | 15.500kr | – |
| Mellem | [#25 – Brugertjek: Udvidelse af informationer i tilhørforholdstabellen](https://github.com/OS2sofd/issues/issues/25) | 186 dage / 6.1 mdr. | Klar til prioritering | 2.500kr | – |
| Mellem | [#27 – Oprettelse af KSP/CICS konti på baggrund af rolletildelinger](https://github.com/OS2sofd/issues/issues/27) | 186 dage / 6.1 mdr. | Klar til prioritering | 8.500kr | – |
| Mellem | [#36 – Auto-opdatere enheder i FK Organisation ved nye KLE emner](https://github.com/OS2sofd/issues/issues/36) | 181 dage / 5.9 mdr. | Klar til prioritering | 4.500kr | – |
| Mellem | [#73 – OS2sofd Kommunikationsmodul - Ønsker til forbedringer](https://github.com/OS2sofd/issues/issues/73) | 97 dage / 3.2 mdr. | Klar til prioritering | 27.500kr | – |
| Mellem | [#82 – ÆndringsønskeObligatorisk drop down menuer samt mulighed for a pre-definere værdier ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/82) | 84 dage / 2.8 mdr. | Klar til prioritering | 9.500kr | – |
| Mellem | [#83 – At kunne gøre data felter obligatoriske ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/83) | 84 dage / 2.8 mdr. | Klar til prioritering | 3.500kr | – |
| Mellem | [#86 – OS2Vikar mulighed for at angive tid ved oprettelse af vikar](https://github.com/OS2sofd/issues/issues/86) | 83 dage / 2.7 mdr. | Klar til prioritering | 17.500kr | – |
| Mellem | [#85 – Brugernavn generator ved oprettelse af vikar (OS2Vikar)](https://github.com/OS2sofd/issues/issues/85) | 83 dage / 2.7 mdr. | Klar til prioritering | 16.500kr | – |
| Mellem | [#97 – Vedligehold/rettidige opdateringer af Autorisationskoder](https://github.com/OS2sofd/issues/issues/97) | 65 dage / 2.1 mdr. | Klar til prioritering | 6.500kr | – |
| Mellem | [#121 – Ændringsønske - Udfordring ved flere mobilnumre til samme person](https://github.com/OS2sofd/issues/issues/121) | 6 dage / 0.2 mdr. | Klar til prioritering | 12.500kr | – |
| Lav | [#15 – Behov for at kunne vise forskelligt displaynavn på ansatte med flere tilhørsforhold/AD-konti](https://github.com/OS2sofd/issues/issues/15) | 187 dage / 6.1 mdr. | Klar til prioritering | 17.500kr | – |
| Lav | [#24 – Prefix i AD Event Dispatcher](https://github.com/OS2sofd/issues/issues/24) | 187 dage / 6.1 mdr. | Klar til prioritering | 4.500kr | – |
| Lav | [#78 – Bjælke for oven og i venstre side, skal fryses fast](https://github.com/OS2sofd/issues/issues/78) | 89 dage / 2.9 mdr. | Klar til prioritering | 6.500kr | – |
| Lav | [#91 – Opslag i MitID Erhverv ved for at se om bruger har et aktivt tildelt MitID Erhverv](https://github.com/OS2sofd/issues/issues/91) | 83 dage / 2.7 mdr. | Klar til prioritering | 8.500kr | – |
| Lav | [#93 – Berigelse af titelfelt for skoleelever med klassetrin](https://github.com/OS2sofd/issues/issues/93) | 83 dage / 2.7 mdr. | Klar til prioritering | 6.500kr | – |
| Lav | [#96 – Vis detaljer om hvem der har bestilt/oprettet en konto undrer ordre-detaljer](https://github.com/OS2sofd/issues/issues/96) | 69 dage / 2.3 mdr. | Klar til prioritering | 5.500kr | – |
| Lav | [#113 – Indlæsning af Mit Erhverv status til OS2Sofd](https://github.com/OS2sofd/issues/issues/113) | 20 dage / 0.7 mdr. | Klar til prioritering | 9.500kr | – |
| Lav | [#120 – Advarsel omkring bestilling af Brugerkonti når man anvender bindingsmodellen](https://github.com/OS2sofd/issues/issues/120) | 8 dage / 0.3 mdr. | Klar til prioritering | 6.500kr | – |
| Lav | [#119 – Forbedret logning/dokumentation af ordredannelser.](https://github.com/OS2sofd/issues/issues/119) | 8 dage / 0.3 mdr. | Klar til prioritering | 6.500kr | – |
| – | [#105 – OS2ILM: Flytning af ILM-oprettede konsulenter](https://github.com/OS2sofd/issues/issues/105) | 42 dage / 1.4 mdr. | Klar til prioritering | 2.250kr | – |
| – | [#101 – OS2ILM: Tildeling af leder via Virksomhed](https://github.com/OS2sofd/issues/issues/101) | 42 dage / 1.4 mdr. | Bestilt hos leverandør | 3.250kr | – |

## 7. Hele pipeline – Fra idé til færdig løsning

| Status | Antal |
| --- | ---: |
| Nye ændringsønsker | 3 |
| Screening | 11 |
| Afventer løsningsbeskrivelse | 32 |
| Klar til prioritering | 27 |
| Bestilt hos leverandør | 2 |
| Igangværende opgaver | 1 |
| Løsninger i test | 3 |
| Løsninger i review | 0 |
| Afsluttede løsninger | 23 |
| Won't fix | 12 |

### Nye ændringsønsker

<details>
<summary>Vis 3 issue(s)</summary>

| Prioritet | Issue | Alder | Kommune | Labels | Senest opdateret |
| --- | --- | ---: | --- | --- | ---: |
| – | [#122 – Mulighed for at angive leder på institutioner](https://github.com/OS2sofd/issues/issues/122) | 2 dage / 0.1 mdr. | – | ændringsønske | 2 dage siden |
| – | [#123 – OS2ILM - Tilknytning af allerede oprettede brugere](https://github.com/OS2sofd/issues/issues/123) | 2 dage / 0.1 mdr. | – | ændringsønske, ilm | 1 dage siden |
| – | [#124 – OS2ILM - Ændring til CMS, mailskabeloner](https://github.com/OS2sofd/issues/issues/124) | 0 dage / 0 mdr. | – | ændringsønske | 0 dage siden |

</details>

### Screening

<details>
<summary>Vis 11 issue(s)</summary>

| Prioritet | Issue | Alder | Kommune | Labels | Senest opdateret |
| --- | --- | ---: | --- | --- | ---: |
| Mellem | [#10 – Udvid SOFDCoreADWritebackAgent til at understøtte forsk. OU'er](https://github.com/OS2sofd/issues/issues/10) | 187 dage / 6.1 mdr. | Favrskov | middleware, brugere og konti | 20 dage siden |
| Mellem | [#22 – Brug af AD konto ved opsætning af 'manuelt valgt' leder på enhed](https://github.com/OS2sofd/issues/issues/22) | 187 dage / 6.1 mdr. | Favrskov | ui, brugere og konti | 2 dage siden |
| Mellem | [#54 – Udvidet stillingskatalog og kodebaseret regelgrundlag i SOFD (og OS2Rollekatalog)](https://github.com/OS2sofd/issues/issues/54) | 133 dage / 4.4 mdr. | Hjørring | idm, datamodel og tilhørsforhold | 9 dage siden |
| Mellem | [#95 – Mulighed for at deaktivere en konto med udskudt dato](https://github.com/OS2sofd/issues/issues/95) | 76 dage / 2.5 mdr. | Tønder | idm, brugere og konti | 8 dage siden |
| Mellem | [#102 – OS2ILM: Mere specifik log](https://github.com/OS2sofd/issues/issues/102) | 42 dage / 1.4 mdr. | Norddjurs | log-data, ilm | 1 dage siden |
| Lav | [#72 – Ekstra data på skoleelever](https://github.com/OS2sofd/issues/issues/72) | 105 dage / 3.4 mdr. | Kalundborg | stamdata, middleware | 4 dage siden |
| Lav | [#90 – At kunde (kommune) selv kan konfigurere i UI, i Brugertjek, hvilke data attributter der skal være synlige ved opslag i brugertjek](https://github.com/OS2sofd/issues/issues/90) | 83 dage / 2.7 mdr. | Lyngby-Taarbæk | ui, brugertjek | 4 dage siden |
| Lav | [#103 – OS2ILM: Visning af firma og navn](https://github.com/OS2sofd/issues/issues/103) | 42 dage / 1.4 mdr. | Norddjurs | ui, ilm | 1 dage siden |
| – | [#16 – Navne- og adressebeskyttelse:](https://github.com/OS2sofd/issues/issues/16) | 187 dage / 6.1 mdr. | Odsherred | stamdata, ui | 20 dage siden |
| – | [#68 – API-udvidelse til undtagelse/pausemarkering](https://github.com/OS2sofd/issues/issues/68) | 105 dage / 3.4 mdr. | Kalundborg | idm, api | 1 dage siden |
| – | [#74 – funktionelle forbedringer](https://github.com/OS2sofd/issues/issues/74) | 97 dage / 3.2 mdr. | Tønder | idm, middleware | 20 dage siden |

</details>

### Afventer løsningsbeskrivelse

<details>
<summary>Vis 32 issue(s)</summary>

| Prioritet | Issue | Alder | Labels | Kommune | Assignee | Senest opdateret |
| --- | --- | ---: | --- | --- | --- | ---: |
| Høj | [#109 – Dobbelt hierarki: Lønhierarki og den administrative organisation. Oprettelse af det administrative hierarki foretages pba. LOS-koblinger og strukturerede valideringer.Ændringsønske](https://github.com/OS2sofd/issues/issues/109) | 41 dage / 1.3 mdr. | stamdata, datamodel og tilhørsforhold | Horsens | – | 20 dage siden |
| Mellem | [#12 – Forstå forskel på Ansatte, Eksterne, Byrøddet, Konsulenter, Vikarer, m.m. typer af AD konti](https://github.com/OS2sofd/issues/issues/12) | 187 dage / 6.1 mdr. | idm, brugere og konti | Sønderborg | – | 20 dage siden |
| Mellem | [#13 – SofdCoreADReplicator - Handlinger ved grupper](https://github.com/OS2sofd/issues/issues/13) | 187 dage / 6.1 mdr. | drift og vedligehold, middleware | Favrskov | – | 20 dage siden |
| Mellem | [#19 – SOFD GUI: Bloker oprettelse af manuelle tilhørsforhold af typen "Medarbejder" når man kører med sync fra et lønsystem](https://github.com/OS2sofd/issues/issues/19) | 187 dage / 6.1 mdr. | idm, ui | Favrskov | – | 20 dage siden |
| Mellem | [#21 – SOFD indlæsning fra lønsystem: Mulighed for selv at administrere indlæsningsfiltre](https://github.com/OS2sofd/issues/issues/21) | 187 dage / 6.1 mdr. | ui, middleware, brugere og konti | Favrskov | – | 20 dage siden |
| Mellem | [#23 – Samlet overblik over diverse opmærkninger/fravalg af enheder](https://github.com/OS2sofd/issues/issues/23) | 187 dage / 6.1 mdr. | rapporter, ui, brugere og konti | Favrskov | – | 20 dage siden |
| Mellem | [#35 – Forslag til rettelser i OS2SOFD Ledermodul](https://github.com/OS2sofd/issues/issues/35) | 181 dage / 5.9 mdr. | idm, lederside | Sønderborg | – | 20 dage siden |
| Mellem | [#55 – Lederside - Forbedring af GUI for Pausemarkering ift. endusers](https://github.com/OS2sofd/issues/issues/55) | 133 dage / 4.4 mdr. | ui, lederside | Favrskov | – | 20 dage siden |
| Mellem | [#76 – Ny pladsholder og pladsholder funktion til mailskabelonen ”Digital post til medarbejder ved oprettelse af AD konto”](https://github.com/OS2sofd/issues/issues/76) | 93 dage / 3.1 mdr. | mailskabelon/advis, funktionelle forbedringer | Vallensbæk | – | 20 dage siden |
| Mellem | [#98 – OS2sofd Telefoni-modul - Ønsker til forbedringer](https://github.com/OS2sofd/issues/issues/98) | 64 dage / 2.1 mdr. | ui, funktionelle forbedringer | Favrskov | – | 20 dage siden |
| Mellem | [#104 – OS2ILM: Placering af medarbejdere i OU](https://github.com/OS2sofd/issues/issues/104) | 42 dage / 1.4 mdr. | idm, ilm | Norddjurs | – | 20 dage siden |
| Mellem | [#110 – Frigørelse af kobling mellem it-brugerkonto og tilhørsforhold fra løndata. Tilhørsforhold skal afspejle den administrative organisation i OS2sofd.Ændringsønske](https://github.com/OS2sofd/issues/issues/110) | 41 dage / 1.3 mdr. | brugere og konti, datamodel og tilhørsforhold | Horsens | – | 20 dage siden |
| Lav | [#18 – Brugertjek: Uddybelse af Entra licenser](https://github.com/OS2sofd/issues/issues/18) | 187 dage / 6.1 mdr. | ui, brugertjek | Bornholm | – | 20 dage siden |
| Lav | [#30 – OS2sofd - ILM: Vedligeholdelse af Fortrolighedsaftale](https://github.com/OS2sofd/issues/issues/30) | 186 dage / 6.1 mdr. | idm, ilm | Bornholm | – | 20 dage siden |
| Lav | [#28 – Brugertjek: Kontrol af lønsystem konto](https://github.com/OS2sofd/issues/issues/28) | 186 dage / 6.1 mdr. | idm, brugertjek | Bornholm | – | 20 dage siden |
| Lav | [#26 – Brugertjek: Robot-flag for robotter](https://github.com/OS2sofd/issues/issues/26) | 186 dage / 6.1 mdr. | ui, brugertjek | Bornholm | – | 20 dage siden |
| Lav | [#29 – Brugertjek: Mulighed for genveje og dybe links](https://github.com/OS2sofd/issues/issues/29) | 186 dage / 6.1 mdr. | ui, brugertjek | Bornholm | – | 20 dage siden |
| Lav | [#34 – ÆndringsønskeMulighed for at sende sms fra Vikarmodulet](https://github.com/OS2sofd/issues/issues/34) | 181 dage / 5.9 mdr. | vikar, mailskabelon/advis | Køge | – | 20 dage siden |
| Lav | [#32 – Import af SOFD enheder til OS2Vikar modulet](https://github.com/OS2sofd/issues/issues/32) | 181 dage / 5.9 mdr. | vikar, middleware | Hjørring | – | 20 dage siden |
| Lav | [#37 – Tilknytning af stillinger til enheder i Vikar modulet](https://github.com/OS2sofd/issues/issues/37) | 180 dage / 5.9 mdr. | vikar, ui | Tårnby | – | 20 dage siden |
| Lav | [#48 – Stoppet medarbejder slettes i Lederportalen/Tillidserhverv](https://github.com/OS2sofd/issues/issues/48) | 163 dage / 5.4 mdr. | lederside, brugere og konti | Odsherred | – | 20 dage siden |
| Lav | [#52 – Automatisk dannede flow-diagrammer til OS2sofd](https://github.com/OS2sofd/issues/issues/52) | 141 dage / 4.6 mdr. | dokumentation, log-data | Ikke kommune | – | 20 dage siden |
| Lav | [#60 – SMS/Kodeordspåmindelse: understøttelse af flere kodeordspolitikker](https://github.com/OS2sofd/issues/issues/60) | 120 dage / 3.9 mdr. | mailskabelon/advis, middleware | Bornholm | – | 20 dage siden |
| Lav | [#70 – Mulighed for at redigere og flytte kolonner i oversigtsbillederne](https://github.com/OS2sofd/issues/issues/70) | 105 dage / 3.4 mdr. | ui | Kalundborg | – | 20 dage siden |
| Lav | [#71 – Videreudvikling af SMS modul](https://github.com/OS2sofd/issues/issues/71) | 105 dage / 3.4 mdr. | mailskabelon/advis, middleware | Kalundborg | – | 20 dage siden |
| Lav | [#67 – Kommunikationsmodul - Udviklingsønsker til email og log](https://github.com/OS2sofd/issues/issues/67) | 105 dage / 3.4 mdr. | log-data, mailskabelon/advis | Kalundborg | – | 20 dage siden |
| Lav | [#66 – Mulighed for at redigere allerede oprettet arbejdssted](https://github.com/OS2sofd/issues/issues/66) | 105 dage / 3.4 mdr. | ui, funktionelle forbedringer | Kalundborg | – | 20 dage siden |
| Lav | [#64 – Brugertjek : oplysninger om sidste kodeordsskifte og kodeordsløb i OS2faktor fanen](https://github.com/OS2sofd/issues/issues/64) | 105 dage / 3.4 mdr. | api, brugertjek | Kalundborg | – | 20 dage siden |
| Lav | [#69 – Mulighed for at fravælge advis ved kontooprettelse](https://github.com/OS2sofd/issues/issues/69) | 105 dage / 3.4 mdr. | idm, mailskabelon/advis | Kalundborg | – | 20 dage siden |
| Lav | [#75 – Kommunikationsmodul i OS2sofd SMS/Email](https://github.com/OS2sofd/issues/issues/75) | 97 dage / 3.2 mdr. | stamdata, mailskabelon/advis | Tønder | – | 20 dage siden |
| Lav | [#99 – Understøtte ny Skole/SFO opmærkning til KOMBIT](https://github.com/OS2sofd/issues/issues/99) | 56 dage / 1.8 mdr. | stamdata, middleware | Ikke kommune | – | 20 dage siden |
| Lav | [#111 – UI forbedringer til stillingskatalog](https://github.com/OS2sofd/issues/issues/111) | 37 dage / 1.2 mdr. | ui, funktionelle forbedringer | Allerød | – | 20 dage siden |

</details>

### Klar til prioritering

| Prioritet | Issue | Alder | Estimat | Størrelse | Release | Kommune |
| --- | --- | ---: | ---: | --- | --- | --- |
| Høj | [#62 – Udvidelse af Opus-integrationen med mulighed for at overføre flere brugerkontotyper](https://github.com/OS2sofd/issues/issues/62) | 113 dage / 3.7 mdr. | 2.500kr | – | – | Egedal |
| Høj | [#65 – NexusSync - automatisk luk af konti udenfor "nexus organisationen"](https://github.com/OS2sofd/issues/issues/65) | 105 dage / 3.4 mdr. | 6.000kr | – | – | Kalundborg |
| Høj | [#108 – Ændringsønske: Fremtidige ændringer: Organisationsændringer og- håndtering fødes i OS2sofd og matches efterfølgende med LOSid i KMD LOS integration mod sofd.](https://github.com/OS2sofd/issues/issues/108) | 41 dage / 1.3 mdr. | – | – | – | Horsens |
| Høj | [#112 – Migrering til Datafordeleren til CPR opslag](https://github.com/OS2sofd/issues/issues/112) | 34 dage / 1.1 mdr. | – | – | – | Ikke kommune |
| Mellem | [#9 – Person tilhørsforhold - Tilføj markering af primært tilhørsforhold](https://github.com/OS2sofd/issues/issues/9) | 187 dage / 6.1 mdr. | 2.500kr | – | – | Favrskov |
| Mellem | [#11 – Tilføj information om en AD konto er i brug + understøtte LocalExtensions i Mail skabeloner](https://github.com/OS2sofd/issues/issues/11) | 187 dage / 6.1 mdr. | 65.000kr | – | – | Favrskov |
| Mellem | [#17 – SOFD GUI: Udvidet overblik over tilhørsforhold og typer](https://github.com/OS2sofd/issues/issues/17) | 187 dage / 6.1 mdr. | 15.500kr | – | – | Favrskov |
| Mellem | [#25 – Brugertjek: Udvidelse af informationer i tilhørforholdstabellen](https://github.com/OS2sofd/issues/issues/25) | 186 dage / 6.1 mdr. | 2.500kr | – | – | Bornholm |
| Mellem | [#27 – Oprettelse af KSP/CICS konti på baggrund af rolletildelinger](https://github.com/OS2sofd/issues/issues/27) | 186 dage / 6.1 mdr. | 8.500kr | – | – | Bornholm |
| Mellem | [#36 – Auto-opdatere enheder i FK Organisation ved nye KLE emner](https://github.com/OS2sofd/issues/issues/36) | 181 dage / 5.9 mdr. | 4.500kr | – | – | Sønderborg |
| Mellem | [#73 – OS2sofd Kommunikationsmodul - Ønsker til forbedringer](https://github.com/OS2sofd/issues/issues/73) | 97 dage / 3.2 mdr. | 27.500kr | – | – | Favrskov |
| Mellem | [#82 – ÆndringsønskeObligatorisk drop down menuer samt mulighed for a pre-definere værdier ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/82) | 84 dage / 2.8 mdr. | 9.500kr | – | – | Lyngby-Taarbæk |
| Mellem | [#83 – At kunne gøre data felter obligatoriske ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/83) | 84 dage / 2.8 mdr. | 3.500kr | – | – | Lyngby-Taarbæk |
| Mellem | [#85 – Brugernavn generator ved oprettelse af vikar (OS2Vikar)](https://github.com/OS2sofd/issues/issues/85) | 83 dage / 2.7 mdr. | 16.500kr | – | – | Lyngby-Taarbæk |
| Mellem | [#86 – OS2Vikar mulighed for at angive tid ved oprettelse af vikar](https://github.com/OS2sofd/issues/issues/86) | 83 dage / 2.7 mdr. | 17.500kr | – | – | Lyngby-Taarbæk |
| Mellem | [#97 – Vedligehold/rettidige opdateringer af Autorisationskoder](https://github.com/OS2sofd/issues/issues/97) | 65 dage / 2.1 mdr. | 6.500kr | – | – | Bornholm |
| Mellem | [#121 – Ændringsønske - Udfordring ved flere mobilnumre til samme person](https://github.com/OS2sofd/issues/issues/121) | 6 dage / 0.2 mdr. | 12.500kr | – | – | Esbjerg |
| Lav | [#15 – Behov for at kunne vise forskelligt displaynavn på ansatte med flere tilhørsforhold/AD-konti](https://github.com/OS2sofd/issues/issues/15) | 187 dage / 6.1 mdr. | 17.500kr | – | – | Sønderborg |
| Lav | [#24 – Prefix i AD Event Dispatcher](https://github.com/OS2sofd/issues/issues/24) | 187 dage / 6.1 mdr. | 4.500kr | – | – | Bornholm |
| Lav | [#78 – Bjælke for oven og i venstre side, skal fryses fast](https://github.com/OS2sofd/issues/issues/78) | 89 dage / 2.9 mdr. | 6.500kr | – | – | Tønder |
| Lav | [#91 – Opslag i MitID Erhverv ved for at se om bruger har et aktivt tildelt MitID Erhverv](https://github.com/OS2sofd/issues/issues/91) | 83 dage / 2.7 mdr. | 8.500kr | – | – | Lyngby-Taarbæk |
| Lav | [#93 – Berigelse af titelfelt for skoleelever med klassetrin](https://github.com/OS2sofd/issues/issues/93) | 83 dage / 2.7 mdr. | 6.500kr | – | – | Kalundborg |
| Lav | [#96 – Vis detaljer om hvem der har bestilt/oprettet en konto undrer ordre-detaljer](https://github.com/OS2sofd/issues/issues/96) | 69 dage / 2.3 mdr. | 5.500kr | – | – | Allerød |
| Lav | [#113 – Indlæsning af Mit Erhverv status til OS2Sofd](https://github.com/OS2sofd/issues/issues/113) | 20 dage / 0.7 mdr. | 9.500kr | – | – | Kalundborg |
| Lav | [#120 – Advarsel omkring bestilling af Brugerkonti når man anvender bindingsmodellen](https://github.com/OS2sofd/issues/issues/120) | 8 dage / 0.3 mdr. | 6.500kr | – | – | Bornholm |
| Lav | [#119 – Forbedret logning/dokumentation af ordredannelser.](https://github.com/OS2sofd/issues/issues/119) | 8 dage / 0.3 mdr. | 6.500kr | – | – | Bornholm |
| – | [#105 – OS2ILM: Flytning af ILM-oprettede konsulenter](https://github.com/OS2sofd/issues/issues/105) | 42 dage / 1.4 mdr. | 2.250kr | – | – | Norddjurs |

### Bestilt hos leverandør

<details>
<summary>Vis 2 issue(s)</summary>

| Prioritet | Issue | Alder | Assignee | Estimat | Release | Senest opdateret |
| --- | --- | ---: | --- | ---: | --- | ---: |
| Kritisk | [#51 – Migrér CVR-integration fra Datafordeler REST til GraphQL](https://github.com/OS2sofd/issues/issues/51) | 146 dage / 4.8 mdr. | pso-digital-identity | 25.000kr | 3. kvartal 2026 | 13 dage siden |
| – | [#101 – OS2ILM: Tildeling af leder via Virksomhed](https://github.com/OS2sofd/issues/issues/101) | 42 dage / 1.4 mdr. | – | 3.250kr | – | 2 dage siden |

</details>

### Igangværende opgaver

<details>
<summary>Vis 1 issue(s)</summary>

| Prioritet | Issue | Alder | Assignee | Estimat | Release | Senest opdateret |
| --- | --- | ---: | --- | ---: | --- | ---: |
| Høj | [#50 – Mulighed for at opsætte grænser for varigheden af OS2sofd tilhørsforhold](https://github.com/OS2sofd/issues/issues/50) | 147 dage / 4.8 mdr. | pso-digital-identity | 25.000kr | 3. kvartal 2026 | 13 dage siden |

</details>

### Løsninger i test

<details>
<summary>Vis 3 issue(s)</summary>

| Issue | Alder | Release | Assignee | Senest opdateret |
| --- | ---: | --- | --- | ---: |
| [#94 – Understøttelse af Pre-hire-brugere i snitfladen mellem SOFD og Rollekatalog](https://github.com/OS2sofd/issues/issues/94) | 79 dage / 2.6 mdr. | 3. kvartal 2026 | – | 7 dage siden |
| [#53 – OS2sofd Lederside - Auditlogning af ændringer skal følge SOFD Core praksis](https://github.com/OS2sofd/issues/issues/53) | 134 dage / 4.4 mdr. | 3. kvartal 2026 | pso-digital-identity | 13 dage siden |
| [#100 – Brugerkontotyper - tilføjelse til skabelonbaseret navnekonvention](https://github.com/OS2sofd/issues/issues/100) | 56 dage / 1.8 mdr. | 3. kvartal 2026 | pso-digital-identity | 13 dage siden |

</details>

### Afsluttede løsninger

> Gennemløbstid vises kun, når der findes en registreret afslutningsdato. Fremadrettet kan automatiseringen opbygge status-historik og dermed måle gennemløbstid mere præcist.

<details>
<summary>Vis 23 issue(s)</summary>

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
| [#39 – IDM: Opret nye AD-konti i disabled tilstand indtil ansættelsesstart](https://github.com/OS2sofd/issues/issues/39) | 82 dage / 2.7 mdr. | – | 2. kvartal 2026 | 30-06-2026 |
| [#38 – IDM: Ny ordretype REACTIVATE i IDM-flow](https://github.com/OS2sofd/issues/issues/38) | 82 dage / 2.7 mdr. | – | 2. kvartal 2026 | 30-06-2026 |
| [#46 – IDM: Bedre håndtering af personinaktivering](https://github.com/OS2sofd/issues/issues/46) | 82 dage / 2.7 mdr. | – | 2. kvartal 2026 | 30-06-2026 |
| [#43 – IDM: Understøt AD-kontooprettelse fra flere tilhørsforholdskilder end for andre kontotyper](https://github.com/OS2sofd/issues/issues/43) | 82 dage / 2.7 mdr. | – | 2. kvartal 2026 | 30-06-2026 |
| [#42 – IDM: Opret konto-ordre straks ved kendskab til ansættelse](https://github.com/OS2sofd/issues/issues/42) | 82 dage / 2.7 mdr. | – | 2. kvartal 2026 | 30-06-2026 |
| [#56 – Bestilling af mail-adresser via ILM modulet](https://github.com/OS2sofd/issues/issues/56) | 107 dage / 3.5 mdr. | – | – | 04-09-2026 |
| [#57 – Tilføjelse i OS2sofd - ILM af e-mailinvitation til konsulent så chancen for selv-registrering øges](https://github.com/OS2sofd/issues/issues/57) | 107 dage / 3.5 mdr. | – | – | 04-09-2026 |
| [#58 – OS2sofd - ilm - udfyld UPN ved oprettelse af konsulentkonto](https://github.com/OS2sofd/issues/issues/58) | – | – | – | – |
| [#59 – OS2sofd - ilm: udfyld displayName ved oprettelse af konsulent](https://github.com/OS2sofd/issues/issues/59) | – | – | – | – |
| [#61 – Vil gerne selv kunne styre username, og navngivningen generelt i ILM](https://github.com/OS2sofd/issues/issues/61) | – | – | – | – |
| [#63 – Opdatering af OS2sofd STIL integration til WS17-V7](https://github.com/OS2sofd/issues/issues/63) | 94 dage / 3.1 mdr. | – | – | 04-09-2026 |
| [#106 – OS2ILM: Det skal være muligt for en administrator at slette en konsulent helt.](https://github.com/OS2sofd/issues/issues/106) | – | – | – | – |
| [#107 – OS2ILM: Manglende e-mailnotifikationer ved konsulentgodkendelse](https://github.com/OS2sofd/issues/issues/107) | – | – | – | – |
| [#118 – TEST - Ændringsønske](https://github.com/OS2sofd/issues/issues/118) | – | – | – | – |

</details>

### Won't fix

<details>
<summary>Vis 12 issue(s)</summary>

| Issue | Alder | Kommune | Senest opdateret |
| --- | ---: | --- | --- |
| [#49 – Ændring af synkronisering af data ind i Nexus](https://github.com/OS2sofd/issues/issues/49) | 159 dage / 5.2 mdr. | Tønder | 15-09-2026 |
| [#79 – Flere steps i godkendelsesflow i OS2Rollekatalog Anmod/Godkend](https://github.com/OS2sofd/issues/issues/79) | 85 dage / 2.8 mdr. | Lyngby-Taarbæk | 22-09-2026 |
| [#80 – ÆndringsønskeUdvidet information ved anmodning om rolle i OS2Rolekatalog Anmod/Godkend](https://github.com/OS2sofd/issues/issues/80) | 85 dage / 2.8 mdr. | Lyngby-Taarbæk | 22-09-2026 |
| [#81 – At kunne ændre afsendernavn på mails fra Rollekatalog](https://github.com/OS2sofd/issues/issues/81) | 84 dage / 2.8 mdr. | Lyngby-Taarbæk | 22-09-2026 |
| [#88 – Ny kolonne i rapporten 'Historiske rolleanmodninger', så man kan se hvilket IT-System de forskellige roller er tilknyttet](https://github.com/OS2sofd/issues/issues/88) | 83 dage / 2.7 mdr. | Lyngby-Taarbæk | 22-09-2026 |
| [#89 – Udvide 'Status' typer for tildeling af rettigheder med 'Tildelt ved godkendt anmodning'.](https://github.com/OS2sofd/issues/issues/89) | 83 dage / 2.7 mdr. | Lyngby-Taarbæk | 22-09-2026 |
| [#92 – Konfigurationsindstilling: Jobfunktionsroller og Rollebuketter listes samlet](https://github.com/OS2sofd/issues/issues/92) | 83 dage / 2.7 mdr. | Lyngby-Taarbæk | 22-09-2026 |
| [#6 – Visning af mailadresse i listevisning/SOFD](https://github.com/OS2sofd/issues/issues/6) | 405 dage / 13.3 mdr. | – | 18-08-2025 |
| [#14 – Nye hændelse til IDM proces: Reaktivering - Oprydning](https://github.com/OS2sofd/issues/issues/14) | 187 dage / 6.1 mdr. | Sønderborg | 19-05-2026 |
| [#33 – Foretræk kendte spærrede konti fremfor at danne et nyt brugernavn](https://github.com/OS2sofd/issues/issues/33) | 181 dage / 5.9 mdr. | Sønderborg | 19-05-2026 |
| [#84 – At kunne skrive data attribut værdier fra OS2Vikar oprettelse til Data attribut i Active Directory](https://github.com/OS2sofd/issues/issues/84) | 83 dage / 2.7 mdr. | Lyngby-Taarbæk | 17-09-2026 |
| [#87 – Begrænse en systemansvarlig's view af it-systemer i OS2Rollekatalog](https://github.com/OS2sofd/issues/issues/87) | 83 dage / 2.7 mdr. | Lyngby-Taarbæk | 22-09-2026 |

</details>

## 8. Proces- og datakvalitet

| Issue | Status | Alder | Problem |
| --- | --- | ---: | --- |
| [#11 – Tilføj information om en AD konto er i brug + understøtte LocalExtensions i Mail skabeloner](https://github.com/OS2sofd/issues/issues/11) | Klar til prioritering | 187 dage / 6.1 mdr. | Nye kommentarer siden seneste PO-review bør vurderes |
| [#17 – SOFD GUI: Udvidet overblik over tilhørsforhold og typer](https://github.com/OS2sofd/issues/issues/17) | Klar til prioritering | 187 dage / 6.1 mdr. | Nye kommentarer siden seneste PO-review bør vurderes |
| [#27 – Oprettelse af KSP/CICS konti på baggrund af rolletildelinger](https://github.com/OS2sofd/issues/issues/27) | Klar til prioritering | 186 dage / 6.1 mdr. | Nye kommentarer siden seneste PO-review bør vurderes |
| [#73 – OS2sofd Kommunikationsmodul - Ønsker til forbedringer](https://github.com/OS2sofd/issues/issues/73) | Klar til prioritering | 97 dage / 3.2 mdr. | Nye kommentarer siden seneste PO-review bør vurderes |
| [#82 – ÆndringsønskeObligatorisk drop down menuer samt mulighed for a pre-definere værdier ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/82) | Klar til prioritering | 84 dage / 2.8 mdr. | Nye kommentarer siden seneste PO-review bør vurderes |
| [#101 – OS2ILM: Tildeling af leder via Virksomhed](https://github.com/OS2sofd/issues/issues/101) | Bestilt hos leverandør | 42 dage / 1.4 mdr. | Mangler prioritet; Mangler planlagt release |
| [#105 – OS2ILM: Flytning af ILM-oprettede konsulenter](https://github.com/OS2sofd/issues/issues/105) | Klar til prioritering | 42 dage / 1.4 mdr. | Mangler prioritet; Nye kommentarer siden seneste PO-review bør vurderes |
| [#108 – Ændringsønske: Fremtidige ændringer: Organisationsændringer og- håndtering fødes i OS2sofd og matches efterfølgende med LOSid i KMD LOS integration mod sofd.](https://github.com/OS2sofd/issues/issues/108) | Klar til prioritering | 41 dage / 1.3 mdr. | Mangler estimat; Mangler PO-review af løsningsbeskrivelsen |
| [#112 – Migrering til Datafordeleren til CPR opslag](https://github.com/OS2sofd/issues/issues/112) | Klar til prioritering | 34 dage / 1.1 mdr. | Mangler estimat; Mangler PO-review af løsningsbeskrivelsen |
| [#121 – Ændringsønske - Udfordring ved flere mobilnumre til samme person](https://github.com/OS2sofd/issues/issues/121) | Klar til prioritering | 6 dage / 0.2 mdr. | Nye kommentarer siden seneste PO-review bør vurderes |

---

_Denne fil er automatisk genereret fra GitHub Project **Fra idé til færdig løsning** og issue-kommentarer. GitHub Project er den autoritative datakilde; data/po-overblik-history.json bruges alene til afledt status-historik. PO-review identificeres via skjulte reviewmarkører i issue-kommentarerne. Kommunikations- og reviewsignaler er indikatorer og skal vurderes af PO._
