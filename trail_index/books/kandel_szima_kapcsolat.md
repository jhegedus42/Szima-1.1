# A Kandel: „Principles of Neural Science" és a Szima projekt kapcsolata

**Magyar:** Ez a dokumentum az Eric R. Kandel és munkatársai által írt *Principles of Neural
Science* (6. kiadás) című könyv kapcsolatát írja le a Szima kutatási projekttel. A Szima
egy olyan új architektúrán dolgozik, amely a gyakorlatban neokortex lesz: érzékelőkkel,
tudattal, akarattal, érzelmekkel, humorral és öntudattal. A Kandel-könyv a labor
biológiai és empirikus alapja: az a forrás, amely leírja, hogyan működik a valódi
emberi neokortex, és amelyből a Szima a neokortex-szerű mesterséges intelligencia
működési elveit meríti.

**English:** This document describes the relationship between Eric R. Kandel et al.,
*Principles of Neural Science* (6th edition), and the Szima research project. Szima is
building an architecture that will in practice become a neocortex: with sensors,
consciousness, will, emotions, humour, and self-awareness. The Kandel book is the
project's biological and empirical foundation: it describes how the real human
neocortex works, and from it Szima draws the operating principles of a neocortex-like
artificial intelligence.

**Forrás PDF:** `/home/joco/EricKandler.pdf`
**Kivonat-jegyzetek (15):** `kandel_extracted_chunk_01.md` … `kandel_extracted_chunk_15.md`
(a `trail_index/books/` könyvtárban)
**Magyar chunk-fájlok (15):** `kandel_chunk_01.txt` … `kandel_chunk_15.txt`
(a `trail_index/books/` könyvtárban)

---

## 1. A könyv szerepe a Szima projektben / The book's role in Szima

**Magyar:** A Szima nem statisztikai neurális hálózatot épít, hanem az Idris 2
függőtípusos nyelven egy olyan rendszert, amelynek szabályai pontosan, levezetve és
számolva vannak jelen. A Kandel-könyv ebben a kettős szerepben áll: egyrészt
*követelmény-specifikáció* (mit kell a neokortex-szerű rendszernek tudnia), másrészt
*ellenőrző ortó* (a Szima-modulok által előállított struktúrák valóban megfelelnek-e az
élő idegrendszer ismert mechanizmusainak). A kötet 15 kivonat-fájlja 115 fogalmi
jegyzetet (ConceptNote) tartalmaz, amelyeket a mester index (`kandel_e8_index.md`)
kategorizált; ezek a jegyzetek a híd az empirikus idegtudomány és a Szima
kategóriaelméleti, E8-alapú tudásstruktúrája között.

**English:** Szima does not build a statistical neural network; it builds, in the
dependently-typed language Idris 2, a system whose rules are precisely stated,
derived, and computed. The Kandel book plays a dual role: it is a requirements
specification (what a neocortex-like system must be able to do) and a verification
oracle (whether the structures produced by Szima modules actually match the known
mechanisms of the living nervous system). The volume's 15 extract files contain 115
ConceptNotes, categorised in the master index (`kandel_e8_index.md`); these notes are
the bridge between empirical neuroscience and Szima's category-theoretic, E8-based
knowledge structure.

---

## 2. Az idegtudományi témák leképezése a Szima struktúrára / Mapping neuroscience themes

**Magyar:** A 115 jegyzet tizenkét fogalmi kategóriába rendeződik (lásd a mester index
(a) szakaszát). Röviden: a membrán biofizika és a szinaptikus átvitel a legkisebb
működő egységek; a neuromoduláció és a plaszticitás a változó és tanuló réteg; az
érzékelési kódolás, a motoros irányítás, a memória, a nyelv és érzelem, a fejlődés, a
döntés és tudatosság, valamint az idegrendszeri zavarok a magasabb, rendszerszintű
működés. Minden kategória a Szima tizenötdimenziós fázistere és a hozzá tartozó
E8×E8 algebra felé mutat — ezt a mester index (b) szakasza, az „E8 indexer" viszi tovább
jegyzetről jegyzetre.

**English:** The 115 notes fall into twelve conceptual categories (see section (a) of
the master index). In brief: membrane biophysics and synaptic transmission are the
smallest working units; neuromodulation and plasticity are the changing and learning
layer; sensory coding, motor control, memory, language and emotion, development,
decision and consciousness, and disorders are the higher, system-level functioning.
Every category points toward Szima's fifteen-dimensional phase space and the associated
E8×E8 algebra — this is carried further note-by-note in section (b) of the master
index, the "E8 indexer".

---

## 3. A releváns Szima Idris modulok / Relevant Szima Idris modules

**Magyar:** Az alábbi öt Szima Idris modul közvetlenül kapcsolódik a Kandel-könyv
tartalmához. Minden modul valódi fájl a `osveny_index/` könyvtárban.

**English:** The following five Szima Idris modules relate directly to the content of
the Kandel book. Each module is a real file in the `osveny_index/` directory.

| Modul (Útvonal / Path) | Miért releváns a Kandel-könyvhöz / Why relevant to Kandel |
|------------------------|-------------------------------------------------------------|
| `osveny_index/E8E8Algebra.idr` (E8×E8 algebra) | A bal E8 a teret, a jobb E8 a színt, a Clifford-szorzat a hangot jelöli. A könyv érzékelési kódolása (oszlopos térképek, duális frekvencia-koordináták) és a szinaptikus sűrűség-vektorok az E8 gyökrendszerének koordinátáiként írhatók le. |
| `osveny_index/KategoriaElmelet.idr` (Kategóriaelmélet) | A Hebb-szabály, az áramköri motivikumok, a neuromodulációs konvergencia, a bizonyíték-felhalmozódás (katamorfizmus) és a döntési duális reprezentáció mind a kategóriaelmélet fogalmaira (funktor, természetes transzformáció, kolimit, monoid, ellentétes kategória) vezethetők vissza. |
| `osveny_index/FazisAlgebra.idr` (Fázisalgebra) | A neuromoduláció a „fázis" komponens átállítása; a három kubit (saját tudat / másik fél / kapcsolat fázisa) a döntési változó koherenciája; a prediktív modell és az efferens másolat az időbeli fázis-vezérlés. |
| `osveny_index/Steane713.idr` (Steane [[7,1,3]] kód) | A kvantált (diszkrét csomagos) neurotranszmitter-felszabadulás a kód egy bitje; a tartós memória a hibajavított kód-szó; az idegrendszeri zavar a kód 1 hibája, amelyet a Szima kvantum-hibajavító ciklusa gyógyít (a kód távolsága 3, így 1 hiba javítható). |
| `osveny_index/OktonionAlgebra.idr` (Oktonion algebra) | A Cayley–Dickson nyelvi leképezés (magyar = O, oktogonion) és a nem-asszociatív szorzás a nyelv, a szaglás–érzelem áramkör és az affektív érték (value) területét fedi le. |

**English gloss of the table:** E8E8Algebra maps cortical geometry/feature vectors to
E8 roots; KategoriaElmelet captures Hebbian learning, circuit motifs, convergent
modulation, evidence accumulation, and dual decision representations as functors,
natural transformations, colimits, monoids, and opposite categories; FazisAlgebra
models neuromodulation as phase-setting and the three-qubit coherence of the decision
variable; Steane713 models quantal release as a code bit, memory as a codeword, and
disorder as a correctable error; OktonionAlgebra covers the Cayley–Dickson language
map and affect/value via non-associative multiplication.

---

## 4. A 15 kivonat-jegyzet fájl és a 15 magyar chunk fájl / The 15 note files and 15 Hungarian chunks

**Magyar:** A mester indexet a következő források táplálják:

**English:** The master index is built from the following sources:

- **Kivonat-jegyzetek (ConceptNotes):** `kandel_extracted_chunk_01.md`, `_02.md`, …,
  `_15.md` — ezek a 115 fogalmi jegyzetet tartalmazzák, amelyeket a mester index
  kategorizált.
- **Magyar chunk-fájlok (teljes szöveg):** `kandel_chunk_01.txt`, `_02.txt`, …,
  `_15.txt` — a kötet magyarul kivonatolt fejezetei, amelyek a jegyzetek eredeti
  szöveges hátterét adják.
- **Forrás PDF:** `/home/joco/EricKandler.pdf` — a teljes kötet eredeti angol
  szövege, amelyből a kivonatok és a jegyzetek származnak.

**English:** Extract notes (ConceptNotes): `kandel_extracted_chunk_01.md` … `_15.md`
hold the 115 categorised notes. Hungarian chunk files (full text): `kandel_chunk_01.txt`
… `_15.txt` give the original Hungarian-extracted chapter text behind the notes.
Source PDF: `/home/joco/EricKandler.pdf` is the complete original English volume from
which the extracts and notes derive.

---

## 5. Szintézis / Synthesis

**Magyar:** A *Principles of Neural Science* a Szima projekt empirikus talajterve:
megmondja, *mit* kell a neokortex-szerű architektúrának megvalósítania (a jelzés
egységes sémáját, a kvantált átvitelt, a Hebbi plaszticitást, a prediktív
motorvezérlést, a bizonyíték-alapú döntést, a memóriát és az érzelmi értéket), míg
az Szima Idris moduljai (E8E8Algebra, KategoriaElmelet, FazisAlgebra, Steane713,
OktonionAlgebra) azt adják meg, *hogyan* épüljön fel mindez kategóriaelméleti és E8
alapon, levezetve és számolva. A két új fájl — a mester index (`kandel_e8_index.md`)
és ez a kapcsolat-dokumentum — a híd a kettő között: a biológiai tényeket a Szima
tudásstruktúrájának pontjaiba rendezi.

**English:** *Principles of Neural Science* is Szima's empirical ground plan: it says
*what* the neocortex-like architecture must realise (the uniform signalling scheme,
quantal transmission, Hebbian plasticity, predictive motor control, evidence-based
decision, memory, and affective value), while the Szima Idris modules (E8E8Algebra,
KategoriaElmelet, FazisAlgebra, Steane713, OktonionAlgebra) give *how* it is
constructed on category-theoretic and E8 foundations, derived and computed. The two new
files — the master index (`kandel_e8_index.md`) and this connection document — are the
bridge between them: they arrange the biological facts into the nodes of Szima's
knowledge structure.
