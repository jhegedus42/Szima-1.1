# Kandel – Kivonat (Chunk 05 / 19. fejezet: Érintés)

Forrás: Kandel et al. — *Principles of Neural Science* (6. kiadás), 19. fejezet:
Touch (Érintés). A chunk 8220 sor, több fejezetet (19 Érintés, 20 Fájdalom,
21 Látás) ölel fel; az alábbi ConceptNote-ok a 19. fejezet mechanizmusaira
(érzékelés, receptorok, kéregi feldolgozás, szorítóerő-szabályozás)
koncentrálnak, mint a neokortex-szerű architektúra építőköveire.

Szabály: „E8" / „neocortex" / „kategoriaelmelet" címke CSÁK akkor, ha valódi
fogalmi híd létezik. Ebben a fejezetben **E8 valódi híd nem azonosítható**
(a receptor-biológiában nincs E8 szimmetria); az E8 címke ezért szándékosan
nincs használva. A „neocortex" és „kategoriaelmelet" címkék ott szerepelnek,
ahol a megfelelés valós (prediktív kódolás, oszlopos modul, populáció-kolimit,
funktorikus absztrakciós rétegezés).

---

```yaml
id: kandel19-active-passive-touch
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 19 Touch"
concept: Aktív és passzív érintés (active vs passive touch)
type: Pattern
idris_version: 2
summary: >
  Az aktív érintés egy felfelé-lefelé (top-down) folyamat, amelyben az alanynak
  ügynöksége (agency) van, konkrét információt keres, és irányítja a történteket;
  a passzív érintés alulról-felfelé (bottom-up) reakció a kísérletvezető vagy
  klinikus által szabályozott külső ingerekre. A kettő ugyanazt a receptor-
  populációt ingerli, de a kognitív jellemzőik (figyelem, viselkedéses cél)
  eltérnek.
signature: "aktivTouch : (cel : Cel) -> Ugynokseg -> SzenzorosBejarat"
code: |
  -- Idris 2 vázlat: az aktív érintés célvezérelt, a passzív külsőleg irányított
  data ErintesMode = Aktiv Cel | Passziv
  erintes : ErintesMode -> ReceptorPopulacio -> Valasz
causes: [kandel19-efference-copy]
caused_by: [ugynokseg, kulso_inger]
resolves: [hogy_a_gep_pontosan_tudja_mi_a_szandek]
tags: [neocortex, predictive-coding, active-perception, top-down]
```

```yaml
id: kandel19-efference-copy
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 19 Touch"
concept: Kísérő kisülés / efference copy (corollary discharge)
type: CausalRelation
idris_version: 2
summary: >
  A motoros kéreg descendáló rostjai az interneuronokon (dorsalis columna
  magvak, medialis dorsalis szarv) keresztül „efference copy"-t (kísérő
  kisülést) küldenek a szenzoros pályáknak, így a saját mozgás által keltett
  taktilis jel központilag elválasztható a külsőleg alkalmazott ingertől. Ez a
  prediktív kódolás (predictive coding) egyik legősibb biológiai megvalósítása.
signature: "efferenceCopy : MotorParancs -> (SzenzorosBejarat -> SzenzorosBejarat)"
code: |
  -- A motorparancs egy módosító, ami kivonja a saját mozgás okozta bemenetet
  efferenceCopy : MotorParancs -> SzenzorosBejarat -> SzenzorosBejarat
  efferenceCopy parancs bemenet = bemenet `minusz` (hatas parancs)
causes: [kandel19-feedback-gating]
caused_by: [kandel19-active-passive-touch, motor-parancs]
resolves: [sensory-ambiguity-during-active-movement]
tags: [neocortex, predictive-coding, corollary-discharge, motor]
```

```yaml
id: kandel19-four-receptors
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 19 Touch"
concept: Négy típusú mechanoreceptor a kézben
type: Definition
idris_version: 2
summary: >
  A kéz glabrous (szőrtelen) bőrében négy mechanoreceptor van: Meissner
  corpuscle (RA1, gyorsan alkalmazkodó 1. típus) és Merkel sejt (SA1, lassan
  alkalmazkodó 1. típus) a felszínes rétegekben; Ruffini ending (SA2) és
  Pacinian corpuscle (RA2) a mély rétegekben és a subcutan szövetben.
signature: "Mechanoreceptor : Type"
code: |
  data Mechanoreceptor
    = MeissnerCorpuscle  -- RA1
    | MerkelSejt         -- SA1
    | RuffiniEnding      -- SA2
    | PacinianCorpuscle  -- RA2
causes: [kandel19-sa-ra]
caused_by: [bor-anatomia]
resolves: [hogy_a-kezképes-sokféle-inger-kulonboztetésére]
tags: [receptor, touch, skin]
```

```yaml
id: kandel19-sa-ra
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 19 Touch"
concept: Lassan vs. gyorsan alkalmazkodó rostok (SA / RA)
type: Pattern
idris_version: 2
summary: >
  A lassan alkalmazkodó (slowly adapting, SA) rostok tartósan tüzelnek állandó
  bőrnyomásnál — ezek kódolják az alakot és a nyomást; a gyorsan alkalmazkodó
  (rapidly adapting, RA) rostok csak a stimulus kezdetén és végén tüzelnek —
  ezek kódolják a mozgást és a rezgést a bőrön vagy a bőrön át.
signature: "adaptacio : Mechanoreceptor -> (AllandoNyomas -> Valasz)"
code: |
  data Valasz = Tartos | Fazisos
  -- SA -> Tartos (forma, nyomás); RA -> Fazisos (mozgás, rezgés)
causes: [kandel19-receptive-field]
caused_by: [kandel19-four-receptors]
resolves: [form-vs-motion-discrimination]
tags: [receptor, adaptation, coding]
```

```yaml
id: kandel19-receptive-field
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 19 Touch"
concept: Receptív mező (receptive field)
type: Definition
idris_version: 2
summary: >
  Egy mechanoreceptor rost által lefedett korlátozott bőrterület. A típus-1
  (RA1, SA1) rostok kis, többszörös „hot spot"-os mezőkkel rendelkeznek
  (több receptor integrációja), a típus-2 (RA2, SA2) rostok nagy, egy központi
  hot spot-os mezőkkel rendelkeznek (egyetlen nagy receptor). Az ujjbegyi
  mezők a legkisebbek (SA1 ~11 mm², RA1 ~25 mm²).
signature: "receptivMezo : Mechanoreceptor -> Terulet"
code: |
  -- A mező a receptor terminálisainak eloszlása; típus-1 = több hot spot
  record ReceptivMezo = (kozeppont : Pont) (hotSpotok : Vect n Pont) (terulet : Double)
causes: [kandel19-two-point, kandel19-population-integration]
caused_by: [kandel19-sa-ra]
resolves: [spatial-localization]
tags: [receptive-field, topographic, skin]
```

```yaml
id: kandel19-population-integration
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 19 Touch"
concept: Populáció-kódolás és integráció egységes észleletté
type: CausalRelation
idris_version: 2
summary: >
  Az objektum téri tulajdonságait egy stimulált receptorpopuláció válaszai
  integrálják az agyban egy egységes észleletté (unified percept). Ez
  kategóriaelméleti értelemben egy kokúpot (colimit) idéz: a lokális
  receptorválaszok egy határozott egésszé olvadnak össze egy kokúppal (cocone).
  Valódi kategoriaelmeleti híd — a bemeneti objektumok kategóriájában a
  populáció egy diagram, a kéregi integráció a kolimit.
signature: "populacioIntegralas : (rf : Vect n ReceptivValasz) -> EgysegesEszlelet"
code: |
  -- A lokális válaszok egy kolimitba (cocone) konvergálnak
  populacioIntegralas : (i : Fin n) -> ReceptivValasz (rf !! i)
                        -> EgysegesEszlelet
causes: [egyseges-eszlelet]
caused_by: [kandel19-receptive-field]
resolves: [distributed-sensory-representation]
tags: [neocortex, kategoriaelmelet, population-coding, colimit]
```

```yaml
id: kandel19-two-point
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 19 Touch"
concept: Kétpont-diszkrimináció / taktilis élesség (tactile acuity)
type: Pattern
idris_version: 2
summary: >
  A kétpont-küszöb (two-point threshold) a receptív mező átmérőjétől függ:
  kisebb mező = élesebb felbontás. Ujjbegyen ~1 mm (fiatal felnőtt), tenyéren
  ~10 mm, a karon/háton ~40 mm. Az élesség a testfelület csúcsain (ujjbegy,
  ajkak, nyelv) a legnagyobb, ahol a mezők a legkisebbek.
signature: "ketPontKuszob : Terulet -> Hossz"
code: |
  -- monoton: kisebb receptív mező -> kisebb küszöb (élesebb felbontás)
  ketPontKuszob mezo = inversArany mezo.receptivMezoAtmerojevel
causes: [kandel19-cortical-magnification]
caused_by: [kandel19-receptive-field]
resolves: [spatial-acuity-measurement]
tags: [acuity, receptive-field, discrimination]
```

```yaml
id: kandel19-hierarchical-abstraction
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 19 Touch"
concept: Fokozatos absztrakció a szukcesszív centrális szinapszisokban
type: Pattern
idris_version: 2
summary: >
  A taktilis információ a szukcesszív centrális szinapszisokban (gerincvelő →
  thalamus → S-I → S-II → posterior parietalis kéreg) egyre absztraktabbá válik,
  az elemi receptor-eseménytől a kognitív objektum-felismerésig. Ez
  funktorkompozíciónak (functorial layering) felel meg: minden réteg egy
  magasabb absztrakciós szintre emelő függvény a kategóriaelméletben.
signature: "absztrakciosLepcsok : (reteg : Nat) -> (Valasz -> AbsztraktValasz reteg)"
code: |
  -- Rétegenként emelkedő functor: F0 ⊆ F1 ⊆ F2 ⊆ ...
  absztrakciosLepcsok : (k : Nat) -> Functor (ErzetiSzint k) (ErzetiSzint (k+1))
causes: [kandel19-columnar-organization]
caused_by: [kandel19-population-integration]
resolves: [perception-to-cognition-bridge]
tags: [neocortex, kategoriaelmelet, hierarchy, functor]
```

```yaml
id: kandel19-columnar-organization
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 19 Touch"
concept: Oszlopos szerveződés a primer szomatoszenzoros kéregben (S-I)
type: Definition
idris_version: 2
summary: >
  A S-I kéreg 300–600 μm széles, a pial felszíntől a fehér állományig terjedő
  függőleges oszlopokból (columns) áll; minden oszlop ugyanabból a bőrterületből
  kap bemenetet és ugyanazt a receptorosztályt dolgozza fel. A thalamocorticalis
  bemenet az IV. rétegben érkezik, onnan függőlegesen terjed a felszín felé.
  Ez a neokortex alapvető moduláris egysége — közvetlenül releváns a
  neokortex-szerű AI architektúrához.
signature: "oszlop : Terulet -> (L1 ** L2 ** L3 ** L4 ** L5 ** L6)"
code: |
  -- Egy oszlop = hat réteg függőleges kompozíciója (DPair sorozat)
  record Oszlop = (bemenetTerulet : Terulet)
                  (reteg : L1 ** L2 ** L3 ** L4 ** L5 ** L6)
causes: [kandel19-cortical-magnification]
caused_by: [kandel19-hierarchical-abstraction]
resolves: [modular-cortical-computation]
tags: [neocortex, column, cortex, module]
```

```yaml
id: kandel19-modality-segregation
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 19 Touch"
concept: Modalitás-szegregáció az emelkedő pályákon
type: Pattern
idris_version: 2
summary: >
  Az érintés (dorsalis columna–medialis lemniscus rendszer) és a proprioceptio
  pályái topográfiailag és funkcionálisan különválnak egészen a thalamusig;
  a VPL/VPM magvak a bőrt, a VPS a izmok/ízületek proprioceptióját küldi a
  parietalis kéreg különböző régióiba (3b/1 vs 3a).
signature: "modalitasUt : Modalitas -> ThalamusMag"
code: |
  data Modalitas = Tapintas | Proprioceptio
  modalitasUt Tapintas = VPL_VPM
  modalitasUt Proprioceptio = VPS
causes: [kandel19-columnar-organization]
caused_by: [anatomiai-palyak]
resolves: [cross-modal-interference]
tags: [pathway, segregation, thalamus]
```

```yaml
id: kandel19-cortical-magnification
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 19 Touch"
concept: Kortikális nagyítás / homunculus
type: Pattern
idris_version: 2
summary: >
  A testfelület kortikális képviselete NEM a testmérettel arányos, hanem az
  érintés szempontjából való fontossággal (innervációs sűrűséggel). Az ujjak
  ~3× több kortikális oszlopot kapnak, mint a törzs, noha a törzs bőrfelülete
  nagyobb. Ez az „erőforrás-allokáció a fontosság szerint" minta.
signature: "kortikalisTerulet : TestResz -> Double"
code: |
  -- arányos az innervációs sűrűséggel, nem a testmérettel
  kortikalisTerulet resz = kepessegiSuly resz * innervaciosSuruseg resz
causes: [kandel19-two-point]
caused_by: [kandel19-receptive-field]
resolves: [efficient-resource-allocation]
tags: [neocortex, magnification, topographic, homunculus]
```

```yaml
id: kandel19-grip-control
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 19 Touch"
concept: Szorítóerő-szabályozás taktilis visszacsatolással
type: CausalRelation
idris_version: 2
summary: >
  A megragadás egy zárt hurkú (closed-loop) rendszer: SA1 a szorítóerőt, RA1 a
  felhordás sebességét, RA2 a tárgyon áthaladó rezgéseket (emelés/letétel),
  SA2 a kéztartást kódolja. A motoros kéreg a csúszás (RA1 tangenciális
  mozgás) jelére automatikusan növeli a szorítóerőt. Ez az érzékelő-motoros
  integráció mintapéldája a neokortexben.
signature: "gripSzabalyzas : (ra1 : CsuszasJel) -> (motorParancs : NoveldSzoritast)"
code: |
  -- csúszás észlelése -> szorítóerő növelése (zárt hurok)
  gripSzabalyzas : RA1Valasz -> MotorParancs
  gripSzabalyzas (Csuszas erosseg) = NoveldSzoritast erosseg
causes: [kandel19-feedback-gating]
caused_by: [kandel19-four-receptors, kandel19-sa-ra]
resolves: [slip-prevention, skilled-manipulation]
tags: [neocortex, sensorimotor, closed-loop, motor]
```

```yaml
id: kandel19-feedback-gating
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 19 Touch"
concept: Visszacsatoló jelek az érzékelési bemenet gating-jére
type: Pattern
idris_version: 2
summary: >
  A magasabb szomatoszenzoros és motoros (posterior parietalis, frontalis
  motoros, limbikus) területek feedback jelei szabályozzák az alacsonyabb
  rétegek excitabilitását, gating-elve a szenzoros jeleket a figyelem és a
  motoros aktivitás során. Ez a prediktív kódolás (predictive coding) korai,
  szinaptikus megvalósítása — a „fenti" modulációja a „lenti" bemenetnek.
signature: "feedbackGate : (felsoModul : Jelek) -> (alsoBejarat : SzenzorosBejarat) -> SzenzorosBejarat"
code: |
  -- a felső réteg módosítja az alsó réteg bemenetét (gating)
  feedbackGate modulacio bemenet = szure Modulacio bemenet
    where szure m b = if aktiv m then b else Null
causes: [kandel19-efference-copy]
caused_by: [kandel19-hierarchical-abstraction]
resolves: [sensory-overload-during-action]
tags: [neocortex, predictive-coding, gating, attention]
```

```yaml
id: kandel19-vibration-coding
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 19 Touch"
concept: Rezgéskódolás multiplexelése (frequency × amplitude)
type: Pattern
idris_version: 2
summary: >
  A rezgés frekvenciáját a spike-train fáziszárolása (phase locking) kódolja —
  minden akciós potenciál egy vibrációs ciklust jelez; az amplitúdót a cikluson-
  kénti spike-szám (burst) és az aktivált rostok össz-kimenete. Egyidejű
  frekvencia- és intenzitás-multiplexelés egyetlen rostpopuláción.
signature: "rezgesKod : Vibratio -> (fazis : SpikeMinta, amplitude : Nat)"
code: |
  -- frekvencia = fáziszárolás, amplitúdó = spike-szám / másodperc
  rezgesKod v = (fazisZarolt v.frekvencia, osszSpike v.amplitudo)
causes: [kandel19-sa-ra]
caused_by: [kandel19-four-receptors]
resolves: [multiplex-frequency-amplitude]
tags: [coding, multiplexing, vibration]
```
