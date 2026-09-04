# Kandel – Kivonat (Chunk 15 / Tárgymutató [Index], 1635–1646. oldal)

Forrás: Kandel et al. — *Principles of Neural Science* (6. kiadás), az
index (tárgymutató) szakasza. Ez a chunk nem folytonos próza, hanem
betűrendes bejegyzéslista oldalszámokkal; a bejegyzésekhez csatolt rövid
leíró töredékek (pl. „CPEB as self-perpetuating switch", „Bayesian
inference in") azonban önálló fogalmi egységek, amelyek közvetlenül
kapcsolódnak a neokortex-szerű architektúra építéséhez.

Szabály: az „E8" / „neocortex" / „kategoriaelmelet" címke CSAK akkor
szerepel, ha valódi fogalmi híd van. Ebben a chunkban:
- **neocortex**: valódi híd — a szinapszisos plaszticitás (Hebbiánus,
  STDP), a kérgi oszlopos szerveződés, a laterális gátlás, a tapasztalat-
  függő élesítés és a thalamus-kapu mind közvetlenül modellezhető a
  neokortexben.
- **kategoriaelmelet**: óvatosan adagolt híd — az állapotbecslés
  (Bayes-i következtetés) a szenzoros+motoros jelekből egy hiedelemállapotba
  vezető leképezésként (funktor) értelmezhető; a szinapszis-címkézés és
  -befogás egy nyom-kategória colimit-szerű összevonásaként. Máshol nem
  használtam.
- **E8**: NINCS valódi híd ebben az index-chunkban (nincs olyan bejegyzés,
  amely kombinatorikus gyök-rács párzáshoz vagy belső szorzathoz kapcsolódna
  a korábbi protokadherin/Dscam módon). Ezért egyetlen ConceptNote sem
  kapott E8 címkét.

---

```yaml
id: kandel-index-hebbian-plaszticitas
source: "Kandel et al. — Principles of Neural Science (6th ed.), Index (Synaptic plasticity, Hebbian, 108, 109f)"
concept: Hebbiánus szinapszisos plaszticitás (Hebbian synaptic plasticity)
type: Pattern
idris_version: 2
summary: >
  A közös aktiváció megerősíti a kapcsolatot: azok a neuronok, amelyek
  egyszerre tüzelnek, között kialakul és fennmarad a szinapszis („neurons
  that fire together wire together"). Ez a tanulás és memória sejtszintű
  alapmintája, és közvetlenül megfeleltethető a neokortex tanulható
  kapcsolat-hálózatának.
signature: "hebbianErosit : (pre, post : Neuron) -> EgyuttTuzel pre post -> MegerosodottSzinapszis pre post"
code: |
  -- Ha a pre- és posztszinaptikus neuron együtt tüzel, a szinapszis erősebb lesz.
  adat Szinapszis = Gyenge | EroS
  hebbianErosit : Szinapszis -> Szinapszis
  hebbianErosit Gyenge = EroS
  hebbianErosit EroS   = EroS
related: [kandel-index-stdp, kandel-index-nmda-ltp, kandel-index-szinapszis-kepzodes-aktivitas-fuggo]
causes: [kandel-index-tapasztalat-binokularis-elesites]
caused_by: [kandel-index-nmda-ltp]
resolves: [hogyan-tanul-a-kapcsolat]
tags: [neocortex, learning, hebbian, plasticity]
```

```yaml
id: kandel-index-stdp
source: "Kandel et al. — Principles of Neural Science (6th ed.), Index (Spike-timing-dependent plasticity, 1349)"
concept: A tüzelés-időzítés-függő szinapszisos plaszticitás (Spike-timing-dependent plasticity, STDP)
type: Pattern
idris_version: 2
summary: >
  A szinapszis erőssége a pre- és posztszinaptikus tüzelés időbeli
  sorrendjétől függ: ha a preszinaptikus neuron előbb tüzel, a kapcsolat
  megerősödik (long-term potentiation, LTP); ha utóbb, gyengül (long-term
  depression, LTD). Ez a neokortex időbeli tanulási szabálya.
signature: "stdp : (dt : Idokulonbseg) -> SzinapszisEro -> SzinapszisEro"
code: |
  -- dt = post_tuzeles - pre_tuzeles; negatív dt => erősödés, pozitív => gyengülés.
  stdp : SzinapszisEro -> SzinapszisEro
  stdp e = ha (preElőbbTüzelt) akkor (novel e) kulonben (csokkent e)
related: [kandel-index-hebbian-plaszticitas, kandel-index-nmda-ltp]
causes: [kandel-index-tapasztalat-binokularis-elesites]
caused_by: [kandel-index-szinapszis-integracio]
resolves: [idobeli-sorrend-tanulasa]
tags: [neocortex, stdp, learning, timing]
```

```yaml
id: kandel-index-cpeb-onfenntarto-kapcsolo
source: "Kandel et al. — Principles of Neural Science (6th ed.), Index (Synapse-specific growth, CPEB as self-perpetuating switch of, 1328–1329)"
concept: Szinapszis-specifikus növekedés — a CPEB önmagát fenntartó kapcsolóként
type: Pattern
idris_version: 2
summary: >
  A CPEB fehérje prion-szerű, önmagát fenntartó (self-perpetuating) állapotú
  kapcsolóként rögzíti a szinapszis-specifikus növekedést, így az egyes
  szinapszisok memórianyomai függetlenül, hosszú távon tartósodnak. Ez a
  neokortex tartós, helyi memória-nyomainak biológiai mintája.
signature: "cpebKapcsolo : Szinapszis -> (Allapot, Onfenntarto SzinapszisNovekedes)"
code: |
  -- A CPEB aktív állapota önmagát újratermeli: egyszer be, marad.
  adat CpebAllapot = Inaktiv | Aktiv
  cpebKapcsolo : CpebAllapot -> CpebAllapot
  cpebKapcsolo Aktiv = Aktiv          -- önfénntartó (self-perpetuating)
  cpebKapcsolo Inaktiv = Inaktiv
related: [kandel-index-szinapszis-cimkezes-es-befogas, kandel-index-nmda-ltp]
causes: [kandel-index-hosszu-tavu-szoktatas]
caused_by: [kandel-index-szinapszis-kepzodes-aktivitas-fuggo]
resolves: [hogyan-marad-meg-a-nyom-helyben]
tags: [neocortex, memory, cpeb, self-perpetuating]
```

```yaml
id: kandel-index-allapotbecsles-bayes
source: "Kandel et al. — Principles of Neural Science (6th ed.), Index (State estimation, Bayesian inference in, 720b; observer model of, 722–723)"
concept: Állapotbecslés Bayes-i következtetéssel (State estimation via Bayesian inference)
type: Pattern
idris_version: 2
summary: >
  Az agy az érzékszervi és motoros jelekből Bayes-i következtetéssel becsli
  a test belső állapotát (observer modell). Ez a neokortex prediktív
  kódolásának (predictive coding) elméleti magja: a szenzoros+motoros
  bemenetek egy hiedelemállapotba vezető leképezése funktorként (kategória-
  elméleti híd) értelmezhető.
signature: "allapotBecsles : (SzenzorosJel, MotorosJel) -> BayesiHiedelem Allapot"
code: |
  -- A kétféle jel együtt frissíti a hiedelmet (Bayes-i frissítés).
  allapotBecsles : SzenzorosJel -> MotorosJel -> HiedelemAllapot
  allapotBecsles s m = bayesFrissites (előzőHiedelem) s m
related: [kandel-index-jelfedezes-elmlet, kandel-index-felulrol-lefeleni-motor-es-visszacsatolas]
causes: [kandel-index-allapotfuggo-reflex-fordulas]
caused_by: [kandel-index-szinapszis-integracio]
resolves: [mit-kovetkeztet-ki-a-rendszer-a-bejovo-jelekbol]
tags: [neocortex, kategoriaelmelet, bayesian, state-estimation, predictive-coding]
```

```yaml
id: kandel-index-allapotfuggo-reflex-fordulas
source: "Kandel et al. — Principles of Neural Science (6th ed.), Index (State-dependent reflex reversal, 776)"
concept: Állapot-függő reflex-fordulás (State-dependent reflex reversal)
type: Pattern
idris_version: 2
summary: >
  Ugyanaz a szenzoros bemenet a viselkedési állapottól függően ellentétes
  motoros választ válthat ki (pl. járás közben serkentő, álláskor gátló hatás).
  Egy kontextus-függő leképezés: azonos inger, különböző belső állapot =>
  különböző kimenet.
signature: "reflexFordulas : SzenzorosBemenet -> BelsoAllapot -> MotorosValasz"
code: |
  reflexFordulas : SzenzorosBemenet -> BelsoAllapot -> MotorosValasz
  reflexFordulas b JarasiAllapot  = SerkentoValasz b
  reflexFordulas b AllasAllapot    = GatloValasz b
related: [kandel-index-allapotbecsles-bayes, kandel-index-kozponti-minta-generalo]
causes: []
caused_by: [kandel-index-allapotbecsles-bayes]
resolves: [ugyanaz-a-be menet-mas-valaszt-ad]
tags: [neocortex, reflex, context]
```

```yaml
id: kandel-index-kozponti-minta-generalo
source: "Kandel et al. — Principles of Neural Science (6th ed.), Index (Spinal pattern generators, in locomotion / Central pattern generators (CPGs))"
concept: Központi minta-generáló hálózatok (Central pattern generators, CPG)
type: Pattern
idris_version: 2
summary: >
  A gerincvelői (spinal) hálózatok önmagukban is képesek ritmikus
  mozgásmintákat (járás, úszás) előállítani; a mintát a mozgó végtagokból
  érkező szenzoros visszacsatolás módosítja. A neokortex hasonlóan
  hordozhat ritmikus/ciklusos generátor-modulokat.
signature: "cpg : RitmusFrevencia -> MotorosMinta"
code: |
  -- A generátor mintát ad, a szenzoros visszacsatolás (szabályozó) módosítja.
  cpg : AlapRitmus -> MotorosMinta
  cpg r = ciklikusMinta r
related: [kandel-index-allapotfuggo-reflex-fordulas, kandel-index-felulrol-lefeleni-motor-es-visszacsatolas]
causes: [kandel-index-felulrol-lefeleni-motor-es-visszacsatolas]
caused_by: []
resolves: [hogyan-keletkezik-a-ritmus-a-kering-ben]
tags: [neocortex, cpg, rhythm, motor]
```

```yaml
id: kandel-index-szinapszis-integracio
source: "Kandel et al. — Principles of Neural Science (6th ed.), Index (Synaptic integration, 273–299)"
concept: Gerjesztő és gátló bemenetek integrálása egyetlen kimenetté
type: Pattern
idris_version: 2
summary: >
  A neuron a dendritjein érkező gerjesztő (excitatory) és gátló (inhibitory)
  bemeneteket egyetlen kimenő tüzelésbe integrálja. A térbeli (spatial) és
  időbeli (temporal) összegzés (summation) határozza meg, hogy a kezdeti
  szegmentumban tüzelés indul-e. Ez a neokortex elemi számítási lépése.
signature: "integral : Vect n Bemenet -> KimenetTuzeles"
code: |
  -- Összegezzük a gerjesztést, kivonjuk a gátlást, küszöbhöz hasonlítjuk.
  integral : Lista Bemenet -> Logikai
  integral bs = (osszegGerjeszto bs - osszegGatlo bs) > kuszob
related: [kandel-index-lateralis-gatlas-surround, kandel-index-stdp]
causes: [kandel-index-stdp, kandel-index-allapotfuggo-reflex-fordulas]
caused_by: []
resolves: [hogyan-dont-a-neuron-tuzelesrol]
tags: [neocortex, integration, summation]
```

```yaml
id: kandel-index-lateralis-gatlas-surround
source: "Kandel et al. — Principles of Neural Science (6th ed.), Index (Surround inhibition, 1456–1457; Spatial filtering in retina via lateral inhibition, 524f, 536–537)"
concept: Környezeti (laterális) gátlás és kontrasztszűrés (Surround / lateral inhibition)
type: Pattern
idris_version: 2
summary: >
  A szomszédos neurális aktivitás gátlása (retinában és kérégben) éles
  helyi reprezentációt és kontrasztot hoz létre. Ez a neokortex oszlopos
  feldolgozásának elemi mintája: a kiugró (salient) jel kiemelése a többi
  elnyomásával.
signature: "lateralisGatlas : (AktivNeuron, SzomszedKornyezet) -> KontrasztKimenet"
code: |
  -- A központi aktivitás megmarad, a környező aktivitás csökkenti a kimenetet.
  lateralisGatlas : NeuronAktivitas -> Lista NeuronAktivitas -> NeuronKimenet
  lateralisGatlas kozep szomszedek = kozep - osszeg szomszedek
related: [kandel-index-szinapszis-integracio, kandel-index-oszlopos-szervezodes-koertek]
causes: [kandel-index-oszlopos-szervezodes-koertek]
caused_by: []
resolves: [hogyan-emelkedik-ki-a-kiugro-jel]
tags: [neocortex, inhibition, contrast, lateral]
```

```yaml
id: kandel-index-oszlopos-szervezodes-koertek
source: "Kandel et al. — Principles of Neural Science (6th ed.), Index (Somatosensory cortex/system, barrels, 1125–1126; neural map in somatosensory cortical columns, 454–456)"
concept: Kérgi oszlopos szerveződés és szomatotopikus térkép (Cortical columns / somatotopy)
type: Pattern
idris_version: 2
summary: >
  A szomatoszenzoros kéreg testrészek szerinti térképes elrendezése (pl.
  barrel cortex, oszlopok) a funkcionális modularitás mintája. A neokortex
  architektúrájának központi szervezőelvét (oszlopos modulok) közvetlenül
  adja.
signature: "oszlopTerkep : TestResz -> OszlopModul"
code: |
  -- Minden testrésznek saját oszlopmodulja felel meg (szomatotópia).
  oszlopTerkep : TestResz -> OszlopModul
  oszlopTerkep r = keresOszlop (szomatotopikusTerkep) r
related: [kandel-index-lateralis-gatlas-surround, kandel-index-talamus-kapocs]
causes: []
caused_by: [kandel-index-lateralis-gatlas-surround]
resolves: [hogyan-rendezodik-a-kereg-modularisan]
tags: [neocortex, columns, somatotopy]
```

```yaml
id: kandel-index-kritikus-periodusok
source: "Kandel et al. — Principles of Neural Science (6th ed.), Index (Critical periods / sensitive periods in, 1211; stabilization of synapses in critical period closing, 1223–1224)"
concept: Kritikus és érzékeny periódusok a szinapszis-élesítésben
type: Pattern
idris_version: 2
summary: >
  A tapasztalat-függő szinapszis-élesítés és -megőrzés (stabilizálás)
  korlátozott életkori ablakokban zajlik, az aktivitás-függő kiválasztással.
  A neokortex fejlődésében a plaszticitás időablakai döntik el, mi rögzül.
signature: "kritikusAblak : Eletkor -> LehetsegesElesites -> Logikai"
code: |
  -- Az élesítés csak az ablakon belül hatékony.
  kritikusAblak : Eletkor -> Logikai
  kritikusAblak e = e >= alsoKor && e <= felsoKor
related: [kandel-index-szinapszis-kepzodes-aktivitas-fuggo, kandel-index-tapasztalat-binokularis-elesites]
causes: [kandel-index-tapasztalat-binokularis-elesites]
caused_by: []
resolves: [mikor-ragadhat-meg-a-kapcsolat]
tags: [neocortex, critical-period, development]
```

```yaml
id: kandel-index-szinapszis-kepzodes-aktivitas-fuggo
source: "Kandel et al. — Principles of Neural Science (6th ed.), Index (Synaptic connections, experience in refinement of, 1210–1234; activity-dependent, 1225–1229; formation of, 1104)"
concept: Aktivitás-függő szinapszis-képződés és -eltávolítás (Activity-dependent formation and pruning)
type: CausalRelation
idris_version: 2
summary: >
  A korai neurális aktivitás a szinapszisok túltermelését (overproduction),
  majd az erősítettek megtartását és a gyengékének eltávolítását (pruning)
  irányítja. Ok–okozat: aktivitás -> szelekció -> hálózat finomodása.
signature: "aktivitasFuggoSzelekcio : Halmaz Szinapszis -> Halmaz Szinapszis"
code: |
  -- Megmaradnak a gyakran együtt tüzelők, eltűnnek a gyengék.
  aktivitasFuggoSzelekcio : Lista Szinapszis -> Lista Szinapszis
  aktivitasFuggoSzelekcio ss = szure (gyakranTuzelEgyutt) ss
related: [kandel-index-kritikus-periodusok, kandel-index-hebbian-plaszticitas, kandel-index-hosszu-tavu-szoktatas]
causes: [kandel-index-tapasztalat-binokularis-elesites, kandel-index-hosszu-tavu-szoktatas]
caused_by: []
resolves: [melyik-kapcsolat-marad-meg]
tags: [neocortex, development, pruning]
```

```yaml
id: kandel-index-szinapszis-cimkezes-es-befogas
source: "Kandel et al. — Principles of Neural Science (6th ed.), Index (Synaptic tagging, 1328; Synaptic capture, 1326–1328)"
concept: Szinapszis-címkézés és -befogás (Synaptic tagging and capture)
type: Pattern
idris_version: 2
summary: >
  A gyenge inger csak címkét (tag) helyez el a szinapszisban; az erős inger
  által termelt „foglaló anyag" (capture protein) teszi a gyenge nyomot is
  tartóssá. A memória consolidációja: a különálló nyomok egy közös, tartós
  állapotba vonódnak össze (kategória-elmiében egy colimit-szerű összevonás).
signature: "cimkezesEsBefogas : (GyengeInger, EroInger) -> TartosNyom"
code: |
  -- A címke önmagában nem elég; a befogó anyag teszi tartóssá.
  cimkezesEsBefogas : Cimke -> BefogoAnyag -> TartosNyom
  cimkezesEsBefogas c b = ha (vanBefogo b) akkor Tartos c kulonben Atlmenyi c
related: [kandel-index-cpeb-onfenntarto-kapcsolo, kandel-index-nmda-ltp]
causes: [kandel-index-nmda-ltp]
caused_by: []
resolves: [hogyan-lesz-tartos-a-gyenge-inger-nyoma]
tags: [neocortex, kategoriaelmelet, memory, tagging]
```

```yaml
id: kandel-index-nmda-ltp
source: "Kandel et al. — Principles of Neural Science (6th ed.), Index (Synaptic plasticity, long-term, NMDA receptors and, 284, 286f–287f)"
concept: NMDA-receptor-függő hosszú távú potenciálás (NMDA-dependent LTP)
type: CausalRelation
idris_version: 2
summary: >
  A glutamát NMDA-receptron keresztüli aktivációja Ca²⁺-beáramlást és
  hosszú távú megerősödést (long-term potentiation, LTP) vált ki. Ez az
  explicit memória sejtszintű alapja és a Hebbiánus szabály molekuláris
  megvalósítása.
signature: "nmdaLtp : GlutamatBeerkezes -> CaBearamlas -> SzinapszisEro"
code: |
  -- NMDA nyitása => Ca²⁺ => erősödés.
  nmdaLtp : Glutamat -> SzinapszisEro -> SzinapszisEro
  nmdaLtp g e = ha (nmdaNyitva g) akkor (novel e) kulonben e
related: [kandel-index-hebbian-plaszticitas, kandel-index-cpeb-onfenntarto-kapcsolo, kandel-index-szinapszis-cimkezes-es-befogas]
causes: [kandel-index-hebbian-plaszticitas, kandel-index-szinapszis-cimkezes-es-befogas]
caused_by: []
resolves: [mi-erositi-meg-a-szinapszist-molekularisan]
tags: [neocortex, ltp, nmda, memory]
```

```yaml
id: kandel-index-jelfedezes-elmlet
source: "Kandel et al. — Principles of Neural Science (6th ed.), Index (Signal detection theory, framework of, 1394; for quantification of sensory detection and discrimination, 389b–390b)"
concept: Jelfelderítés-elmélet (Signal detection theory)
type: Definition
idris_version: 2
summary: >
  A megkülönböztetési küszöbök és a zaj statisztikai modellje; a szenzoros
  döntést valószínűségi (Bayes-i) keretbe helyezi. A neokortex észlelési
  döntéseinek kvantitatív alapja.
signature: "jelFelderites : (SerultJel, ZajEloszlas) -> DontesiKulcs"
code: |
  -- A válasz a jel/zaj arány és a küszöb függvénye.
  jelFelderites : Valos -> Valos -> Logikai
  jelFelderites j z = (j / z) > dontesiKulcs
related: [kandel-index-allapotbecsles-bayes]
causes: []
caused_by: [kandel-index-allapotbecsles-bayes]
resolves: [hogyan-kulomböztetjuk-meg-a-jelet-a-zajtol]
tags: [neocortex, bayesian, signal-detection]
```

```yaml
id: kandel-index-sebesseg-pontossag-kompromisszum
source: "Kandel et al. — Principles of Neural Science (6th ed.), Index (Speed–accuracy trade-off, 727–728)"
concept: Sebesség–pontosság kompromisszum (Speed–accuracy trade-off)
type: Pattern
idris_version: 2
summary: >
  A gyorsabb válasz pontatlanabbá, a pontosabb válasz lassabbá teszi a
  döntést. Ez a hatékonysági korlát a mozgás- és döntéskontrollban a
  neokortex erőforrás-elosztásának alapvető tulajdonsága.
signature: "sebessegPontossag : Valasztas -> (Sebesseg, Pontossag)"
code: |
  -- Minél gyorsabb, annál kevésbé pontos (inverz kapcsolat).
  sebessegPontossag : Valasztas -> (Sebesseg, Pontossag)
  sebessegPontossag v = (sebesseg v, inverz (sebesseg v))
related: [kandel-index-allapotbecsles-bayes]
causes: []
caused_by: []
resolves: [miert-nem-lehet-gyors-es-pontos-egyszerre]
tags: [neocortex, decision, tradeoff]
```

```yaml
id: kandel-index-talamus-kapocs
source: "Kandel et al. — Principles of Neural Science (6th ed.), Index (Thalamus as link between sensory receptors and cerebral cortex, 82–84)"
concept: A thalamus kapcsolóállomásként a receptorok és a kéreg között
type: Pattern
idris_version: 2
summary: >
  A thalamus a perifériás receptorok és az agykéreg közötti kapcsoló- és
  továbbító állomás, a szenzoros információ kéregbe jutásának kapuja. A
  neokortex architektúrájában ez a bemeneti kapu (gating) modul.
signature: "talamusKapu : SzenzorosBeemenet -> KergeiBeemenet"
code: |
  -- A thalamus továbbítja (vagy szűri) a bejövő jelet a kéreg felé.
  talamusKapu : SzenzorosBeemenet -> Opcionalis KergeiBeemenet
  talamusKapu s = ha (atenged s) akkor (Van s) kulonben Nincs
related: [kandel-index-oszlopos-szervezodes-koertek]
causes: [kandel-index-oszlopos-szervezodes-koertek]
caused_by: []
resolves: [hogyan-jut-be-a-jel-a-kerigbe]
tags: [neocortex, thalamus, sensory-gate]
```

```yaml
id: kandel-index-tapasztalat-binokularis-elesites
source: "Kandel et al. — Principles of Neural Science (6th ed.), Index (formation of synaptic connections, in binocular circuits, 1212–1213; experience in refinement of, 1210–1234)"
concept: Tapasztalat-függő élesítés a binokuláris kérgi körökben
type: CausalRelation
idris_version: 2
summary: >
  A kétoldali látási tapasztalat az aktivitás-függő élesítéssel alakítja a
  binokuláris körkörös kapcsolatokat. Ez a neokortex tapasztalat-függő
  plaszticitásának legtisztább modellje (látás, sztereopszis).
signature: "tapasztalatElesites : LatasiTapasztalat -> BinokularisHalozat -> FinomHalozat"
code: |
  -- A közös látási minta megtartja a kompatibilis kapcsolatokat.
  tapasztalatElesites : LatasiTapasztalat -> Halmaz Szinapszis -> Halmaz Szinapszis
  tapasztalatElesites t ss = szure (kompatibilis t) ss
related: [kandel-index-kritikus-periodusok, kandel-index-hebbian-plaszticitas]
causes: []
caused_by: [kandel-index-kritikus-periodusok, kandel-index-szinapszis-kepzodes-aktivitas-fuggo]
resolves: [hogyan-formalja-a-latas-a-kapcsolatokat]
tags: [neocortex, binocular, plasticity]
```

```yaml
id: kandel-index-hosszu-tavu-szoktatas
source: "Kandel et al. — Principles of Neural Science (6th ed.), Index (Synaptic pruning in long-term habituation, 1324)"
concept: Szinapszis-vesztés a hosszú távú megszokásban (Habituation pruning)
type: Pattern
idris_version: 2
summary: >
  Az ismételt, ártalmatlan ingerre adott válasz csökkenése szinapszis-vesztéssel
  (pruning) és a szinaptikus hatékonyság csökkenésével jár. A neokortex a
  felesleges, nem erősített kapcsolatokat eltávolítja.
signature: "megszokas : IsmeteltInger -> SzinapszisEro -> SzinapszisEro"
code: |
  -- Minél gyakrabban ártalmatlan, annál gyengébb a válasz.
  megszokas : Nat -> SzinapszisEro -> SzinapszisEro
  megszokas n e = csokkent (n -szor) e
related: [kandel-index-szinapszis-kepzodes-aktivitas-fuggo]
causes: []
caused_by: [kandel-index-szinapszis-kepzodes-aktivitas-fuggo]
resolves: [miert-gyengul-a-valasz-ismetlesre]
tags: [neocortex, habituation, pruning]
```

```yaml
id: kandel-index-statisztikai-tanulas
source: "Kandel et al. — Principles of Neural Science (6th ed.), Index (Statistical learning, 1303–1304)"
concept: Statisztikai tanulás (Statistical learning)
type: Pattern
idris_version: 2
summary: >
  A rendszer a bemeneti statisztikai szerkezetből (pl. szóhatárok, szabályok)
  tanul anélkül, hogy explicit visszajelzést kapna. A nyelvi és motoros
  tanulás, valamint a neokortex mintázat-felismerésének alapja.
signature: "statisztikaiTanulas : BemenetiSorozat -> TanultSzabaly"
code: |
  -- A gyakori együttállásokból szabály válik.
  statisztikaiTanulas : Lista Esemeny -> Halmaz Szabaly
  statisztikaiTanulas es = gyakoriEgyutallások es
related: [kandel-index-szinapszis-kepzodes-aktivitas-fuggo, kandel-index-tapasztalat-binokularis-elesites]
causes: []
caused_by: []
resolves: [hogyan-tanul-mintazatot-viszszajelzes-nelkul]
tags: [neocortex, statistical-learning]
```

```yaml
id: kandel-index-felulrol-lefeleni-motor-es-visszacsatolas
source: "Kandel et al. — Principles of Neural Science (6th ed.), Index (sensory feedback and descending motor commands for, 773–778; State estimation, sensory and motor signals in, 719–723)"
concept: Lemondó motoros parancsok és szenzoros visszacsatolás együttes feldolgozása
type: Pattern
idris_version: 2
summary: >
  A gerincvelői motoros irányítás a lefelé tartó (descending) parancsok és a
  felfelé tartó (ascending) szenzoros visszacsatolás együttesét dolgozza fel
  az állapotbecslés (state estimation) keretében. A neokortex motoros és
  szenzoros pályáinak zárt hurka.
signature: "motorEsVisszacsatolas : (LemondoParancs, SzenzorosVisszacsatolas) -> Allapot"
code: |
  -- A kettő együtt adja a frissített belső állapotot.
  motorEsVisszacsatolas : LemondoParancs -> SzenzorosVisszacsatolas -> Allapot
  motorEsVisszacsatolas p v = allapotFrissites p v
related: [kandel-index-allapotbecsles-bayes, kandel-index-kozponti-minta-generalo]
causes: [kandel-index-allapotbecsles-bayes]
caused_by: [kandel-index-kozponti-minta-generalo]
resolves: [hogyan-zarodik-a-motor-szenzoros-hurk]
tags: [neocortex, motor-control, feedback]
```
