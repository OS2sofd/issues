# PO-overblik – OS2sofd ændringsønsker

> **Formål:** PO-styring af ændringsønsker med særligt fokus på omløbstid, kommunikation, prioritering og releasefremdrift.

Senest genereret: **16-09-2026 02:04**  
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
| 🔴 | Lukket GitHub-issue i aktiv Project-status | 0 |
| 🔵 | Klar til prioritering | 14 |
| 🔴 | Klar til prioritering uden prioritet | 3 |
| 🔴 | Klar til prioritering uden estimat | 11 |
| 🟡 | Bestilt/igangværende uden planlagt release | 3 |
| ℹ️ | Bestilt/igangværende uden assignee | 3 |
| 🟡 | Test/review uden opdatering i mindst 14 dage | 0 |
| ⚠️ | Kommunikation bør vurderes | 3 |
| 🟠 | GitHub-alder 4,5–6 måneder | 28 |

### Foreslåede næste PO-handlinger

- Fastlæg prioritet på **3** issue(s) i **Klar til prioritering**.
- Få estimat på **11** issue(s) i **Klar til prioritering**.
- Fastlæg planlagt release på **3** bestilt/igangværende issue(s).
- Vurder om der bør sættes assignee på **3** bestilt/igangværende issue(s).
- Vurder individuel statuskommunikation på **3** ældre issue(s).
- Forbered generel kommunikation om backlog, ekstra ressourcer og målet om højst 6 måneders omløbstid.

<details>
<summary>Vis konkrete issues, der kræver PO-opmærksomhed (21)</summary>

| Signal | Issue | Status | Prioritet | Alder | PO-opmærksomhed |
| --- | --- | --- | --- | ---: | --- |
| 🔴 🔵 | [#65 – NexusSync - automatisk luk af konti udenfor "nexus organisationen"](https://github.com/OS2sofd/issues/issues/65) | Klar til prioritering | Høj | 97 dage / 3.2 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler estimat |
| 🔴 🔵 | [#9 – Person tilhørsforhold - Tilføj markering af primært tilhørsforhold](https://github.com/OS2sofd/issues/issues/9) | Klar til prioritering | Mellem | 179 dage / 5.9 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler estimat |
| 🔴 🔵 | [#27 – Oprettelse af KSP/CICS konti på baggrund af rolletildelinger](https://github.com/OS2sofd/issues/issues/27) | Klar til prioritering | Mellem | 178 dage / 5.8 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler estimat |
| 🔴 🔵 | [#25 – Brugertjek: Udvidelse af informationer i tilhørforholdstabellen](https://github.com/OS2sofd/issues/issues/25) | Klar til prioritering | Mellem | 178 dage / 5.8 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler estimat |
| 🔴 🔵 | [#36 – Auto-opdatere enheder i FK Organisation ved nye KLE emner](https://github.com/OS2sofd/issues/issues/36) | Klar til prioritering | Mellem | 173 dage / 5.7 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler estimat |
| 🔴 🔵 | [#83 – At kunne gøre data felter obligatoriske ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/83) | Klar til prioritering | Mellem | 76 dage / 2.5 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler estimat |
| 🔴 🔵 | [#82 – ÆndringsønskeObligatorisk drop down menuer samt mulighed for a pre-definere værdier ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/82) | Klar til prioritering | Mellem | 76 dage / 2.5 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler estimat |
| 🔴 🔵 | [#85 – Brugernavn generator ved oprettelse af vikar (OS2Vikar)](https://github.com/OS2sofd/issues/issues/85) | Klar til prioritering | Mellem | 75 dage / 2.5 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler estimat |
| 🔴 🔵 | [#97 – Vedligehold/rettidige opdateringer af Autorisationskoder](https://github.com/OS2sofd/issues/issues/97) | Klar til prioritering | Mellem | 57 dage / 1.9 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler estimat |
| 🔴 🔵 | [#24 – Prefix i AD Event Dispatcher](https://github.com/OS2sofd/issues/issues/24) | Klar til prioritering | Lav | 179 dage / 5.9 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler estimat |
| 🔴 🔵 | [#15 – Behov for at kunne vise forskelligt displaynavn på ansatte med flere tilhørsforhold/AD-konti](https://github.com/OS2sofd/issues/issues/15) | Klar til prioritering | Lav | 179 dage / 5.9 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler estimat |
| 🔴 ⚠️ 🔵 | [#59 – OS2sofd - ilm: udfyld displayName ved oprettelse af konsulent](https://github.com/OS2sofd/issues/issues/59) | Klar til prioritering | – | 116 dage / 3.8 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler prioritet; Kommunikation bør vurderes: seneste respons til opretter er 33 dage gammel |
| 🔴 ⚠️ 🔵 | [#58 – OS2sofd - ilm - udfyld UPN ved oprettelse af konsulentkonto](https://github.com/OS2sofd/issues/issues/58) | Klar til prioritering | – | 116 dage / 3.8 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler prioritet; Kommunikation bør vurderes: seneste respons til opretter er 33 dage gammel |
| 🔴 🔵 | [#105 – OS2ILM: Flytning af ILM-oprettede konsulenter](https://github.com/OS2sofd/issues/issues/105) | Klar til prioritering | – | 34 dage / 1.1 mdr. | Klar til PO/koordinationsgruppens prioritering; Klar til prioritering, men mangler prioritet |
| 🟡 | [#51 – Migrér CVR-integration fra Datafordeler REST til GraphQL](https://github.com/OS2sofd/issues/issues/51) | Bestilt hos leverandør | Kritisk | 138 dage / 4.5 mdr. | Planlagt til 3. kvartal 2026, men endnu ikke igangværende |
| 🟡 | [#50 – Mulighed for at opsætte grænser for varigheden af OS2sofd tilhørsforhold](https://github.com/OS2sofd/issues/issues/50) | Bestilt hos leverandør | Høj | 139 dage / 4.6 mdr. | Planlagt til 3. kvartal 2026, men endnu ikke igangværende |
| 🟡 | [#53 – OS2sofd Lederside - Auditlogning af ændringer skal følge SOFD Core praksis](https://github.com/OS2sofd/issues/issues/53) | Bestilt hos leverandør | Høj | 126 dage / 4.1 mdr. | Planlagt til 3. kvartal 2026, men endnu ikke igangværende |
| 🟡 | [#100 – Brugerkontotyper - tilføjelse til skabelonbaseret navnekonvention](https://github.com/OS2sofd/issues/issues/100) | Bestilt hos leverandør | Høj | 48 dage / 1.6 mdr. | Planlagt til 3. kvartal 2026, men endnu ikke igangværende |
| 🟡 ⚠️ | [#61 – Vil gerne selv kunne styre username, og navngivningen generelt i ILM](https://github.com/OS2sofd/issues/issues/61) | Igangværende opgaver | – | 111 dage / 3.6 mdr. | Igangværende opgaver, men mangler planlagt release; Igangværende opgaver, men mangler assignee; Kommunikation bør vurderes: seneste respons til opretter er 33 dage gammel |
| 🟡 | [#107 – OS2ILM: Manglende e-mailnotifikationer ved konsulentgodkendelse](https://github.com/OS2sofd/issues/issues/107) | Igangværende opgaver | – | 34 dage / 1.1 mdr. | Igangværende opgaver, men mangler planlagt release; Igangværende opgaver, men mangler assignee |
| 🟡 | [#106 – OS2ILM: Det skal være muligt for en administrator at slette en konsulent helt.](https://github.com/OS2sofd/issues/issues/106) | Igangværende opgaver | – | 34 dage / 1.1 mdr. | Igangværende opgaver, men mangler planlagt release; Igangværende opgaver, men mangler assignee |

</details>

> **Bemærk:** Kommunikationssignalet er en indikator. Det ser på seneste kommentar fra en anden end den oprindelige opretter. Det kan stadig ikke i sig selv afgøre, om opretter faktisk er tilstrækkeligt orienteret.

## 2. Omløbstid og kommunikation

| Nøgletal | Antal / værdi |
| --- | ---: |
| Aktive ændringsønsker | 88 |
| Gennemsnitlig alder | 104 dage / 3.4 mdr. |
| Median alder | 97 dage / 3.2 mdr. |
| 4,5–6 måneder gamle | 28 |
| Over 6 måneder | 0 |
| Over 12 måneder | 0 |
| Kommunikation bør vurderes | 3 |
| Aktive issues med JIRA-reference | 32 |

> ℹ️ **Målegrundlag:** 32 aktive issues har en JIRA-reference. For disse kan GitHub-alderen være lavere end den reelle alder på ændringsønsket.

> 📣 **Generel kommunikation anbefales:** 28 aktive ændringsønsker ligger allerede mellem 4,5 og 6 måneder. Der bør kommunikeres om den aktuelle backlog, de tilførte ressourcer og målet om højst 6 måneders omløbstid.

> 👤 **Individuel kommunikation:** 3 ældre issues bør vurderes konkret i forhold til, om opretter har fået en tilstrækkelig og aktuel status.

### Kommunikationskø

| Issue | Alder | Status | Prioritet | Seneste respons til opretter |
| --- | ---: | --- | --- | ---: |
| [#58 – OS2sofd - ilm - udfyld UPN ved oprettelse af konsulentkonto](https://github.com/OS2sofd/issues/issues/58) | 116 dage / 3.8 mdr. | Klar til prioritering | – | 33 dage siden |
| [#59 – OS2sofd - ilm: udfyld displayName ved oprettelse af konsulent](https://github.com/OS2sofd/issues/issues/59) | 116 dage / 3.8 mdr. | Klar til prioritering | – | 33 dage siden |
| [#61 – Vil gerne selv kunne styre username, og navngivningen generelt i ILM](https://github.com/OS2sofd/issues/issues/61) | 111 dage / 3.6 mdr. | Igangværende opgaver | – | 33 dage siden |

### Nærmer sig 6-månedersgrænsen

<details>
<summary>Vis alle 28 issues mellem 4,5 og 6 måneder</summary>

| Issue | Alder | Status | Prioritet | Kommune |
| --- | ---: | --- | --- | --- |
| [#24 – Prefix i AD Event Dispatcher](https://github.com/OS2sofd/issues/issues/24) | 179 dage / 5.9 mdr. | Klar til prioritering | Lav | Bornholm |
| [#23 – Samlet overblik over diverse opmærkninger/fravalg af enheder](https://github.com/OS2sofd/issues/issues/23) | 179 dage / 5.9 mdr. | Afventer løsningsbeskrivelse | Mellem | Favrskov |
| [#22 – Brug af AD konto ved opsætning af 'manuelt valgt' leder på enhed](https://github.com/OS2sofd/issues/issues/22) | 179 dage / 5.9 mdr. | Afventer løsningsbeskrivelse | Mellem | Favrskov |
| [#19 – SOFD GUI: Bloker oprettelse af manuelle tilhørsforhold af typen "Medarbejder" når man kører med sync fra et lønsystem](https://github.com/OS2sofd/issues/issues/19) | 179 dage / 5.9 mdr. | Afventer løsningsbeskrivelse | Mellem | Favrskov |
| [#18 – Brugertjek: Uddybelse af Entra licenser](https://github.com/OS2sofd/issues/issues/18) | 179 dage / 5.9 mdr. | Afventer løsningsbeskrivelse | Lav | Bornholm |
| [#17 – SOFD GUI: Udvidet overblik over tilhørsforhold og typer](https://github.com/OS2sofd/issues/issues/17) | 179 dage / 5.9 mdr. | Afventer løsningsbeskrivelse | Mellem | Favrskov |
| [#16 – Navne- og adressebeskyttelse:](https://github.com/OS2sofd/issues/issues/16) | 179 dage / 5.9 mdr. | Screening | – | Odsherred |
| [#13 – SofdCoreADReplicator - Handlinger ved grupper](https://github.com/OS2sofd/issues/issues/13) | 179 dage / 5.9 mdr. | Afventer løsningsbeskrivelse | Mellem | Favrskov |
| [#21 – SOFD indlæsning fra lønsystem: Mulighed for selv at administrere indlæsningsfiltre](https://github.com/OS2sofd/issues/issues/21) | 179 dage / 5.9 mdr. | Afventer løsningsbeskrivelse | Mellem | Favrskov |
| [#11 – Tilføj information om en AD konto er i brug + understøtte LocalExtensions i Mail skabeloner](https://github.com/OS2sofd/issues/issues/11) | 179 dage / 5.9 mdr. | Afventer løsningsbeskrivelse | Mellem | Favrskov |
| [#10 – Udvid SOFDCoreADWritebackAgent til at understøtte forsk. OU'er](https://github.com/OS2sofd/issues/issues/10) | 179 dage / 5.9 mdr. | Afventer løsningsbeskrivelse | Mellem | Favrskov |
| [#9 – Person tilhørsforhold - Tilføj markering af primært tilhørsforhold](https://github.com/OS2sofd/issues/issues/9) | 179 dage / 5.9 mdr. | Klar til prioritering | Mellem | Favrskov |
| [#15 – Behov for at kunne vise forskelligt displaynavn på ansatte med flere tilhørsforhold/AD-konti](https://github.com/OS2sofd/issues/issues/15) | 179 dage / 5.9 mdr. | Klar til prioritering | Lav | Sønderborg |
| [#12 – Forstå forskel på Ansatte, Eksterne, Byrøddet, Konsulenter, Vikarer, m.m. typer af AD konti](https://github.com/OS2sofd/issues/issues/12) | 179 dage / 5.9 mdr. | Afventer løsningsbeskrivelse | – | Sønderborg |
| [#30 – OS2sofd - ILM: Vedligeholdelse af Fortrolighedsaftale](https://github.com/OS2sofd/issues/issues/30) | 178 dage / 5.8 mdr. | Afventer løsningsbeskrivelse | – | Bornholm |
| [#29 – Brugertjek: Mulighed for genveje og dybe links](https://github.com/OS2sofd/issues/issues/29) | 178 dage / 5.8 mdr. | Afventer løsningsbeskrivelse | Lav | Bornholm |
| [#28 – Brugertjek: Kontrol af lønsystem konto](https://github.com/OS2sofd/issues/issues/28) | 178 dage / 5.8 mdr. | Afventer løsningsbeskrivelse | Lav | Bornholm |
| [#27 – Oprettelse af KSP/CICS konti på baggrund af rolletildelinger](https://github.com/OS2sofd/issues/issues/27) | 178 dage / 5.8 mdr. | Klar til prioritering | Mellem | Bornholm |
| [#25 – Brugertjek: Udvidelse af informationer i tilhørforholdstabellen](https://github.com/OS2sofd/issues/issues/25) | 178 dage / 5.8 mdr. | Klar til prioritering | Mellem | Bornholm |
| [#26 – Brugertjek: Robot-flag for robotter](https://github.com/OS2sofd/issues/issues/26) | 178 dage / 5.8 mdr. | Afventer løsningsbeskrivelse | Lav | Bornholm |
| [#32 – Import af SOFD enheder til OS2Vikar modulet](https://github.com/OS2sofd/issues/issues/32) | 173 dage / 5.7 mdr. | Afventer løsningsbeskrivelse | Lav | Hjørring |
| [#34 – ÆndringsønskeMulighed for at sende sms fra Vikarmodulet](https://github.com/OS2sofd/issues/issues/34) | 173 dage / 5.7 mdr. | Afventer løsningsbeskrivelse | Lav | Køge |
| [#35 – Forslag til rettelser i OS2SOFD Ledermodul](https://github.com/OS2sofd/issues/issues/35) | 173 dage / 5.7 mdr. | Afventer løsningsbeskrivelse | Mellem | Sønderborg |
| [#36 – Auto-opdatere enheder i FK Organisation ved nye KLE emner](https://github.com/OS2sofd/issues/issues/36) | 173 dage / 5.7 mdr. | Klar til prioritering | Mellem | Sønderborg |
| [#37 – Tilknytning af stillinger til enheder i Vikar modulet](https://github.com/OS2sofd/issues/issues/37) | 172 dage / 5.7 mdr. | Afventer løsningsbeskrivelse | Lav | Tårnby |
| [#48 – Stoppet medarbejder slettes i Lederportalen/Tillidserhverv](https://github.com/OS2sofd/issues/issues/48) | 155 dage / 5.1 mdr. | Afventer løsningsbeskrivelse | Lav | Odsherred |
| [#50 – Mulighed for at opsætte grænser for varigheden af OS2sofd tilhørsforhold](https://github.com/OS2sofd/issues/issues/50) | 139 dage / 4.6 mdr. | Bestilt hos leverandør | Høj | Bornholm |
| [#51 – Migrér CVR-integration fra Datafordeler REST til GraphQL](https://github.com/OS2sofd/issues/issues/51) | 138 dage / 4.5 mdr. | Bestilt hos leverandør | Kritisk | Ikke kommune |

</details>

### Ældste aktive ændringsønsker

| Signal | Issue | Alder | Status | Prioritet | Senest opdateret |
| --- | --- | ---: | --- | --- | ---: |
| 🟠 | [#24 – Prefix i AD Event Dispatcher](https://github.com/OS2sofd/issues/issues/24) | 179 dage / 5.9 mdr. | Klar til prioritering | Lav | 0 dage siden |
| 🟠 | [#15 – Behov for at kunne vise forskelligt displaynavn på ansatte med flere tilhørsforhold/AD-konti](https://github.com/OS2sofd/issues/issues/15) | 179 dage / 5.9 mdr. | Klar til prioritering | Lav | 0 dage siden |
| 🟠 | [#23 – Samlet overblik over diverse opmærkninger/fravalg af enheder](https://github.com/OS2sofd/issues/issues/23) | 179 dage / 5.9 mdr. | Afventer løsningsbeskrivelse | Mellem | 12 dage siden |
| 🟠 | [#22 – Brug af AD konto ved opsætning af 'manuelt valgt' leder på enhed](https://github.com/OS2sofd/issues/issues/22) | 179 dage / 5.9 mdr. | Afventer løsningsbeskrivelse | Mellem | 12 dage siden |
| 🟠 | [#21 – SOFD indlæsning fra lønsystem: Mulighed for selv at administrere indlæsningsfiltre](https://github.com/OS2sofd/issues/issues/21) | 179 dage / 5.9 mdr. | Afventer løsningsbeskrivelse | Mellem | 12 dage siden |
| 🟠 | [#19 – SOFD GUI: Bloker oprettelse af manuelle tilhørsforhold af typen "Medarbejder" når man kører med sync fra et lønsystem](https://github.com/OS2sofd/issues/issues/19) | 179 dage / 5.9 mdr. | Afventer løsningsbeskrivelse | Mellem | 12 dage siden |
| 🟠 | [#18 – Brugertjek: Uddybelse af Entra licenser](https://github.com/OS2sofd/issues/issues/18) | 179 dage / 5.9 mdr. | Afventer løsningsbeskrivelse | Lav | 12 dage siden |
| 🟠 | [#17 – SOFD GUI: Udvidet overblik over tilhørsforhold og typer](https://github.com/OS2sofd/issues/issues/17) | 179 dage / 5.9 mdr. | Afventer løsningsbeskrivelse | Mellem | 12 dage siden |
| 🟠 | [#16 – Navne- og adressebeskyttelse:](https://github.com/OS2sofd/issues/issues/16) | 179 dage / 5.9 mdr. | Screening | – | 12 dage siden |
| 🟠 | [#13 – SofdCoreADReplicator - Handlinger ved grupper](https://github.com/OS2sofd/issues/issues/13) | 179 dage / 5.9 mdr. | Afventer løsningsbeskrivelse | Mellem | 12 dage siden |

## 3. Flow og flaskehalse

> ⚠️ **Aktuel største kø / potentiel flaskehals:** 61 af 88 aktive ændringsønsker (69.3 %) står i **Afventer løsningsbeskrivelse**. Rapporten kan endnu ikke måle tid i status historisk, så den kan ikke alene afgøre, om dette er en vedvarende flaskehals.

| Status | Antal | Andel af aktive | Median GitHub-alder | Median observeret tid i status | Ældste observerede tid i status | 4,5–6 mdr. GitHub-alder | >6 mdr. GitHub-alder |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| Screening | 5 | 5.7 % | 89 dage / 2.9 mdr. | 11 dage / 0.4 mdr. | 11 dage / 0.4 mdr. | 1 | 0 |
| Afventer løsningsbeskrivelse | 61 | 69.3 % | 97 dage / 3.2 mdr. | 11 dage / 0.4 mdr. | 11 dage / 0.4 mdr. | 19 | 0 |
| Klar til prioritering | 14 | 15.9 % | 116 dage / 3.8 mdr. | 0 dage / 0 mdr. | 11 dage / 0.4 mdr. | 6 | 0 |
| Bestilt hos leverandør | 4 | 4.5 % | 132 dage / 4.3 mdr. | 5 dage / 0.2 mdr. | 5 dage / 0.2 mdr. | 2 | 0 |
| Igangværende opgaver | 3 | 3.4 % | 34 dage / 1.1 mdr. | 0 dage / 0 mdr. | 0 dage / 0 mdr. | 0 | 0 |
| Løsninger i test | 1 | 1.1 % | 71 dage / 2.3 mdr. | 10 dage / 0.3 mdr. | 10 dage / 0.3 mdr. | 0 | 0 |

_Observeret tid i status tælles fra første registrering i historikfilen. For baseline-issues kan den reelle tid i status være længere._

## 4. Klar til prioritering

| Prioritet | Issue | Alder | Tid i status | Labels | Kommune | Estimat | Størrelse | Release |
| --- | --- | ---: | ---: | --- | --- | ---: | --- | --- |
| Høj | [#65 – NexusSync - automatisk luk af konti udenfor "nexus organisationen"](https://github.com/OS2sofd/issues/issues/65) | 97 dage / 3.2 mdr. | 0 dage / 0 mdr. | idm, middleware | Kalundborg | – | – | – |
| Mellem | [#9 – Person tilhørsforhold - Tilføj markering af primært tilhørsforhold](https://github.com/OS2sofd/issues/issues/9) | 179 dage / 5.9 mdr. | 0 dage / 0 mdr. | ui, brugere og konti, datamodel og tilhørsforhold | Favrskov | – | – | – |
| Mellem | [#25 – Brugertjek: Udvidelse af informationer i tilhørforholdstabellen](https://github.com/OS2sofd/issues/issues/25) | 178 dage / 5.8 mdr. | 0 dage / 0 mdr. | brugertjek, datamodel og tilhørsforhold | Bornholm | – | – | – |
| Mellem | [#27 – Oprettelse af KSP/CICS konti på baggrund af rolletildelinger](https://github.com/OS2sofd/issues/issues/27) | 178 dage / 5.8 mdr. | 0 dage / 0 mdr. | idm, api, brugere og konti | Bornholm | – | – | – |
| Mellem | [#36 – Auto-opdatere enheder i FK Organisation ved nye KLE emner](https://github.com/OS2sofd/issues/issues/36) | 173 dage / 5.7 mdr. | 0 dage / 0 mdr. | stamdata, middleware, datamodel og tilhørsforhold | Sønderborg | – | – | – |
| Mellem | [#82 – ÆndringsønskeObligatorisk drop down menuer samt mulighed for a pre-definere værdier ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/82) | 76 dage / 2.5 mdr. | 0 dage / 0 mdr. | stamdata, vikar | Lyngby-Taarbæk | – | – | – |
| Mellem | [#83 – At kunne gøre data felter obligatoriske ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/83) | 76 dage / 2.5 mdr. | 0 dage / 0 mdr. | stamdata, vikar | Lyngby-Taarbæk | – | – | – |
| Mellem | [#85 – Brugernavn generator ved oprettelse af vikar (OS2Vikar)](https://github.com/OS2sofd/issues/issues/85) | 75 dage / 2.5 mdr. | 0 dage / 0 mdr. | vikar, brugere og konti | Lyngby-Taarbæk | – | – | – |
| Mellem | [#97 – Vedligehold/rettidige opdateringer af Autorisationskoder](https://github.com/OS2sofd/issues/issues/97) | 57 dage / 1.9 mdr. | 0 dage / 0 mdr. | stamdata, drift og vedligehold | Bornholm | – | – | – |
| Lav | [#24 – Prefix i AD Event Dispatcher](https://github.com/OS2sofd/issues/issues/24) | 179 dage / 5.9 mdr. | 0 dage / 0 mdr. | stamdata, middleware, datamodel og tilhørsforhold | Bornholm | – | – | – |
| Lav | [#15 – Behov for at kunne vise forskelligt displaynavn på ansatte med flere tilhørsforhold/AD-konti](https://github.com/OS2sofd/issues/issues/15) | 179 dage / 5.9 mdr. | 0 dage / 0 mdr. | brugere og konti, datamodel og tilhørsforhold | Sønderborg | – | – | – |
| – | [#58 – OS2sofd - ilm - udfyld UPN ved oprettelse af konsulentkonto](https://github.com/OS2sofd/issues/issues/58) | 116 dage / 3.8 mdr. | ≥ 11 dage / 0.4 mdr. | ilm | Norddjurs | 3.250kr | – | – |
| – | [#59 – OS2sofd - ilm: udfyld displayName ved oprettelse af konsulent](https://github.com/OS2sofd/issues/issues/59) | 116 dage / 3.8 mdr. | ≥ 11 dage / 0.4 mdr. | ilm | Norddjurs | 1.000kr | – | – |
| – | [#105 – OS2ILM: Flytning af ILM-oprettede konsulenter](https://github.com/OS2sofd/issues/issues/105) | 34 dage / 1.1 mdr. | ≥ 11 dage / 0.4 mdr. | ilm | Norddjurs | 2.250kr | – | – |

## 5. Release-overblik – 3. kvartal 2026

| Status | Antal |
| --- | ---: |
| Bestilt hos leverandør | 4 |
| Løsninger i test | 1 |

| Prioritet | Issue | Alder | Status | Estimat | Assignee |
| --- | --- | ---: | --- | ---: | --- |
| Kritisk | [#51 – Migrér CVR-integration fra Datafordeler REST til GraphQL](https://github.com/OS2sofd/issues/issues/51) | 138 dage / 4.5 mdr. | Bestilt hos leverandør | 25.000kr | pso-digital-identity |
| Kritisk | [#94 – Understøttelse af Pre-hire-brugere i snitfladen mellem SOFD og Rollekatalog](https://github.com/OS2sofd/issues/issues/94) | 71 dage / 2.3 mdr. | Løsninger i test | 5.000kr | – |
| Høj | [#50 – Mulighed for at opsætte grænser for varigheden af OS2sofd tilhørsforhold](https://github.com/OS2sofd/issues/issues/50) | 139 dage / 4.6 mdr. | Bestilt hos leverandør | 25.000kr | pso-digital-identity |
| Høj | [#53 – OS2sofd Lederside - Auditlogning af ændringer skal følge SOFD Core praksis](https://github.com/OS2sofd/issues/issues/53) | 126 dage / 4.1 mdr. | Bestilt hos leverandør | 26.000kr | pso-digital-identity |
| Høj | [#100 – Brugerkontotyper - tilføjelse til skabelonbaseret navnekonvention](https://github.com/OS2sofd/issues/issues/100) | 48 dage / 1.6 mdr. | Bestilt hos leverandør | 15.000kr | pso-digital-identity |

### Release-efterslæb

Ingen aktive issues har en udløbet planlagt release.

### Kandidater uden planlagt release

| Prioritet | Issue | Alder | Status | Estimat | Assignee |
| --- | --- | ---: | --- | ---: | --- |
| Høj | [#65 – NexusSync - automatisk luk af konti udenfor "nexus organisationen"](https://github.com/OS2sofd/issues/issues/65) | 97 dage / 3.2 mdr. | Klar til prioritering | – | – |
| Mellem | [#9 – Person tilhørsforhold - Tilføj markering af primært tilhørsforhold](https://github.com/OS2sofd/issues/issues/9) | 179 dage / 5.9 mdr. | Klar til prioritering | – | – |
| Mellem | [#25 – Brugertjek: Udvidelse af informationer i tilhørforholdstabellen](https://github.com/OS2sofd/issues/issues/25) | 178 dage / 5.8 mdr. | Klar til prioritering | – | – |
| Mellem | [#27 – Oprettelse af KSP/CICS konti på baggrund af rolletildelinger](https://github.com/OS2sofd/issues/issues/27) | 178 dage / 5.8 mdr. | Klar til prioritering | – | – |
| Mellem | [#36 – Auto-opdatere enheder i FK Organisation ved nye KLE emner](https://github.com/OS2sofd/issues/issues/36) | 173 dage / 5.7 mdr. | Klar til prioritering | – | – |
| Mellem | [#82 – ÆndringsønskeObligatorisk drop down menuer samt mulighed for a pre-definere værdier ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/82) | 76 dage / 2.5 mdr. | Klar til prioritering | – | – |
| Mellem | [#83 – At kunne gøre data felter obligatoriske ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/83) | 76 dage / 2.5 mdr. | Klar til prioritering | – | – |
| Mellem | [#85 – Brugernavn generator ved oprettelse af vikar (OS2Vikar)](https://github.com/OS2sofd/issues/issues/85) | 75 dage / 2.5 mdr. | Klar til prioritering | – | – |
| Mellem | [#97 – Vedligehold/rettidige opdateringer af Autorisationskoder](https://github.com/OS2sofd/issues/issues/97) | 57 dage / 1.9 mdr. | Klar til prioritering | – | – |
| Lav | [#15 – Behov for at kunne vise forskelligt displaynavn på ansatte med flere tilhørsforhold/AD-konti](https://github.com/OS2sofd/issues/issues/15) | 179 dage / 5.9 mdr. | Klar til prioritering | – | – |
| Lav | [#24 – Prefix i AD Event Dispatcher](https://github.com/OS2sofd/issues/issues/24) | 179 dage / 5.9 mdr. | Klar til prioritering | – | – |
| – | [#59 – OS2sofd - ilm: udfyld displayName ved oprettelse af konsulent](https://github.com/OS2sofd/issues/issues/59) | 116 dage / 3.8 mdr. | Klar til prioritering | 1.000kr | – |
| – | [#58 – OS2sofd - ilm - udfyld UPN ved oprettelse af konsulentkonto](https://github.com/OS2sofd/issues/issues/58) | 116 dage / 3.8 mdr. | Klar til prioritering | 3.250kr | – |
| – | [#61 – Vil gerne selv kunne styre username, og navngivningen generelt i ILM](https://github.com/OS2sofd/issues/issues/61) | 111 dage / 3.6 mdr. | Igangværende opgaver | 19.500kr | – |
| – | [#105 – OS2ILM: Flytning af ILM-oprettede konsulenter](https://github.com/OS2sofd/issues/issues/105) | 34 dage / 1.1 mdr. | Klar til prioritering | 2.250kr | – |
| – | [#107 – OS2ILM: Manglende e-mailnotifikationer ved konsulentgodkendelse](https://github.com/OS2sofd/issues/issues/107) | 34 dage / 1.1 mdr. | Igangværende opgaver | 4.000kr | – |
| – | [#106 – OS2ILM: Det skal være muligt for en administrator at slette en konsulent helt.](https://github.com/OS2sofd/issues/issues/106) | 34 dage / 1.1 mdr. | Igangværende opgaver | 8.750kr | – |

## 6. Hele pipeline – Fra idé til færdig løsning

| Status | Antal |
| --- | ---: |
| Nye ændringsønsker | 0 |
| Screening | 5 |
| Afventer løsningsbeskrivelse | 61 |
| Klar til prioritering | 14 |
| Bestilt hos leverandør | 4 |
| Igangværende opgaver | 3 |
| Løsninger i test | 1 |
| Løsninger i review | 0 |
| Afsluttede løsninger | 18 |
| Won't fix | 4 |

### Screening

<details>
<summary>Vis 5 issue(s)</summary>

| Prioritet | Issue | Alder | Kommune | Labels | Senest opdateret |
| --- | --- | ---: | --- | --- | ---: |
| Mellem | [#54 – Udvidet stillingskatalog og kodebaseret regelgrundlag i SOFD (og OS2Rollekatalog)](https://github.com/OS2sofd/issues/issues/54) | 125 dage / 4.1 mdr. | Hjørring | idm, datamodel og tilhørsforhold | 1 dage siden |
| Mellem | [#95 – Mulighed for at deaktivere en konto med udskudt dato](https://github.com/OS2sofd/issues/issues/95) | 68 dage / 2.2 mdr. | Tønder | idm, brugere og konti | 0 dage siden |
| – | [#16 – Navne- og adressebeskyttelse:](https://github.com/OS2sofd/issues/issues/16) | 179 dage / 5.9 mdr. | Odsherred | stamdata, ui | 12 dage siden |
| – | [#74 – funktionelle forbedringer](https://github.com/OS2sofd/issues/issues/74) | 89 dage / 2.9 mdr. | Tønder | idm, middleware | 12 dage siden |
| – | [#84 – At kunne skrive data attribut værdier fra OS2Vikar oprettelse til Data attribut i Active Directory](https://github.com/OS2sofd/issues/issues/84) | 75 dage / 2.5 mdr. | Lyngby-Taarbæk | vikar, middleware | 12 dage siden |

</details>

### Afventer løsningsbeskrivelse

<details>
<summary>Vis 61 issue(s)</summary>

| Prioritet | Issue | Alder | Labels | Kommune | Assignee | Senest opdateret |
| --- | --- | ---: | --- | --- | --- | ---: |
| Høj | [#108 – Ændringsønske: Fremtidige ændringer: Organisationsændringer og- håndtering fødes i OS2sofd og matches efterfølgende med LOSid i KMD LOS integration mod sofd.](https://github.com/OS2sofd/issues/issues/108) | 33 dage / 1.1 mdr. | stamdata, datamodel og tilhørsforhold | Horsens | – | 1 dage siden |
| Høj | [#109 – Dobbelt hierarki: Lønhierarki og den administrative organisation. Oprettelse af det administrative hierarki foretages pba. LOS-koblinger og strukturerede valideringer.Ændringsønske](https://github.com/OS2sofd/issues/issues/109) | 33 dage / 1.1 mdr. | stamdata, datamodel og tilhørsforhold | Horsens | – | 12 dage siden |
| Mellem | [#10 – Udvid SOFDCoreADWritebackAgent til at understøtte forsk. OU'er](https://github.com/OS2sofd/issues/issues/10) | 179 dage / 5.9 mdr. | middleware, brugere og konti | Favrskov | – | 12 dage siden |
| Mellem | [#11 – Tilføj information om en AD konto er i brug + understøtte LocalExtensions i Mail skabeloner](https://github.com/OS2sofd/issues/issues/11) | 179 dage / 5.9 mdr. | mailskabelon/advis, middleware, funktionelle forbedringer | Favrskov | – | 12 dage siden |
| Mellem | [#13 – SofdCoreADReplicator - Handlinger ved grupper](https://github.com/OS2sofd/issues/issues/13) | 179 dage / 5.9 mdr. | drift og vedligehold, middleware | Favrskov | – | 12 dage siden |
| Mellem | [#17 – SOFD GUI: Udvidet overblik over tilhørsforhold og typer](https://github.com/OS2sofd/issues/issues/17) | 179 dage / 5.9 mdr. | ui, brugere og konti | Favrskov | – | 12 dage siden |
| Mellem | [#19 – SOFD GUI: Bloker oprettelse af manuelle tilhørsforhold af typen "Medarbejder" når man kører med sync fra et lønsystem](https://github.com/OS2sofd/issues/issues/19) | 179 dage / 5.9 mdr. | idm, ui | Favrskov | – | 12 dage siden |
| Mellem | [#21 – SOFD indlæsning fra lønsystem: Mulighed for selv at administrere indlæsningsfiltre](https://github.com/OS2sofd/issues/issues/21) | 179 dage / 5.9 mdr. | ui, middleware, brugere og konti | Favrskov | – | 12 dage siden |
| Mellem | [#22 – Brug af AD konto ved opsætning af 'manuelt valgt' leder på enhed](https://github.com/OS2sofd/issues/issues/22) | 179 dage / 5.9 mdr. | ui, brugere og konti | Favrskov | – | 12 dage siden |
| Mellem | [#23 – Samlet overblik over diverse opmærkninger/fravalg af enheder](https://github.com/OS2sofd/issues/issues/23) | 179 dage / 5.9 mdr. | rapporter, ui, brugere og konti | Favrskov | – | 12 dage siden |
| Mellem | [#35 – Forslag til rettelser i OS2SOFD Ledermodul](https://github.com/OS2sofd/issues/issues/35) | 173 dage / 5.7 mdr. | idm, lederside | Sønderborg | – | 12 dage siden |
| Mellem | [#55 – Lederside - Forbedring af GUI for Pausemarkering ift. endusers](https://github.com/OS2sofd/issues/issues/55) | 125 dage / 4.1 mdr. | ui, lederside | Favrskov | – | 12 dage siden |
| Mellem | [#73 – OS2sofd Kommunikationsmodul - Ønsker til forbedringer](https://github.com/OS2sofd/issues/issues/73) | 89 dage / 2.9 mdr. | middleware, funktionelle forbedringer | Favrskov | – | 12 dage siden |
| Mellem | [#76 – Ny pladsholder og pladsholder funktion til mailskabelonen ”Digital post til medarbejder ved oprettelse af AD konto”](https://github.com/OS2sofd/issues/issues/76) | 85 dage / 2.8 mdr. | mailskabelon/advis, funktionelle forbedringer | Vallensbæk | – | 12 dage siden |
| Mellem | [#79 – Flere steps i godkendelsesflow i OS2Rollekatalog Anmod/Godkend](https://github.com/OS2sofd/issues/issues/79) | 77 dage / 2.5 mdr. | idm, ui | Lyngby-Taarbæk | – | 12 dage siden |
| Mellem | [#98 – OS2sofd Telefoni-modul - Ønsker til forbedringer](https://github.com/OS2sofd/issues/issues/98) | 56 dage / 1.8 mdr. | ui, funktionelle forbedringer | Favrskov | – | 12 dage siden |
| Mellem | [#104 – OS2ILM: Placering af medarbejdere i OU](https://github.com/OS2sofd/issues/issues/104) | 34 dage / 1.1 mdr. | idm, ilm | Norddjurs | – | 12 dage siden |
| Mellem | [#102 – OS2ILM: Mere specifik log](https://github.com/OS2sofd/issues/issues/102) | 34 dage / 1.1 mdr. | log-data, ilm | Norddjurs | – | 12 dage siden |
| Mellem | [#110 – Frigørelse af kobling mellem it-brugerkonto og tilhørsforhold fra løndata. Tilhørsforhold skal afspejle den administrative organisation i OS2sofd.Ændringsønske](https://github.com/OS2sofd/issues/issues/110) | 33 dage / 1.1 mdr. | brugere og konti, datamodel og tilhørsforhold | Horsens | – | 12 dage siden |
| Lav | [#18 – Brugertjek: Uddybelse af Entra licenser](https://github.com/OS2sofd/issues/issues/18) | 179 dage / 5.9 mdr. | ui, brugertjek | Bornholm | – | 12 dage siden |
| Lav | [#28 – Brugertjek: Kontrol af lønsystem konto](https://github.com/OS2sofd/issues/issues/28) | 178 dage / 5.8 mdr. | idm, brugertjek | Bornholm | – | 12 dage siden |
| Lav | [#29 – Brugertjek: Mulighed for genveje og dybe links](https://github.com/OS2sofd/issues/issues/29) | 178 dage / 5.8 mdr. | ui, brugertjek | Bornholm | – | 12 dage siden |
| Lav | [#26 – Brugertjek: Robot-flag for robotter](https://github.com/OS2sofd/issues/issues/26) | 178 dage / 5.8 mdr. | ui, brugertjek | Bornholm | – | 12 dage siden |
| Lav | [#32 – Import af SOFD enheder til OS2Vikar modulet](https://github.com/OS2sofd/issues/issues/32) | 173 dage / 5.7 mdr. | vikar, middleware | Hjørring | – | 12 dage siden |
| Lav | [#34 – ÆndringsønskeMulighed for at sende sms fra Vikarmodulet](https://github.com/OS2sofd/issues/issues/34) | 173 dage / 5.7 mdr. | vikar, mailskabelon/advis | Køge | – | 12 dage siden |
| Lav | [#37 – Tilknytning af stillinger til enheder i Vikar modulet](https://github.com/OS2sofd/issues/issues/37) | 172 dage / 5.7 mdr. | vikar, ui | Tårnby | – | 12 dage siden |
| Lav | [#48 – Stoppet medarbejder slettes i Lederportalen/Tillidserhverv](https://github.com/OS2sofd/issues/issues/48) | 155 dage / 5.1 mdr. | lederside, brugere og konti | Odsherred | – | 12 dage siden |
| Lav | [#52 – Automatisk dannede flow-diagrammer til OS2sofd](https://github.com/OS2sofd/issues/issues/52) | 133 dage / 4.4 mdr. | dokumentation, log-data | Ikke kommune | – | 12 dage siden |
| Lav | [#60 – SMS/Kodeordspåmindelse: understøttelse af flere kodeordspolitikker](https://github.com/OS2sofd/issues/issues/60) | 112 dage / 3.7 mdr. | mailskabelon/advis, middleware | Bornholm | – | 12 dage siden |
| Lav | [#72 – Ekstra data på skoleelever](https://github.com/OS2sofd/issues/issues/72) | 97 dage / 3.2 mdr. | stamdata, middleware | Kalundborg | – | 12 dage siden |
| Lav | [#71 – Videreudvikling af SMS modul](https://github.com/OS2sofd/issues/issues/71) | 97 dage / 3.2 mdr. | mailskabelon/advis, middleware | Kalundborg | – | 12 dage siden |
| Lav | [#70 – Mulighed for at redigere og flytte kolonner i oversigtsbillederne](https://github.com/OS2sofd/issues/issues/70) | 97 dage / 3.2 mdr. | ui | Kalundborg | – | 12 dage siden |
| Lav | [#69 – Mulighed for at fravælge advis ved kontooprettelse](https://github.com/OS2sofd/issues/issues/69) | 97 dage / 3.2 mdr. | idm, mailskabelon/advis | Kalundborg | – | 12 dage siden |
| Lav | [#64 – Brugertjek : oplysninger om sidste kodeordsskifte og kodeordsløb i OS2faktor fanen](https://github.com/OS2sofd/issues/issues/64) | 97 dage / 3.2 mdr. | api, brugertjek | Kalundborg | – | 12 dage siden |
| Lav | [#67 – Kommunikationsmodul - Udviklingsønsker til email og log](https://github.com/OS2sofd/issues/issues/67) | 97 dage / 3.2 mdr. | log-data, mailskabelon/advis | Kalundborg | – | 12 dage siden |
| Lav | [#66 – Mulighed for at redigere allerede oprettet arbejdssted](https://github.com/OS2sofd/issues/issues/66) | 97 dage / 3.2 mdr. | ui, funktionelle forbedringer | Kalundborg | – | 12 dage siden |
| Lav | [#75 – Kommunikationsmodul i OS2sofd SMS/Email](https://github.com/OS2sofd/issues/issues/75) | 89 dage / 2.9 mdr. | stamdata, mailskabelon/advis | Tønder | – | 12 dage siden |
| Lav | [#78 – Bjælke for oven og i venstre side, skal fryses fast](https://github.com/OS2sofd/issues/issues/78) | 81 dage / 2.7 mdr. | ui | Tønder | – | 12 dage siden |
| Lav | [#80 – ÆndringsønskeUdvidet information ved anmodning om rolle i OS2Rolekatalog Anmod/Godkend](https://github.com/OS2sofd/issues/issues/80) | 77 dage / 2.5 mdr. | idm, ui | Lyngby-Taarbæk | – | 12 dage siden |
| Lav | [#81 – At kunne ændre afsendernavn på mails fra Rollekatalog](https://github.com/OS2sofd/issues/issues/81) | 76 dage / 2.5 mdr. | ui, mailskabelon/advis | Lyngby-Taarbæk | – | 12 dage siden |
| Lav | [#93 – Berigelse af titelfelt for skoleelever med klassetrin](https://github.com/OS2sofd/issues/issues/93) | 75 dage / 2.5 mdr. | stamdata, middleware | Kalundborg | – | 12 dage siden |
| Lav | [#91 – Opslag i MitID Erhverv ved for at se om bruger har et aktivt tildelt MitID Erhverv](https://github.com/OS2sofd/issues/issues/91) | 75 dage / 2.5 mdr. | idm, brugertjek | Lyngby-Taarbæk | – | 12 dage siden |
| Lav | [#90 – At kunde (kommune) selv kan konfigurere i UI, i Brugertjek, hvilke data attributter der skal være synlige ved opslag i brugertjek](https://github.com/OS2sofd/issues/issues/90) | 75 dage / 2.5 mdr. | ui, brugertjek | Lyngby-Taarbæk | – | 12 dage siden |
| Lav | [#92 – Konfigurationsindstilling: Jobfunktionsroller og Rollebuketter listes samlet](https://github.com/OS2sofd/issues/issues/92) | 75 dage / 2.5 mdr. | idm, ui | Lyngby-Taarbæk | – | 12 dage siden |
| Lav | [#88 – Ny kolonne i rapporten 'Historiske rolleanmodninger', så man kan se hvilket IT-System de forskellige roller er tilknyttet](https://github.com/OS2sofd/issues/issues/88) | 75 dage / 2.5 mdr. | rapporter, idm | Lyngby-Taarbæk | – | 12 dage siden |
| Lav | [#89 – Udvide 'Status' typer for tildeling af rettigheder med 'Tildelt ved godkendt anmodning'.](https://github.com/OS2sofd/issues/issues/89) | 75 dage / 2.5 mdr. | rapporter, idm | Lyngby-Taarbæk | – | 12 dage siden |
| Lav | [#96 – Vis detaljer om hvem der har bestilt/oprettet en konto undrer ordre-detaljer](https://github.com/OS2sofd/issues/issues/96) | 61 dage / 2 mdr. | log-data, idm | Allerød | – | 12 dage siden |
| Lav | [#99 – Understøtte ny Skole/SFO opmærkning til KOMBIT](https://github.com/OS2sofd/issues/issues/99) | 48 dage / 1.6 mdr. | stamdata, middleware | Ikke kommune | – | 12 dage siden |
| Lav | [#103 – OS2ILM: Visning af firma og navn](https://github.com/OS2sofd/issues/issues/103) | 34 dage / 1.1 mdr. | ui, ilm | Norddjurs | – | 12 dage siden |
| Lav | [#111 – UI forbedringer til stillingskatalog](https://github.com/OS2sofd/issues/issues/111) | 29 dage / 1 mdr. | ui, funktionelle forbedringer | Allerød | – | 12 dage siden |
| Lav | [#113 – Indlæsning af Mit Erhverv status til OS2Sofd](https://github.com/OS2sofd/issues/issues/113) | 12 dage / 0.4 mdr. | idm, middleware | Kalundborg | – | 12 dage siden |
| Lav | [#119 – Forbedret logning/dokumentation af ordredannelser.](https://github.com/OS2sofd/issues/issues/119) | 0 dage / 0 mdr. | log-data, idm | Bornholm | – | 0 dage siden |
| Lav | [#120 – Advarsel omkring bestilling af Brugerkonti når man anvender bindingsmodellen](https://github.com/OS2sofd/issues/issues/120) | 0 dage / 0 mdr. | idm, ui | Bornholm | – | 0 dage siden |
| – | [#12 – Forstå forskel på Ansatte, Eksterne, Byrøddet, Konsulenter, Vikarer, m.m. typer af AD konti](https://github.com/OS2sofd/issues/issues/12) | 179 dage / 5.9 mdr. | idm, brugere og konti | Sønderborg | – | 12 dage siden |
| – | [#30 – OS2sofd - ILM: Vedligeholdelse af Fortrolighedsaftale](https://github.com/OS2sofd/issues/issues/30) | 178 dage / 5.8 mdr. | idm, ilm | Bornholm | – | 12 dage siden |
| – | [#62 – Udvidelse af Opus-integrationen med mulighed for at overføre flere brugerkontotyper](https://github.com/OS2sofd/issues/issues/62) | 105 dage / 3.4 mdr. | middleware, brugere og konti | Egedal | – | 12 dage siden |
| – | [#68 – API-udvidelse til undtagelse/pausemarkering](https://github.com/OS2sofd/issues/issues/68) | 97 dage / 3.2 mdr. | idm, api | Kalundborg | – | 12 dage siden |
| – | [#87 – Begrænse en systemansvarlig's view af it-systemer i OS2Rollekatalog](https://github.com/OS2sofd/issues/issues/87) | 75 dage / 2.5 mdr. | idm, ui | Lyngby-Taarbæk | – | 12 dage siden |
| – | [#86 – OS2Vikar mulighed for at angive tid ved oprettelse af vikar](https://github.com/OS2sofd/issues/issues/86) | 75 dage / 2.5 mdr. | vikar | Lyngby-Taarbæk | – | 12 dage siden |
| – | [#101 – OS2ILM: Tildeling af leder via Virksomhed](https://github.com/OS2sofd/issues/issues/101) | 34 dage / 1.1 mdr. | ui, ilm | Norddjurs | – | 12 dage siden |
| – | [#112 – Migrering til Datafordeleren til CPR opslag](https://github.com/OS2sofd/issues/issues/112) | 26 dage / 0.9 mdr. | api, drift og vedligehold | Ikke kommune | – | 12 dage siden |

</details>

### Klar til prioritering

| Prioritet | Issue | Alder | Estimat | Størrelse | Release | Kommune |
| --- | --- | ---: | ---: | --- | --- | --- |
| Høj | [#65 – NexusSync - automatisk luk af konti udenfor "nexus organisationen"](https://github.com/OS2sofd/issues/issues/65) | 97 dage / 3.2 mdr. | – | – | – | Kalundborg |
| Mellem | [#9 – Person tilhørsforhold - Tilføj markering af primært tilhørsforhold](https://github.com/OS2sofd/issues/issues/9) | 179 dage / 5.9 mdr. | – | – | – | Favrskov |
| Mellem | [#25 – Brugertjek: Udvidelse af informationer i tilhørforholdstabellen](https://github.com/OS2sofd/issues/issues/25) | 178 dage / 5.8 mdr. | – | – | – | Bornholm |
| Mellem | [#27 – Oprettelse af KSP/CICS konti på baggrund af rolletildelinger](https://github.com/OS2sofd/issues/issues/27) | 178 dage / 5.8 mdr. | – | – | – | Bornholm |
| Mellem | [#36 – Auto-opdatere enheder i FK Organisation ved nye KLE emner](https://github.com/OS2sofd/issues/issues/36) | 173 dage / 5.7 mdr. | – | – | – | Sønderborg |
| Mellem | [#82 – ÆndringsønskeObligatorisk drop down menuer samt mulighed for a pre-definere værdier ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/82) | 76 dage / 2.5 mdr. | – | – | – | Lyngby-Taarbæk |
| Mellem | [#83 – At kunne gøre data felter obligatoriske ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/83) | 76 dage / 2.5 mdr. | – | – | – | Lyngby-Taarbæk |
| Mellem | [#85 – Brugernavn generator ved oprettelse af vikar (OS2Vikar)](https://github.com/OS2sofd/issues/issues/85) | 75 dage / 2.5 mdr. | – | – | – | Lyngby-Taarbæk |
| Mellem | [#97 – Vedligehold/rettidige opdateringer af Autorisationskoder](https://github.com/OS2sofd/issues/issues/97) | 57 dage / 1.9 mdr. | – | – | – | Bornholm |
| Lav | [#24 – Prefix i AD Event Dispatcher](https://github.com/OS2sofd/issues/issues/24) | 179 dage / 5.9 mdr. | – | – | – | Bornholm |
| Lav | [#15 – Behov for at kunne vise forskelligt displaynavn på ansatte med flere tilhørsforhold/AD-konti](https://github.com/OS2sofd/issues/issues/15) | 179 dage / 5.9 mdr. | – | – | – | Sønderborg |
| – | [#58 – OS2sofd - ilm - udfyld UPN ved oprettelse af konsulentkonto](https://github.com/OS2sofd/issues/issues/58) | 116 dage / 3.8 mdr. | 3.250kr | – | – | Norddjurs |
| – | [#59 – OS2sofd - ilm: udfyld displayName ved oprettelse af konsulent](https://github.com/OS2sofd/issues/issues/59) | 116 dage / 3.8 mdr. | 1.000kr | – | – | Norddjurs |
| – | [#105 – OS2ILM: Flytning af ILM-oprettede konsulenter](https://github.com/OS2sofd/issues/issues/105) | 34 dage / 1.1 mdr. | 2.250kr | – | – | Norddjurs |

### Bestilt hos leverandør

<details>
<summary>Vis 4 issue(s)</summary>

| Prioritet | Issue | Alder | Assignee | Estimat | Release | Senest opdateret |
| --- | --- | ---: | --- | ---: | --- | ---: |
| Kritisk | [#51 – Migrér CVR-integration fra Datafordeler REST til GraphQL](https://github.com/OS2sofd/issues/issues/51) | 138 dage / 4.5 mdr. | pso-digital-identity | 25.000kr | 3. kvartal 2026 | 5 dage siden |
| Høj | [#50 – Mulighed for at opsætte grænser for varigheden af OS2sofd tilhørsforhold](https://github.com/OS2sofd/issues/issues/50) | 139 dage / 4.6 mdr. | pso-digital-identity | 25.000kr | 3. kvartal 2026 | 5 dage siden |
| Høj | [#53 – OS2sofd Lederside - Auditlogning af ændringer skal følge SOFD Core praksis](https://github.com/OS2sofd/issues/issues/53) | 126 dage / 4.1 mdr. | pso-digital-identity | 26.000kr | 3. kvartal 2026 | 5 dage siden |
| Høj | [#100 – Brugerkontotyper - tilføjelse til skabelonbaseret navnekonvention](https://github.com/OS2sofd/issues/issues/100) | 48 dage / 1.6 mdr. | pso-digital-identity | 15.000kr | 3. kvartal 2026 | 5 dage siden |

</details>

### Igangværende opgaver

<details>
<summary>Vis 3 issue(s)</summary>

| Prioritet | Issue | Alder | Assignee | Estimat | Release | Senest opdateret |
| --- | --- | ---: | --- | ---: | --- | ---: |
| – | [#61 – Vil gerne selv kunne styre username, og navngivningen generelt i ILM](https://github.com/OS2sofd/issues/issues/61) | 111 dage / 3.6 mdr. | – | 19.500kr | – | 29 dage siden |
| – | [#106 – OS2ILM: Det skal være muligt for en administrator at slette en konsulent helt.](https://github.com/OS2sofd/issues/issues/106) | 34 dage / 1.1 mdr. | – | 8.750kr | – | 29 dage siden |
| – | [#107 – OS2ILM: Manglende e-mailnotifikationer ved konsulentgodkendelse](https://github.com/OS2sofd/issues/issues/107) | 34 dage / 1.1 mdr. | – | 4.000kr | – | 29 dage siden |

</details>

### Løsninger i test

<details>
<summary>Vis 1 issue(s)</summary>

| Issue | Alder | Release | Assignee | Senest opdateret |
| --- | ---: | --- | --- | ---: |
| [#94 – Understøttelse af Pre-hire-brugere i snitfladen mellem SOFD og Rollekatalog](https://github.com/OS2sofd/issues/issues/94) | 71 dage / 2.3 mdr. | 3. kvartal 2026 | – | 10 dage siden |

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
<summary>Vis 4 issue(s)</summary>

| Issue | Alder | Kommune | Senest opdateret |
| --- | ---: | --- | --- |
| [#49 – Ændring af synkronisering af data ind i Nexus](https://github.com/OS2sofd/issues/issues/49) | 151 dage / 5 mdr. | Tønder | 15-09-2026 |
| [#6 – Visning af mailadresse i listevisning/SOFD](https://github.com/OS2sofd/issues/issues/6) | 397 dage / 13 mdr. | – | 18-08-2025 |
| [#14 – Nye hændelse til IDM proces: Reaktivering - Oprydning](https://github.com/OS2sofd/issues/issues/14) | 179 dage / 5.9 mdr. | Sønderborg | 19-05-2026 |
| [#33 – Foretræk kendte spærrede konti fremfor at danne et nyt brugernavn](https://github.com/OS2sofd/issues/issues/33) | 173 dage / 5.7 mdr. | Sønderborg | 19-05-2026 |

</details>

## 7. Proces- og datakvalitet

| Issue | Status | Alder | Problem |
| --- | --- | ---: | --- |
| [#24 – Prefix i AD Event Dispatcher](https://github.com/OS2sofd/issues/issues/24) | Klar til prioritering | 179 dage / 5.9 mdr. | Mangler estimat |
| [#15 – Behov for at kunne vise forskelligt displaynavn på ansatte med flere tilhørsforhold/AD-konti](https://github.com/OS2sofd/issues/issues/15) | Klar til prioritering | 179 dage / 5.9 mdr. | Mangler estimat |
| [#9 – Person tilhørsforhold - Tilføj markering af primært tilhørsforhold](https://github.com/OS2sofd/issues/issues/9) | Klar til prioritering | 179 dage / 5.9 mdr. | Mangler estimat |
| [#12 – Forstå forskel på Ansatte, Eksterne, Byrøddet, Konsulenter, Vikarer, m.m. typer af AD konti](https://github.com/OS2sofd/issues/issues/12) | Afventer løsningsbeskrivelse | 179 dage / 5.9 mdr. | Mangler prioritet |
| [#25 – Brugertjek: Udvidelse af informationer i tilhørforholdstabellen](https://github.com/OS2sofd/issues/issues/25) | Klar til prioritering | 178 dage / 5.8 mdr. | Mangler estimat |
| [#27 – Oprettelse af KSP/CICS konti på baggrund af rolletildelinger](https://github.com/OS2sofd/issues/issues/27) | Klar til prioritering | 178 dage / 5.8 mdr. | Mangler estimat |
| [#30 – OS2sofd - ILM: Vedligeholdelse af Fortrolighedsaftale](https://github.com/OS2sofd/issues/issues/30) | Afventer løsningsbeskrivelse | 178 dage / 5.8 mdr. | Mangler prioritet |
| [#36 – Auto-opdatere enheder i FK Organisation ved nye KLE emner](https://github.com/OS2sofd/issues/issues/36) | Klar til prioritering | 173 dage / 5.7 mdr. | Mangler estimat |
| [#58 – OS2sofd - ilm - udfyld UPN ved oprettelse af konsulentkonto](https://github.com/OS2sofd/issues/issues/58) | Klar til prioritering | 116 dage / 3.8 mdr. | Mangler prioritet |
| [#59 – OS2sofd - ilm: udfyld displayName ved oprettelse af konsulent](https://github.com/OS2sofd/issues/issues/59) | Klar til prioritering | 116 dage / 3.8 mdr. | Mangler prioritet |
| [#61 – Vil gerne selv kunne styre username, og navngivningen generelt i ILM](https://github.com/OS2sofd/issues/issues/61) | Igangværende opgaver | 111 dage / 3.6 mdr. | Mangler prioritet; Mangler planlagt release |
| [#62 – Udvidelse af Opus-integrationen med mulighed for at overføre flere brugerkontotyper](https://github.com/OS2sofd/issues/issues/62) | Afventer løsningsbeskrivelse | 105 dage / 3.4 mdr. | Mangler prioritet |
| [#68 – API-udvidelse til undtagelse/pausemarkering](https://github.com/OS2sofd/issues/issues/68) | Afventer løsningsbeskrivelse | 97 dage / 3.2 mdr. | Mangler prioritet |
| [#65 – NexusSync - automatisk luk af konti udenfor "nexus organisationen"](https://github.com/OS2sofd/issues/issues/65) | Klar til prioritering | 97 dage / 3.2 mdr. | Mangler estimat |
| [#83 – At kunne gøre data felter obligatoriske ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/83) | Klar til prioritering | 76 dage / 2.5 mdr. | Mangler estimat |
| [#82 – ÆndringsønskeObligatorisk drop down menuer samt mulighed for a pre-definere værdier ved oprettelse i OS2Vikar](https://github.com/OS2sofd/issues/issues/82) | Klar til prioritering | 76 dage / 2.5 mdr. | Mangler estimat |
| [#85 – Brugernavn generator ved oprettelse af vikar (OS2Vikar)](https://github.com/OS2sofd/issues/issues/85) | Klar til prioritering | 75 dage / 2.5 mdr. | Mangler estimat |
| [#86 – OS2Vikar mulighed for at angive tid ved oprettelse af vikar](https://github.com/OS2sofd/issues/issues/86) | Afventer løsningsbeskrivelse | 75 dage / 2.5 mdr. | Mangler prioritet |
| [#87 – Begrænse en systemansvarlig's view af it-systemer i OS2Rollekatalog](https://github.com/OS2sofd/issues/issues/87) | Afventer løsningsbeskrivelse | 75 dage / 2.5 mdr. | Mangler prioritet |
| [#97 – Vedligehold/rettidige opdateringer af Autorisationskoder](https://github.com/OS2sofd/issues/issues/97) | Klar til prioritering | 57 dage / 1.9 mdr. | Mangler estimat |
| [#105 – OS2ILM: Flytning af ILM-oprettede konsulenter](https://github.com/OS2sofd/issues/issues/105) | Klar til prioritering | 34 dage / 1.1 mdr. | Mangler prioritet |
| [#107 – OS2ILM: Manglende e-mailnotifikationer ved konsulentgodkendelse](https://github.com/OS2sofd/issues/issues/107) | Igangværende opgaver | 34 dage / 1.1 mdr. | Mangler prioritet; Mangler planlagt release |
| [#106 – OS2ILM: Det skal være muligt for en administrator at slette en konsulent helt.](https://github.com/OS2sofd/issues/issues/106) | Igangværende opgaver | 34 dage / 1.1 mdr. | Mangler prioritet; Mangler planlagt release |
| [#101 – OS2ILM: Tildeling af leder via Virksomhed](https://github.com/OS2sofd/issues/issues/101) | Afventer løsningsbeskrivelse | 34 dage / 1.1 mdr. | Mangler prioritet |
| [#112 – Migrering til Datafordeleren til CPR opslag](https://github.com/OS2sofd/issues/issues/112) | Afventer løsningsbeskrivelse | 26 dage / 0.9 mdr. | Mangler prioritet |

---

_Denne fil er automatisk genereret fra GitHub Project **Fra idé til færdig løsning**. GitHub Project er den autoritative datakilde; data/po-overblik-history.json bruges alene til afledt status-historik. Kommunikationssignaler er indikatorer og skal vurderes af PO._
