# Kandel Chunk 09 — ConceptNotes (Extraction)
# Forrás / Source: Kandel et al., "Principles of Neural Science" (6th ed.), Chapter 37 — The Cerebellum, pp. 915–928.
# Schema: book_processor.md ConceptNote.
# Jegyzet: a neocortex-építés szempontjából releváns mechanizmusokat emeltük ki.
# Az "E8" / "neocortex" / "kategoriaelmelet" címke CSak akkor szerepel, ha valódi fogalmi híd van.

---
id: kandel-c09-001
source: Kandel Principles of Neural Science Ch.37 (The Cerebellum)
concept: Cerebellar functional subdivisions
type: Definition
idris_version: 2
summary: >
  A kisagy három funkcionális egységre oszlik — vestibulocerebellum (flocculonodularis
  lebeny), spinocerebellum (vermis + intermedier hemisphere-részek), és cerebrocerebellum
  (lateralis hemisphere-részek). Mindegyik eltérő bemenetet, kimenetet és motoros
  funkciót szolgál, de ugyanazt az alapvető mikroáramköri architektúrát használja.
signature: CerebellarTerulet : Type
code: ""
related: [kandel-c09-005, kandel-c09-008]
causes: []
caused_by: []
resolves: []
tags: [neocortex, kategoriaelmelet]

---
id: kandel-c09-002
source: Kandel Principles of Neural Science Ch.37 (The Cerebellum)
concept: Cerebellar lesion disrupts ipsilateral limb movement
type: CausalRelation
idris_version: 2
summary: >
  A kisagyi sérülés az ellenoldali (kontralaterális) végtagmozgást zavarja, mert a
  corticospinalis és rubrospinalis pályák a leszállás során átkeresztezik a középvonalat.
  A kisagy tehát az ipszilaterális (azonos oldali) végtagot irányítja a keresztezés miatt.
signature: sérülés : Terulet -> (kontralaterálisVégtagZavar : TudományosÁllítás)
code: ""
related: [kandel-c09-001]
causes: [kontralaterálisVégtagAtaxia]
caused_by: [pályaKeresztezésAKözépvonalban]
resolves: []
tags: [neocortex]

---
id: kandel-c09-003
source: Kandel Principles of Neural Science Ch.37 (The Cerebellum)
concept: Feedforward (anticipatory) motor control
type: Pattern
idris_version: 2
summary: >
  A kisagy előrejelző (feedforward) szabályozást alkalmaz: az antagonista izom
  összehúzódását a mozgás elején, jóval azelőtt programozza be, hogy az érzékszervi
  visszacsatolás elérné az agyat. Ez lehetővé teszi a mozgás sima, pontos, gyors
  levezénylését a kívánt végpontig anélkül, hogy a végrehajtás érzékszervi
  visszacsatolásra várna.
signature: előreProgramozottIdőzítés : MozgásCél -> IzomParancsSorozat
code: |
  -- Az antagonista aktivációt a mozgás megkezdése előtt ütemezzük, mielőtt a
  -- szenzoros visszacsatolás megérkezne.
  előreProgramozottIdőzítés : MozgásCél -> IzomParancsSorozat
  előreProgramozottIdőzítés cél = agonisták célpontig ++ antagonistaLeállítás célpontban
related: [kandel-c09-004, kandel-c09-012, kandel-c09-013]
causes: [simítottPontosMozgás]
caused_by: [belsőModell, kísérőKisülés]
resolves: [késleltetettVisszacsatolásProbléma]
tags: [neocortex, kategoriaelmelet]

---
id: kandel-c09-004
source: Kandel Principles of Neural Science Ch.37 (The Cerebellum)
concept: Failure of feedforward timing causes intention tremor
type: CausalRelation
idris_version: 2
summary: >
  Ha az előrejelző időzítés mechanizmusa sérül, a mozgás szándékos (intention) remegésével
  járó zavar lép fel: az agonista lassabban és elhúzódóbban aktiválódik, az antagonista
  késik, a mozgás túllövi a célt, és a korrekciók oszcillációkat produkálnak.
signature: időzítésiHiba : FeedforwardHiba -> SzándékosRemegés
code: ""
related: [kandel-c09-003, kandel-c09-011]
causes: [szándékosRemegés]
caused_by: [mélyMagInaktiválás]
resolves: []
tags: [neocortex]

---
id: kandel-c09-005
source: Kandel Principles of Neural Science Ch.37 (The Cerebellum)
concept: Cerebellar cortex three-layer organization
type: Definition
idris_version: 2
summary: >
  A kisagykéreg három funkcionálisan specializált rétegből áll: a legmélyebb szemcsés
  réteg a bemeneti réteg (granule sejtek + mossy fiber terminálok + Golgi sejtek),
  a középső Purkinje-sejtréteg a kimeneti réteg (GABAerg inhibitoros kimenet a mély
  magokba), és a legkülső molekuláris réteg (Purkinje-dendritek, stellata és kosár
  sejtek, parallel fiber-ek).
signature: KisagyKéregRéteg : Type
code: ""
related: [kandel-c09-001, kandel-c09-008]
causes: []
caused_by: []
resolves: []
tags: [neocortex]

---
id: kandel-c09-006
source: Kandel Principles of Neural Science Ch.37 (The Cerebellum)
concept: Climbing fibers vs mossy fibers as distinct information channels
type: Definition
idris_version: 2
summary: >
  A kisagy két fő afferens típusa eltérő funkciót szolgálhat. A mossy fiber-ek a gerincvelőből
  és agytörzsből származnak, érzékszervi információt és kísérőkisülést (efference copy)
  hordoznak, és a szemcsés rétegben végződnek. A mászó fiber-ek az inferior olivából
  jönnek, érzékszervi és kérgi információt hoznak, és a Purkinje-sejtek proximalis
  dendritjein végződnek — mindegyik Purkinje-sejt csak EGY mászó fiber-től kap bemenetet.
signature: AfferensCsatorna : Type
code: |
  -- Két különálló bemeneti csatorna, eltérő konvergenciával/divergenciával.
  MászóFiberBemenet : PurkinjeSejt -> EgyetlenForrás
  MohaFiberBemenet  : GranuleSejt -> SokforrásKonvergencia
related: [kandel-c09-007, kandel-c09-015]
causes: []
caused_by: []
resolves: []
tags: [neocortex, kategoriaelmelet]

---
id: kandel-c09-007
source: Kandel Principles of Neural Science Ch.37 (The Cerebellum)
concept: Complex spikes (event detection) vs simple spikes (graded rate coding)
type: Pattern
idris_version: 2
summary: >
  A mászó fiber-ek ritkán, de nagy hatással "complex spike"-ot váltanak ki (kezdeti nagy
  amplitúdójú akciós potenciál + nagyfrekvenciás robbanás) — ez az eseményészlelésre
  specializálódott, szinkron tüzeléssel jelzi a fontos eseményeket. Ezzel szemben a
  mossy→parallel fiber bemenet "simple spike"-okat produkál magas, fokozatosan modulálható
  tüzelési rátával, ami a perifériális inger nagyságát és időtartamát kódolja.
signature: tüzelésiMód : Csatorna -> KimenetiEsemény
code: |
  -- Két kódolási mód ugyanazon Purkinje-sejten: ritka esemény vs. folytonos ráta.
  komplexTüskék  : MászóFiberAktivitás -> EseményJelzés
  egyszerűTüskék : MohaFiberAktivitás   -> FokozatosRátaKódolás
related: [kandel-c09-006, kandel-c09-015]
causes: [eseményÉszlelés, amplitúdóKódolás]
caused_by: [mászóFiber, mohaFiber]
resolves: []
tags: [neocortex, kategoriaelmelet]

---
id: kandel-c09-008
source: Kandel Principles of Neural Science Ch.37 (The Cerebellum)
concept: Canonical computation — uniform repeated microcircuit
type: Rule
idris_version: 2
summary: >
  A kisagykéreg mikroáramköre sokszor ismétlődik a felszínen; mivel minden modul
  azonos architektúrájú és azonos konvergencia/divergencia-mintázatú, a kéreg ugyanazt
  az alapvető "kanonikus" számítást végzi az összes bemenetén, és hasonlóan alakítja
  át a kisagyi kimeneti rendszerek bemeneteit. Ez a uniformitás a Szima-projekt E8
  gyökérrácsának (240 gyökér, egyenletes szimmetria) megismételt, azonos szerkezetű
  egységeihez hasonló: egyetlen algebrai objektum sokszoros alkalmazása.
signature: kanonikusSzamitas : (be : Bemenet) -> Kimenet
code: |
  -- Minden modul ugyanazt a leképezést kapja: F alkalmazása az összes bemenetre.
  -- Kategóriaelméleti értelemben ez egy funktor: azonos szerkezetű modulokon
  -- egyetlen, mindenütt érvényes leképezés.
  KanonikusFunktor : (bemenet : ModulBemenet) -> ModulKimenet
  KanonikusFunktor b = ugyanazASzamitas b  -- minden modulra azonos
related: [kandel-c09-005, kandel-c09-009, kandel-c09-010, kandel-c09-017]
causes: [egységesTranszformáció]
caused_by: [ismétlődőMikroáramkör]
resolves: [skálázhatóSzámításTöbbBemeneten]
tags: [neocortex, kategoriaelmelet, E8]

---
id: kandel-c09-009
source: Kandel Principles of Neural Science Ch.37 (The Cerebellum)
concept: Parallel excitatory and inhibitory pathways with convergence/divergence
type: Pattern
idris_version: 2
summary: >
  A mikroáramkör általános jellemzője a Purkinje-sejtekhez és a mély kisagyi magokhoz
  vezető párhuzamos excitatoros és inhibitoros pályák konvergenciája és divergenciája.
  A mossy fiber közvetlen excitatoros szinapszissal és közvetve, a kéreg + inhibitoros
  Purkinje-sejtek útján hat a célsejtekre, miközben a konvergencia/divergencia széles
  információterjesztést valósít meg.
signature: konvergenciaDivergencia : (források : Lista Bemenet) -> (cél : Sejt)
code: |
  -- Egy célsejt excitatoros és inhibitoros bemenetek konvergenciája.
  -- A funktor kiterjesztése: sok forrás -> egy cél, párhuzamos előjelű ágakkal.
  PárhuzamosPálya : (exc : Bemenet) -> (inh : Bemenet) -> CélSejt -> Kimenet
related: [kandel-c09-008, kandel-c09-011]
causes: [szélesInformációTerjesztés]
caused_by: [mohaFiber, purkinjeSejt]
resolves: []
tags: [kategoriaelmelet, neocortex]

---
id: kandel-c09-010
source: Kandel Principles of Neural Science Ch.37 (The Cerebellum)
concept: Recurrent loops (Golgi loop, Purkinje→inferior olive loop)
type: Pattern
idris_version: 2
summary: >
  A kisagyban több visszacsatoló hurok működik. A Golgi-sejtek hurok a kéregben
  szabályozza a szemcsés sejtek aktivitását (Golgi GABAerg termináljai gátolják a
  granule sejteket). Egy második hurok lehetővé teszi, hogy a Purkinje-sejtek a saját
  mászó fiber bemenetüket szabályozzák: a Purkinje-sejtek gátolják a mély magok
  inhibitoros interneuronjait, amelyek az inferior olivába vetítenek vissza.
signature: GolgiHurok : ModulAllapot -> ModulAllapot
code: |
  -- A visszacsatoló hurok egy állapot->állapot leképezés (endofunktor).
  -- Rögzített pontja a stabil granule-sejt aktivitást írja le.
  GolgiHurok : ModulAllapot -> ModulAllapot
  PurkinjeHurok : InferiorOliveÁllapot -> InferiorOliveÁllapot
related: [kandel-c09-008, kandel-c09-009]
causes: [granuleSejtSzabályozás, mászóFiberÖnszabályozás]
caused_by: [golgiSejt, purkinjeSejt, mélyMag]
resolves: [granuleSejtBurstIdőtartam]
tags: [kategoriaelmelet, neocortex]

---
id: kandel-c09-011
source: Kandel Principles of Neural Science Ch.37 (The Cerebellum)
concept: Deep nuclei spontaneous activity sculpted by Purkinje inhibition
type: Rule
idris_version: 2
summary: >
  A mély kisagyi magok neuronjai szinaptikus bemenet nélkül is spontán aktívak; a
  Purkinje-sejtek inhibitoros kimenete nem csupán váltja ki a választ, hanem modulálja
  ezt a belső aktivitást és formálja (sculpts) a mossy fiber-ekből érkező excitatoros
  jeleket. Az antagonista izom időzítése a mély magok ezen szabályozott aktivitásától függ.
signature: mélyMagAktivitás : PurkinjeInhibíció -> ExcitatorosJel -> Kimenet
code: ""
related: [kandel-c09-004, kandel-c09-009]
causes: [agonistaAntagonistaIdőzítés]
caused_by: [purkinjeSejtGátlás, spontánTüzelés]
resolves: []
tags: [neocortex]

---
id: kandel-c09-012
source: Kandel Principles of Neural Science Ch.37 (The Cerebellum)
concept: Internal models of the motor apparatus (inverse and forward dynamics)
type: Definition
idris_version: 2
summary: >
  A kisagy belső modelleket (internal models) tart fenn a motorapparátusról. Az inverz
  dinamikai modell az érzékszervi adatokból (testtartás) megfelelően időzített és
  skálázott mozgásparancsokat generál; az előre tekintő (forward) dinamikai modell a
  motoros parancs másolatát dolgozza fel és előrejelzi a mozgás közelgő kinematikáját
  (pozíció és sebesség). Ez a pár a kategóriaelméleti adjunkcióhoz (két irányú leképezés)
  hasonló szerkezetet mutat.
signature: inverzModell : ÉrzékszerviÁllapot -> MozgásParancs; eloModell : MozgásParancs -> KinematikaElorejelzes
code: |
  -- Inverz dinamikai modell: érzékszervi állapot -> mozgásparancs.
  inverzModell : ÉrzékszerviÁllapot -> MozgásParancs
  -- Előre tekintő dinamikai modell: parancsmásolat -> kinematikai előrejelzés.
  eloModell : MozgásParancs -> KinematikaElorejelzes
  -- A kettő együtt egy visszacsatolásmentes (feedforward) irányító hurkot ad.
related: [kandel-c09-003, kandel-c09-013, kandel-c09-014]
causes: [feedforwardIrányítás, szegmentumKöziInerciaKompenzáció]
caused_by: [tanulás, szenzorosBemenet]
resolves: [többSzegmensesMozgásPontatlanság]
tags: [neocortex, kategoriaelmelet]

---
id: kandel-c09-013
source: Kandel Principles of Neural Science Ch.37 (The Cerebellum)
concept: Delayed sensory feedback necessitates feedforward + internal model
type: CausalRelation
idris_version: 2
summary: >
  Mivel az érzékszervi visszacsatolás természeténél fogva késleltetett, a mozgás
  megkezdésekor idő telik el, mire hasznos visszajelzés érkezik. Ezért a kisagy a
  parancsokat előre programozza és koordinálja a hasznos visszacsatolás beérkezése
  előtt, és a visszacsatolást főként saját teljesítményének monitorozására használja —
  a belső modell és a kísérőkisülés teszi ezt lehetővé.
signature: késleltetettVisszacsatolás : ÉrzékszerviKésés -> Szükségesség (Feedforward + BelsőModell)
code: ""
related: [kandel-c09-003, kandel-c09-012, kandel-c09-014]
causes: [előreProgramozottKoordináció]
caused_by: [érzékszerviKésés]
resolves: [elavultVisszacsatolásOkoztaTévedés]
tags: [neocortex, kategoriaelmelet]

---
id: kandel-c09-014
source: Kandel Principles of Neural Science Ch.37 (The Cerebellum)
concept: Corollary discharge (efference copy) converges with sensory input
type: Pattern
idris_version: 2
summary: >
  A kísérőkisülés (corollary discharge / efference copy) ugyanazokat a motoros
  parancsokat jelenti, amelyeket az agy a motoros idegeknek küld. A granuláris rétegben
  egyes szemcsés sejtek konvergens érzékszervi ÉS kísérőkisülés-bemenetet kapnak, így a
  tervezett mozgást a szenzoros következményekkel hasonlíthatják össze. A belső modell
  a kísérőkisülést szenzoros visszacsatolás-előrejelzéssé alakítja; a valós és
  előrejelzett visszacsatolás különbsége a szenzoros predikciós hiba, amely a korrekciót
  és tanulást vezérli.
signature: kísérőKisülés : MotorParancs -> ÉrzékszerviElorejelzes
code: |
  -- A kísérőkisülés + érzékszervi bemenet összevetése: predikciós hiba számítása.
  szenzorosPredikciósHiba : (valós : ÉrzékszerviVisszacsatolás) -> (jósolt : ÉrzékszerviElorejelzes) -> Hiba
related: [kandel-c09-012, kandel-c09-013]
causes: [szenzorosPredikciósHiba, motorTanulás]
caused_by: [kísérőKisülés, érzékszerviBemenet]
resolves: [sajátMozgásOkoztaZajSzűrése]
tags: [neocortex, kategoriaelmelet]

---
id: kandel-c09-015
source: Kandel Principles of Neural Science Ch.37 (The Cerebellum)
concept: Climbing-fiber-coincident long-term depression (LTD) at PF–Purkinje synapses
type: CausalRelation
idris_version: 2
summary: >
  A mászó fiber-ek szelektíven hosszú távú depressziót (LTD) válthatnak ki a parallel
  fiber–Purkinje szinapszisokban, ha azokat egyidejűleg (konkurrensen) ingerlik a
  mászó fiber-rel. Ez a plasticitás a Marr–Albus–Ito elmélet szerint a kisagyi motoros
  tanulás alapja: a hibajelző mászó fiber-aktivitás csökkenti a hibát okozó parallel
  fiber bemenetek súlyát, a simple-spike mintázat megváltozik, és a mozgáshibák
  eltűnnek. Ez a neocortex-szerű tanulható súlymódosítás archetípusa.
signature: hosszúTávúDepresszió : (pf : ParallelRost) -> (cf : MászóRost) -> SzinapszisÁllapot
code: |
  -- Együttműködő CF+PF ingerlés -> szinaptikus depresszió (LTD).
  -- Predikátum: csak az egyidejűleg aktivált PF-eket érinti.
  hosszúTávúDepresszió : (pf : ParallelRost) -> (cf : MászóRost) -> SzinapszisÁllapot
related: [kandel-c09-006, kandel-c09-007, kandel-c09-016]
causes: [kisagyiMotorosTanulás, simpleSpikeMegváltozás]
caused_by: [mászóFiberEgyidejűség, parallelFiberAktivitás]
resolves: [mozgáshiba]
tags: [neocortex, kategoriaelmelet]

---
id: kandel-c09-016
source: Kandel Principles of Neural Science Ch.37 (The Cerebellum)
concept: Cerebellar learning restores feedback-free accuracy
type: Rule
idris_version: 2
summary: >
  A kisagyi tanulás célja a mozgás feedforward (visszacsatolásmentes) irányításának
  javítása. A hibák átmenetileg visszacsatolás-függővé teszik a motoros irányítást;
  a tanulás visszaállítja az ideális állapotot, amelyben a teljesítmény pontos
  anélkül, hogy az érzékszervi visszacsatolásra hagyatkozna (pl. prisma-adaptáció,
  vestibulo-okuláris reflex tanulása).
signature: tanulás : HibaSorozat -> FeedforwardPontosság
code: ""
related: [kandel-c09-014, kandel-c09-015]
causes: [visszacsatolásmentesPontosság]
caused_by: [hibaJelzés, plasticitás]
resolves: [átmenetiVisszacsatolásFüggőség]
tags: [neocortex]

---
id: kandel-c09-017
source: Kandel Principles of Neural Science Ch.37 (The Cerebellum)
concept: Fractured somatotopy
type: Definition
idris_version: 2
summary: >
  A kisagykéreg szomatotópiás térképe "töredezett" (fractured): több, egymástól
  független, részleges térkép jelenik meg, szemben a motoros kéreg folytonos
  szomatotópiájával. A mászó fiber-ek axonjai vékony paraszaggittális csíkokban
  végződnek, amelyek több folium-on átívelnek, és az egy csíkhoz tartozó Purkinje-sejtek
  a mély magok egy közös csoportjába konvergálnak — egy diszkrét, szimmetrikus
  rács/sáv-szerkezet, amely a Szima-projekt E8 gyökérrácsának diszkrét szimmetriájához
  hasonlítható.
signature: töredezettTérkép : Terület -> DiszkrétRács
code: ""
related: [kandel-c09-008]
causes: []
caused_by: [paraszaggittálisSzerveződés]
resolves: []
tags: [E8, kategoriaelmelet, neocortex]

---
id: kandel-c09-018
source: Kandel Principles of Neural Science Ch.37 (The Cerebellum)
concept: Cerebellar timing control beyond contraction timing
type: Pattern
idris_version: 2
summary: >
  A kisagy szerepe a mozgás időzítésében túlmutat az izomösszehúzódások időzítésén:
  a laterális kisagyi sérülés a sorozatos események időzítését zavarja, és a hibák
  nem motorosak — érintik az eltelt idő megítélését is kognitív feladatokban (pl. két
  hang hosszának összehasonlítása). Ez az időzítő mechanizmus a neocortex-időzítés
  és ritmus-szabályozás mintája lehet.
signature: időzítésSzabályozás : Eseménysorozat -> RitmusPontosság
code: ""
related: [kandel-c09-003, kandel-c09-004]
causes: [ritmusPontosság, kognitívIdőzítés]
caused_by: [laterálisKisagy]
resolves: []
tags: [neocortex]
