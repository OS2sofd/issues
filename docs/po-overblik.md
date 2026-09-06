# PO-overblik – OS2sofd ændringsønsker

> **Formål:** PO-styring af ændringsønsker med særligt fokus på omløbstid, kommunikation, prioritering og releasefremdrift.

Senest genereret: **06-09-2026 11:00**  
Mål for omløbstid: **maks. 6 måneder fra idé til færdig løsning**  
Aktuel release: **3. kvartal 2026**

> **Om alder:** Alder beregnes fra GitHub-issuets oprettelsesdato. For ønsker, der er migreret fra JIRA eller andre tidligere kilder, kan den reelle alder fra idé til færdig løsning derfor være højere.

> **Om tid i status:** Statushistorikken registreres fra den dag denne automatisering tages i brug. ≥ betyder, at issuet allerede stod i status ved første observation, så den reelle tid i status kan være længere.

---

## 1. Kræver PO-opmærksomhed

### Samlet PO-signal

| Signal | Område | Antal |
| --- | --- | ---: |
| 🔴 | GitHub-alder over 6 måneder | 0 |
| 🔴 | Udløbet planlagt release | 0 |
| 🔴 | Kritisk/Høj uden opdatering i mindst 14 dage | 0 |
| 🔴 | Lukket GitHub-issue i aktiv Project-status | 1 |
| 🔵 | Klar til prioritering | 3 |
| 🔴 | Klar til prioritering uden prioritet | 3 |
| 🔴 | Klar til prioritering uden estimat | 0 |
| 🟡 | Bestilt/igangværende uden planlagt release | 3 |
| ℹ️ | Bestilt/igangværende uden assignee | 3 |
| 🟡 | Test/review uden opdatering i mindst 14 dage | 0 |
| ⚠️ | Kommunikation bør vurderes | 0 |
| 🟠 | GitHub-alder 4,5–6 måneder | 28 |

### Foreslåede næste PO-handlinger

- Ryd op i **1** lukket/lukkede GitHub-issue(s), der stadig står i en aktiv Project-status.
- Fastlæg prioritet på **3** issue(s) i **Klar til prioritering**.
- Fastlæg planlagt release på **3** bestilt/igangværende issue(s).
- Vurder om der bør sættes assignee på **3** bestilt/igangværende issue(s).
- Forbered generel kommunikation om backlog, ekstra ressourcer og målet om højst 6 måneders omløbstid.

<details>
<summary>Vis konkrete issues, der kræver PO-opmærksomhed (7)</summary>

| Signal | Issue | Status | Prioritet | Alder | PO-opmærksomhed |
| --- | --- | --- | --- | ---: | --- |
| 🔴 | [#77 – Ændring af dannede kodeord i forbindelse med kontooprettelser i Sofd Account Agent](https://github.com/OS2sofd/issues/issues/77) | Afventer løsningsbeskrivelse | Lav | 75 dage / 2.5 mdr. | GitHub-issue er lukket, men står fortsat i aktiv Project-status |
| 🔴 🔵 | [#59 – OS2sofd - ilm: udfyld displayName ved oprettelse af konsulent](https://github.com/OS2sofd/issues/issues/59) | Klar til prioritering | – | 107 dage / 3.5 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler prioritet |
| 🔴 🔵 | [#58 – OS2sofd - ilm - udfyld UPN ved oprettelse af konsulentkonto](https://github.com/OS2sofd/issues/issues/58) | Klar til prioritering | – | 107 dage / 3.5 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler prioritet |
| 🔴 🔵 | [#105 – OS2ILM: Flytning af ILM-oprettede konsulenter](https://github.com/OS2sofd/issues/issues/105) | Klar til prioritering | – | 25 dage / 0.8 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler prioritet |
| 🟡 | [#61 – Vil gerne selv kunne styre username, og navngivningen generelt i ILM](https://github.com/OS2sofd/issues/issues/61) | Bestilt hos leverandør | – | 101 dage / 3.3 mdr. | Bestilt hos leverandør, men mangler planlagt release; Bestilt hos leverandør, men mangler assignee |
| 🟡 | [#107 – OS2ILM: Manglende e-mailnotifikationer ved konsulentgodkendelse](https://github.com/OS2sofd/issues/issues/107) | Bestilt hos leverandør | – | 25 dage / 0.8 mdr. | Bestilt hos leverandør, men mangler planlagt release; Bestilt hos leverandør, men mangler assignee |
| 🟡 | [#106 – OS2ILM: Det skal være muligt for en administrator at slette en konsulent helt.](https://github.com/OS2sofd/issues/issues/106) | Bestilt hos leverandør | – | 25 dage / 0.8 mdr. | Bestilt hos leverandør, men mangler planlagt release; Bestilt hos leverandør, men mangler assignee |

</details>

> **Bemærk:** Kommunikationssignalet er en indikator. Det ser på seneste kommentar fra en anden end den oprindelige opretter. Det kan stadig ikke i sig selv afgøre, om opretter faktisk er tilstrækkeligt orienteret.

## 2. Omløbstid og kommunikation

| Nøgletal | Antal / værdi |
| --- | ---: |
| Aktive ændringsønsker | 89 |
| Gennemsnitlig alder | 99 dage / 3.3 mdr. |
| Median alder | 88 dage / 2.9 mdr. |
| 4,5–6 måneder gamle | 28 |
| Over 6 måneder | 0 |
| Over 12 måneder | 0 |
| Kommunikation bør vurderes | 0 |
| Aktive issues med JIRA-reference | 32 |

> ℹ️ **Målegrundlag:** 32 aktive issues har en JIRA-reference. For disse kan GitHub-alderen være lavere end den reelle alder på ændringsønsket.

> 📣 **Generel kommunikation anbefales:** 28 aktive ændringsønsker ligger allerede mellem 4,5 og 6 måneder. Der bør kommunikeres om den aktuelle backlog, de tilførte ressourcer og målet om højst 6 måneders omløbstid.

### Kommunikationskø

Ingen ældre aktive issues rammer den aktuelle kommunikationsregel.

### Nærmer sig 6-månedersgrænsen

<details>
<summary>Vis alle 28 issues mellem 4,5 og 6 måneder</summary>

| Issue | Alder | Status | Prioritet | Kommune |
| --- | ---: | --- | --- | --- |
| [#7 – Mulighed for at overskrive medarbejders stillingsbetegnelse fra lønsystemet](https://github.com/OS2sofd/issues/issues/7) | 170 dage / 5.6 mdr. | Afventer løsningsbeskrivelse | Mellem | Bornholm |
| [#9 – Person tilhørsforhold - Tilføj markering af primært tilhørsforhold](https://github.com/OS2sofd/issues/issues/9) | 170 dage / 5.6 mdr. | Afventer løsningsbeskrivelse | Mellem | Favrskov |
| [#10 – Udvid SOFDCoreADWritebackAgent til at understøtte forsk. OU'er](https://github.com/OS2sofd/issues/issues/10) | 170 dage / 5.6 mdr. | Afventer løsningsbeskrivelse | Mellem | Favrskov |
| [#11 – Tilføj information om en AD konto er i brug + understøtte LocalExtensions i Mail skabeloner](https://github.com/OS2sofd/issues/issues/11) | 170 dage / 5.6 mdr. | Afventer løsningsbeskrivelse | Mellem | Favrskov |
| [#12 – Forstå forskel på Ansatte, Eksterne, Byrøddet, Konsulenter, Vikarer, m.m. typer af AD konti](https://github.com/OS2sofd/issues/issues/12) | 170 dage / 5.6 mdr. | Afventer løsningsbeskrivelse | – | Sønderborg |
| [#13 – SofdCoreADReplicator - Handlinger ved grupper](https://github.com/OS2sofd/issues/issues/13) | 170 dage / 5.6 mdr. | Afventer løsningsbeskrivelse | Mellem | Favrskov |
| [#15 – Behov for at kunne vise forskelligt displaynavn på ansatte med flere tilhørsforhold/AD-konti](https://github.com/OS2sofd/issues/issues/15) | 170 dage / 5.6 mdr. | Afventer løsningsbeskrivelse | Lav | Sønderborg |
| [#30 – OS2sofd - ILM: Vedligeholdelse af Fortrolighedsaftale](https://github.com/OS2sofd/issues/issues/30) | 169 dage / 5.6 mdr. | Afventer løsningsbeskrivelse | – | Bornholm |
| [#29 – Brugertjek: Mulighed for genveje og dybe links](https://github.com/OS2sofd/issues/issues/29) | 169 dage / 5.6 mdr. | Afventer løsningsbeskrivelse | Lav | Bornholm |
| [#28 – Brugertjek: Kontrol af lønsystem konto](https://github.com/OS2sofd/issues/issues/28) | 169 dage / 5.6 mdr. | Afventer løsningsbeskrivelse | Lav | Bornholm |
| [#27 – Oprettelse af KSP/CICS konti på baggrund af rolletildelinger](https://github.com/OS2sofd/issues/issues/27) | 169 dage / 5.6 mdr. | Afventer løsningsbeskrivelse | Mellem | Bornholm |
| [#26 – Brugertjek: Robot-flag for robotter](https://github.com/OS2sofd/issues/issues/26) | 169 dage / 5.6 mdr. | Afventer løsningsbeskrivelse | Lav | Bornholm |
| [#25 – Brugertjek: Udvidelse af informationer i tilhørforholdstabellen](https://github.com/OS2sofd/issues/issues/25) | 169 dage / 5.6 mdr. | Afventer løsningsbeskrivelse | Mellem | Bornholm |
| [#24 – Prefix i AD Event Dispatcher](https://github.com/OS2sofd/issues/issues/24) | 169 dage / 5.6 mdr. | Afventer løsningsbeskrivelse | Lav | Bornholm |
| [#23 – Samlet overblik over diverse opmærkninger/fravalg af enheder](https://github.com/OS2sofd/issues/issues/23) | 169 dage / 5.6 mdr. | Afventer løsningsbeskrivelse | Mellem | Favrskov |
| [#22 – Brug af AD konto ved opsætning af 'manuelt valgt' leder på enhed](https://github.com/OS2sofd/issues/issues/22) | 169 dage / 5.6 mdr. | Afventer løsningsbeskrivelse | Mellem | Favrskov |
| [#21 – SOFD indlæsning fra lønsystem: Mulighed for selv at administrere indlæsningsfiltre](https://github.com/OS2sofd/issues/issues/21) | 169 dage / 5.6 mdr. | Afventer løsningsbeskrivelse | Mellem | Favrskov |
| [#19 – SOFD GUI: Bloker oprettelse af manuelle tilhørsforhold af typen "Medarbejder" når man kører med sync fra et lønsystem](https://github.com/OS2sofd/issues/issues/19) | 169 dage / 5.6 mdr. | Afventer løsningsbeskrivelse | Mellem | Favrskov |
| [#18 – Brugertjek: Uddybelse af Entra licenser](https://github.com/OS2sofd/issues/issues/18) | 169 dage / 5.6 mdr. | Afventer løsningsbeskrivelse | Lav | Bornholm |
| [#17 – SOFD GUI: Udvidet overblik over tilhørsforhold og typer](https://github.com/OS2sofd/issues/issues/17) | 169 dage / 5.6 mdr. | Afventer løsningsbeskrivelse | Mellem | Favrskov |
| [#16 – Navne- og adressebeskyttelse:](https://github.com/OS2sofd/issues/issues/16) | 169 dage / 5.6 mdr. | Screening | – | Odsherred |
| [#32 – Import af SOFD enheder til OS2Vikar modulet](https://github.com/OS2sofd/issues/issues/32) | 163 dage / 5.4 mdr. | Afventer løsningsbeskrivelse | Lav | Hjørring |
| [#34 – ÆndringsønskeMulighed for at sende sms fra Vikarmodulet](https://github.com/OS2sofd/issues/issues/34) | 163 dage / 5.4 mdr. | Afventer løsningsbeskrivelse | Lav | Køge |
| [#35 – Forslag til rettelser i OS2SOFD Ledermodul](https://github.com/OS2sofd/issues/issues/35) | 163 dage / 5.4 mdr. | Afventer løsningsbeskrivelse | Mellem | Sønderborg |
| [#36 – Auto-opdatere enheder i FK Organisation ved nye KLE emner](https://github.com/OS2sofd/issues/issues/36) | 163 dage / 5.4 mdr. | Afventer løsningsbeskrivelse | Mellem | Sønderborg |
| [#37 – Tilknytning af stillinger til enheder i Vikar modulet](https://github.com/OS2sofd/issues/issues/37) | 163 dage / 5.4 mdr. | Afventer løsningsbeskrivelse | Lav | Tårnby |
| [#48 – Stoppet medarbejder slettes i Lederportalen/Tillidserhverv](https://github.com/OS2sofd/issues/issues/48) | 146 dage / 4.8 mdr. | Afventer løsningsbeskrivelse | Lav | Odsherred |
| [#49 – Ændring af synkronisering af data ind i Nexus](https://github.com/OS2sofd/issues/issues/49) | 142 dage / 4.7 mdr. | Afventer løsningsbeskrivelse | Mellem | Tønder |

</details>

### Ældste aktive ændringsønsker

| Signal | Issue | Alder | Status | Prioritet | Senest opdateret |
| --- | --- | ---: | --- | --- | ---: |
| 🟠 | [#7 – Mulighed for at overskrive medarbejders stillingsbetegnelse fra lønsystemet](https://github.com/OS2sofd/issues/issues/7) | 170 dage / 5.6 mdr. | Afventer løsningsbeskrivelse | Mellem | 2 dage siden |
| 🟠 | [#9 – Person tilhørsforhold - Tilføj markering af primært tilhørsforhold](https://github.com/OS2sofd/issues/issues/9) | 170 dage / 5.6 mdr. | Afventer løsningsbeskrivelse | Mellem | 2 dage siden |
| 🟠 | [#10 – Udvid SOFDCoreADWritebackAgent til at understøtte forsk. OU'er](https://github.com/OS2sofd/issues/issues/10) | 170 dage / 5.6 mdr. | Afventer løsningsbeskrivelse | Mellem | 2 dage siden |
| 🟠 | [#11 – Tilføj information om en AD konto er i brug + understøtte LocalExtensions i Mail skabeloner](https://github.com/OS2sofd/issues/issues/11) | 170 dage / 5.6 mdr. | Afventer løsningsbeskrivelse | Mellem | 2 dage siden |
| 🟠 | [#12 – Forstå forskel på Ansatte, Eksterne, Byrøddet, Konsulenter, Vikarer, m.m. typer af AD konti](https://github.com/OS2sofd/issues/issues/12) | 170 dage / 5.6 mdr. | Afventer løsningsbeskrivelse | – | 2 dage siden |
| 🟠 | [#13 – SofdCoreADReplicator - Handlinger ved grupper](https://github.com/OS2sofd/issues/issues/13) | 170 dage / 5.6 mdr. | Afventer løsningsbeskrivelse | Mellem | 2 dage siden |
| 🟠 | [#15 – Behov for at kunne vise forskelligt displaynavn på ansatte med flere tilhørsforhold/AD-konti](https://github.com/OS2sofd/issues/issues/15) | 170 dage / 5.6 mdr. | Afventer løsningsbeskrivelse | Lav | 2 dage siden |
| 🟠 | [#29 – Brugertjek: Mulighed for genveje og dybe links](https://github.com/OS2sofd/issues/issues/29) | 169 dage / 5.6 mdr. | Afventer løsningsbeskrivelse | Lav | 2 dage siden |
| 🟠 | [#30 – OS2sofd - ILM: Vedligeholdelse af Fortrolighedsaftale](https://github.com/OS2sofd/issues/issues/30) | 169 dage / 5.6 mdr. | Afventer løsningsbeskrivelse | – | 2 dage siden |
| 🟠 | [#28 – Brugertjek: Kontrol af lønsystem konto](https://github.com/OS2sofd/issues/issues/28) | 169 dage / 5.6 mdr. | Afventer løsningsbeskrivelse | Lav | 2 dage siden |

## 3. Flow og flaskehalse

> ⚠️ **Aktuel største kø / potentiel flaskehals:** 79 af 89 aktive ændringsønsker (88.8 %) står i **Afventer løsningsbeskrivelse**. Rapporten kan endnu ikke måle tid i status historisk, så den kan ikke alene afgøre, om dette er en vedvarende flaskehals.

| Status | Antal | Andel af aktive | Median GitHub-alder | Median observeret tid i status | Ældste observerede tid i status | 4,5–6 mdr. GitHub-alder | >6 mdr. GitHub-alder |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| Screening | 3 | 3.4 % | 79 dage / 2.6 mdr. | 1 dage / 0 mdr. | 1 dage / 0 mdr. | 1 | 0 |
| Afventer løsningsbeskrivelse | 79 | 88.8 % | 88 dage / 2.9 mdr. | 1 dage / 0 mdr. | 1 dage / 0 mdr. | 27 | 0 |
| Klar til prioritering | 3 | 3.4 % | 107 dage / 3.5 mdr. | 1 dage / 0 mdr. | 1 dage / 0 mdr. | 0 | 0 |
| Bestilt hos leverandør | 3 | 3.4 % | 25 dage / 0.8 mdr. | 1 dage / 0 mdr. | 1 dage / 0 mdr. | 0 | 0 |
| Løsninger i test | 1 | 1.1 % | 61 dage / 2 mdr. | 1 dage / 0 mdr. | 1 dage / 0 mdr. | 0 | 0 |

_Observeret tid i status tælles fra første registrering i historikfilen. For baseline-issues kan den reelle tid i status være længere._

## 4. Klar til prioritering

| Prioritet | Issue | Alder | Tid i status | Labels | Kommune | Estimat | Størrelse | Release |
| --- | --- | ---: | ---: | --- | --- | ---: | --- | --- |
| – | [#58 – OS2sofd - ilm - udfyld UPN ved oprettelse af konsulentkonto](https://github.com/OS2sofd/issues/issues/58) | 107 dage / 3.5 mdr. | ≥ 1 dage / 0 mdr. | ilm | Norddjurs | 3.250kr | – | – |
| – | [#59 – OS2sofd - ilm: udfyld displayName ved oprettelse af konsulent](https://github.com/OS2sofd/issues/issues/59) | 107 dage / 3.5 mdr. | ≥ 1 dage / 0 mdr. | ilm | Norddjurs | 1.000kr | – | – |
| – | [#105 – OS2ILM: Flytning af ILM-oprettede konsulenter](https://github.com/OS2sofd/issues/issues/105) | 25 dage / 0.8 mdr. | ≥ 1 dage / 0 mdr. | ilm | Norddjurs | 2.250kr | – | – |

## 5. Release-overblik – 3. kvartal 2026

| Status | Antal |
| --- | ---: |
| Løsninger i test | 1 |

| Prioritet | Issue | Alder | Status | Estimat | Assignee |
| --- | --- | ---: | --- | ---: | --- |
| Kritisk | [#94 – Understøttelse af Pre-hire-brugere i snitfladen mellem SOFD og Rollekatalog](https://github.com/OS2sofd/issues/issues/94) | 61 dage / 2 mdr. | Løsninger i test | 5.000kr | – |

### Release-efterslæb

Ingen aktive issues har en udløbet planlagt release.

### Kandidater uden planlagt release

| Prioritet | Issue | Alder | Status | Estimat | Assignee |
| --- | --- | ---: | --- | ---: | --- |
| – | [#58 – OS2sofd - ilm - udfyld UPN ved oprettelse af konsulentkonto](https://github.com/OS2sofd/issues/issues/58) | 107 dage / 3.5 mdr. | Klar til prioritering | 3.250kr | – |
| – | [#59 – OS2sofd - ilm: udfyld displayName ved oprettelse af konsulent](https://github.com/OS2sofd/issues/issues/59) | 107 dage / 3.5 mdr. | Klar til prioritering | 1.000kr | – |
| – | [#61 – Vil gerne selv kunne styre username, og navngivningen generelt i ILM](https://github.com/OS2sofd/issues/issues/61) | 101 dage / 3.3 mdr. | Bestilt hos leverandør | 19.500kr | – |
| – | [#105 – OS2ILM: Flytning af ILM-oprettede konsulenter](https://github.com/OS2sofd/issues/issues/105) | 25 dage / 0.8 mdr. | Klar til prioritering | 2.250kr | – |
| – | [#106 – OS2ILM: Det skal være muligt for en administrator at slette en konsulent helt.](https://github.com/OS2sofd/issues/issues/106) | 25 dage / 0.8 mdr. | Bestilt hos leverandør | 8.750kr | – |
| – | [#107 – OS2ILM: Manglende e-mailnotifikationer ved konsulentgodkendelse](https://github.com/OS2sofd/issues/issues/107) | 25 dage / 0.8 mdr. | Bestilt hos leverandør | 4.000kr | – |

## 6. Hele pipeline – Fra idé til færdig løsning

| Status | Antal |
| --- | ---: |
| Nye ændringsønsker | 0 |
| Screening | 3 |
| Afventer løsningsbeskrivelse | 79 |
| Klar til prioritering | 3 |
| Bestilt hos leverandør | 3 |
| Igangværende opgaver | 0 |
| Løsninger i test | 1 |
| Løsninger i review | 0 |
| Afsluttede løsninger | 15 |
| Won't fix | 3 |

### Screening

<details>
<summary>Vis 3 issue(s)</summary>

| Prioritet | Issue | Alder | Kommune | Labels | Senest opdateret |
| --- | --- | ---: | --- | --- | ---: |
| – | [#16 – Navne- og adressebeskyttelse:](https://github.com/OS2sofd/issues/issues/16) | 169 dage / 5.6 mdr. | Odsherred | stamdata, ui | 2 dage siden |
| – | [#74 – funktionelle forbedringer](https://github.com/OS2sofd/issues/issues/74) | 79 dage / 2.6 mdr. | Tønder | idm, middleware | 2 dage siden |
| – | [#84 – At kunne skrive data attribut værdier fra OS2Vikar oprettelse til Data attribut i Active Directory](https://github.com/OS2sofd/issues/issues/84) | 66 dage / 2.2 mdr. | Lyngby-Taarbæk | vikar, middleware | 2 dage siden |

</details>

### Afventer løsningsbeskrivelse

<details>
<summary>Vis 79 issue(s)</summary>

| Prioritet | Issue | Alder | Labels | Kommune | Assignee | Senest opdateret |
| --- | --- | ---: | --- | --- | --- | ---: |
| Kritisk | [#51 – Migrér CVR-integration fra Datafordeler REST til GraphQL](https://github.com/OS2sofd/issues/issues/51) | 129 dage / 4.2 mdr. | api, drift og vedligehold | Ikke kommune | – | 2 dage siden |
| Høj | [#50 – Mulighed for at opsætte grænser for varigheden af OS2sofd tilhørsforhold](https://github.com/OS2sofd/issues/issues/50) | 130 dage / 4.3 mdr. | idm, datamodel og tilhørsforhold | Bornholm | – | 2 dage siden |
| Høj | [#53 – OS2sofd Lederside - Auditlogning af ændringer skal følge SOFD Core praksis](https://github.com/OS2sofd/issues/issues/53) | 117 dage / 3.8 mdr. | log-data, lederside | Favrskov | – | 2 dage siden |
| Høj | [#65 – NexusSync - automatisk luk af konti udenfor "nexus organisationen"](https://github.com/OS2sofd/issues/issues/65) | 88 dage / 2.9 mdr. | idm, middleware | Kalundborg | – | 2 dage siden |
| Høj | [#100 – Brugerkontotyper - tilføjelse til skabelonbaseret navnekonvention](https://github.com/OS2sofd/issues/issues/100) | 39 dage / 1.3 mdr. | idm, brugere og konti | Sønderborg | – | 2 dage siden |
| Høj | [#109 – Dobbelt hierarki: Lønhierarki og den administrative organisation. Oprettelse af det administrative hierarki foretages pba. LOS-koblinger og strukturerede valideringer.Ændringsønske](https://github.com/OS2sofd/issues/issues/109) | 24 dage / 0.8 mdr. | stamdata, datamodel og tilhørsforhold | Horsens | – | 2 dage siden |
| Høj | [#108 – Ændringsønske: Fremtidige ændringer: Organisationsændringer og- håndtering fødes i OS2sofd og matches efterfølgende med LOSid i KMD LOS integration mod sofd.](https://github.com/OS2sofd/issues/issues/108) | 24 dage / 0.8 mdr. | stamdata, datamodel og tilhørsforhold | Horsens | – | 2 dage siden |
| Mellem | [#7 – Mulighed for at overskrive medarbejders stillingsbetegnelse fra lønsystemet](https://github.com/OS2sofd/issues/issues/7) | 170 dage / 5.6 mdr. | api, datamodel og tilhørsforhold | Bornholm | – | 2 dage siden |
| Mellem | [#13 – SofdCoreADReplicator - Handlinger ved grupper](https://github.com/OS2sofd/issues/issues/13) | 170 dage / 5.6 mdr. | drift og vedligehold, middleware | Favrskov | – | 2 dage siden |
| Mellem | [#11 – Tilføj information om en AD konto er i brug + understøtte LocalExtensions i Mail skabeloner](https://github.com/OS2sofd/issues/issues/11) | 170 dage / 5.6 mdr. | mailskabelon/advis, middleware, funktionelle forbedringer | Favrskov | – | 2 dage siden |
| Mellem | [#10 – Udvid SOFDCoreADWritebackAgent til at understøtte forsk. OU'er](https://github.com/OS2sofd/issues/issues/10) | 170 dage / 5.6 mdr. | middleware, brugere og konti | Favrskov | – | 2 dage siden |
| Mellem | [#9 – Person tilhørsforhold - Tilføj markering af primært tilhørsforhold](https://github.com/OS2sofd/issues/issues/9) | 170 dage / 5.6 mdr. | ui, brugere og konti, datamodel og tilhørsforhold | Favrskov | – | 2 dage siden |
| Mellem | [#21 – SOFD indlæsning fra lønsystem: Mulighed for selv at administrere indlæsningsfiltre](https://github.com/OS2sofd/issues/issues/21) | 169 dage / 5.6 mdr. | ui, middleware, brugere og konti | Favrskov | – | 2 dage siden |
| Mellem | [#22 – Brug af AD konto ved opsætning af 'manuelt valgt' leder på enhed](https://github.com/OS2sofd/issues/issues/22) | 169 dage / 5.6 mdr. | ui, brugere og konti | Favrskov | – | 2 dage siden |
| Mellem | [#23 – Samlet overblik over diverse opmærkninger/fravalg af enheder](https://github.com/OS2sofd/issues/issues/23) | 169 dage / 5.6 mdr. | rapporter, ui, brugere og konti | Favrskov | – | 2 dage siden |
| Mellem | [#25 – Brugertjek: Udvidelse af informationer i tilhørforholdstabellen](https://github.com/OS2sofd/issues/issues/25) | 169 dage / 5.6 mdr. | brugertjek, datamodel og tilhørsforhold | Bornholm | – | 2 dage siden |
| Mellem | [#27 – Oprettelse af KSP/CICS konti på baggrund af rolletildelinger](https://github.com/OS2sofd/issues/issues/27) | 169 dage / 5.6 mdr. | idm, api, brugere og konti | Bornholm | – | 2 dage siden |
| Mellem | [#17 – SOFD GUI: Udvidet overblik over tilhørsforhold og typer](https://github.com/OS2sofd/issues/issues/17) | 169 dage / 5.6 mdr. | ui, brugere og konti | Favrskov | – | 2 dage siden |
| Mellem | [#19 – SOFD GUI: Bloker oprettelse af manuelle tilhørsforhold af typen "Medarbejder" når man kører med sync fra et lønsystem](https://github.com/OS2sofd/issues/issues/19) | 169 dage / 5.6 mdr. | idm, ui | Favrskov | – | 2 dage siden |
| Mellem | [#35 – Forslag til rettelser i OS2SOFD Ledermodul](https://github.com/OS2sofd/issues/issues/35) | 163 dage / 5.4 mdr. | idm, lederside | Sønderborg | – | 2 dage siden |
| Mellem | [#36 – Auto-opdatere enheder i FK Organisation ved nye KLE emner](https://github.com/OS2sofd/issues/issues/36) | 163 dage / 5.4 mdr. | stamdata, middleware, datamodel og tilhørsforhold | Sønderborg | – | 2 dage siden |
| Mellem | [#49 – Ændring af synkronisering af data ind i Nexus](https://github.com/OS2sofd/issues/issues/49) | 142 dage / 4.7 mdr. | bug, middleware | Tønder | – | 2 dage siden |
| Mellem | [#55 – Lederside - Forbedring af GUI for Pausemarkering ift. endusers](https://github.com/OS2sofd/issues/issues/55) | 116 dage / 3.8 mdr. | ui, lederside | Favrskov | – | 2 dage siden |
| Mellem | [#54 – Udvidet stillingskatalog og kodebaseret regelgrundlag i SOFD (og OS2Rollekatalog)](https://github.com/OS2sofd/issues/issues/54) | 116 dage / 3.8 mdr. | idm, datamodel og tilhørsforhold | Hjørring | – | 2 dage siden |
| Mellem | [#73 – OS2sofd Kommunikationsmodul - Ønsker til forbedringer](https://github.com/OS2sofd/issues/issues/73) | 80 dage / 2.6 mdr. | middleware, funktionelle forbedringer | Favrskov | – | 2 dage siden |
| Mellem | [#76 – Ny pladsholder og pladsholder funktion til mailskabelonen ”Digital post til medarbejder ved oprettelse af AD konto”](https://github.com/OS2sofd/issues/issues/76) | 76 dage / 2.5 mdr. | mailskabelon/advis, funktionelle forbedringer | Vallensbæk | – | 2 dage siden |
| Mellem | [#79 – Flere steps i godkendelsesflow i OS2Rollekatalog Anmod/Godkend](https://github.com/OS2sofd/issues/issues/79) | 67 dage / 2.2 mdr. | idm, ui | Lyngby-Taarbæk | – | 2 dage siden |
| Mellem | [#85 – Brugernavn generator ved oprettelse af vikar (OS2Vikar)](https://github.com/OS2sofd/issues/issues/85) | 66 dage / 2.2 mdr. | vikar, brugere og konti | Lyngby-Taarbæk | – | 2 dage siden |
| Mellem | [#82 – ÆndringsønskeObligatorisk drop down menuer samt mulighed for a pre-definere værdier ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/82) | 66 dage / 2.2 mdr. | stamdata, vikar | Lyngby-Taarbæk | – | 2 dage siden |
| Mellem | [#83 – At kunne gøre data felter obligatoriske ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/83) | 66 dage / 2.2 mdr. | stamdata, vikar | Lyngby-Taarbæk | – | 2 dage siden |
| Mellem | [#95 – Mulighed for at deaktivere en konto med udskudt dato](https://github.com/OS2sofd/issues/issues/95) | 59 dage / 1.9 mdr. | idm, brugere og konti | Tønder | – | 2 dage siden |
| Mellem | [#97 – Vedligehold/rettidige opdateringer af Autorisationskoder](https://github.com/OS2sofd/issues/issues/97) | 48 dage / 1.6 mdr. | stamdata, drift og vedligehold | Bornholm | – | 2 dage siden |
| Mellem | [#98 – OS2sofd Telefoni-modul - Ønsker til forbedringer](https://github.com/OS2sofd/issues/issues/98) | 47 dage / 1.5 mdr. | ui, funktionelle forbedringer | Favrskov | – | 2 dage siden |
| Mellem | [#104 – OS2ILM: Placering af medarbejdere i OU](https://github.com/OS2sofd/issues/issues/104) | 25 dage / 0.8 mdr. | idm, ilm | Norddjurs | – | 2 dage siden |
| Mellem | [#102 – OS2ILM: Mere specifik log](https://github.com/OS2sofd/issues/issues/102) | 25 dage / 0.8 mdr. | log-data, ilm | Norddjurs | – | 2 dage siden |
| Mellem | [#110 – Frigørelse af kobling mellem it-brugerkonto og tilhørsforhold fra løndata. Tilhørsforhold skal afspejle den administrative organisation i OS2sofd.Ændringsønske](https://github.com/OS2sofd/issues/issues/110) | 24 dage / 0.8 mdr. | brugere og konti, datamodel og tilhørsforhold | Horsens | – | 2 dage siden |
| Lav | [#15 – Behov for at kunne vise forskelligt displaynavn på ansatte med flere tilhørsforhold/AD-konti](https://github.com/OS2sofd/issues/issues/15) | 170 dage / 5.6 mdr. | brugere og konti, datamodel og tilhørsforhold | Sønderborg | – | 2 dage siden |
| Lav | [#26 – Brugertjek: Robot-flag for robotter](https://github.com/OS2sofd/issues/issues/26) | 169 dage / 5.6 mdr. | ui, brugertjek | Bornholm | – | 2 dage siden |
| Lav | [#28 – Brugertjek: Kontrol af lønsystem konto](https://github.com/OS2sofd/issues/issues/28) | 169 dage / 5.6 mdr. | idm, brugertjek | Bornholm | – | 2 dage siden |
| Lav | [#29 – Brugertjek: Mulighed for genveje og dybe links](https://github.com/OS2sofd/issues/issues/29) | 169 dage / 5.6 mdr. | ui, brugertjek | Bornholm | – | 2 dage siden |
| Lav | [#24 – Prefix i AD Event Dispatcher](https://github.com/OS2sofd/issues/issues/24) | 169 dage / 5.6 mdr. | stamdata, middleware, datamodel og tilhørsforhold | Bornholm | – | 2 dage siden |
| Lav | [#18 – Brugertjek: Uddybelse af Entra licenser](https://github.com/OS2sofd/issues/issues/18) | 169 dage / 5.6 mdr. | ui, brugertjek | Bornholm | – | 2 dage siden |
| Lav | [#34 – ÆndringsønskeMulighed for at sende sms fra Vikarmodulet](https://github.com/OS2sofd/issues/issues/34) | 163 dage / 5.4 mdr. | vikar, mailskabelon/advis | Køge | – | 2 dage siden |
| Lav | [#37 – Tilknytning af stillinger til enheder i Vikar modulet](https://github.com/OS2sofd/issues/issues/37) | 163 dage / 5.4 mdr. | vikar, ui | Tårnby | – | 2 dage siden |
| Lav | [#32 – Import af SOFD enheder til OS2Vikar modulet](https://github.com/OS2sofd/issues/issues/32) | 163 dage / 5.4 mdr. | vikar, middleware | Hjørring | – | 2 dage siden |
| Lav | [#48 – Stoppet medarbejder slettes i Lederportalen/Tillidserhverv](https://github.com/OS2sofd/issues/issues/48) | 146 dage / 4.8 mdr. | lederside, brugere og konti | Odsherred | – | 2 dage siden |
| Lav | [#52 – Automatisk dannede flow-diagrammer til OS2sofd](https://github.com/OS2sofd/issues/issues/52) | 124 dage / 4.1 mdr. | dokumentation, log-data | Ikke kommune | – | 2 dage siden |
| Lav | [#60 – SMS/Kodeordspåmindelse: understøttelse af flere kodeordspolitikker](https://github.com/OS2sofd/issues/issues/60) | 103 dage / 3.4 mdr. | mailskabelon/advis, middleware | Bornholm | – | 2 dage siden |
| Lav | [#67 – Kommunikationsmodul - Udviklingsønsker til email og log](https://github.com/OS2sofd/issues/issues/67) | 88 dage / 2.9 mdr. | log-data, mailskabelon/advis | Kalundborg | – | 2 dage siden |
| Lav | [#72 – Ekstra data på skoleelever](https://github.com/OS2sofd/issues/issues/72) | 88 dage / 2.9 mdr. | stamdata, middleware | Kalundborg | – | 2 dage siden |
| Lav | [#71 – Videreudvikling af SMS modul](https://github.com/OS2sofd/issues/issues/71) | 88 dage / 2.9 mdr. | mailskabelon/advis, middleware | Kalundborg | – | 2 dage siden |
| Lav | [#70 – Mulighed for at redigere og flytte kolonner i oversigtsbillederne](https://github.com/OS2sofd/issues/issues/70) | 88 dage / 2.9 mdr. | ui | Kalundborg | – | 2 dage siden |
| Lav | [#64 – Brugertjek : oplysninger om sidste kodeordsskifte og kodeordsløb i OS2faktor fanen](https://github.com/OS2sofd/issues/issues/64) | 88 dage / 2.9 mdr. | api, brugertjek | Kalundborg | – | 2 dage siden |
| Lav | [#66 – Mulighed for at redigere allerede oprettet arbejdssted](https://github.com/OS2sofd/issues/issues/66) | 88 dage / 2.9 mdr. | ui, funktionelle forbedringer | Kalundborg | – | 2 dage siden |
| Lav | [#69 – Mulighed for at fravælge advis ved kontooprettelse](https://github.com/OS2sofd/issues/issues/69) | 88 dage / 2.9 mdr. | idm, mailskabelon/advis | Kalundborg | – | 2 dage siden |
| Lav | [#75 – Kommunikationsmodul i OS2sofd SMS/Email](https://github.com/OS2sofd/issues/issues/75) | 79 dage / 2.6 mdr. | stamdata, mailskabelon/advis | Tønder | – | 2 dage siden |
| Lav | [#77 – Ændring af dannede kodeord i forbindelse med kontooprettelser i Sofd Account Agent](https://github.com/OS2sofd/issues/issues/77) | 75 dage / 2.5 mdr. | bug, idm | Bornholm | – | 2 dage siden |
| Lav | [#78 – Bjælke for oven og i venstre side, skal fryses fast](https://github.com/OS2sofd/issues/issues/78) | 72 dage / 2.4 mdr. | ui | Tønder | – | 2 dage siden |
| Lav | [#80 – ÆndringsønskeUdvidet information ved anmodning om rolle i OS2Rolekatalog Anmod/Godkend](https://github.com/OS2sofd/issues/issues/80) | 67 dage / 2.2 mdr. | idm, ui | Lyngby-Taarbæk | – | 2 dage siden |
| Lav | [#81 – At kunne ændre afsendernavn på mails fra Rollekatalog](https://github.com/OS2sofd/issues/issues/81) | 67 dage / 2.2 mdr. | ui, mailskabelon/advis | Lyngby-Taarbæk | – | 2 dage siden |
| Lav | [#88 – Ny kolonne i rapporten 'Historiske rolleanmodninger', så man kan se hvilket IT-System de forskellige roller er tilknyttet](https://github.com/OS2sofd/issues/issues/88) | 66 dage / 2.2 mdr. | rapporter, idm | Lyngby-Taarbæk | – | 2 dage siden |
| Lav | [#92 – Konfigurationsindstilling: Jobfunktionsroller og Rollebuketter listes samlet](https://github.com/OS2sofd/issues/issues/92) | 65 dage / 2.1 mdr. | idm, ui | Lyngby-Taarbæk | – | 2 dage siden |
| Lav | [#93 – Berigelse af titelfelt for skoleelever med klassetrin](https://github.com/OS2sofd/issues/issues/93) | 65 dage / 2.1 mdr. | stamdata, middleware | Kalundborg | – | 2 dage siden |
| Lav | [#90 – At kunde (kommune) selv kan konfigurere i UI, i Brugertjek, hvilke data attributter der skal være synlige ved opslag i brugertjek](https://github.com/OS2sofd/issues/issues/90) | 65 dage / 2.1 mdr. | ui, brugertjek | Lyngby-Taarbæk | – | 2 dage siden |
| Lav | [#89 – Udvide 'Status' typer for tildeling af rettigheder med 'Tildelt ved godkendt anmodning'.](https://github.com/OS2sofd/issues/issues/89) | 65 dage / 2.1 mdr. | rapporter, idm | Lyngby-Taarbæk | – | 2 dage siden |
| Lav | [#91 – Opslag i MitID Erhverv ved for at se om bruger har et aktivt tildelt MitID Erhverv](https://github.com/OS2sofd/issues/issues/91) | 65 dage / 2.1 mdr. | idm, brugertjek | Lyngby-Taarbæk | – | 2 dage siden |
| Lav | [#96 – Vis detaljer om hvem der har bestilt/oprettet en konto undrer ordre-detaljer](https://github.com/OS2sofd/issues/issues/96) | 51 dage / 1.7 mdr. | log-data, idm | Allerød | – | 2 dage siden |
| Lav | [#99 – Understøtte ny Skole/SFO opmærkning til KOMBIT](https://github.com/OS2sofd/issues/issues/99) | 39 dage / 1.3 mdr. | stamdata, middleware | Ikke kommune | – | 2 dage siden |
| Lav | [#103 – OS2ILM: Visning af firma og navn](https://github.com/OS2sofd/issues/issues/103) | 25 dage / 0.8 mdr. | ui, ilm | Norddjurs | – | 2 dage siden |
| Lav | [#111 – UI forbedringer til stillingskatalog](https://github.com/OS2sofd/issues/issues/111) | 19 dage / 0.6 mdr. | ui, funktionelle forbedringer | Allerød | – | 2 dage siden |
| Lav | [#113 – Indlæsning af Mit Erhverv status til OS2Sofd](https://github.com/OS2sofd/issues/issues/113) | 2 dage / 0.1 mdr. | idm, middleware | Kalundborg | – | 2 dage siden |
| – | [#12 – Forstå forskel på Ansatte, Eksterne, Byrøddet, Konsulenter, Vikarer, m.m. typer af AD konti](https://github.com/OS2sofd/issues/issues/12) | 170 dage / 5.6 mdr. | idm, brugere og konti | Sønderborg | – | 2 dage siden |
| – | [#30 – OS2sofd - ILM: Vedligeholdelse af Fortrolighedsaftale](https://github.com/OS2sofd/issues/issues/30) | 169 dage / 5.6 mdr. | idm, ilm | Bornholm | – | 2 dage siden |
| – | [#62 – Udvidelse af Opus-integrationen med mulighed for at overføre flere brugerkontotyper](https://github.com/OS2sofd/issues/issues/62) | 96 dage / 3.2 mdr. | middleware, brugere og konti | Egedal | – | 2 dage siden |
| – | [#68 – API-udvidelse til undtagelse/pausemarkering](https://github.com/OS2sofd/issues/issues/68) | 88 dage / 2.9 mdr. | idm, api | Kalundborg | – | 2 dage siden |
| – | [#87 – Begrænse en systemansvarlig's view af it-systemer i OS2Rollekatalog](https://github.com/OS2sofd/issues/issues/87) | 66 dage / 2.2 mdr. | idm, ui | Lyngby-Taarbæk | – | 2 dage siden |
| – | [#86 – OS2Vikar mulighed for at angive tid ved oprettelse af vikar](https://github.com/OS2sofd/issues/issues/86) | 66 dage / 2.2 mdr. | vikar | Lyngby-Taarbæk | – | 2 dage siden |
| – | [#101 – OS2ILM: Tildeling af leder via Virksomhed](https://github.com/OS2sofd/issues/issues/101) | 25 dage / 0.8 mdr. | ui, ilm | Norddjurs | – | 2 dage siden |
| – | [#112 – Migrering til Datafordeleren til CPR opslag](https://github.com/OS2sofd/issues/issues/112) | 17 dage / 0.6 mdr. | api, drift og vedligehold | Ikke kommune | – | 2 dage siden |

</details>

### Klar til prioritering

| Prioritet | Issue | Alder | Estimat | Størrelse | Release | Kommune |
| --- | --- | ---: | ---: | --- | --- | --- |
| – | [#58 – OS2sofd - ilm - udfyld UPN ved oprettelse af konsulentkonto](https://github.com/OS2sofd/issues/issues/58) | 107 dage / 3.5 mdr. | 3.250kr | – | – | Norddjurs |
| – | [#59 – OS2sofd - ilm: udfyld displayName ved oprettelse af konsulent](https://github.com/OS2sofd/issues/issues/59) | 107 dage / 3.5 mdr. | 1.000kr | – | – | Norddjurs |
| – | [#105 – OS2ILM: Flytning af ILM-oprettede konsulenter](https://github.com/OS2sofd/issues/issues/105) | 25 dage / 0.8 mdr. | 2.250kr | – | – | Norddjurs |

### Bestilt hos leverandør

<details>
<summary>Vis 3 issue(s)</summary>

| Prioritet | Issue | Alder | Assignee | Estimat | Release | Senest opdateret |
| --- | --- | ---: | --- | ---: | --- | ---: |
| – | [#61 – Vil gerne selv kunne styre username, og navngivningen generelt i ILM](https://github.com/OS2sofd/issues/issues/61) | 101 dage / 3.3 mdr. | – | 19.500kr | – | 20 dage siden |
| – | [#106 – OS2ILM: Det skal være muligt for en administrator at slette en konsulent helt.](https://github.com/OS2sofd/issues/issues/106) | 25 dage / 0.8 mdr. | – | 8.750kr | – | 20 dage siden |
| – | [#107 – OS2ILM: Manglende e-mailnotifikationer ved konsulentgodkendelse](https://github.com/OS2sofd/issues/issues/107) | 25 dage / 0.8 mdr. | – | 4.000kr | – | 20 dage siden |

</details>

### Løsninger i test

<details>
<summary>Vis 1 issue(s)</summary>

| Issue | Alder | Release | Assignee | Senest opdateret |
| --- | ---: | --- | --- | ---: |
| [#94 – Understøttelse af Pre-hire-brugere i snitfladen mellem SOFD og Rollekatalog](https://github.com/OS2sofd/issues/issues/94) | 61 dage / 2 mdr. | 3. kvartal 2026 | – | 1 dage siden |

</details>

### Afsluttede løsninger

> Gennemløbstid vises kun, når der findes en registreret afslutningsdato. Fremadrettet kan automatiseringen opbygge status-historik og dermed måle gennemløbstid mere præcist.

<details>
<summary>Vis 15 issue(s)</summary>

| Issue | Gennemløbstid | Prioritet | Release | Afsluttet |
| --- | ---: | --- | --- | --- |
| [#8 – OS2sofd Lederside - fixes + ønsker til forbedringer](https://github.com/OS2sofd/issues/issues/8) | 168 dage / 5.5 mdr. | – | 2. kvartal 2026 | 04-09-2026 |
| [#20 – SOFD Replikator: Undtage eksterne fra gruppe sync](https://github.com/OS2sofd/issues/issues/20) | 101 dage / 3.3 mdr. | – | 2. kvartal 2026 | 30-06-2026 |
| [#39 – IDM: Opret nye AD-konti i disabled tilstand indtil ansættelsesstart](https://github.com/OS2sofd/issues/issues/39) | 82 dage / 2.7 mdr. | – | 2. kvartal 2026 | 30-06-2026 |
| [#38 – IDM: Ny ordretype REACTIVATE i IDM-flow](https://github.com/OS2sofd/issues/issues/38) | 82 dage / 2.7 mdr. | – | 2. kvartal 2026 | 30-06-2026 |
| [#43 – IDM: Understøt AD-kontooprettelse fra flere tilhørsforholdskilder end for andre kontotyper](https://github.com/OS2sofd/issues/issues/43) | 82 dage / 2.7 mdr. | – | 2. kvartal 2026 | 30-06-2026 |
| [#46 – IDM: Bedre håndtering af personinaktivering](https://github.com/OS2sofd/issues/issues/46) | 82 dage / 2.7 mdr. | – | 2. kvartal 2026 | 30-06-2026 |
| [#42 – IDM: Opret konto-ordre straks ved kendskab til ansættelse](https://github.com/OS2sofd/issues/issues/42) | 82 dage / 2.7 mdr. | – | 2. kvartal 2026 | 30-06-2026 |
| [#45 – IDM: OPUS-konto brugernavn præfiks-validering](https://github.com/OS2sofd/issues/issues/45) | 82 dage / 2.7 mdr. | – | 2. kvartal 2026 | 30-06-2026 |
| [#44 – IDM: Per-afdeling konfiguration af dage for kontooprettelse](https://github.com/OS2sofd/issues/issues/44) | 82 dage / 2.7 mdr. | – | 2. kvartal 2026 | 30-06-2026 |
| [#41 – IDM: Nyt Cleanup-trin i IDM-livscyklus](https://github.com/OS2sofd/issues/issues/41) | 82 dage / 2.7 mdr. | – | 2. kvartal 2026 | 30-06-2026 |
| [#40 – IDM: Undgå utilsigtet genbrug af gamle konti](https://github.com/OS2sofd/issues/issues/40) | 82 dage / 2.7 mdr. | – | 2. kvartal 2026 | 30-06-2026 |
| [#47 – IDM: Dokumentation af alle IDM-flows](https://github.com/OS2sofd/issues/issues/47) | 82 dage / 2.7 mdr. | – | 2. kvartal 2026 | 30-06-2026 |
| [#56 – Bestilling af mail-adresser via ILM modulet](https://github.com/OS2sofd/issues/issues/56) | 107 dage / 3.5 mdr. | – | – | 04-09-2026 |
| [#57 – Tilføjelse i OS2sofd - ILM af e-mailinvitation til konsulent så chancen for selv-registrering øges](https://github.com/OS2sofd/issues/issues/57) | 107 dage / 3.5 mdr. | – | – | 04-09-2026 |
| [#63 – Opdatering af OS2sofd STIL integration til WS17-V7](https://github.com/OS2sofd/issues/issues/63) | 94 dage / 3.1 mdr. | – | – | 04-09-2026 |

</details>

### Won't fix

<details>
<summary>Vis 3 issue(s)</summary>

| Issue | Alder | Kommune | Senest opdateret |
| --- | ---: | --- | --- |
| [#6 – Visning af mailadresse i listevisning/SOFD](https://github.com/OS2sofd/issues/issues/6) | 387 dage / 12.7 mdr. | – | 18-08-2025 |
| [#14 – Nye hændelse til IDM proces: Reaktivering - Oprydning](https://github.com/OS2sofd/issues/issues/14) | 170 dage / 5.6 mdr. | Sønderborg | 19-05-2026 |
| [#33 – Foretræk kendte spærrede konti fremfor at danne et nyt brugernavn](https://github.com/OS2sofd/issues/issues/33) | 163 dage / 5.4 mdr. | Sønderborg | 19-05-2026 |

</details>

## 7. Proces- og datakvalitet

| Issue | Status | Alder | Problem |
| --- | --- | ---: | --- |
| [#12 – Forstå forskel på Ansatte, Eksterne, Byrøddet, Konsulenter, Vikarer, m.m. typer af AD konti](https://github.com/OS2sofd/issues/issues/12) | Afventer løsningsbeskrivelse | 170 dage / 5.6 mdr. | Mangler prioritet |
| [#30 – OS2sofd - ILM: Vedligeholdelse af Fortrolighedsaftale](https://github.com/OS2sofd/issues/issues/30) | Afventer løsningsbeskrivelse | 169 dage / 5.6 mdr. | Mangler prioritet |
| [#58 – OS2sofd - ilm - udfyld UPN ved oprettelse af konsulentkonto](https://github.com/OS2sofd/issues/issues/58) | Klar til prioritering | 107 dage / 3.5 mdr. | Mangler prioritet |
| [#59 – OS2sofd - ilm: udfyld displayName ved oprettelse af konsulent](https://github.com/OS2sofd/issues/issues/59) | Klar til prioritering | 107 dage / 3.5 mdr. | Mangler prioritet |
| [#61 – Vil gerne selv kunne styre username, og navngivningen generelt i ILM](https://github.com/OS2sofd/issues/issues/61) | Bestilt hos leverandør | 101 dage / 3.3 mdr. | Mangler prioritet; Mangler planlagt release |
| [#62 – Udvidelse af Opus-integrationen med mulighed for at overføre flere brugerkontotyper](https://github.com/OS2sofd/issues/issues/62) | Afventer løsningsbeskrivelse | 96 dage / 3.2 mdr. | Mangler prioritet |
| [#68 – API-udvidelse til undtagelse/pausemarkering](https://github.com/OS2sofd/issues/issues/68) | Afventer løsningsbeskrivelse | 88 dage / 2.9 mdr. | Mangler prioritet |
| [#77 – Ændring af dannede kodeord i forbindelse med kontooprettelser i Sofd Account Agent](https://github.com/OS2sofd/issues/issues/77) | Afventer løsningsbeskrivelse | 75 dage / 2.5 mdr. | Issue er lukket, men Project-status er aktiv |
| [#86 – OS2Vikar mulighed for at angive tid ved oprettelse af vikar](https://github.com/OS2sofd/issues/issues/86) | Afventer løsningsbeskrivelse | 66 dage / 2.2 mdr. | Mangler prioritet |
| [#87 – Begrænse en systemansvarlig's view af it-systemer i OS2Rollekatalog](https://github.com/OS2sofd/issues/issues/87) | Afventer løsningsbeskrivelse | 66 dage / 2.2 mdr. | Mangler prioritet |
| [#105 – OS2ILM: Flytning af ILM-oprettede konsulenter](https://github.com/OS2sofd/issues/issues/105) | Klar til prioritering | 25 dage / 0.8 mdr. | Mangler prioritet |
| [#101 – OS2ILM: Tildeling af leder via Virksomhed](https://github.com/OS2sofd/issues/issues/101) | Afventer løsningsbeskrivelse | 25 dage / 0.8 mdr. | Mangler prioritet |
| [#106 – OS2ILM: Det skal være muligt for en administrator at slette en konsulent helt.](https://github.com/OS2sofd/issues/issues/106) | Bestilt hos leverandør | 25 dage / 0.8 mdr. | Mangler prioritet; Mangler planlagt release |
| [#107 – OS2ILM: Manglende e-mailnotifikationer ved konsulentgodkendelse](https://github.com/OS2sofd/issues/issues/107) | Bestilt hos leverandør | 25 dage / 0.8 mdr. | Mangler prioritet; Mangler planlagt release |
| [#112 – Migrering til Datafordeleren til CPR opslag](https://github.com/OS2sofd/issues/issues/112) | Afventer løsningsbeskrivelse | 17 dage / 0.6 mdr. | Mangler prioritet |

---

_Denne fil er automatisk genereret fra GitHub Project **Fra idé til færdig løsning**. GitHub Project er den autoritative datakilde; data/po-overblik-history.json bruges alene til afledt status-historik. Kommunikationssignaler er indikatorer og skal vurderes af PO._
