# Kandel – Kivonat (Chunk 11 / 46–47. fejezet: Idegsejtek differenciálódása és az axonok növekedése és irányítása)

Forrás: Kandel et al. — *Principles of Neural Science* (6. kiadás), 46. fejezet
(Differentiation and Survival of Nerve Cells) és 47. fejezet (The Growth and
Guidance of Axons). A chunk az axon–dendrit polarizáció, a növekedési kúp
(growth cone) szenzoros–motoros működése, valamint az axonok molekuláris
irányítása (kemoattraktáns/kemorepellens, ephrin, netrin, szemaphorin,
protokadherin, Dscam) mechanizmusait tárgyalja.

Szabály: az „E8" / „neocortex" / „kategoriaelmelet" címke CSAK akkor szerepel,
ha valódi fogalmi híd van. Ebben a chunkban:
- **neocortex**: valódi híd — a polarizáció (győztes-Viszi-Mindent),
  az öngátlás, a csempézés (tiling) és a növekedési kúp belső-állapot-
  függő vonzás/taszítás mind közvetlenül modellezhető a neokortex-szerű
  architektúrában (oszlopos modulok, laterális gátlás, prediktív kódolás).
- **kategoriaelmelet**: valódi híd — az öndiszkrimináció (self/non-self)
  homofil kötése egy ekvivalenciareláció / hányados (quotient) szerkezet;
  az irányítás ligand–receptor párokkal egy leképezés (funktor) a környezeti
  mezőről a növekedési kúp viselkedésére.
- **E8**: egyetlen, óvatosan megadott híd — a protokadherin/Dscam kombinatorikus
  homofil kód egy hatalmas kódteret (≈60→ezrek, ill. ≈38 000 izoforma) és egy
  belső-szorzaton alapuló illeszkedési kaput használ, ami szerkezeti rokonságot
  mutat az E8 gyökérrács geometriai szorzatával (csak bizonyos párok „illenek");
  ezt a megjegyzést a megfelelő ConceptNote-ban explicit kitárom. Máshol E8
  nincs használva.

---

```yaml
id: kandel47-polarizacio-szimmetriaszunes
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 47 The Growth and Guidance of Axons"
concept: Az axon–dendrit polarizáció korai szimmetriaszűnése (neuronal polarization symmetry breaking)
type: Pattern
idris_version: 2
summary: >
  Az izoláltan tenyésztett hippokampális neuron először több azonértékű
  rövid nyúlványt (neurite) növeszt, majd az egyiket axonná, a többit
  dendritté teszi meg. Ez egy szimmetriaszűnési folyamat: a kiválasztott
  nyúlvány kitüntetetté (kitermelődően terminális objektummá) válik, a
  többi a maradék (hányados) kategóriába kerül.
signature: "polarizal : (nyulvanyok : Vect n Nyulvany) -> (Axon, Vect (n `minusz` 1) Dendrit)"
code: |
  -- A legelső kitüntetett nyúlvány lesz az axon; a többi dendrit.
  data Nyulvany = Immature
  data Sereg = Axon | Dendrit
  polarizal : Vect (S n) Nyulvany -> (Axon ** Vect n Dendrit)
causes: [kandel47-uj-axon-jel, kandel47-par-komplex]
caused_by: [kandel47-aktin-instabilitas]
resolves: [iranyitatlan-vs-iranyitott-informacio]
tags: [neocortex, kategoriaelmelet, polarization, symmetry-breaking, winner-take-all]
```

```yaml
id: kandel47-aktin-instabilitas
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 47 The Growth and Guidance of Axons"
concept: Az aktin-filamentum destabilizálódása indítja a tengely-kijelölést
type: CausalRelation
idris_version: 2
summary: >
  Ha egy korai nyúlvány aktin-filamentumai destabilizálódnak, a
  citoszkeleton úgy rendeződik át, hogy a nyúlványt axon fejlődésére
  kötelezi; másodlagosan a maradék nyúlványok dendritté válnak. Az
  ok–okozati irány: citoszkeletális átrendeződés → axon-specifikáció →
  dendrit-reakció.
signature: "aktinDestabilizal : Nyulvany -> (Axon + Dendrit)"
code: |
  -- Destabilizált aktin => az adott nyúlvány axon lesz
  aktinDestabilizal : Nyulvany -> Sereg
  aktinDestabilizal n = ha (aktinStabil n) akkor Dendrit kulonben Axon
causes: [kandel47-polarizacio-szimmetriaszunes]
caused_by: [kandel47-par-komplex]
resolves: [mi-valasztja-ki-az-axont]
tags: [cytoskeleton, actin, mechanism]
```

```yaml
id: kandel47-uj-axon-jel
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 47 The Growth and Guidance of Axons"
concept: Az új axon jelzése elnyomja a további axonokat és serkenti a dendritképződést
type: Pattern
idris_version: 2
summary: >
  A frissen képződött axon egy ismeretlen jelmolekulát bocsát ki, amely
  csökkenti a szomszédos nyúlványok axonná válásának esélyét és
  dendritként való differenciálódásra kényszeríti őket. Ez a sejten
  belüli laterális gátlás (winner-take-all) egy biológiai megvalósítása.
signature: "axonJel : Axon -> (Vect n Nyulvany -> Vect n Dendrit)"
code: |
  -- Győztes-viszi-mindent: egy axon kijelölése a többit dendritté teszi
  axonJel : Axon -> Vect n Nyulvany -> Vect n Dendrit
  axonJel a = map (kovetkezo AXon helyett Dendrit)
causes: [kandel47-polarizacio-szimmetriaszunes]
caused_by: [kandel47-polarizacio-szimmetriaszunes]
resolves: [egy-axon-tobb-dendrit-szabaly]
tags: [neocortex, lateral-inhibition, winner-take-all, axon-specification]
```

```yaml
id: kandel47-par-komplex
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 47 The Growth and Guidance of Axons"
concept: A Par-komplex fehérjék összekötik a külső jelet a citoszkeleton-átrendeződéssel
type: CausalRelation
idris_version: 2
summary: >
  Az emlős előagyi neuronokban a Par3, Par4, Par6 és Par1 rokonainak
  hiánya több, axon és dendrit közötti átmeneti hosszúságú, mindkét
  markerre pozitív nyúlványt eredményez. A Par-komplex az
  extracelluláris szignált (pl. szemaphorin) a citoszkeleton-átalakító
  gépezethez kapcsolja, részben az aktin/tubulin módosító fehérjék
  szabályozásán át.
signature: "parKomplex : KulsoJel -> CytoskeletonValtozas"
code: |
  -- Extracelluláris jel -> Par -> citoszkeleton átrendeződés
  parKomplex : KulsoJel -> CytoskeletonValtozas
  parKomplex jel = valtoztat (aktinTubulinModosito jel)
causes: [kandel47-aktin-instabilitas, kandel47-polarizacio-szimmetriaszunes]
caused_by: [kandel47-szemaphorin-3a]
resolves: [extrinsic-polarity-mechanism]
tags: [par-complex, cytoskeleton, polarity]
```

```yaml
id: kandel47-szemaphorin-3a
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 47 The Growth and Guidance of Axons"
concept: A szemaphorin-3A a növekvő dendritek vonzója a fejlődő neokortexben
type: Example
idris_version: 2
summary: >
  A pia (felszíni) közelében elhelyezkedő sejtek szemaphorin-3A-t
  (Sema 3A) választanak ki, amely vonzó a növekvő dendritek számára és
  segít a neurális polarizáció és orientáció kialakításában. Funkcionális
  Sema 3A nélküli mutant egerekben a kéregi piramissejtek párhuzamos
  orientációja felbomlik.
signature: "sema3a : Dendrit -> HaladasIrany"
code: |
  -- Sema 3A vonzza a dendritet a pia felé
  sema3a : Dendrit -> Irany
  sema3a d = irany PiaFele
causes: [kandel47-par-komplex]
caused_by: [kandel47-dendrit-mintazat]
resolves: [dendrit-orientacio]
tags: [semaphorin, guidance, neocortex, dendrite]
```

```yaml
id: kandel47-dendrit-mintazat
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 47 The Growth and Guidance of Axons"
concept: A dendritmintázat intrinzikus (transzkripciós) és extrinzikus tényezők együttese
type: Rule
idris_version: 2
summary: >
  A dendritek alakja részben a sejt saját transzkripciós programjába
  (neurontípus-specifikus transzkripciós faktorok) van kódolva — ezt
  igazolja, hogy disszociált tenyészetben is azonos a minta az in vivo
  alakkal —, részben a szomszédos sejtek és a saját egyéb dendritek
  kölcsönhatásai alakítják. A két forrás kombinációja adja a végső
  arborizációt.
signature: "dendritMintazat : (Intrinzikus, Extrinzikus) -> Arbor"
code: |
  dendritMintazat : (Transzkripcio, KulsoKornyezet) -> Arbor
  dendritMintazat (t, k) = osszeallit (intrinzikus t) (extrinzikus k)
causes: [kandel47-ongataka, kandel47-cempezes]
caused_by: [transzkripcios-program]
resolves: [hogyan-alakul-a-dendrit-forma]
tags: [neocortex, dendrite, intrinsic-extrinsic, pattern]
```

```yaml
id: kandel47-ongataka
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 47 The Growth and Guidance of Axons"
concept: Ön-eltérítés (self-avoidance): a testvér-dendritek taszítják egymást
type: Pattern
idris_version: 2
summary: >
  Egyes neuronok dendritjei egyenletesen, rés nélkül helyezkednek el,
  mert a testvér-dendritek kölcsönösen taszítják egymást (self-avoidance).
  Ez biztosítja, hogy a neuron hatékonyan, egyenletesen mintázza az
  bemeneteket. Fogalmilag ez egy ekvivalenciareláció: az azonos sejthez
  tartozó dendritek egy osztályt alkotnak, amelyen belül taszítás, az
  osztályon kívül nem.
signature: "ongataka : (Dendrit, Dendrit) -> Bool"
code: |
  -- Azonos neuron testvér-dendritjei taszítják egymást
  ongataka : Dendrit -> Dendrit -> Bool
  ongataka d1 d2 = (sejt d1) == (sejt d2)  -- azonos osztály => taszítás
causes: [kandel47-protokadherin-dscam]
caused_by: [kandel47-dendrit-mintazat]
resolves: [egyenletes-bemeneti-mintazas]
tags: [neocortex, kategoriaelmelet, self-avoidance, equivalence-relation, tiling]
```

```yaml
id: kandel47-cempezes
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 47 The Growth and Guidance of Axons"
concept: Csempézés (tiling): azonos típusú neuronok dendritjei minimális átfedéssel fedik a területet
type: Pattern
idris_version: 2
summary: >
  Sok esetben egy adott neurontípus dendritjei minimális átfedéssel
  borítják a felszínt (tiling). Fogalmilag rokonságban áll az
  ön-eltérítéssel, de míg az ön-eltérítés egyetlen neuron testvér-
  dendritjei között működik, a csempézés azonos típusú neuronok között.
  A csempézés lehetővé teszi, hogy az osztály minden neurona az általa
  beidegzett teljes területről kapjon információt, átfedés-zavar nélkül.
signature: "cempéz : Vect n Neuron -> TeruletFedés"
code: |
  -- Azonos típusú neuronok => minimális átfedés (partíció)
  cementez : Vect n Neuron -> Particio Terulet
  cementez ns = partíció (map dendritTakarasa ns)
causes: [kandel47-dendrit-mintazat]
caused_by: [kandel47-dendrit-mintazat]
resolves: [teruleti-atfedes-zavara]
tags: [neocortex, tiling, partition, coverage]
```

```yaml
id: kandel47-protokadherin-dscam
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 47 The Growth and Guidance of Axons"
concept: Protokadherin és Dscam1 kombinatorikus homofil kódok az ön/idegen-diszkriminációra
type: Definition
idris_version: 2
summary: >
  Két molekulacsalád közvetíti az ön/idegen-diszkriminációt: a kluszterált
  protokadherinek (emlős) és a Dscam1 (Drosophila). Mindkettő hatalmas
  izoforma-készletet generál (Dscam1 ≈ 38 000 alternatív splicing útján;
  protokadherin ≈ 60 fehérje, amelyek ezernyi különböző multimeré
  szerelhetők össze). Szinte minden izoforma homofil módon köt: pl. a
  γa1 a γa1-gyel jól, más izoformával gyengén vagy egyáltalán nem. Mivel
  minden neuron véletlenszerű izoforma-részhalmazt fejez ki, a felszínük
  gyakorlatilag egyedi.
signature: "homofilKot : (Isoforma, Isoforma) -> Bool"
code: |
  -- Homofil kötés: csak azonos izoforma illik (belső szorzaton alapuló kapu)
  homofilKot : Isoforma -> Isoforma -> Bool
  homofilKot a b = (izoSzekvencia a) == (izoSzekvencia b)
  -- E8-híd: a protokadherin/Dscam kód egy hatalmas kódteret és egy
  -- illeszkedési kaput használ, ami szerkezetileg rokon az E8 gyökérrács
  -- geometriai (a·b) belső szorzatával: csak bizonyos párok „illenek".
causes: [kandel47-ongataka]
caused_by: [kandel47-dendrit-mintazat]
resolves: [self-nonself-discrimination-of-dendrites]
tags: [E8, neocortex, kategoriaelmelet, protocadherin, dscam, combinatorial-code, homophilic-binding]
```

```yaml
id: kandel47-novekedesi-kup
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 47 The Growth and Guidance of Axons"
concept: A növekedési kúp (growth cone) szenzoros átalakító és motoros szerkezet
type: Definition
idris_version: 2
summary: >
  A növekedési kúp az axon csúcsán lévő specializált szerkezet, amely
  egyszerre szenzoros (környezeti irányító jeleket vesz fel) és motoros
  (citoszkeleton-vezérléssel hajtja az axon meghosszabbodását). A
  felismerő fehérjék a filopódiumokon szignálindukáló receptorok, nem
  csupán kötő elemek; a ligand–receptor kötés közvetlenül vagy második
  hírvivőkön át a citoszkeletonhoz kapcsol.
signature: "novekedesiKup : (KornyezetiJel) -> AxonMozgas"
code: |
  data NovekedesiKup = Kup (Filopodium (Vect n Receptor))
  -- Szenzoros bemenet -> motoros kimenet (transzdukció)
  transzdukal : Kup -> KornyezetiJel -> AxonMozgas
causes: [kandel47-filopodium, kandel47-masodik-hirvivo]
caused_by: [kandel47-axon-kezdet]
resolves: [mi-hajtja-az-axon-novekedest]
tags: [neocortex, growth-cone, sensorimotor, transduction]
```

```yaml
id: kandel47-filopodium
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 47 The Growth and Guidance of Axons"
concept: A filopódiumok aktin-gazdag, mozgékony nyúlványok a környezet mintavételezésére
type: Definition
idris_version: 2
summary: >
  A növekedési kúp hosszú, vékony, aktin-gazdag, membránnal határolt
  nyúlványai (filopódiumok) hordozzák a receptorokat és távol előre
  mintavételezik a környezetet. Gyors mozgásuk és rugalmasságuk
  lehetővé teszi az akadályok megkerülését; a kalciumkoncentráció
  oldalirányú gradiense irányváltást tesz lehetővé.
signature: "filopodium : ReceptorHalmaz -> KornyezetMinta"
code: |
  -- A filopódium receptorai mintát gyűjtenek a környezetből
  filopodium : Vect n Receptor -> KornyezetMinta
  filopodium rs = osszegyujt (map erzekel rs)
causes: [kandel47-masodik-hirvivo]
caused_by: [kandel47-novekedesi-kup]
resolves: [korai-kornyezet-mintavetel]
tags: [growth-cone, filopodia, actin, sampling]
```

```yaml
id: kandel47-masodik-hirvivo
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 47 The Growth and Guidance of Axons"
concept: Második hírvivők (kalcium, cAMP, cGMP) határozzák meg, hogy egy jel vonzó vagy taszító
type: Rule
idris_version: 2
summary: >
  Ugyanaz a külső orientáló jel vonzó vagy taszító lehet attól függően,
  hogy a neuron belső második-hírvivő állapota (pl. PKA aktivitás, cAMP
  szint) milyen. Alacsony cAMP/PKA mellett a netrin taszít; magas cAMP
  mellett vonz. A növekedési kúp válasza tehát a belső állapot és a
  külső jel összefüggése — ez a prediktív/állapot-függő kódolás egyik
  legalapvetőbb példája.
signature: "valasz : (KulsoJel, BelsoAllapot) -> Irany"
code: |
  -- Ugyanaz a jel különböző belső állapottal: vonzó vs taszító
  valasz : KulsoJel -> BelsoAllapot -> Valasztipus
  valasz Netrin (Alacsony cAMP) = Taszit
  valasz Netrin (Magas   cAMP) = Vonz
causes: [kandel47-novekedesi-kup]
caused_by: [kandel47-filopodium]
resolves: [same-cue-opposite-action]
tags: [neocortex, second-messenger, predictive-coding, state-dependent, cAMP]
```

```yaml
id: kandel47-helyi-feherjeszintesis
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 47 The Growth and Guidance of Axons"
concept: Helyi fehérjeszintézis a növekedési kúpban a második hírvivők irányításával
type: Pattern
idris_version: 2
summary: >
  A növekedési kúpok (és egyes dendritek) rendelkeznek a fehérjeszintézés
  gépezetével, beleértve egy messenger-RNS részhalmazt. A növekedési
  kúp-receptorok aktivációja második hírvivőket termel, amelyek a helyi
  szintézist szabályozzák, így az új motorfehérjék pontosan ott és akkor
  keletkeznek, ahová szükség van (pl. netrinre adott lokális aktin-
  szintézis fordulást okoz).
signature: "helyiSzintesis : (ReceptorAktivacio, mRNAHalmaz) -> UjFeherje"
code: |
  -- Helyi receptoraktiváció -> helyi fehérjeszintézés
  helyiSzintesis : ReceptorAktivacio -> Vect n mRNA -> Vect k Feherje
  helyiSzintesis akt mRNSek = fordít (szabályozottak akt) mRNSek
causes: [kandel47-novekedesi-kup]
caused_by: [kandel47-masodik-hirvivo]
resolves: [local-rapid-response-without-soma]
tags: [growth-cone, local-translation, mrna, mechanism]
```

```yaml
id: kandel47-kemoaffinitas
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 47 The Growth and Guidance of Axons"
concept: Sperry kemoaffinitás-hipotézise: a molekuláris illeszkedés, nem a véletlen kapcsolat
type: CausalRelation
idris_version: 2
summary: >
  Sperry 180°-os szemelforgatásos kísérlete kimutatta, hogy a regenerálódó
  retinális axonok az eredeti tectális céljaikat keresik meg, még ha az
  így hibás (invertált) térképet szolgáltat is az agynak. A következtetés:
  az axon–cél felismerés molekuláris párosításon alapul, nem funkcionális
  validáción és véletlen kapcsolatok utólagos finomításán.
signature: "kemoaffinitas : (Axon, Cel) -> Bool"
code: |
  -- Az axon a saját molekuláris célját keresi (nem a funkcionális helyeset)
  kemoaffinitas : Axon -> Cel -> Bool
  kemoaffinitas a c = (ligand a) `illeszkedik` (receptor c)
causes: [kandel47-ligand-receptor-par]
caused_by: [kandel47-novekedesi-kup]
resolves: [molecular-matching-vs-random]
tags: [neocortex, chemospecificity, molecular-matching, sperry]
```

```yaml
id: kandel47-ligand-receptor-par
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 47 The Growth and Guidance of Axons"
concept: Az irányító jelek párban álló ligand–receptorok: térbeli pontosságú leképezés a viselkedésre
type: Rule
idris_version: 2
summary: >
  Az axonirányítás fehérjepárokkal történik: a ligandot a pálya menti
  sejtek, a receptort a növekedési kúp hordozza. A ligand a növekedési
  kúp egyik oldalán lokális aktivációt/gátlást okoz, ami fordulást eredményez;
  a környezeti cue-k lokális eloszlása határozza meg az útvonalat. Fogalmilag
  ez egy funktor: a környezeti mezőből a növekedési kúp viselkedésébe való
  leképezés, térbeli pontossággal.
signature: "iranyitas : (LigandMezo, Receptor) -> Mozgas"
code: |
  -- Környezeti ligand-mező -> (funktor) -> növekedési kúp mozgás
  iranyitas : LigandMezo -> Receptor -> Mozgas
  iranyitas mezo r = lekepez (lokalis aktivacio mezo r) mozgasValasz
causes: [kandel47-kemoaffinitas, kandel47-masodik-hirvivo]
caused_by: [kandel47-novekedesi-kup]
resolves: [how-spatial-cues-choreograph-growth]
tags: [neocortex, kategoriaelmelet, ligand-receptor, functor, spatial-guidance]
```
