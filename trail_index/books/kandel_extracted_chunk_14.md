# Kandel — Principles of Neural Science (6th ed.) — Kinyerés / Extraction
# Forrás chunk: kandel_chunk_14.txt (Chapter 61: Disorders of Mood and Anxiety, oldalak 1515–1521)
# Séma: book_processor.md ConceptNote YAML.
# Minden azonosító magyar (AGENTS.md §0), rövidítés nincs. Idris 2 aláírások.
# A "neocortex" / "E8" / "kategoriaelmelet" címkék csak valódi fogalmi hídnál kerülnek fel.

---

## Fogalomjegyzetek / ConceptNotes

```yaml
- id: KANDEL14-001
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 61: Disorders of Mood and Anxiety"
  concept: "Szelektív szerotonin-visszavétel-gátlók (Selective Serotonin Reuptake Inhibitors, SSRI)"
  type: Definition
  idris_version: 2
  summary: >
    A fluoxetin, szerteralin és paroxetin típusú szerek szelektíven gátolják a
    SERT (szerotonin-transzporter) fehérjét. Hatásosságuk nem nagyobb a régebbi
    triciklikus és MAO-gátló szereknél, de enyhébb mellékhatásaik és túladagolás
    esetén nagyobb biztonságuk miatt széles körben használatosak.
  signature: "SzelektívSzerotoninVisszavételGátló : GátlóSzer"
  code: "SzelektívSzerotoninVisszavételGátló = Fluoxetin + Szerteralin + Paroxetin"
  related: [KANDEL14-002, KANDEL14-003, KANDEL14-010]
  causes: [KANDEL14-011]
  caused_by: []
  resolves: ["Major depresszió és számos szorongásos zavar tüneteinek enyhítése"]
  tags: [neocortex, "szerotonerg-rendszer", "szinaptikus-átvitel"]
```

```yaml
- id: KANDEL14-002
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 61: Disorders of Mood and Anxiety"
  concept: "Szerotonerg és noradrenerg szinaptikus gyógyszercélpontok (Figure 61–7)"
  type: Pattern
  idris_version: 2
  summary: >
    Az antidepresszánsok hatása a szerotonerg és noradrenerg szinapszis hat
    lépésére osztható: (1) enzimaktikus szintézis, (2) hólyagos tárolás,
    (3) preszinaptikus receptorok negatív visszacsatolása, (4) posztszinaptikus
    receptorok, (5) visszavétel (uptake), (6) lebontás (degradáció, MAO).
    A szerotonin- és noradrenalin-transzporter valamint a MAO az antidepresszánsok
    elsődleges célpontja.
  signature: "GyógyszerCélpontok : (SzerotonergSzinapszis, NoradrenergSzinapszis) -> HatásHely"
  code: "GyógyszerCélpontok = [Szintézis, Tárolás, PreszinaptikusReceptor, PosztszinaptikusReceptor, Visszavétel, Lebontás]"
  related: [KANDEL14-001, KANDEL14-003, KANDEL14-009]
  causes: [KANDEL14-010]
  caused_by: []
  resolves: ["A monoaminerg átvitel szabályozása több, független ponton"]
  tags: [neocortex, "szinaptikus-átvitel", "gyógyszer-célpont", "moduláris-architektúra"]
```

```yaml
- id: KANDEL14-003
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 61: Disorders of Mood and Anxiety"
  concept: "Veszikuláris monoamin-transzporter (VMAT2) gátlása rezerpinnel"
  type: CausalRelation
  idris_version: 2
  summary: >
    A rezerpin és tetrabenazin blokkolja a VMAT2-t, megakadályozva a szerotonin,
    a katekolaminok és a dopamin szinaptikus hólyagokba jutását. A citoplazmában
    maradt ingerületátvivő anyag lebomlik, így a neuron kimerül az
    ingerületátvivő anyagból. A rezerpin gyakran okozott depressziót
    mellékhatásként.
  signature: "VMAT2Gátlás : (Rezerpin, Tetrabenazin) -> NeurotranszmitterKimerülés"
  code: "VMAT2Gátlás = BlokkoltHólyagTárolás => CitoplazmatikusLebomlás => Kimerülés"
  related: [KANDEL14-002, KANDEL14-011]
  causes: [KANDEL14-011]
  caused_by: [KANDEL14-002]
  resolves: ["Antihipertóniás hatás, de depressziós mellékhatással"]
  tags: [neocortex, "szinaptikus-tárolás", "visszacsatolás"]
```

```yaml
- id: KANDEL14-004
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 61: Disorders of Mood and Anxiety"
  concept: "Terápiás hatás késleltetése (delay of therapeutic effect)"
  type: CausalRelation
  idris_version: 2
  summary: >
    Bár az antidepresszánsok az első adaggal kötődnek és gátolják a MAO-t,
    a NET-et vagy a SERT-et, a depresszív tünetek enyhülése általában csak
    hetekig tartó kezelés után észlelhető. Ez a késleltetés a legfőbb akadálya
    a gyógyszerek hatásmechanizmusának megértésének.
  signature: "TerápiásKésleltetés : (GyógyszerKötés, Idő) -> TünetEnyhülés"
  code: "TerápiásKésleltetés = GyorsCélpontKötés => LassúKlinikaiVálasz"
  related: [KANDEL14-005, KANDEL14-006, KANDEL14-007]
  causes: []
  caused_by: [KANDEL14-005, KANDEL14-006, KANDEL14-007]
  resolves: []
  tags: [neocortex, "szinaptikus-plaszticitás", "időzítés"]
```

```yaml
- id: KANDEL14-005
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 61: Disorders of Mood and Anxiety"
  concept: "Hipotézis 1: újonnan szintetizált fehérjék lassú felhalmozódása"
  type: Pattern
  idris_version: 2
  summary: >
    Az egyik magyarázat szerint a gyorsan felhalmozódó, újonnan szintetizált
    fehérjék lassú felépülése megváltoztatja az idegsejtek válaszkészségét
    oly módon, amely kezeli a depressziót. Ez a "lassú sejtszintű
    újraprogramozás" mintázat a neokortex tanulási mechanizmusainak
    analógja lehet.
  signature: "FehérjeFelhalmozódás : (Szintézis, Idő) -> NeuronVálaszkészség"
  code: "FehérjeFelhalmozódás = LassúÚjraszintézis => MegváltozottVálasz"
  related: [KANDEL14-004, KANDEL14-006]
  causes: [KANDEL14-004]
  caused_by: []
  resolves: ["A terápiás késleltetés egy lehetséges oka"]
  tags: [neocortex, "szinaptikus-plaszticitás", "tanulás"]
```

```yaml
- id: KANDEL14-006
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 61: Disorders of Mood and Anxiety"
  concept: "Hipotézis 2: szinaptikus súlyok új tapasztalatok általi módosítása"
  type: CausalRelation
  idris_version: 2
  summary: >
    A szerotonin vagy noradrenalin szinaptikus átvitelének gyors emelkedése
    gyorsan növeli a plaszticitást különböző érzelem-feldolgozó áramkörökben;
    a terápiás haszon késése azon az időn múlik, amelyre az új tapasztalatoknak
    szükségük van a szinaptikus súlyok megváltoztatásához. Ez közvetlenül
    kapcsolódik a neokortex súly-alapú tanulási paradigmájához.
  signature: "SzinaptikusSúlyMódosítás : (EmelkedettÁtvitel, ÚjTapasztalat) -> TerápiásHaszon"
  code: "SzinaptikusSúlyMódosítás = PlaszticitásNövekedés => IdőigényesSúlyVáltozás"
  related: [KANDEL14-004, KANDEL14-005, KANDEL14-007]
  causes: [KANDEL14-004]
  caused_by: []
  resolves: ["A terápiás késleltetés egy lehetséges oka (tapasztalat-függő tanulás)"]
  tags: [neocortex, "szinaptikus-plaszticitás", "súly-alapú-tanulás", "tanulás"]
```

```yaml
- id: KANDEL14-007
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 61: Disorders of Mood and Anxiety"
  concept: "Hipotézis 3: hipokampális neurogenezis serkentése"
  type: CausalRelation
  idris_version: 2
  summary: >
    Egy harmadik feltevés szerint az antidepreszáns hatékonyságát részben a
    hipokampális neurogenezis fokozódása közvetíti. Mivel a felnőttkori
    hipokampális neurogenezis a memória és a hangulatszabályozás összekapcsolását
    jelenti, ez a befogadó (hippokampális) és a kéregrendszeri szabályozás
    közti kapcsolatra utal.
  signature: "NeurogenezisSerkentés : (Antidepresszáns) -> HipokampálisPlaszticitás"
  code: "NeurogenezisSerkentés = GyógyszerHatás => ÚjNeuronKépződés => HangulatSzabályozás"
  related: [KANDEL14-004, KANDEL14-006]
  causes: [KANDEL14-004]
  caused_by: []
  resolves: ["A terápiás késleltetés egy lehetséges oka (strukturális átalakulás)"]
  tags: [neocortex, "neurogenezis", "hipokampusz", "memória"]
```

```yaml
- id: KANDEL14-008
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 61: Disorders of Mood and Anxiety"
  concept: "Ketamin: gyors hatású NMDA-glutamát-receptor-blokkoló antidepresszáns"
  type: Definition
  idris_version: 2
  summary: >
    A ketamin, amely blokkolja az N-metil-D-aszpartát (NMDA) glutamát-receptort,
    intravénás infúzióval 2 órán belül antidepresszáns hatást fejt ki,
    szemben a hetekig tartó hagyományos szerekkel. A hatás kb. 7 napig tart.
    Ez az első olyan antidepresszáns, amelynek elsődleges hatása nem a
    monoaminerg ingerületátvitelen alapul.
  signature: "Ketamin : NMDAReceptorBlokkoló"
  code: "Ketamin = NMDA blokkolás => GyorsAntidepresszánsHatás (2 óra, 7 napig)"
  related: [KANDEL14-009, KANDEL14-010, KANDEL14-011]
  causes: [KANDEL14-010]
  caused_by: []
  resolves: ["Akutan öngyilkos betegek gyors kezelése (elméleti előny)"]
  tags: [neocortex, "glutamáterg-rendszer", "szinaptikus-plaszticitás", "gyors-tanulás"]
```

```yaml
- id: KANDEL14-009
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 61: Disorders of Mood and Anxiety"
  concept: "NMDA-receptor-blokkolás mint szinaptikus plaszticitás-kapu"
  type: Pattern
  idris_version: 2
  summary: >
    Mivel a ketamin az NMDA (glutamát) receptoron hat, és a gyors antidepresszáns
    hatás nem monoaminerg úton jön létre, a szer a glutamáterg plaszticitás
    (például a hosszú távú potenciálás, LTP) közvetlen módosítójaként értelmezhető.
    Ez a neokortex-szerű architektúrában a "tanulási sebesség" modulálhatóságát
    demonstrálja egyetlen receptoros kapu által.
  signature: "NMDABlokkPlaszticitás : (Ketamin) -> MódosultGlutamátergPlaszticitás"
  code: "NMDABlokkPlaszticitás = ReceptorZárás => GyorsSúlyÚjrakonfiguráció"
  related: [KANDEL14-008, KANDEL14-006]
  causes: [KANDEL14-010]
  caused_by: [KANDEL14-008]
  resolves: ["A monoamin-rendszertől független, gyors plasztikus átállás"]
  tags: [neocortex, "glutamáterg-rendszer", "LTP", "szinaptikus-plaszticitás"]
```

```yaml
- id: KANDEL14-010
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 61: Disorders of Mood and Anxiety"
  concept: "Szinapszisban maradó ingerületátvivő koncentráció növekedése visszavétel-gátlással"
  type: CausalRelation
  idris_version: 2
  summary: >
    A szelektív visszavétel-gátlók (például fluoxetin a szerotonin-, reboxetin a
    noradrenalin-transzporterre) növelik a szinaptikus ingerületátvivő
    koncentrációját azáltal, hogy megakadályozzák az újrafelvételt. Ez a
    lokális koncentráció-emelkedés a további plasztikus válasz (KANDEL14-006)
    előfeltétele.
  signature: "VisszavételGátlás : (TranszporterBlokk, Felszabadulás) -> EmelkedettSzinaptikusKoncentráció"
  code: "VisszavételGátlás = BlokkoltUptake => MegnövekedettSzinaptikusSzerotonin"
  related: [KANDEL14-001, KANDEL14-002, KANDEL14-008]
  causes: [KANDEL14-006, KANDEL14-011]
  caused_by: [KANDEL14-001, KANDEL14-002]
  resolves: ["A monoaminerg átvitel helyi felerősítése"]
  tags: [neocortex, "szinaptikus-átvitel", "visszacsatolás"]
```

```yaml
- id: KANDEL14-011
  concept: "Hipokampális–kérgi szabályozás a hangulatban: a rostralis anterior (subgenualis) cinguláris kéreg"
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 61: Disorders of Mood and Anxiety"
  type: CausalRelation
  idris_version: 2
  summary: >
    A szomorúság aktiválja a rostralis anterior (subgenualis) cinguláris kérget
    (Brodmann 25 terület, Cg25). Mélyagyi ingerléssel (DBS) kezelt, terápiarezisztens
    depresszióban a Cg25 aktivitása csökken a pozitívan reagáló betegeknél. Ez
    a kéregrégió a hangulatszabályozó hálózat egy megcélozható csomópontja.
  signature: "CingulárisSzabályozás : (Cg25Aktivitás) -> HangulatÁllapot"
  code: "CingulárisSzabályozás = MagasCg25Aktivitás => Depresszió; DBS => AlacsonyCg25 => Javulás"
  related: [KANDEL14-012, KANDEL14-003]
  causes: []
  caused_by: [KANDEL14-003]
  resolves: ["Terápiarezisztens depresszió célozható beavatkozása"]
  tags: [neocortex, "kérgi-hálózat", "mélyagyi-ingerlés", "hangulat"]
```

```yaml
- id: KANDEL14-012
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 61: Disorders of Mood and Anxiety"
  concept: "Kioltási tanulás (extinction learning) a prefrontális kéreg és hipokampusz révén"
  type: CausalRelation
  idris_version: 2
  summary: >
    Az expozíciós terápia állatkísérletes analógiában kioltási tanulást idéz elő:
    a fóbiás inger emléke nem törlődik, de a félelmi válasz egy új információval
    elnyomódik (az inger és kontextusa nem veszélyes). A prefrontális kéreg
    szükséges a kioltási tanuláshoz, a hipokampusz az új kontextusok tanulásához.
    Ez a neokortex-függő, kontextus-érzékeny újraírási minta.
  signature: "KioltásiTanulás : (PrefrontálisKéreg, Hipokampusz, ÚjKontextus) -> ElfojtottFélelem"
  code: "KioltásiTanulás = Expozíció + BiztonságosKontextus => ÚjAsszociáció (régi nem törlődik)"
  related: [KANDEL14-013, KANDEL14-011, KANDEL14-007]
  causes: []
  caused_by: []
  resolves: ["Fóbiák és PTSD kezelése új asszociáció beírásával a régi helyett"]
  tags: [neocortex, "kioltási-tanulás", "hipokampusz", "prefrontális-kéreg", "memória"]
```

```yaml
- id: KANDEL14-013
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 61: Disorders of Mood and Anxiety"
  concept: "Kognitív viselkedésterápia: automatikus negatív gondolatok korrekciója"
  type: Pattern
  idris_version: 2
  summary: >
    A kognitív terápiák a depressziósok túlzott negatív figyelmi torzítását
    (automatikus negatív interpretáció, semleges események negatívként értelmezése)
    célozzák. Az ilyen automatikus negatív gondolkodás, amely elindíthatja vagy
    fenntarthatja a levert hangulatot, kognitív pszichoterápiával javítható.
    Ez a "figyelmi torzítás" mint a kérgi feldolgozás hibás súlyozása értelmezhető.
  signature: "KognitívKorrekció : (NegatívFigyelmiTorzítás) -> MódosultInterpretáció"
  code: "KognitívKorrekció = Azonosítás + Újraértelmezés => CsökkentettNegatívTorzítás"
  related: [KANDEL14-012, KANDEL14-006]
  causes: []
  caused_by: []
  resolves: ["Depresszív hangulatot fenntartó automatikus negatív gondolkodás javítása"]
  tags: [neocortex, "figyelmi-torzítás", "kérgi-feldolgozás", "tanulás"]
```

```yaml
- id: KANDEL14-014
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 61: Disorders of Mood and Anxiety"
  concept: "Elektrokonvulzív terápia (ECT) és a nagyfokú ingerületátvivő-felszabadulás"
  type: CausalRelation
  idris_version: 2
  summary: >
    Modern érzéstelenítésben alkalmazott ECT orvosilag biztonságos, hatékony
    akut major depresszió ellen. Rágcsálókban az ECT hatalmas ingerületátvivő-
    felszabadulást vált ki, ami jelentős génexpressziós aktivációt és feltételezhetően
    nagyléptékű idegi plaszticitást okoz. A pontos molekuláris út ismeretlen marad.
  signature: "ECTPlaszticitás : (GeneralizáltRovancs, IngerületÁtvivőKiáramlás) -> GénAktiváció"
  code: "ECTPlaszticitás = Rovancs + Felszabadulás => GénExpresszió => NagyléptékűPlaszticitás"
  related: [KANDEL14-006, KANDEL14-011]
  causes: []
  caused_by: []
  resolves: ["Gyógyszer-rezisztens major depresszió akut kezelése"]
  tags: [neocortex, "szinaptikus-plaszticitás", "gén-aktiváció", "neuromoduláció"]
```

```yaml
- id: KANDEL14-015
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 61: Disorders of Mood and Anxiety"
  concept: "Transzkraniális mágneses ingerlés (TMS) mint nem invazív neuromoduláció"
  type: Pattern
  idris_version: 2
  summary: >
    A TMS rövid, gyorsan váltakozó mágneses impulzusokat juttat az agykéreg alatti
    axonokba, ott áramot indukálva. A bal prefrontális kéreg napi ingerlése biztonságos
    és FDA-jóváhagyással rendelkezik, bár későbbi vizsgálatokban csak mérsékelt
    hatékonyságú. A minta: külső, célzott mezővel a kérgi aktivitás módosítása.
  signature: "TMSModuláció : (MágnesesImpulzus, PrefrontálisKéreg) -> MódosultKérgiÁram"
  code: "TMSModuláció = SkalpviteliImpulzus => AxonálisÁram => KérgiÁtállás"
  related: [KANDEL14-011, KANDEL14-016, KANDEL14-014]
  causes: []
  caused_by: []
  resolves: ["Nem invazív depresszió-kezelés a prefrontális kéreg célzásával"]
  tags: [neocortex, "neuromoduláció", "prefrontális-kéreg", "TMS"]
```

```yaml
- id: KANDEL14-016
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 61: Disorders of Mood and Anxiety"
  concept: "Mélyagyi ingerlés (DBS) olvasó-író elektródákkal a hálózati megértéshez"
  type: Pattern
  idris_version: 2
  summary: >
    A DBS invazív neuromoduláció: elektróda (például a subgenualis cinguláris
    kéregben, Cg25) ingerli a célpontot, a külső vezérlő a stimulációs rátát
    szabályozza. Új, kutatási "olvasó-író" elektródák nemcsak stimulálnak, hanem
    rögzítik az extracelluláris neuronális aktivitást is, ezzel előrevihetik a
    körzavar (circuit dysfunction) és terápiás moduláció megértését.
  signature: "DBSOlvasóÍró : (Elektróda, Célpont) -> (Stimuláció + Rögzítés)"
  code: "DBSOlvasóÍró = Stimuláció + NeuronálisRögzítés => KörFunkcióMegértés"
  related: [KANDEL14-011, KANDEL14-015, KANDEL14-012]
  causes: []
  caused_by: []
  resolves: ["Hangulatszabályozó áramkörök megismerése és célzott modulációja"]
  tags: [neocortex, "mélyagyi-ingerlés", "neuromoduláció", "olvasó-író", "kérgi-hálózat"]
```

```yaml
- id: KANDEL14-017
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 61: Disorders of Mood and Anxiety"
  concept: "Lítium mint hangulatstabilizátor: GSK3β (glikogén-szintáz-kináz 3 béta) gátlása"
  type: CausalRelation
  idris_version: 2
  summary: >
    A lítium a bipoláris zavar akut mánia és a hangulatciklus-stabilizálására
    hatékony. Legtöbb valószínűsíthető molekuláris célpontja a glikogén-szintáz-
    kináz 3β (GSK3β) gátlása, a Wnt jelátviteli út egyik komponense, amelynek
    számos funkciója van az idegrendszerben. A hangulatstabilizátorok a
    hangulatszabályozó rendszerek dinamikáját csillapítják.
  signature: "LítiumHatás : (GSK3βGátlás) -> HangulatciklusCsillapítás"
  code: "LítiumHatás = GSK3βGátlás (Wnt út) => CsökkentettMánia / StabilizáltHangulat"
  related: [KANDEL14-018, KANDEL14-011]
  causes: []
  caused_by: []
  resolves: ["Bipoláris zavar mánia és ciklizálás kezelése"]
  tags: [neocortex, "Wnt-jelátvitel", "hangulatstabilizálás", "kináz"]
```

```yaml
- id: KANDEL14-018
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 61: Disorders of Mood and Anxiety"
  concept: "Hangulat komplex dinamikus integrációja (környezet + belső bemenetek)"
  type: Pattern
  idris_version: 2
  summary: >
    A hangulatot a külső környezet és több belső bemenet (hormonális miliő,
    immunmodulátorok, cirkadián szabályozás) együttese szabályozza. A
    szerotonerg és noradrenerg rendszerek is mutatnak a cirkadián (alvás-ébrenlét)
    ciklushoz szorosan kapcsolódó napi ingadozást. Az integráció dinamikus
    kölcsönhatásokból áll, amelyek még kevéssé értettek — egy több-bemenetű,
    több-időskálájú szabályozó hálózat, amely a neokortex szintű integráció
    analógja.
  signature: "HangulatIntegráció : (Környezet, Hormon, Immunológia, Cirkadián) -> HangulatÁllapot"
  code: "HangulatIntegráció = DinamikusÖsszekapcsolás (több bemenet, több időskála)"
  related: [KANDEL14-017, KANDEL14-011, KANDEL14-006]
  causes: []
  caused_by: []
  resolves: ["A hangulatszabályozás több-rétegű bemeneti architektúrájának leírása"]
  tags: [neocortex, "több-bemenetű-integráció", "dinamikus-hálózat", "cirkadián"]
```

```yaml
- id: KANDEL14-019
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 61: Disorders of Mood and Anxiety"
  concept: "Másodgenerációs antipszichotikumok: D2 + 5-HT2A receptorblokád"
  type: Pattern
  idris_version: 2
  summary: >
    Valamennyi antipszichotikum a D2 dopamin-receptor blokkolásával hat, de a
    másodgenerációs szerek alacsonyabb affinitással kötődnek a D2-höz, és
    emellett szerotonin 5-HT2A receptorokat is blokkolnak, így kevésbé okoznak
    súlyos motoros mellékhatásokat. A bipoláris zavar és az akut mánia kezelésére
    is használatosak.
  signature: "MásodgenerációsAntipszichotikum : (D2Blokád, Szerotonin5HT2ABlokád)"
  code: "MásodgenerációsAntipszichotikum = D2Gátlás + 5HT2AGátlás => KisebbMotorosMellékhatás"
  related: [KANDEL14-001, KANDEL14-017]
  causes: []
  caused_by: []
  resolves: ["Bipoláris zavar és akut mánia kezelése csökkentett motoros kockázattal"]
  tags: [neocortex, "dopaminerg-rendszer", "szerotonerg-rendszer", "receptorblokád"]
```

```yaml
- id: KANDEL14-020
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 61: Disorders of Mood and Anxiety"
  concept: "Félelem és szorongás idegi áramköre: amigdala és prefrontális kéreg összeköttetései"
  type: Definition
  idris_version: 2
  summary: >
    A félelem és szorongás zavarainak idegi áramköre az amigdalát és annak a
    prefrontális kéreggel való összeköttetéseit foglalja magában. A major
    depresszió és a bipoláris zavar áramköre kevésbé ismert, de emberi
    neuroképi vizsgálatok az érzelmi jelentőség (salience) feldolgozásában és a
    kognitív kontrollban érintett köröket azonosítottak.
  signature: "FélelemÁramkör : (Amigdala, PrefrontálisKéreg) -> SzorongásVálasz"
  code: "FélelemÁramkör = Amigdala <-> PrefrontálisKéreg (top-down kontroll)"
  related: [KANDEL14-012, KANDEL14-013, KANDEL14-016]
  causes: []
  caused_by: []
  resolves: ["A szorongásos zavarok célozható hálózati leírása"]
  tags: [neocortex, "amigdala", "prefrontális-kéreg", "kérgi-hálózat", "félelem"]
```
