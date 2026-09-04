# Kandel kivonat — chunk 02 (ConceptNotes)
# Forrás / Source: Kandel et al., Principles of Neural Science (6th ed.), Chapter 4
# "The Neuroanatomical Bases by Which Neural Circuits Mediate Behavior"
# Feldolgozta / Processed: 2026-08-24, Szima kutatási projekt
# Megjegyzés / Note: a chunk_02 valójában 4. fejezet (neuroanatómia), NEM szinaptikus
#   transzmisszió — a prompt fejléce téves volt. A kivonat a tényleges tartalmat követi.

---

## ConceptNote 01
```yaml
id: kandel_ch04_somatotopia_testfelszin_terkep
source: "Principles of Neural Science (6th ed.), Chapter 4 — Neuroanatomical Bases"
concept: "Somatotopikus szerveződés (a testfelszín idegi térképe)"
type: Definition
idris_version: 2
summary: >
  A dorzális gyökér ganglion sejtjeinek központi axonjai a gerincvelőben
  az elrendezésüket megőrizve végződnek, így a testfelszín pontjainak
  rendezett (somatotopikus) térképe jön létre. Ez a rendezett eloszlás
  végig megmarad a teljes felszálló érző pályán (gerincvelő → medulla →
  thalamus → primer szomatoszenzoros kéreg).
signature: "Somatotopia : BodySurface -> NeuralMap"
code: ""
related: [kandel_ch04_felszallas_hierarchia, kandel_ch04_parhuzamos_palyak, kandel_ch04_kortikalis_nagyitas]
causes: [kandel_ch04_kortikalis_nagyitas]
caused_by: [kandel_ch04_dorsalis_gyoker_ganglion]
resolves: []
tags: [neocortex, kategoriaelmelet, somatotopia, topografia, erzekeles]
```

## ConceptNote 02
```yaml
id: kandel_ch04_felszallas_hierarchia
source: "Principles of Neural Science (6th ed.), Chapter 4 — Neuroanatomical Bases"
concept: "Hierarchikus feldolgozás: feedforward (felfelé) és feedback (visszafelé) vetületek"
type: Pattern
idris_version: 2
summary: >
  A központi idegrendszer kapcsolatai hierarchikusak: az alacsonyabb
  feldolgozási régióból a magasabb felé tartó vetület a feedforward,
  míg a magasabb régióból az alacsonyabb felé tartó visszatérő vetület a
  feedback. Az A régió -> B régió és onnan vissza-vetület motívuma az
  idegrendszer egészében újra és újra megjelenik (rezapituláció).
signature: "Hierarchia : Region -> Region -> (Feedforward, Feedback)"
code: ""
related: [kandel_ch04_thalamus_kapuor, kandel_ch04_kortikalis_feedback, kandel_ch04_parhuzamos_palyak]
causes: [kandel_ch04_thalamus_kapuor]
caused_by: []
resolves: [kandel_ch04_felszallas_hierarchia_modulacio]
tags: [neocortex, kategoriaelmelet, hierarchia, feedforward, feedback, kategoria]
```

## ConceptNote 03
```yaml
id: kandel_ch04_parhuzamos_palyak
source: "Principles of Neural Science (6th ed.), Chapter 4 — Neuroanatomical Bases"
concept: "Párhuzamos, modalitásspecifikus érző pályák (epikritikus vs protopátiás)"
type: Definition
idris_version: 2
summary: >
  A szomatoszenzoros információnak két fő felszálló pályája van, amelyek
  el vannak különítve: a dorzális oszlop–medialis lemniskus rendszer
  (finom tapintás, nyomás, proprioceptio — az úgynevezett epicritikus
  rendszer) és az anterolaterális rendszer (fájdalom, viszketés, hőmérséklet
  — a protopátiás rendszer). Minden szomatikus almodalitás (tapintás,
  fájdalom, hőmérséklet, helyzetérzés) külön pályán, külön agyi régióban
  dolgozódik fel.
signature: "ParallelPathway : Submodality -> NeuralPath"
code: ""
related: [kandel_ch04_somatotopia_testfelszin_terkep, kandel_ch04_felszallas_hierarchia]
causes: []
caused_by: []
resolves: [kandel_ch04_modularitas]
tags: [neocortex, kategoriaelmelet, parhuzamossag, modalitas, epitkritikus, protopatias]
```

## ConceptNote 04
```yaml
id: kandel_ch04_thalamus_kapuor
source: "Principles of Neural Science (6th ed.), Chapter 4 — Neuroanatomical Bases"
concept: "A thalamus mint kapuőr (gatekeeper), nem passzív átjátszó állomás"
type: Pattern
idris_version: 2
summary: >
  A thalamus nem csupán továbbítja az információt a neokortex felé, hanem
  kapuőrként működik: a szervezet viselkedési állapotától függően
  engedi vagy felerősíti, illetve gátolja a specifikus információ
  áthaladását. A ventroposterior lateralis nucleus szomatoszenzoros
  kimenete négyféle feldolgozást kap: (1) helyi feldolgozás a magban;
  (2) agytörzsi (noradrenerg és szerotoninerg) bemenet modulációja;
  (3) gátló bemenet a retikuláris magból; (4) a neokortex moduláló
  visszacsatolása.
signature: "ThalamusGate : SensoryInput -> BehavioralState -> GatedOutput"
code: ""
related: [kandel_ch04_felszallas_hierarchia, kandel_ch04_kortikalis_feedback, kandel_ch04_reticularis_gatlas]
causes: [kandel_ch04_kortikalis_feedback]
caused_by: [kandel_ch04_felszallas_hierarchia]
resolves: [kandel_ch04_informacio_szures]
tags: [neocortex, thalamus, gatekeeper, modulacio, figyelem]
```

## ConceptNote 05
```yaml
id: kandel_ch04_reticularis_gatlas
source: "Principles of Neural Science (6th ed.), Chapter 4 — Neuroanatomical Bases"
concept: "Thalamicus retikuláris mag: gátló moduláció"
type: Pattern
idris_version: 2
summary: >
  A thalamicus retikuláris mag egy vékony, majdnem kizárólag gátló
  (inhibitoros) neuronokból álló réteg, amely a relay-sejtekre szinaptál,
  és egyáltalán nem vetít a neokortexbe. A neokortex feedback-vetületeit
  is fogadja, lehetővé téve, hogy a thalamus modulálja relay-sejtjeinek
  válaszát a beérkező érző információra.
signature: "ReticularisInhibit : RelayCell -> InhibitedRelayCell"
code: ""
related: [kandel_ch04_thalamus_kapuor, kandel_ch04_kortikalis_feedback]
causes: [kandel_ch04_informacio_szures]
caused_by: []
resolves: [kandel_ch04_tulterheles_gatlas]
tags: [neocortex, thalamus, gatlas, inhibitoros]
```

## ConceptNote 06
```yaml
id: kandel_ch04_kortikalis_feedback
source: "Principles of Neural Science (6th ed.), Chapter 4 — Neuroanatomical Bases"
concept: "Kortikofugális (feedback) vetület a thalamikus magnakba"
type: CausalRelation
idris_version: 2
summary: >
  A neokortex kiterjedt visszatérő bemeneteket küld a thalamusba
  (feedback kapcsolat). Például a lateralis geniculatus magnálban a
  látókéreg feedback-vetületéből származó szinapszisok száma nagyobb,
  mint amennyit a retina ad — ez a visszacsatolás a szenzoros
  feldolgozás fontos modulátora, bár pontos funkciója még nem tisztázott.
signature: "CorticalFeedback : Neocortex -> Thalamus -> ModulatedRelay"
code: ""
related: [kandel_ch04_thalamus_kapuor, kandel_ch04_felszallas_hierarchia]
causes: [kandel_ch04_thalamus_kapuor]
caused_by: [kandel_ch04_felszallas_hierarchia]
resolves: []
tags: [neocortex, thalamus, feedback, modulacio, latas]
```

## ConceptNote 07
```yaml
id: kandel_ch04_kortikalis_nagyitas
source: "Principles of Neural Science (6th ed.), Chapter 4 — Neuroanatomical Bases"
concept: "Kortikális nagyítás (cortical magnification): a kéregterület aránya a megkülönböztetés finomságához, nem a testtömeghez"
type: Pattern
idris_version: 2
summary: >
  A szomatoszenzoros kéregben a testrészek szomatotopikusan ábrázolva
  vannak, de a kéregfelszín egy testrészre jutó aránya NEM a testrész
  tömegével arányos, hanem a megkülönböztetés (diszkrimináció)
  finomságával — ami viszont az érző rostok beidegzési sűrűségével
  függ össze. Így az ujjak kéregterülete nagyobb, mint a karoké; az
  ajkak és nyelv nagyobb, mint az arc többi része. A reprezentáció nem
  rögzített: a tapasztalat módosíthatja (pl. hegedűsök ujj-reprezentációja
  kitágul).
signature: "CorticalMagnification : DiscriminationFinesse -> CorticalArea"
code: ""
related: [kandel_ch04_somatotopia_testfelszin_terkep]
causes: []
caused_by: [kandel_ch04_somatotopia_testfelszin_terkep]
resolves: [kandel_ch04_plaszticitas]
tags: [neocortex, szomatotopia, plaszticitas, homunkulus, megkulonboztetes]
```

## ConceptNote 08
```yaml
id: kandel_ch04_dorsalis_gyoker_ganglion
source: "Principles of Neural Science (6th ed.), Chapter 4 — Neuroanatomical Bases"
concept: "Pseudo-unipoláris elsődleges érző neuronok a dorsális gyökér ganglionban"
type: Definition
idris_version: 2
summary: >
  A törzs és a végtagok bőréből, izmaiból, ízületeiből származó érző
  információt szállító elsődleges érző neuronok a gerincvelő melletti
  dorsális gyökér ganglionokban csoportosulnak. Ezek a neuronok
  pseudo-unipoláris alakúak: elágazó (bifurkált) axonjuk van, amelynek
  perifériás ága a bőrt, izmot vagy más szövetet idegzi be szabad
  idegvégződéssel vagy specializált receptorral, a központi ága pedig a
  gerincvelő dorsális részébe lép be.
signature: "DorsalRootGanglionCell : Pseudounipolar (PeripheralBranch, CentralBranch)"
code: ""
related: [kandel_ch04_somatotopia_testfelszin_terkep, kandel_ch04_parhuzamos_palyak]
causes: [kandel_ch04_somatotopia_testfelszin_terkep]
caused_by: []
resolves: []
tags: [neuron, erzekelas, dorsalis_gyoker, receptor]
```

## ConceptNote 09
```yaml
id: kandel_ch04_gerincvelo_H_szur
source: "Principles of Neural Science (6th ed.), Chapter 4 — Neuroanatomical Bases"
concept: "Gerincvelő H-alakú szürkeállomány: dorsális és ventrális szarv"
type: Definition
idris_version: 2
summary: >
  A törzs és végtagok szomatoszenzoros információja a gerincvelőbe
  lép, amelynek magjában H-alakú szürkeállomány található (a neuron
  sejttestek helye). A szürkeállományt fehérállomány veszi körül
  (myelinált axonok rövid és hosszú kapcsolatai). A dorsális (poszterior)
  szarv másodlagos érző neuronokat, a ventrális (anterior) szarv
  motoros neuronokat (motoros magokat) tartalmaz. Az interneuronok
  (gerjesztők és gátlók egyaránt) modulálják az agy felé tartó érző
  információt és a lefelé tartó motoros parancsokat.
signature: "SpinalCord : HGrayMatter (DorsalHorn, VentralHorn, WhiteMatter)"
code: ""
related: [kandel_ch04_parhuzamos_palyak, kandel_ch04_dorsalis_gyoker_ganglion]
causes: []
caused_by: []
resolves: []
tags: [gerincvelo, interneuron, motor, erzekelas, reflex]
```

## ConceptNote 10
```yaml
id: kandel_ch04_medialis_lemniskus_dekusszacio
source: "Principles of Neural Science (6th ed.), Chapter 4 — Neuroanatomical Bases"
concept: "Kontralaterális reprezentáció: az információ átkelése a középvonalon"
type: CausalRelation
idris_version: 2
summary: >
  Mivel a pályák a középvonalon átkelnek a másik oldalra (dekusszáció),
  a test bal oldaláról származó érző információ a jobb agyféltekébe,
  és fordítva kerül. A medialis lemniskus rostjai a ventroposterior
  lateralis nucleusban szomatotopikusan végződnek: az alsó testfél
  információja laterálisan, a felső testfél információja mediálisan
  végződik.
signature: "Decussation : BodySide -> ContralateralBrainSide"
code: ""
related: [kandel_ch04_somatotopia_testfelszin_terkep, kandel_ch04_parhuzamos_palyak]
causes: []
caused_by: []
resolves: [kandel_ch04_kontralateralitas]
tags: [neocortex, dekusszacio, kontralateralitas, thalamus]
```

---

# Kapcsolódó fogalmak / Cross-references (E8 / kategoriaelmélet szempontból)
# - kandel_ch04_felszallas_hierarchia: a feedforward/feedback motívum kategoriális
#   struktúra (rétegek közötti functor-szerű leképezés) — valós hid a neokortex
#   architektúra felé.
# - kandel_ch04_somatotopia_testfelszin_terkep: a testfelszín -> kéreg topografikus
#   leképezése kategoriális (functoriális) térkép analógiája.
# - E8 címke: ebben a chunkban NINCS közvetlen, valós E8-híd (a topológiai
#   szerveződés nem E8-specifikus), ezért nem címkéztem E8-re.
