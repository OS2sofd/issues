# OS2sofd – PO-review af løsningsbeskrivelser v1

## Formål

PO-reviewet skal kvalificere leverandørens løsningsbeskrivelse, før ændringsønsket behandles af koordinationsgruppen.

Reviewet er et kvalitetslag oven på det eksisterende statusflow og indfører ikke en ny Project-status.

Udgangspunktet er den løsningsbeskrivelse, leverandøren faktisk har leveret. Der stilles i v1 ikke krav om et bestemt format eller faste overskrifter.

Hvis væsentlige oplysninger mangler, skal reviewet gøre manglen tydelig, så leverandøren kan supplere eller præcisere beskrivelsen.

---

## Hvornår gennemføres reviewet?

Reviewet gennemføres, når et ændringsønske er flyttet til:

**Klar til prioritering**

Formålet er at sikre, at koordinationsgruppen får et tilstrækkeligt og forståeligt beslutningsgrundlag.

Reviewet må ikke i sig selv flytte et issue tilbage til en tidligere status. Hvis der findes blokerende mangler, afgør PO, om sagen skal returneres til **Afventer løsningsbeskrivelse**.

---


## Relevans og proportionalitet

Reviewkriterierne er perspektiver, som skal anvendes **i det omfang de er relevante for det konkrete ændringsønske**.

Ændringsønsker kan spænde fra en meget lille teknisk justering til en omfattende ændring, der påvirker flere funktioner, integrationer eller arkitekturelementer. Reviewets dybde og vægtning skal derfor stå i rimeligt forhold til ændringens omfang, kompleksitet og risiko.

Før hvert kriterium vurderes, skal reviewet tage stilling til kriteriets relevans:

- **Relevant** – kriteriet har reel betydning for løsningen og skal vurderes fuldt ud.
- **Delvist relevant** – kriteriet har begrænset betydning og vurderes proportionalt med ændringens omfang.
- **Ikke relevant** – kriteriet har ingen reel betydning for den konkrete ændring og skal ikke påvirke den samlede vurdering.

Et kriterium må ikke få 🟡 eller 🔴 alene, fordi et forhold ikke er beskrevet, hvis forholdet ikke er relevant for den konkrete løsning.

### Ændringens karakter

Som støtte for proportionalitetsvurderingen klassificeres ændringen overordnet som:

- **Mindre ændring** – afgrænset teknisk eller funktionel justering med begrænset påvirkning.
- **Mellemstor ændring** – påvirker en væsentlig funktion, integration eller arbejdsgang.
- **Omfattende ændring** – berører flere dele af løsningen, integrationer, arkitektur eller mange anvendere.

Klassifikationen er **ikke en prioritet og ikke et estimat**. Den bruges alene til at sikre et passende niveau i reviewet.

Den samlede PO-vurdering baseres kun på relevante forhold og skal stå i rimeligt forhold til ændringens omfang, kompleksitet og risiko.


## Vurderingsskala

Hvert kriterium vurderes med:

- 🟢 **OK** – beskrivelsen er tilstrækkelig på dette punkt.
- 🟡 **Opmærksomhed** – der er en uklarhed, mangel eller et forhold, som bør bemærkes, men som ikke nødvendigvis blokerer for prioritering.
- 🔴 **Skal afklares før prioritering** – der mangler eller er uklarhed om så væsentlige forhold, at PO bør afklare sagen, før den behandles af koordinationsgruppen.

Et gult kriterium er ikke i sig selv blokerende.

---

## Reviewkriterier

### 1. Forståelighed og tydelighed

**Hvad vurderes?**

Om løsningsbeskrivelsen er formuleret klart og tilstrækkeligt forståeligt til, at relevante interessenter kan forstå:

- hvad der foreslås ændret
- hvordan løsningen forventes at virke
- hvordan løsningen hænger sammen med det oprindelige behov
- hvilke væsentlige konsekvenser eller afgrænsninger løsningen har

Der må gerne indgå tekniske detaljer, men de centrale dele af løsningen skal kunne forstås uden indgående kendskab til den konkrete kode eller implementering.

🟢 når løsningens hovedidé, virkemåde og konsekvenser er tydelige.  
🟡 når løsningen overordnet kan forstås, men væsentlige dele er uklart eller meget teknisk beskrevet.  
🔴 når det ikke er muligt at forstå, hvad der konkret foreslås leveret.

---

### 2. Sammenhæng mellem behov og løsning

**Hvad vurderes?**

Om den foreslåede løsning reelt adresserer det forretningsbehov, der ligger til grund for ændringsønsket.

Reviewet skal være opmærksomt på:

- om løsningen løser hele eller kun dele af behovet
- om væsentlige dele af behovet er faldet ud
- om løsningsforslaget introducerer ny funktionalitet eller afgrænsninger, som ændrer sagen
- om løsningen ser ud til at være bredere eller smallere end det oprindelige ændringsønske

🟢 når der er tydelig sammenhæng mellem behov og løsning.  
🟡 når løsningen ser relevant ud, men der er uklarhed om dele af behovet.  
🔴 når løsningen ikke tydeligt adresserer det oprindelige behov.

---

### 3. API-perspektiv og fremtidssikring

**Hvad vurderes?**

Om løsningen har et API- eller integrationsperspektiv, som bør ses i sammenhæng med OS2sofd's fremtidige API-strategi.

Reviewet skal ikke kun lede efter ordet "API", men også være opmærksomt på løsninger, der:

- udstiller eller modtager data
- etablerer nye system-til-system-integrationer
- bygger integrationslogik direkte ind i OS2sofd
- introducerer nye endpoints, services, middleware eller dataudveksling
- på anden måde kunne være relevante for en fremtidig fælles API-løsning

Det gennemgående spørgsmål er:

> Kan hele eller dele af behovet med fordel løses eller påvirkes af den fremtidige API-arkitektur?

🟢 når der ikke ses et relevant API-perspektiv, eller når det er tilstrækkeligt håndteret.  
🟡 når der er et muligt API-/integrationsperspektiv, som koordinationsgruppen eller PO bør være opmærksom på.  
🔴 når løsningen tydeligt risikerer at være i konflikt med eller foregribe en væsentlig API-retning, som bør afklares først.

---

### 4. Forbehold, afhængigheder og begrænsninger

**Hvad vurderes?**

Om væsentlige forbehold og afhængigheder er synlige og forståelige.

Reviewet ser bl.a. efter:

- tekniske eller funktionelle forudsætninger
- afhængigheder til andre systemer, moduler eller leverancer
- kendte begrænsninger
- forhold der ikke løses
- påvirkning af eksisterende funktionalitet
- usikkerheder i estimat eller gennemførelse

🟢 når væsentlige forbehold og afhængigheder er tilstrækkeligt beskrevet, eller der ikke ses nogen.  
🟡 når der er mulige forbehold eller afhængigheder, som bør præciseres eller fremhæves.  
🔴 når et centralt forbehold eller en væsentlig afhængighed er uafklaret på en måde, der gør prioritering usikker.

---

### 5. Dokumentation

**Hvad vurderes?**

Om dokumentationsbehovet er tænkt tilstrækkeligt ind i løsningen.

Der kræves ikke et bestemt afsnit eller en bestemt formulering. Reviewet skal vurdere indholdet i den samlede løsningsbeskrivelse.

Der ses bl.a. efter:

- om bruger- eller produktdokumentation skal opdateres
- om teknisk eller integrationsmæssig dokumentation påvirkes
- om nye konfigurationsmuligheder eller begrænsninger skal beskrives
- om der er dokumentationsbehov, som slet ikke er omtalt

🟢 når dokumentationsbehovet er tilstrækkeligt håndteret eller tydeligt ikke relevant.  
🟡 når dokumentation ser relevant ud, men ikke er tilstrækkeligt beskrevet.  
🔴 når manglende dokumentationsafklaring vurderes som væsentlig for, at løsningen kan overtages, anvendes eller forvaltes forsvarligt.

---

### 6. Test og accept

**Hvad vurderes?**

Om løsningsbeskrivelsen giver et tilstrækkeligt grundlag for senere test og accept.

Reviewet ser bl.a. efter:

- om det er muligt at forstå, hvad der skal kunne testes
- om der er særlige scenarier eller risici, der bør verificeres
- om opretter eller en relevant kommune bør involveres i testen
- om løsningsbeskrivelsen giver PO grundlag for at formulere forretningsmæssige acceptkriterier

Færdige acceptkriterier behøver ikke allerede stå i leverandørens løsningsbeskrivelse.

Ansvarsfordelingen er:

- **Opretter** beskriver behovet og det forventede resultat.
- **PO** ejer de forretningsmæssige acceptkriterier.
- **Leverandøren** kvalificerer dem teknisk og kan supplere med tekniske testkriterier.

🟢 når løsningen kan omsættes til relevante test- og acceptkriterier.  
🟡 når der er behov for yderligere afklaring af, hvordan løsningen skal verificeres.  
🔴 når det ikke er muligt at se, hvordan det kan afgøres, om løsningen faktisk opfylder behovet.

---

### 7. Påvirkning og rækkevidde

**Hvad vurderes?**

Om løsningens påvirkning på andre dele af OS2sofd og omgivelserne er tilstrækkeligt synlig.

Reviewet ser bl.a. efter påvirkning af:

- andre moduler
- integrationer
- data og datamodeller
- eksisterende konfigurationer
- andre kommuner eller anvendelsesmønstre
- bagudkompatibilitet
- relaterede ændringsønsker eller planlagte initiativer

🟢 når påvirkningen er forståelig og afgrænset.  
🟡 når der er mulige følgevirkninger, som bør undersøges eller fremhæves.  
🔴 når væsentlige konsekvenser ikke er afklaret godt nok til, at sagen bør prioriteres endnu.

---

## Samlet PO-review

Reviewet afsluttes med én af tre samlede vurderinger:

### 🟢 Klar til prioritering

Løsningsbeskrivelsen giver et tilstrækkeligt beslutningsgrundlag, og der er ingen væsentlige opmærksomhedspunkter.

### 🟡 Klar til prioritering med opmærksomhedspunkter

Løsningsbeskrivelsen er tilstrækkelig til prioritering, men koordinationsgruppen bør gøres opmærksom på konkrete forhold.

### 🔴 Kræver PO-afklaring før prioritering

Der er væsentlige mangler eller uklarheder. PO vurderer, om leverandøren skal supplere løsningsbeskrivelsen, og om sagen skal flyttes tilbage til **Afventer løsningsbeskrivelse**.

Automationen må ikke selv foretage denne tilbageflytning.

---

## Reviewkommentar – forventet indhold

Det automatiske review skal senere kunne skrive en kommentar på issuet med:

1. tabel med de syv reviewkriterier og vurdering
2. kort opsummering af opmærksomhedspunkter
3. konkrete mangler eller spørgsmål, som bør afklares
4. fundet estimeret pris, hvis den kan identificeres sikkert
5. samlet PO-review

Eksempel:

```markdown
## PO-review af løsningsbeskrivelse

| Kriterium | Relevans | Vurdering |
| --- | --- | --- |
| Forståelighed og tydelighed | Relevant | 🟢 |
| Sammenhæng mellem behov og løsning | Relevant | 🟢 |
| API-perspektiv og fremtidssikring | Delvist relevant | 🟡 |
| Forbehold, afhængigheder og begrænsninger | Relevant | 🟢 |
| Dokumentation | Delvist relevant | 🟡 |
| Test og accept | Relevant | 🟢 |
| Påvirkning og rækkevidde | Relevant | 🟢 |

### Opmærksomhed
- Muligt API-perspektiv bør vurderes i forhold til den fremtidige API-strategi.
- Dokumentationsbehovet er ikke tydeligt beskrevet.

### Estimat
16.500 kr.

### Samlet PO-review
🟡 Klar til prioritering med opmærksomhedspunkter.
```

---

## Principper for v1

- Reviewet vurderer **indhold**, ikke format.
- Reviewet skal være **relevansbaseret og proportionalt** med ændringens omfang, kompleksitet og risiko.
- Ikke relevante kriterier skal ikke påvirke den samlede vurdering.
- Der stilles ikke krav om faste overskrifter i leverandørens løsningsbeskrivelse.
- Manglende oplysninger skal identificeres og gøres konkrete.
- AI må ikke opfinde oplysninger, som ikke fremgår af issue eller løsningsbeskrivelse.
- Et gult signal er ikke automatisk blokerende.
- Et rødt signal kræver PO-vurdering.
- Automationen må ikke selv ændre status på baggrund af reviewet.
- Reviewet skal være leverandørneutralt i sin formulering.
- Resultatet skal være kort nok til at kunne bruges af koordinationsgruppen som beslutningsstøtte.

---

## Næste udviklingstrin

Efter denne v1-specifikation følger:

1. automatisk prisudlæsning fra løsningsbeskrivelsen til Project-feltet **Estimat**
2. automatisk generering af reviewkommentar
3. review-afsnit i PO-overblikket
4. kobling til eksisterende notifikation af koordinationsgruppen, så notifikation først sker, når review og estimat er håndteret
