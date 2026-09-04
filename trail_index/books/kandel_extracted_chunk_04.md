# Kandel Chunk 04 — Kivonatolt Fogalmi Jegyzetek (ConceptNotes)

Forrás: Kandel et al., *Principles of Neural Science* (6th ed.), Chapter 14 —
"Modulation of Synaptic Transmission and Neuronal Excitability: Second Messengers".

A jegyzetek a neokortex-szerű architektúra szempontjából releváns mechanizmusokra
fókuszálnak: állapotfüggő moduláció, konvergencia, hosszú távú plauzibilitás,
áramkör-újrakonfigurálás. A "neocortex" / "kategoriaelmelet" / "E8" címkék csak
valódi fogalmi híd esetén kerültek fel.

---

```yaml
- id: kandel14_gprotein_direct_gating
  source: "Principles of Neural Science (Kandel), Chapter 14 — Second Messengers"
  concept: "G-fehérje közvetlen ioncsatorna-nyitása (GIRK, βγ-alegység)"
  type: CausalRelation
  idris_version: 2
  summary: >
    A metabotrop receptorhoz kötődő transzmitter felszabadít egy G-fehérje
    alegységet, amely közvetlenül kölcsönhat a céloncsatornával anélkül, hogy
    diffundáló második hírvivőt hozna létre. A GIRK K+-csatornát a Gi/Go
    fehérje βγ komplexe nyitja meg, hiperpolarizálva a sejtet EK irányába.
  signature: "GProteinBetaGamma -> IonChannel -> ChannelState"
  code: |
    -- A βγ alegység NEM hoz létre diffundáló második hírvivőt:
    -- a hatás a receptorhoz kötött marad (membrane-tethered).
    adat GIRKNyitas : Receptor -> GiGoFeherje -> BetaGamma -> GIRKCsatorna -> Nyitott
  related: [kandel14_pip2_mchannel, kandel14_camp_pka_schannel, kandel14_convergence]
  causes: [kandel14_firing_rate_modulation]
  caused_by: [kandel14_metabotropic_binding]
  resolves: [kandel14_fast_modulation_without_second_messenger]
  tags: [neocortex, gprotein, girk, beta_gamma, direct_gating, ion_channel]

- id: kandel14_pip2_mchannel
  source: "Principles of Neural Science (Kandel), Chapter 14 — Second Messengers"
  concept: "M-típusú K+ csatorna zárása PIP2 hidrolízissel (ACh)"
  type: Pattern
  idris_version: 2
  summary: >
    A muszkarinos ACh receptor aktiválja a PLC-t, amely csökkenti a membrán
    PIP2 szintjét; az M-csatorna működéséhez PIP2 ko-faktor kell, így a
    csatorna bezáródik. Ez lassú depolarizációt és a perceptron-küszöb alatti
    excitabilitás emelkedését okozza — a csatorna nemcsak a nyugalmi
    potenciált állítja be, hanem az excitabilitást is szabályozza.
  signature: "ACh -> MuscarinicReceptor -> PLC -> PIP2Depletion -> MChannelClose"
  code: |
    adat MZaras : AChJelenlet -> PLC Aktiv -> PIP2Csokken -> M Csatorna Zarodott
  related: [kandel14_gprotein_direct_gating, kandel14_camp_pka_schannel]
  causes: [kandel14_excitability_control]
  caused_by: [kandel14_plc_activation]
  resolves: [kandel14_resting_conductance_control]
  tags: [neocortex, ach, plc, pip2, m_channel, excitability]

- id: kandel14_camp_pka_schannel
  source: "Principles of Neural Science (Kandel), Chapter 14 — Second Messengers"
  concept: "cAMP-függő PKA zárja az S-típusú K+ csatornát (Aplysia, szerotonin)"
  type: CausalRelation
  idris_version: 2
  summary: >
    A szerotonin (5-HT) Gs-hez kapcsolt receptort aktivál, amely emeli a
    cAMP szintet és aktiválja a PKA-t; a PKA közvetlenül foszforilálja és
    bezárja az S-típusú (szerotonin-érzékeny) K+ csatornát. A csatorna-zárás
    csökkenti a K+ effluxust, depolarizál és egy egyszerű tanulási forma
    (érzékenyítés, sensitization) alapja az Aplysia visszahúzódási reflexében.
  signature: "Serotonin -> Gs -> AdenylylCyclase -> cAMP -> PKA -> SChannelClose"
  code: |
    adat SKozvetitett : 5HT -> Gs -> AdenylylCiklaz -> cAMP -> PKA -> S Csatorna Zarodott
  related: [kandel14_gprotein_direct_gating, kandel14_longterm_genexpression]
  causes: [kandel14_sensitization, kandel14_depolarization]
  caused_by: [kandel14_serotonin_release]
  resolves: [kandel14_resting_conductance_decrease]
  tags: [neocortex, camp, pka, serotonin, aplysia, learning, s_channel]

- id: kandel14_longterm_genexpression
  source: "Principles of Neural Science (Kandel), Chapter 14 — Second Messengers"
  concept: "Második hírvivők hosszú távú génexpressziót indítanak (CREB/CBP)"
  type: CausalRelation
  idris_version: 2
  summary: >
    Tartós receptor-aktiváció esetén a kináz átvándorol a sejtmagba és
    foszforilál transzkripciós faktorokat (pl. CREB), amelyek a CRE
    DNS-szakaszhoz kötődve, a CBP rekrutálásával (hiszton-acetiláz) megnyitják
    a kromatinszerkezetet. Az új fehérjeszintézés napokig-tartó változásokat
    hoz létre — ez a híd a rövid távú szinaptikus potenciál és a hosszú távú
    tanulás/emlékezet között.
  signature: "SustainedReceptor -> KinaseTranslocatesToNucleus -> CREB -> GeneExpression"
  code: |
    adat HosszuTap : RovidKitettség -> PKA -> CsatornaFoszf -> Percek
                       ; Tartos kitettség -> PKA -> Nukleusz -> CREB -> mRNA -> Napok
  related: [kandel14_camp_pka_schannel, kandel14_firing_rate_modulation]
  causes: [kandel14_longterm_memory]
  caused_by: [kandel14_sustained_receptor_activation]
  resolves: [kandel14_short_to_long_term_bridge]
  tags: [neocortex, creb, cbp, chromatin, gene_expression, memory, long_term]

- id: kandel14_firing_rate_modulation
  source: "Principles of Neural Science (Kandel), Chapter 14 — Second Messengers"
  concept: "GIRK aktiváció csökkenti a spontán tüzelési rátát"
  type: Pattern
  idris_version: 2
  summary: >
    Az önállóan tüzelő neuronokban a GIRK-en átmenő kifelé irányuló K+ áram
    elsősorban a sejt intrinsikus tüzelési rátáját csökkenti, szemben állva a
    HCN-csatornák (pacemaker) lassú depolarizációjával. Mivel a GIRK-et
    transzmitterek aktiválják, szinaptikus úton modulálják az excitábilis
    sejtek tüzelési rátáját — ez a "belső excitabilitás" szabályozásának
    egyik alapmintája.
  signature: "Neurotransmitter -> GIRK -> OutwardKCurrent -> DecreasedFiringRate"
  code: |
    adat TuzelesMod : GIRKAktiv -> KifeleKaram -> LassabbTuzeles (ellenben HCN lassu depolar)
  related: [kandel14_gprotein_direct_gating]
  causes: [kandel14_state_dependent_response]
  caused_by: [kandel14_gprotein_direct_gating]
  resolves: [kandel14_intrinsic_excitability_control]
  tags: [neocortex, girk, hcn, firing_rate, intrinsic_excitability]

- id: kandel14_ca_channel_inhibition
  source: "Principles of Neural Science (Kandel), Chapter 14 — Second Messengers"
  concept: "G-fehérje βγ gátolja a feszültségfüggő Ca2+ csatornákat"
  type: CausalRelation
  idris_version: 2
  summary: >
    Több G-protein-kapcsolt receptor a Gi/Go βγ komplexének közvetlen
    kötődésével gátolja bizonyos feszültségfüggő Ca2+ csatornák nyitását.
    Mivel a Ca2+ beáramlás depolarizáló hatású, a Ca2+ gátlás és a K+
    aktiváció együttesen erősen gátolja a neuronális tüzelést, és a
    preszinaptikus terminálisokban csökkentheti a transzmitter-felszabadulást.
  signature: "GiGoBetaGamma -> VoltageGatedCaChannel -> CaInfluxDecrease -> FiringInhibition"
  code: |
    adat CaGatlas : BetaGamma -> CaCsatorna -> CaBearamlasCsokken -> TuzelesGatlas
  related: [kandel14_gprotein_direct_gating, kandel14_firing_rate_modulation]
  causes: [kandel14_firing_inhibition]
  caused_by: [kandel14_metabotropic_binding]
  resolves: [kandel14_presynaptic_release_suppression]
  tags: [neocortex, ca_channel, beta_gamma, inhibition, presynaptic]

- id: kandel14_convergence
  source: "Principles of Neural Science (Kandel), Chapter 14 — Second Messengers"
  concept: "Több neuromodulátor konvergál ugyanarra a neuronra és csatornára"
  type: Pattern
  idris_version: 2
  summary: >
    Ugyanaz az ioncsatorna (pl. M-típusú K+ csatorna, vagy az Aplysia S-csatornája)
    különböző modulátorokkal (ACh, szubasztanci P, peptidek; szerotonin)
    szabályozható. A rákféle stomatogastricus ganglionban sokféle
    neuropeptid konvergál egyetlen feszültségfüggő beáramlási áramra (IMI).
    Ez a "konvergencia" a neuronokat rugalmassá teszi különböző agyi állapotok
    között — kategóriaelméleti szemmel egy koproduct/colimit szerkezete:
    több bemeneti áramlás egyetlen céloncsatorna-állapotba olvad.
  signature: "ManyModulators -> SameChannel -> FlexibleStateDependentResponse"
  code: |
    -- Konvergencia mint koproduktum:
    adat Konvergencia : (m1, m2, m3 : Modulator) -> Egy Csatorna -> AllapotValtozas
  related: [kandel14_gprotein_direct_gating, kandel14_camp_pka_schannel, kandel14_why_many]
  causes: [kandel14_computational_power, kandel14_state_dependent_response]
  caused_by: [kandel14_multiple_receptor_types]
  resolves: [kandel14_flexible_state_response]
  tags: [neocortex, kategoriaelmelet, convergence, colimit, polymorphism, modulation]

- id: kandel14_state_dependent_response
  source: "Principles of Neural Science (Kandel), Chapter 14 — Second Messengers"
  concept: "Moduláció állapotfüggő érzékelési választ hoz létre"
  type: Pattern
  idris_version: 2
  summary: >
    Sok érzékelési folyamat nagyon eltérő választ vált ki az állat
    viselkedési állapotától függően; a szinaptikus erősséget és intrinsikus
    excitabilitást módosító modulátorok gyakran részt vesznek ezekben a
    műveletekben. A moduláció tehát nem "üzenet", hanem az áramköri
    dinamika eltolása a viselkedési igényekhez — ez közvetlenül kapcsolódik
    a neokortex állapotfüggő (éber/alvó/fókuszált) működéséhez.
  signature: "BehavioralState -> ModulatorSet -> AlteredCircuitDynamics"
  code: |
    adat AllapotFuggo : ViselkedesAllapot -> Modulatorok -> AramkorDynamika
  related: [kandel14_convergence, kandel14_circuit_reconfiguration]
  causes: [kandel14_circuit_reconfiguration]
  caused_by: [kandel14_convergence]
  resolves: [kandel14_behavioral_adaptation]
  tags: [neocortex, state, behavioral_state, modulation, sensory]

- id: kandel14_circuit_reconfiguration
  source: "Principles of Neural Science (Kandel), Chapter 14 — Second Messengers"
  concept: "Egyetlen modulátor újrakonfigurál egy teljes áramkört (dopamin, STG)"
  type: Example
  idris_version: 2
  summary: >
    A rák pyloric áramkörében (AB, PD, PY neuronok) a dopamin szelektíven
    módosítja az AB, PD és PY neuronok különböző feszültségfüggő csatornáit
    (ICa, IK,Ca, IK,A, Ih, INa, IKv), megváltoztatva a PY neuron tüzelésének
    időzítését a pacemaker-csoporthoz képest. Egyetlen modulátor szelektív
    hatása elosztott áramköri elemekre együttesen új viselkedést eredményez —
    modellként szolgál a neokortex térbelileg elosztott excitabilitás-
    szabályozásához.
  signature: "Dopamine -> DistributedChannelModulation -> CircuitTimingChange"
  code: |
    adat Ujrakonfig : Dopamin -> [AB, PD, PY csatornak] -> IdozitesValtozas
  related: [kandel14_convergence, kandel14_state_dependent_response]
  causes: [kandel14_computational_power]
  caused_by: [kandel14_multiple_receptor_types]
  resolves: [kandel14_circuit_function_control]
  tags: [neocortex, dopamine, stomatogastric, circuit, reconfiguration, timing]

- id: kandel14_why_many
  source: "Principles of Neural Science (Kandel), Chapter 14 — Second Messengers"
  concept: "Miért ennyi modulátor? — plaszticitás ÉS stabilitás"
  type: Rule
  idris_version: 2
  summary: >
    A kis STG ganglion 26–30 neuronja 50-nél több neuromodulátor célpontja.
    A gazdagságnak kettős szerepe van: (1) különböző viselkedésileg releváns
    motoros kimenetek előállítása, és (2) redundancia — hasonló hatású
    modulátorok biztosítják, hogy egy modulációs rendszer kiesése esetén is
    megmaradjon a kritikus funkció. Ez a plaszticitás-stabilitás dichotómia
    közvetlenül tükröződik a Szima északi csillagában: "diverse modulators
    may be used in the service of both plasticity and stability."
  signature: "ManyModulators -> (BehavioralVariety | RedundantStability)"
  code: |
    adat MiertSok : Modulatorok s -> Ha egyik elesik -> Masik megtartja a funkciot
  related: [kandel14_convergence, kandel14_circuit_reconfiguration]
  causes: [kandel14_robustness]
  caused_by: [kandel14_evolutionary_redundancy]
  resolves: [kandel14_plasticity_stability_tradeoff]
  tags: [neocortex, plasticity, stability, redundancy, robustness]

- id: kandel14_metabotropic_binding
  source: "Principles of Neural Science (Kandel), Chapter 14 — Second Messengers"
  concept: "Metabotrop receptorok két nagy családja"
  type: Definition
  idris_version: 2
  summary: >
    A neuromodulátorok legtöbb receptora metabotrop. Két fő család létezik:
    a G-protein-kapcsolt receptorok (GPCR) és a receptor tirozin-kinázok.
    Számos fontos agyi jelmolekula (noradrenalin, ACh, GABA, glutamát,
    szerotonin, dopamin, neuropeptidek) aktivál metabotrop receptorokat,
    sokuk ionotrop receptorokat is.
  signature: "MetabotropicReceptor = GPCR | ReceptorTyrosineKinase"
  code: |
    adat Metabotrop : Tipus -> GPCR + ReceptorTirozinKinaz
  related: [kandel14_gprotein_direct_gating, kandel14_camp_pka_schannel]
  causes: []
  caused_by: []
  resolves: [kandel14_receptor_classification]
  tags: [neocortex, metabotropic, gpcr, rtk, receptor]
```

---

## Összefüggés a Szima-projekttel (röviden)

- **neocortex**: az állapotfüggő moduláció, a konvergencia (több bemenet → egy
  csatornaállapot), az elosztott excitabilitás-szabályozás és a hosszú távú
  második-hírvivő → génexpresszió híd mind közvetlen analógiák a neokortex
  építéséhez: a kéreg sem "fix huzalozás", hanem modulátorokkal újrakonfigurált
  dinamikus áramkör.
- **kategoriaelmelet**: a `kandel14_convergence` jegyzet a konvergenciát
  koproduktumként/colimitként értelmezi (több modulátor-áramlat egyetlen
  csatornaállapotba) — ez valódi kategóriaelméleti híd.
- **E8**: ebben a fejezetben nincs közvetlen szimmetria- vagy kivételes-csoport
  kapcsolat; az E8 címke szándékosan NEM került fel (ne erőltessünk
  hamis hidat).
