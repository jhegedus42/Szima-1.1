# Kandel — Kivonat (ConceptNotes) / Extraction — chunk 01

Forrás chunk: `kandel_chunk_01.txt` — ez a kötet Eleje (front matter): címlap, ajánlás,
jogi nyilatkozat, tartalomjegyzék (Contents in Brief + Contents). A tényleges mechanizmus-szöveg
(action potential, ioncsatornák, szinapszis) a későbbi chunkekben van; itt csak a fejezetcímek és
a fejezetekben kiemelt (highlight) elvi állítások alkotják a kinyerhető fogalmi anyagot.

Konvenció: `idris_version: 2` mindenhol, ahol a projekt északkövetkezetesen Idris 2 típussal
modellezi a fogalmat. Az `E8` / `neocortex` / `kategoriaelmelet` címke csak valódi fogalmi híd
esetén kerül fel.

---

- id: kandel_01_ionchannel_def
  source: "Principles of Neural Science" (6th ed.) — Ch. 8 Ion Channels
  concept: Ioncsatorna (Ion Channel)
  type: Definition
  idris_version: 2
  summary: >
    Az ioncsatorna egy fehérje, amely átíveli a sejthártyát, és szelektíven átereszti az ionokat.
    A csatornanyitás/zárás konformációs változással jár; egycsatornás áram rögzíthető.
  signature: "Ionsatorna : (feherje : Feherje) -> (atmeres : Atmero) -> (szelektivitas : IonFajta -> Type) -> Type"
  code: |
    -- Idris 2 vázlat: egy ioncsatorna szelektivitása típusszinten rögzítve
    public export
    data Ionsatorna : (szelektiv : IonFajta) -> Type where
      KonstrualtIonsatorna : (fajta : IonFajta) -> Ionsatorna fajta
  related: [kandel_01_voltagegated_def, kandel_01_restingpot_def, kandel_01_fluxvsdiff]
  causes: [kandel_01_membranpot, kandel_01_actionpot]
  caused_by: []
  resolves: [kandel_01_selective_permeability]
  tags: [ioncsatorna, membran, sejtbiológia]

- id: kandel_01_voltagegated_def
  source: "Principles of Neural Science" (6th ed.) — Ch. 8 & 10
  concept: Feszültségvezérelt csatorna (Voltage-Gated Channel)
  type: Definition
  idris_version: 2
  summary: >
    Feszültségvezérelt csatornák nyitása a membránfeszültség változásától függ. Nátrium-, kálium-,
    kalcium- és hiperpolarizáció-aktivált ciklikus-nukleotid-vezérelt típusok léteznek; genetikai
    úton sokszínűsödnek (pl. alternatív splicing, családok).
  signature: "FeszultsegVezereltCsatorna : (ion : IonFajta) -> (kuszob : Feszultseg) -> Type"
  code: |
    public export
    data FeszultsegVezereltCsatorna : (ion : IonFajta) -> Type where
      NatriumCsatorna  : FeszultsegVezereltCsatorna Natrium
      KaliumCsatorna   : FeszultsegVezereltCsatorna Kalium
      KalciumCsatorna  : FeszultsegVezereltCsatorna Kalcium
  related: [kandel_01_ionchannel_def, kandel_01_actionpot, kandel_01_sodiumselect]
  causes: [kandel_01_actionpot]
  caused_by: [kandel_01_membranpot]
  resolves: [kandel_01_propagated_signal]
  tags: [ioncsatorna, feszültség, jelátvitel]

- id: kandel_01_restingpot_def
  source: "Principles of Neural Science" (6th ed.) — Ch. 9 Membrane Potential
  concept: Nyugalmi membránpotenciál (Resting Membrane Potential)
  type: Definition
  idris_version: 2
  summary: >
    A nyugalmi potenciál a töltés szétválasztásából a sejthártya két oldala között származik.
    Nongated és gated csatornák, valamint aktív transzport (Na/K pumpa) határozzák meg; a Goldman-egyenlet
    kvantálja a különböző ionok hozzájárulását.
  signature: "NyugalmiPotencial : (gradienst : IonGradienst) -> (permabilis : IonFajta -> Type) -> Feszultseg"
  code: |
    -- Goldman-egyenlet iránya: súlyozott permeabilitásokból számolt egyensúlyi feszültség
    public export
    NyugalmiPotencial : (p : IonFajta -> Double) -> (konc : IonFajta -> (kint : Double, belul : Double)) -> Double
    NyugalmiPotencial p konc = ?goldman_onelet -- Refl-lel bizonyítandó zárt alak
  related: [kandel_01_ionchannel_def, kandel_01_goldman, kandel_01_actionpot]
  causes: [kandel_01_actionpot]
  caused_by: [kandel_01_ionchannel_def]
  resolves: [kandel_01_electrochem_grad]
  tags: [membránpotenciál, Goldman, egyensúly]

- id: kandel_01_goldman
  source: "Principles of Neural Science" (6th ed.) — Ch. 9
  concept: Goldman-egyenlet (Goldman Equation)
  type: Definition
  idris_version: 2
  summary: >
    A Goldman-egyenlet kvantálja, hogy a különböző ionok (Na, K, Ca, Cl) hogyan járulnak hozzá a
    nyugalmi membránpotenciálhoz, a permeabilitásaik súlyozásával.
  signature: "Goldman : (p : IonFajta -> Double) -> (konc : IonFajta -> (kint : Double, belul : Double)) -> Feszultseg"
  code: |
    -- l. kandel_01_restingpot_def kódot; itt csak a típus-híd
    public export
    Goldman : (permeabilitas : IonFajta -> Double) -> (koncentracio : IonFajta -> KettoSzam) -> Feszultseg
  related: [kandel_01_restingpot_def]
  causes: []
  caused_by: []
  resolves: [kandel_01_ion_contrib]
  tags: [Goldman, egyenlet, membránpotenciál]

- id: kandel_01_actionpot
  source: "Principles of Neural Science" (6th ed.) — Ch. 10 Action Potential
  concept: Cselekvési potenciál (Action Potential)
  type: Definition
  idris_version: 2
  summary: >
    A cselekvési potenciál az ionok áramlásából keletkezik feszültségvezérelt csatornákon át;
    all-or-none jel, amelyet a trigger zóna dönt el, és amelyet a vezető komponens propagál.
    Újraépíthető a nátrium- és káliumcsatornák tulajdonságaiból.
  signature: "CselekvesiPotencial : (ingeru : Feszultseg) -> (kuszob : Feszultseg) -> Either NemKivaltott Kivaltott"
  code: |
    public export
    data CselekvesiPotencial : Type where
      Nyugalom    : CselekvesiPotencial
      Kivaltas    : (amplit : Double) -> CselekvesiPotencial   -- all-or-none
  related: [kandel_01_voltagegated_def, kandel_01_restingpot_def, kandel_01_napot_recon]
  causes: [kandel_01_neurotransmitter_release]
  caused_by: [kandel_01_voltagegated_def]
  resolves: [kandel_01_propagated_signal]
  tags: [cselekvési potenciál, all-or-none, jelpropagáció, neocortex]

- id: kandel_01_napot_recon
  source: "Principles of Neural Science" (6th ed.) — Ch. 10
  concept: Cselekvési potenciál rekonstrukciója Na/K csatornákbol
  type: Pattern
  idris_version: 2
  summary: >
    A cselekvési potenciál alakja levezethető a nátrium- és káliumvezetékek (conductances) áramaiból.
    Ez a "mechanizmusból forma" mintázat: a makrojel a mikroszkopikus csatornadinasztika összege.
  signature: "Rekonstrukcio : (naAram : Aram) -> (kAram : Aram) -> CselekvesiPotencial"
  code: |
    -- a vezeték = áram / feszültség; a potenciál a két áram függvénye
    public export
    Rekonstrukcio : (gNa : Double) -> (gK : Double) -> CselekvesiPotencial
    Rekonstrukcio gNa gK = ?cselekves_alak -- numerikus Idris Double szimulációval ellenőrizendő
  related: [kandel_01_actionpot, kandel_01_voltagegated_def]
  causes: []
  caused_by: [kandel_01_voltagegated_def]
  resolves: [kandel_01_emergent_shape]
  tags: [minta, emergencia, csatornadinasztika, neocortex]

- id: kandel_01_synapse_overview
  source: "Principles of Neural Science" (6th ed.) — Ch. 11 Overview of Synaptic Transmission
  concept: Szinapszis — elektromos vs kémiai
  type: Definition
  idris_version: 2
  summary: >
    A szinapszisok túlnyomórészt elektromosak vagy kémiaiak. Az elektromos (gap-junction)
    gyors, szinkron átvitelt ad; a kémiai felerősítheti a jelet, és a posztszinaptikus
    receptor tulajdonságaitól függ.
  signature: "Szinapszis : Either ElektromosSzinapszis KemiaiSzinapszis"
  code: |
    public export
    data Szinapszis : Type where
      Elektromos  : (kapu : GapJunction) -> Szinapszis
      Kemiai      : (to : Neurotranszmitter) -> Szinapszis
  related: [kandel_01_gapjunction, kandel_01_chemsynapse_amp, kandel_01_neurotransmitter_release]
  causes: [kandel_01_chemsynapse_amp]
  caused_by: []
  resolves: [kandel_01_signal_coupling]
  tags: [szinapszis, jelátvitel, neocortex]

- id: kandel_01_chemsynapse_amp
  source: "Principles of Neural Science" (6th ed.) — Ch. 11 (highlight)
  concept: Kémiai szinapszisok felerősítik a jelet
  type: CausalRelation
  idris_version: 2
  summary: >
    A kémiai szinapszisok képesek amplifikálni a jelet: egy preszinaptikus esemény sok
    posztszinaptikus receptorcsatornát nyithat meg. Ez a felerősítés a neuronális
    számítás egyik alapja.
  signature: "Amplifikacio : (eloszin : Jel) -> (utoszin : Jel) -> (nagyobb : Koncentracio utoszin eloszin) -> Type"
  code: |
    public export
    Amplit : (be : Double) -> (ki : Double) -> Type
    Amplit be ki = So (ki > be)
  related: [kandel_01_synapse_overview, kandel_01_neurotransmitter_release]
  causes: [kandel_01_synaptic_integration]
  caused_by: [kandel_01_synapse_overview]
  resolves: [kandel_01_gain_control]
  tags: [szinapszis, amplifikáció, jelerősítés, neocortex]

- id: kandel_01_gapjunction
  source: "Principles of Neural Science" (6th ed.) — Ch. 11
  concept: Gap-junction (elektromos szinapszis)
  type: Definition
  idris_version: 2
  summary: >
    Az elektromos szinapszisban lévő sejteket gap-junction csatornák kötik össze; ez gyors,
    szinkron tüzelést tesz lehetővé, és szerepe van a glia működésében és egyes betegségekben is.
  signature: "GapJunction : (sejtA : Sejt) -> (sejtB : Sejt) -> Osszekotes"
  code: |
    public export
    GapJunction : (a : Sejt) -> (b : Sejt) -> Type
    GapJunction a b = Kapcsolodott a b
  related: [kandel_01_synapse_overview]
  causes: [kandel_01_sync_firing]
  caused_by: []
  resolves: [kandel_01_rapid_coupling]
  tags: [gap-junction, glia, szinkron]

- id: kandel_01_neurotransmitter_release
  source: "Principles of Neural Science" (6th ed.) — Ch. 12 & 15
  concept: Neurotranszmitter-kibocsátás diszkrét csomagokban (kvantális)
  type: Pattern
  idris_version: 2
  summary: >
    Az acetilkolin (és általában a neurotranszmitterek) diszkrét csomagokban (kvantákban)
    szabadul fel; az end-plate potenciál helyi permeabilitásváltozásból származik. Ez a
    "kvantált jel" mintázat a digitális idegrendszeri kód alapja.
  signature: "Kibocsatas : (csomagok : Nat) -> ( osszes : List Neurotranszmitter) -> Hossz osszes = csomagok"
  code: |
    public export
    KvantaltKibocsatas : (n : Nat) -> Vect n Neurotranszmitter
    KvantaltKibocsatas Z = []
    KvantaltKibocsatas (S k) = EgyCsomag :: KvantaltKibocsatas k
  related: [kandel_01_synapse_overview, kandel_01_chemsynapse_amp, kandel_01_actionpot]
  causes: [kandel_01_postsyn_pot]
  caused_by: [kandel_01_actionpot]
  resolves: [kandel_01_quantal_coding]
  tags: [kvantális, neurotranszmitter, kódolás, neocortex]

- id: kandel_01_nmda
  source: "Principles of Neural Science" (6th ed.) — Ch. 13 Synaptic Integration
  concept: NMDA receptor — hosszú távú szinaptikus plasticitás alapja
  type: Definition
  idris_version: 2
  summary: >
    Az NMDA receptor egy ionotróp glutamát receptor-k csatorna, egyedi biofizikai és farmakológiai
    tulajdonságokkal. Tulajdonságai alátámasztják a hosszú távú szinaptikus plasticitást (LTP),
    ezért központi a tanulás és memória idegrendszeri modelljében.
  signature: "NMDAReceptor : (koaktivalas : Bool) -> (MagnesiumRako : Bool) -> Ionotropikus"
  code: |
    public export
    data NMDAReceptor : Type where
      -- koaktiváció (pre + poszt) és Mg blokk eltávolítása szükséges a Ca beáramláshoz
      NyitottNMDA : (preEs PostKozos : Bool) -> (mgBlokkNelkul : Bool) -> NMDAReceptor
  related: [kandel_01_hebbian, kandel_01_ltp, kandel_01_synaptic_plasticity]
  causes: [kandel_01_ltp]
  caused_by: [kandel_01_hebbian]
  resolves: [kandel_01_longterm_memory]
  tags: [NMDA, LTP, plasticitás, tanulás, neocortex, kategoriaelmelet]

- id: kandel_01_hebbian
  source: "Principles of Neural Science" (6th ed.) — Ch. 5 Computational Bases (highlight)
  concept: Hebbi plasticitás azonosítja a domináns bemeneti mintákat
  type: Rule
  idris_version: 2
  summary: >
    "A domináns szinaptikus bemeneti mintázatok Hebbi plasticitással azonosíthatók." A gyakran
    együtt tüzelő bemenetek szinapszisa megerősödik — ez a Hebb-szabály, a tanulás és memória
    alapja, és közvetlen fogalmi híd a kategóriaelméleti struktúraképzéshez.
  signature: "Hebb : (a : Bemenet) -> (b : Bemenet) -> (egyuttTuzel : a ~> b) -> Megerositett (a,b)"
  code: |
    -- Hebb elve: az együtt aktivált csomópontok éle megerősödik
    public export
    HebbiMegerosites : (egyutt : Bool) -> (suly : Double) -> (ujSuly : Double)
    HebbiMegerosites egyutt suly = if egyutt then suly + 1 else suly
  related: [kandel_01_nmda, kandel_01_synaptic_plasticity, kandel_01_ltp]
  causes: [kandel_01_synaptic_plasticity]
  caused_by: [kandel_01_coactivation]
  resolves: [kandel_01_pattern_learning]
  tags: [Hebb, plasticitás, tanulás, neocortex, kategoriaelmelet]

- id: kandel_01_synaptic_plasticity
  source: "Principles of Neural Science" (6th ed.) — Ch. 5 (highlight)
  concept: Tanulás és memória a szinaptikus plasticitástól függ
  type: CausalRelation
  idris_version: 2
  summary: >
    "A tanulás és memória a szinaptikus plasticitástól függ." A viselkedés tartós megváltozása
    a szinapszisok súlyának és szerkezetének módosulásán keresztül valósul meg.
  signature: "Fuggoseg : (tanulas : Viselkedes) -> (plasticitas : SzinaptikusValtozas) -> OkOkozat"
  code: |
    public export
    TanulasMemoriaFugg : (pl : SzinaptikusPlasticitas) -> (tm : TanulasMemoria) -> Type
    TanulasMemoriaFugg pl tm = Okozza pl tm
  related: [kandel_01_hebbian, kandel_01_nmda, kandel_01_ltp]
  causes: [kandel_01_memory]
  caused_by: [kandel_01_synaptic_plasticity_mech]
  resolves: [kandel_01_behavior_change]
  tags: [plasticitás, tanulás, memória, neocortex, kategoriaelmelet]

- id: kandel_01_ltp
  source: "Principles of Neural Science" (6th ed.) — Ch. 13 (highlight)
  concept: Az NMDA receptor tulajdonságai alátámasztják a hosszú távú szinaptikus plasticitást
  type: CausalRelation
  idris_version: 2
  summary: >
    Az NMDA receptorok egyedi tulajdonságai (feszültség- és ligandumvezérelt, Mg-blokkolt,
    Ca-áteresztő) teszik lehetővé a hosszú távú potenciálást (LTP). Ez a mechaniztikus híd
    a Hebbi szabály és a tartós memória között.
  signature: "LTP : (nmda : NMDAReceptor) -> (caBearamlas : Double) -> SzinaptikusMegerosites"
  code: |
    public export
    HosszuTavuPotencialas : (nyitott : NMDAReceptor) -> (ca : Double) -> SzinaptikusSuly
    HosszuTavuPotencialas nyitott ca = NoveltSuly ca
  related: [kandel_01_nmda, kandel_01_hebbian, kandel_01_synaptic_plasticity]
  causes: [kandel_01_memory]
  caused_by: [kandel_01_nmda]
  resolves: [kandel_01_persistent_change]
  tags: [LTP, NMDA, plasticitás, memória, neocortex]

- id: kandel_01_signaling_uniform
  source: "Principles of Neural Science" (6th ed.) — Ch. 3 (highlight)
  concept: A jelzés minden idegsejtben ugyanúgy szerveződik
  type: Pattern
  idris_version: 2
  summary: >
    "A jelzés szerveződése minden idegsejtben azonos": bemeneti komponens (fokozatos helyi jel),
    trigger zóna (döntés akcióspotenciálról), vezető komponens (all-or-none terjedés), kimeneti
    komponens (neurotranszmitter-kibocsátás). Ez a négykomponensű séma univerzális huzalozási minta.
  signature: "SejtJelzes : (be : Bemenet) -> (trigger : Dontes) -> (vezeto : Terjedes) -> (ki : Kimenet) -> Neurolog"
  code: |
    public export
    data SejtJelzes : Type where
      Komponens : (be : Bemenet) -> (trig : TriggerZona) -> (terj : Terjedes) -> (ki : Kimenet) -> SejtJelzes
  related: [kandel_01_actionpot, kandel_01_neurotransmitter_release, kandel_01_reflex]
  causes: [kandel_01_reflex]
  caused_by: []
  resolves: [kandel_01_uniform_wiring]
  tags: [minta, jelzés, architektúra, neocortex]

- id: kandel_01_circuit_motifs
  source: "Principles of Neural Science" (6th ed.) — Ch. 5 (highlight)
  concept: Neuronális áramköri motivikumok (motifs) alaplogikát adnak az információfeldolgozásnak
  type: Pattern
  idris_version: 2
  summary: >
    A helyi áramkörök (feed-forward hierarchia, visszacsatolás/recurrent) ismétlődő motivikumokat
    alkotnak; ezek a motivikumok adják az információfeldolgozás alaplogikáját. A vizuális
    feldolgozás hierarchikus feed-forward reprezentáción alapul.
  signature: "Motif : (tipus : KorTipus) -> (kapcsolat : List El) -> Aramkor"
  code: |
    public export
    data Motif : Type where
      FeedForward : (retek : Vect n Regio) -> Motif
      Visszacsatolas : (ciklikus : El) -> Motif
  related: [kandel_01_signaling_uniform, kandel_01_hebbian]
  causes: [kandel_01_info_processing]
  caused_by: []
  resolves: [kandel_01_circuit_logic]
  tags: [motif, áramkör, információfeldolgozás, neocortex, kategoriaelmelet]

- id: kandel_01_reflex
  source: "Principles of Neural Science" (6th ed.) — Ch. 3
  concept: Reflex-áramkör — a viselkedés idegrendszeri architektúrájának kiindulópontja
  type: Example
  idris_version: 2
  summary: >
    A nyújtási reflex (stretch-reflex) útja illusztrálja, hogyan alakul át a szenzoros jel
    motoros jellé egy egyszerű áramköron át. A reflex-áramkör a komplexebb viselkedési
    architektúra értelmezésének kiindulópontja.
  signature: "Reflex : (szenzoros : Jel) -> (koztes : Neuron) -> (motoros : Valasz) -> Ut"
  code: |
    public export
    NyujtasiReflex : (s : SzenzorosRovid) -> (a : AlfaMotor) -> Ut
    NyujtasiReflex s a = EgyenesUt s a
  related: [kandel_01_signaling_uniform, kandel_01_circuit_motifs]
  causes: []
  caused_by: [kandel_01_signaling_uniform]
  resolves: [kandel_01_simple_behavior]
  tags: [reflex, példa, architektúra, neocortex]

- id: kandel_01_fluxvsdiff
  source: "Principles of Neural Science" (6th ed.) — Ch. 8
  concept: Az ionáramlás a csatornán át különbözik a szabad oldatbeli diffúziótól
  type: Definition
  idris_version: 2
  summary: >
    Az ionok csatornán átfolyó fluxusa nem azonos a szabad oldatbeli diffúzióval: a csatorna
    szelektivitása és energiagátjai alakítják az áramlást (pl. hidratációs energia, méret, töltés).
  signature: "Flux : (csatorna : Ionsatorna) -> (aramlasis : Aram) -> (nemDiffuzio : Not FreeDiffusion) -> Type"
  code: |
    public export
    CsatornaFlux : (szel : Ionsatorna) -> (szabad : Diffuzio) -> Type
    CsatornaFlux szel szabad = Kulonbozo szel szabad
  related: [kandel_01_ionchannel_def, kandel_01_sodiumselect]
  causes: [kandel_01_selective_permeability]
  caused_by: []
  resolves: [kandel_01_channel_selectivity]
  tags: [diffúzió, flux, szelektivitás]

- id: kandel_01_sodiumselect
  source: "Principles of Neural Science" (6th ed.) — Ch. 10
  concept: Feszültségvezérelt nátriumcsatorna szelektivitása méret/töltés/hidratáció alapján
  type: Definition
  idris_version: 2
  summary: >
    A feszültségvezérelt nátriumcsatorna a nátriumot a részecske mérete, töltése és hidratációs
    energiája alapján választja ki a többi ion közül.
  signature: "Szelektivitas : (ion : IonFajta) -> (meret : Double) -> (toltes : Int) -> (hidr : Double) -> Bool"
  code: |
    public export
    NatriumSzelektiv : (i : IonFajta) -> Bool
    NatriumSzelektiv Natrium = True
    NatriumSzelektiv _ = False
  related: [kandel_01_voltagegated_def, kandel_01_fluxvsdiff]
  causes: [kandel_01_actionpot]
  caused_by: []
  resolves: [kandel_01_ion_specificity]
  tags: [nátrium, szelektivitás, csatorna]

- id: kandel_01_selective_permeability
  source: "Principles of Neural Science" (6th ed.) — Ch. 8
  concept: Szelektív permeabilitás szerkezeti alapja (klorid csatorna ~ transzporter)
  type: Pattern
  idris_version: 2
  summary: >
    A klorid csatornák szelektív permeabilitásának szerkezeti alapja szoros rokonságot mutat a
    transzporterekével — a csatorna és szállító fehérjék családjai átfednek.
  signature: "SzelektivPermeabilitas : (csatorna : Feherje) -> (szallito : Feherje) -> Kapcsolat"
  code: |
    public export
    SzelektivPermeabilitas : (c : Feherje) -> (s : Feherje) -> Type
    SzelektivPermeabilitas c s = Rokon c s
  related: [kandel_01_ionchannel_def, kandel_01_fluxvsdiff]
  causes: []
  caused_by: []
  resolves: [kandel_01_channel_transporter_link]
  tags: [klorid, permeabilitás, transzporter]

---

## Jegyzet a chunk határáról / Boundary note

Ez a chunk a kötet Elejét (front matter) tartalmazza: címlap (1–41), ajánlás Sarah H. Macknak
(64–114) és Thomas M. Jessellnek (120–196), jogi nyilatkozat (202–218), és a teljes
tartalomjegyzék (224–634+). A mechanizmus-leíró szöveg (cselekvési potenciál kinetikája,
csatornadinasztika, szinapszis molekuláris részletei) a `kandel_chunk_02` és további chunkekben
van — azok feldolgozása további ConceptNote-okat fog adni (pl. valódi Hodgkin–Huxley típusok,
javított kvantális modell, cáfolható mérések).
