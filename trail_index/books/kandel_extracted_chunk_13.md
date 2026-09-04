# Kandel — Principles of Neural Science (6th ed.) — Kinyerés / Extraction
# Forrás chunk: kandel_chunk_13.txt (Chapter 56: Decision-Making and Consciousness, 1395–1416. oldal)
# Séma: book_processor.md ConceptNote YAML.
# Minden azonosító és összefoglaló magyar (AGENTS.md §0, §25), rövidítés nincs, ékezetekkel.
# Idris 2 aláírások. Az "E8" címke csak valódi algebrai hídon át kerül fel — ebben a fejezetben
# nem találtunk közvetlen E8-hidat, ezért nem szerepel. A "kategoriaelmelet" címke a valóban
# algebrai szerkezeteknél (monoid-homomorfizmus, catamorfizmus) szerepel.

---

## Fogalomjegyzetek / ConceptNotes

```yaml
- id: KANDEL13-001
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 56: Decision-Making and Consciousness"
  concept: "Jel–zaj–küszöb keret (signal detection theory): a döntés mint a bizonyíték és a kritérium összevetése"
  type: Definition
  idris_version: 2
  summary: >
    Egy észlelési döntés akkor születik, ha a bizonyíték (a jel) mértéke átlép egy küszöböt
    (kritériumot). Ha a küszöb alacsony, a téves riasztás (false alarm) gyakori; ha magas, az
    elszalasztás (miss) gyakori. A két eloszlás (jel-jelen / csak-zaj) átfedése határozza meg
    az alapvető pontosságot, függetlenül a küszöb beállításától.
  signature: "Döntés : (Bizonyíték, Küszöb) -> Választás"
  code: "Döntés bizonyíték küszöb = ha bizonyíték > küszöb akkor EgyikMásikKiválasztás különben MásikKiválasztás"
  related: [KANDEL13-002, KANDEL13-003, KANDEL13-006]
  causes: [KANDEL13-002]
  caused_by: []
  resolves: ["A pontosság és a két hiba típus (téves riasztás / elszalasztás) közötti kompromisszum leírása"]
  tags: [neocortex, "signal-detection", "küszöb", "kritérium"]
```

```yaml
- id: KANDEL13-002
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 56: Decision-Making and Consciousness"
  concept: "A kritérium (küszöb) a döntéshozó irányított szabálya és attitűdje, nem a zajé"
  type: Pattern
  idris_version: 2
  summary: >
    A küszöb egy döntési szabályt valósít meg, amely a probléma ismeretét (a két hiba relatív
    költségét) és a helyes válasz pozitív, illetve a hiba negatív értékelését kódolja. A
    döntéshozót a politikája (küszöbe) miatt dicsérjük vagy kritizáljuk, nem a mérés zajos
    tökéletlensége miatt. Ezt a politikát a döntéshozó irányítja és érte felelősséggel tartozik.
  signature: "KüszöbBeállítás : (HibaKöltség, ÉrtékElvárás) -> Küszöb"
  code: "KüszöbBeállítás = függ a kétHibaRelatívKöltsége és a helyesVálaszÉrtéke"
  related: [KANDEL13-001, KANDEL13-006, KANDEL13-013]
  causes: []
  caused_by: [KANDEL13-001]
  resolves: ["Megkülönbözteti a mérés minőségét (zaj) a döntéshozó stratégiájától (politika)"]
  tags: [neocortex, "kritérium", "politika", "érték-alapú"]
```

```yaml
- id: KANDEL13-003
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 56: Decision-Making and Consciousness"
  concept: "ROC-görbe (receiver operating characteristic): a küszöb változtatása a pontosság függvényében"
  type: Pattern
  idris_version: 2
  summary: >
    A ROC-görbe mutatja, hogyan függ a helyes „igen" (találat) és a téves „igen" (téves riasztás)
    valószínűsége egymástól adott küszöb mellett. A görbe a mérés megbízhatóságáról (a két
    eloszlás szétválásáról) szól, függetlenül a döntéshozó szabályától; a küszöb a döntéshozó
    politikájáról árulkodik.
  signature: "ROC : Küszöb -> (TalálatArány, TévesRiasztásArány)"
  code: "ROC küszöb = (helyesIgenArány küszöb, tévesIgenArány küszöb)"
  related: [KANDEL13-001, KANDEL13-002]
  causes: []
  caused_by: [KANDEL13-001]
  resolves: ["A mérési megbízhatóság és a döntéshozó politika szétválasztása"]
  tags: [neocortex, "signal-detection", "ROC"]
```

```yaml
- id: KANDEL13-004
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 56: Decision-Making and Consciousness"
  concept: "A döntési változó (decision variable) két ellentétes idegsejt-populáció tüzelési sebességének különbségeként"
  type: Definition
  idris_version: 2
  summary: >
    A bizonyítékot a vizuális kéreg irány szelektív idegsejtjeinek (pl. jobbra- és balra-
    prefereáló) tüzelési sebességei közötti különbség reprezentálja. A döntés akkor születik,
    ha ezt a különbséget egy küszöbhöz (itt: zérus) viszonyítjuk: pozitív → jobb, negatív →
    bal. Ez a magas dimenziós szenzoros bizonyíték egyetlen skalárrá való leképezése.
  signature: "DöntésiVáltozó : (JobbPreferálóSebesség, BalPreferálóSebesség) -> Skalár"
  code: "DöntésiVáltozó = jobbPreferálóSebesség - balPreferálóSebesség"
  related: [KANDEL13-005, KANDEL13-006, KANDEL13-008]
  causes: [KANDEL13-006]
  caused_by: [KANDEL13-005]
  resolves: ["A szenzoros bizonyíték egyetlen, küszöbölhető skalárra való redukálása"]
  tags: [neocortex, "döntési-változó", "vetítés", "populáció-kód"]
```

```yaml
- id: KANDEL13-005
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 56: Decision-Making and Consciousness"
  concept: "Az MT terület irány szelektív idegsejtjei szolgáltatják a zajos bizonyíték-mintákat"
  type: Definition
  idris_version: 2
  summary: >
    A magasabb emlősök látókérgében (V1 → MT) az irány szelektív idegsejtek tüzelése zajos:
    bármely próbán a tüzelési sebesség egy eloszlásból vett véletlen húzásnak tekinthető. A 0%
    koherenciájú (tiszta zaj) ingerre is tüzelnek, mert a dinamikus véletlen pontok minden
    irányt tartalmaznak. A jobb- és bal-preferáló populáció válaszai együtt érhetők el, így a
    bizonyíték a két átlag különbségeként jellemezhető.
  signature: "BizonyítékMinta : Inger -> Eloszlás TüzelésiSebesség"
  code: "BizonyítékMinta inger = véletlenHúzás az irányPreferálóSebességEloszlásból"
  related: [KANDEL13-004, KANDEL13-006, KANDEL13-007]
  causes: [KANDEL13-004]
  caused_by: []
  resolves: ["A perceptuális döntés bemeneti (zajos) bizonyítékának neurális forrása"]
  tags: [neocortex, "MT", "zajos-minta", "populáció-kód"]
```

```yaml
- id: KANDEL13-006
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 56: Decision-Making and Consciousness"
  concept: "Korlátos bizonyíték-felhalmozódás (bounded evidence accumulation) és a sebesség–pontosság kompromisszum"
  type: Pattern
  idris_version: 2
  summary: >
    A zajos bizonyíték időben halmozódik fel (két ellentétes irányú, gyengén anticorrelált
    random walk), amíg az egyik felhalmozódás el nem éri a felső megállító határt (küszöb) —
    ekkor születik a válasz. A határok közelebb helyezése gyors, de hibázó döntést ad; távolabb
    helyezése lassú, de pontosabbat. Ez magyarázza a sebesség–pontosság kompromisszumot.
  signature: "Felhalmozás : (KezdetÁllapot, Stream BizonyítékMinta, MegállítóHatár) -> (Állapot, Döntés)"
  code: "Felhalmozás állapot (bizonyíték :: hátralévő) = ha elérteHatárt állapot akkor (állapot, döntés) különben Felhalmozás (állapot + bizonyíték) hátralévő"
  related: [KANDEL13-001, KANDEL13-002, KANDEL13-004, KANDEL13-008, KANDEL13-009]
  causes: [KANDEL13-009]
  caused_by: [KANDEL13-004, KANDEL13-005]
  resolves: ["A döntés időtartamának és a választás pontosságának egységes magyarázata"]
  tags: [neocortex, "catamorfizmus", "kategoriaelmelet", "drift-diffusion", "időzített-megállás"]
```

```yaml
- id: KANDEL13-007
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 56: Decision-Making and Consciousness"
  concept: "A mikrostimuláció (Newsome) ok-okozati kapcsolatot igazol: az MT idegsejtek a bizonyítékot szolgáltatják"
  type: CausalRelation
  idris_version: 2
  summary: >
    Az MT területen egy irány szerint prefereált idegsejt-klaszter gyenge árammal való
    stimulációja (mikrostimuláció) a majom döntését az adott irány felé torzítja, de nem
    okoz látási hallucinációt. A hatás akkor a legnagyobb, ha a mozgás gyenge (nehéz a
    döntés). Ez azt mutatja: ezek az idegsejtek okozati láncban részt vevő bizonyítékot adnak.
  signature: "Mikrostimuláció : (MTKlaszter, Irány) -> DöntésTorzítás"
  code: "Mikrostimuláció klaszter irány = növeliABizonyítékot irány felé (leginkább gyengeJel esetén)"
  related: [KANDEL13-005, KANDEL13-008, KANDEL13-010]
  causes: [KANDEL13-008]
  caused_by: [KANDEL13-005]
  resolves: ["Bizonyítja, hogy az MT idegsejtek ténylegesen használva vannak a döntéshez"]
  tags: [neocortex, "ok-okozat", "mikrostimuláció", "MT", "kauzalitás"]
```

```yaml
- id: KANDEL13-008
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 56: Decision-Making and Consciousness"
  concept: "Csapda: a részleges perturbáció csak a nehéz (alacsony jel-zaj arányú) rezsimben mutat hatást"
  type: Pitfall
  idris_version: 2
  summary: >
    Ha a perturbációt (stimuláció vagy elnémítás) csak a számításban részt vevő idegsejtek
    kis hányadára korlátozzuk, a könnyű feltételek mellett nulla hatást mérünk, és tévesen
    következtetnénk arra, hogy az adott terület nem okozati. Ez a szabály, nem a kivétel a
    magasabb kéregfunkciók vizsgálatában: a hatás csak a kis különbséget jelentő (nehéz)
    rezsimben válik észlelhetővé.
  signature: "PerturbációHatás : (Nehézség, NeuronszámArány) -> Észlelhetőség"
  code: "PerturbációHatás nehézség arány = észlelhető csak ha nehéz(ing) és arányKicsi(idegsejt)"
  related: [KANDEL13-007, KANDEL13-006]
  causes: []
  caused_by: [KANDEL13-007]
  resolves: ["Megmagyarázza, miért tűnhet egy valódi ok-okozati áramkör inaktívnak könnyű feladatoknál"]
  tags: [neocortex, "csapda", "perturbáció", "kísérlettervezés"]
```

```yaml
- id: KANDEL13-009
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 56: Decision-Making and Consciousness"
  concept: "A log-valószínűségi hányados (logLR) felhalmozódása: a szorzás összegzéssé alakítása (monoid-homomorfizmus)"
  type: CausalRelation
  idris_version: 2
  summary: >
    Több forrásból származó bizonyíték egyesítésekor a megfelelő művelet a valószínűségi
    hányadosok szorzata, ami a logaritmus miatt összegre (logLR) vált: log(x·y) = log x + log y.
    Az agy ezeket a logLR-inkrementumokat adja össze, így a statisztikus bizonyíték-egyesítés
    egy additív halmazzá (monoiddá) válik. Ez a felhalmozódás ugyanaz a mechanizmus, mint a
    perceptuális döntésé, csak absztraktabb forrásokkal.
  signature: "LogValószínűségiHányadosHalmaz : CsoportMorphismus (Szorzó, Összegző)"
  code: "logLRÖsszeg = logLR1 + logLR2 + ... ; ahol logLR = log(esélyHányados), és log(x*y) = log x + log y"
  related: [KANDEL13-006, KANDEL13-011, KANDEL13-013]
  causes: [KANDEL13-011]
  caused_by: [KANDEL13-006]
  resolves: ["Több forrású bizonyíték algebrai (additív) egyesítése a szorzás helyett"]
  tags: [neocortex, "kategoriaelmelet", "monoid", "log-valószínűség", "homomorfizmus"]
```

```yaml
- id: KANDEL13-010
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 56: Decision-Making and Consciousness"
  concept: "A parietális (LIP) és prefrontális kéreg idegsejtjei a fejlődő döntési változót reprezentálják (perzisztens, rampoló aktivitás)"
  type: Pattern
  idris_version: 2
  summary: >
    Az MT-től közvetve vagy közvetlenül információt kapó idegsejtek (főleg a oldalsó
    intraparietális terület, LIP, és a prefrontális kéreg) képesek fenntartani és frissíteni a
    tüzelési sebességüket: a bizonyíték halmozódásával rampszerűen nő a tüzelés. A
    megállító küszöb elérésekor a válasz előtt egy közös szintet érnek el. Ez a tartós
    aktivitás a munkamemória és a terv alapja is.
  signature: "DöntésiVáltozóReprezentáció : (BizonyítékFolyam, Idő) -> Ramppont"
  code: "DöntésiVáltozóReprezentáció = alapSzint + (pillanatnyiBizonyítékErőssége * idő), amíg elériAKüszöböt"
  related: [KANDEL13-004, KANDEL13-006, KANDEL13-001]
  causes: [KANDEL13-006]
  caused_by: [KANDEL13-004]
  resolves: ["A felhalmozódást végző és a küszöböt elérő neurális állapot megvalósítása"]
  tags: [neocortex, "LIP", "perzisztens-aktivitás", "munkamemória", "döntési-változó"]
```

```yaml
- id: KANDEL13-011
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 56: Decision-Making and Consciousness"
  concept: "A valószínűségi következtetés (időjárás-jósló feladat) ugyanazt a felhalmozódási mechanizmust használja, mint a perceptuális döntés"
  type: CausalRelation
  idris_version: 2
  summary: >
    Majmokat meg lehet tanítani szimbólumokból (alakokból) álló valószínűségi következtetésre.
    Az LIP idegsejtek ugyanúgy a bizonyíték futó összegét (a logLR-ek szummaját) kódolják,
    mint a mozgási feladatban; a tüzelési sebesség növekménye arányos a szimbólum
    megbízhatóságával. A perceptuális döntés mechanizmusa tehát általánosabb kognitív
    funkciókra is kiterjed.
  signature: "KövetkeztetésFelhalmozás : Stream Szimbólum -> KumuláltLogLR"
  code: "KövetkeztetésFelhalmozás = foldl (+) 0 (térkép logLR szimbólumok)"
  related: [KANDEL13-009, KANDEL13-006, KANDEL13-010]
  causes: []
  caused_by: [KANDEL13-009, KANDEL13-010]
  resolves: ["Bizonyítja a perceptuális döntés mechanizmusának általánosíthatóságát absztrakt forrásokra"]
  tags: [neocortex, "kategoriaelmelet", "probabilisztikus-következtetés", "catamorfizmus"]
```

```yaml
- id: KANDEL13-012
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 56: Decision-Making and Consciousness"
  concept: "Érték-alapú döntések: két tétel értékének különbsége vezérli a választást, mint a perceptuális döntésnél"
  type: Pattern
  idris_version: 2
  summary: >
    Az előnyben részesítés (preferencia) döntései a tételhez rendelt érték különbségén alapulnak,
    akárcsak a bal/jobb mozgásnál az irány szelektív idegsejtek tüzelési különbsége. Az értéket
    kódoló idegsejtek (striatum = cselekvés értéke; orbitofrontális és cinguláris kéreg = tétel
    értéke) zajosak, és a két hasonló értékű tétel közötti választás tovább tart (sebesség–
    következetesség kompromisszum).
  signature: "ÉrtékDöntés : (TételÉrtékA, TételÉrtékB) -> Választás"
  code: "ÉrtékDöntés = ha értékA > értékB akkor VálasztA különben VálasztB"
  related: [KANDEL13-006, KANDEL13-002, KANDEL13-004]
  causes: []
  caused_by: [KANDEL13-004, KANDEL13-002]
  resolves: ["A szubjektív érték és a perceptuális bizonyíték döntési struktúrájának párhuzama"]
  tags: [neocortex, "érték-alapú", "preferencia", "striatum", "zajos-reprezentáció"]
```

```yaml
- id: KANDEL13-013
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 56: Decision-Making and Consciousness"
  concept: "A tudatosság mint a nem-tudatos agy „jelentési" (report) döntése — a provizórikus affordancia keret"
  type: Definition
  idris_version: 2
  summary: >
    A fejezet hipotézise szerint a tudatos tudás akkor születhet meg, ha a nem-tudatos agy
    eljut a döntésre, hogy egy tételt egy másik elmének (vagy önmagának) jelez. A „jelentés"
    is egy provizórikus affordancia — akárcsak a tekintés, a nyúlás vagy a megragadás lehetősége.
    Az ismeretállapot egy próvizórikus elköteleződés egy állítás (propozíció) mellett, nem
    feltétlenül jár cselekvéssel.
  signature: "Tudatosulás : NemTudatosÁllapot -> JelentésiDöntés -> TudatosTudás"
  code: "Tudatosulás = ha elériAKüszöböt(jelentésiSzándék) akkor TudatosTudás különben NemTudatos"
  related: [KANDEL13-001, KANDEL13-002, KANDEL13-006, KANDEL13-014]
  causes: [KANDEL13-014]
  caused_by: [KANDEL13-002, KANDEL13-006]
  resolves: ["A tudatosságot a döntésképzés folyamataként keretezi meg, nem külön „tudat-területként""]
  tags: [neocortex, "tudatosság", "affordancia", "provizórikus-elköteleződés", "elmélet-elme"]
```

```yaml
- id: KANDEL13-014
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 56: Decision-Making and Consciousness"
  concept: "Affordancia (Gibson): a provizórikus elköteleződés egy lehetséges cselekvés (terv) mellett"
  type: Definition
  idris_version: 2
  summary: >
    Gibson szerint az objektumok és környezet tulajdonságai „affordanciákat" (lehetőségeket)
    kínálnak az állat viselkedésére (megragadás, dobás, elrejtés). A döntéskutatás szemszögéből
    az affordancia egy provizórikus elköteleződés egy terv mellett — a cselekvés lehet, hogy
    most vagy soha nem következik be. Az asszociációs kéreg idegsejtjei nem közvetlen
    parancsot adnak, hanem a cselekvés lehetőségét (szándékot) reprezentálják.
  signature: "Affordancia : ObjektumTulajdonság -> LehetségesCselekvés"
  code: "Affordancia objektum = provizórikusElköteleződés (cselekvésLehetősége objektummal)"
  related: [KANDEL13-013, KANDEL13-010, KANDEL13-004]
  causes: [KANDEL13-013]
  caused_by: [KANDEL13-010]
  resolves: ["A tudatos és nem-tudatos ismeretállapotokat cselekvési lehetőségként értelmezi"]
  tags: [neocortex, "affordancia", "Gibson", "provizórikus-elköteleződés", "tudatosság"]
```

```yaml
- id: KANDEL13-015
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 56: Decision-Making and Consciousness"
  concept: "Két anticorrelált felhalmozódás mint a bal/jobb lehetőségek kettős (duális) reprezentációja"
  type: Pattern
  idris_version: 2
  summary: >
    A bal és jobb lehetőség felhalmozódása gyengén anticorrelált: a bizonyíték a bal mellett
    a jobb ellen szól (és fordítva). A két folyamat együtt, de nem tökéletesen tükröződően
    fejlődik, mert a jobb- és bal-preferáló idegsejtek saját zaja további varianciát visz be.
    Egyetlen felhalmozódással is leírható, amely egy felső vagy egy alsó határon áll meg.
  signature: "KettősFelhalmozás : Bizonyíték -> (BalHalmaz, JobbHalmaz)"
  code: "KettősFelhalmozás = (halmoz(záróJobb, biz), halmoz(záróBal, biz)) ; gyengénAnticorrelált"
  related: [KANDEL13-006, KANDEL13-004, KANDEL13-009]
  causes: []
  caused_by: [KANDEL13-004, KANDEL13-006]
  resolves: ["A két választási lehetőség szimmetrikus, mégis korrigált kezelése"]
  tags: [neocortex, "kategoriaelmelet", "duális-reprezentáció", "anticorreláció", "szimmetria"]
```

```yaml
- id: KANDEL13-016
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 56: Decision-Making and Consciousness"
  concept: "Ismeretállapotok perzisztenciája: a tudás a szenzoros aktivitáson túl is fennmarad (temporális vastagság)"
  type: Pattern
  idris_version: 2
  summary: >
    A szenzoros területek csak inger jelenlétében aktivak, de az asszociációs (parietális,
    temporális, prefrontális) területek perzisztens aktivitása időbeli rugalmasságot és
    kitartást nyújt — ez a „jelen temporális vastagsága" (Merleau-Ponty). Az ismeretállapot
    szerkezete megegyezik a döntésével: egy próvizórikus elköteleződés egy lehetséges
    viselkedési almenü valamelyik elemére.
  signature: "IsmeretÁllapot : Észlelés -> PerzisztensReprezentáció"
  code: "IsmeretÁllapot = perzisztensAktivitás (túlél az inger megszűnésén)"
  related: [KANDEL13-010, KANDEL13-013, KANDEL13-014]
  causes: [KANDEL13-013]
  caused_by: [KANDEL13-010]
  resolves: ["Magyarázza, miért marad fenn a tudás a szenzoros bemenet megszűnése után is"]
  tags: [neocortex, "perzisztens-aktivitás", "munkamemória", "tudatosság", "időbeliség"]
```
