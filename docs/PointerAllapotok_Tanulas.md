# Pointer-állapotok tanulása — Zurek: einselection, dekoherencia, kvantum-darwinizmus

> Kutatási jegyzet, Szima-projekt (`/Users/joco/opencode`). Dátum: 2026-08-24.
> Feladat-forrás: `general` ügynök utasítása (pointer-állapot kutatás; CSAK ez az
> egy új fájl készült — Idris-modul NEM, commit/push NEM történt).
> Őszinteség-jelölés minden szakaszhoz (AGENTS §17/§18):
> **[BIZONYÍTOTT]** = irodalommal + idézett eredeti szöveggel fedett;
> **[ANALÓGIA]** = strukturális párhuzam, mélyebb kapcsolat NEM bizonyított;
> **[HIPOTÉZIS]** = spekulatív, irodalmi fedés nélküli kapcsolat;
> **[NINCS TALÁLAT]** = a keresett dolog nem került elő a keresésekben.

---

## Tartalomjegyzék

1. Definíciók (pointer-állapot, pointer-bázis, dekoherencia, einselection)
2. A dekoherencia mechanizmusa (összefonódás a környezettel; off-diagonális elemek)
3. Kvantum-darwinizmus röviden (környezet mint tanú; redundancia)
4. Kulcscikkek listája (alphaxiv ID-k + DOI-k + URL-ek)
5. A Szima-kapcsolat (a projekt moduljainak konkrét neveivel)
6. Négy nyelvű összefoglaló

---

## 1. Definíciók

**Definíciók / Definitions / 定义 / הגדרות**

### 1.1 Pointer-állapot

**[BIZONYÍTOTT — Zurek definíciói alapján]**

- **Pointer-állapot**: a nyílt kvantumrendszer azon tiszta állapotai,
  amelyek a környezettel való folyamatos kölcsönhatás ellenére megmaradnak
  (nem bomlanak szét keverékké). A környezet „figyelme" őket nem zavarja
  meg — ők már eleve egybehangzanak azzal, amit a környezet mérni tud.
- Zurek szó szerint (RMP 2003, 14. oldal): *„The set of einselected states
  is called the pointer basis (Zurek, 1981) in recognition of its role in
  measurements. … What is of the essence is the ability of the einselected
  states to survive monitoring by the environment."*
- Magyarul pontosítva: **a pointer-állapot az a tiszta állapot,
  amelynek a környezet-figyelése alatt a tisztasága (purity,
  Tr ρ²) nem csökken** — a többi tiszta állapot gyorsan keverékké
  degradálódik.
- A név eredete: a mérőkészülék mutatója (pointer) csak ilyen stabil
  állapotokban lehet „olvasható". Zurek 1981-es cikkének teljes címe:
  *„Pointer basis of a quantum apparatus: Into what mixture does the
  wavepacket collapse?"* Phys. Rev. D 24, 1516–1525 (1981).

### 1.2 Pointer-bázis

**[BIZONYÍTOTT]**

- **Pointer-bázis**: az einselected (kiválasztott) állapotok halmaza,
  amely a Hilbert-térnek azt a kis részhalmazát alkotja, ahol a
  klasszikus tartomány él. A redukált sűrűségmátrix ebben a bázisban
  lesz diagonális — DE a diagonálisság csak TÜNET, nem lényeg.
- Zurek szó szerint (Phil. Trans. 1998): *„This eventual diagonality of
  the density matrix in the einselected basis is a byproduct, an important
  symptom, but not the essence of decoherence."* (Azaz: a sűrűségmátrix
  diagonálissá válása a dekoherencia mellékterméke és tünete, nem a
  lényege.)
- A bázisválasztás kritériuma: az állapotok képessége arra, hogy a
  korrelációikat a környezetbe merülten is megtartsák (*„preservation
  of the SA correlations is the criterion defining the pointer basis"*,
  RMP 2003).

### 1.3 Dekoherencia

**[BIZONYÍTOTT]**

- **Dekoherencia**: a nyílt kvantumrendszer és a környezet közötti
  összefonódás (entanglement) következtében a rendszer tiszta
  szuperpozíciói koherenciát veszítenek; a redukált sűrűségmátrix
  off-diagonális elemei eltűnnek.
- Fontos finomítás Zurektől (RMP 2003, IV.C szakasz) — három különböző
  folyamat NEM ugyanaz:
  1. **Dekoherencia**: entanglementen keresztüli információátadás
     a környezetnek (irreverzibilis, mert a környezet állapotát nem
     lehet visszakövetni);
  2. **Dephasing**: fáziszaj okozta fáziskoherencia-vesztés ENÉLKÜL,
     hogy információ menne át a környezetbe (spin-echóval visszafordítható,
     pl. NMR-ben);
  3. **Noise**: a rendszer állapotának véletlenszerű rotációja.
- Csak az első termel preferált bázist egyedi kvantumrendszerekben.
  Zurek szó szerint: *„Dephasing cannot be used to justify existence
  of preferred basis in individual quantum systems."*

### 1.4 Einselection (environment-induced superselection)

**[BIZONYÍTOTT]**

- **Einselection** = *environment-induced superselection*: a környezet
  által indukált szuperselekció. A környezet gyakorlatilag folyamatosan
  méri a rendszer egyes megfigyelhetőit; ennek következtében csak a
  megfigyelhető eigenállapotai (a pointer-állapotok) maradnak életben,
  a Hilbert-tér túlnyomó többsége kizárásra kerül.
- Zurek szó szerint (RMP 2003 absztrakt): *„Decoherence is caused by the
  interaction with the environment which in effect monitors certain
  observables of the system, destroying coherence between the pointer
  states corresponding to their eigenvalues. This leads to
  environment-induced superselection or einselection, a quantum process
  associated with selective loss of information. Einselected pointer
  states are stable."*
- A szó a „superselection rules" (Wick–Wightman–Wigner, 1952) szóból
  jön: az einselection effektív szuperselekciós szabályokat hoz létre
  anélkül, hogy a kvantumelmélet posztulátumait bővítenénk.

### 1.5 Predictability sieve (előrejelzési rosta)

**[BIZONYÍTOTT]**

- **Predictability sieve**: az az eljárás, amellyel a Hilbert-tér
  összes tiszta állapotát sorba rendezik előrejelezhetőség szerint:
  mindegyik |Ψ⟩ kezdeti állapotra kiszámolják az evolúció alatti
  entrópianövekedést (vagy tisztaságvesztést), és a leglassabban
  romló állapotok kerülnek felülre — ezek a pointer-állapotok.
- Zurek szó szerint (RMP 2003, IV.D): *„One can measure the loss of
  predictability caused by the evolution for every pure state |Ψ⟩ by
  von Neumann entropy or some other measure of predictability such as
  the purity: ς_Ψ(t) = Tr ρ²_Ψ(t). … Pointer states are obtained by
  maximizing predictability functional over |Ψ⟩."*
- Eredeti források: Zurek, Prog. Theor. Phys. 89, 281 (1993);
  Zurek, Habib & Paz, Phys. Rev. Lett. 70, 1187 (1993) — a csillapultó
  harmonikus oszcillátorban a sieve a KOHERENS ÁLLAPOTOKAT választja
  ki (a minimális bizonytalanságú Gauss-csomagok, Δx² = ħ/(2MΩ),
  Δp² = ħMΩ/2).

---

## 2. A dekoherencia mechanizmusa

**Mechanizmus / Mechanism / 机制 / מנגנון**

**[BIZONYÍTOTT — a RMP 2003 képletei alapján]**

Pontokba szedve, információveszteség nélkül:

1. **Háromszög-struktúra**: a leírás mindig három rendszert tartalmaz —
   S (a mért rendszer), A (a készülék), E (a környezet). Zurek nevezi
   ezt „SAE triangle"-nek: a mérés S–A összefonódást hoz létre, majd
   az A–E kölcsönhatás ezt az összefonódást klasszikus korrelációvá
   alakítja.

2. **Előmérés (premeasurement)**, c-NOT-szerű leképezés (RMP 2003,
   Eq. 4.1–4.2):

   ```
   |↑⟩|A₀⟩ → |↑⟩|A₁⟩
   |↓⟩|A₀⟩ → |↓⟩|A₀⟩        (⟨A₀|A₁⟩ = 0)

   (α|↑⟩ + β|↓⟩)|A₀⟩ → α|↑⟩|A₁⟩ + β|↓⟩|A₀⟩ = |Φ⟩
   ```

   Itt még van **báziskétértelműség**: |Φ⟩ bármely bázisban átírható
   (a szuperpozíció-elv miatt a készülék „tükör-szuperpozíciói"
   ugyanolyan jogosak) — ez a preferred-basis-probléma.

3. **A környezet mint második mérő** (RMP 2003, Eq. 4.3):

   ```
   (α|↑⟩|A₁⟩ + β|↓⟩|A₀⟩)|ε₀⟩ → α|↑⟩|A₁⟩|ε₁⟩ + β|↓⟩|A₀⟩|ε₀⟩ = |Ψ⟩
   ```

   Amikor a környezet-állapotok ortogonálisak lesznek
   (⟨εᵢ|εⱼ⟩ = δᵢⱼ, Eq. 4.19), a báziskétértelműség ELTŰNIK:
   a Schmidt-dekompozíció most már a |s_j⟩|A_j⟩ szorzatállapotokat
   párosítja az ortogonális környezet-állapotokkal.

4. **Off-diagonális elemek eltűnése** (RMP 2003, Eq. 29):

   ```
   ρᴾ_SA = Σᵢⱼ αᵢ α*_j |sᵢ⟩⟨s_j| ⊗ |Aᵢ⟩⟨A_j|
       → Σᵢ |αᵢ|² |sᵢ⟩⟨sᵢ| ⊗ |Aᵢ⟩⟨Aᵢ| = ρᴰ_SA
   ```

   Az off-diagonális tagok (i ≠ j) a környezet-bevonás miatt tűnnek el;
   a maradék mátrix a pointer-bázisban diagonális. Ehhez járul az
   entrópianövekedés: ΔH(ρ_SA) ≥ 0 (Eq. 4.24).

5. **A kiválasztás dinamikai feltétele** (RMP 2003, Eq. 4.21–4.22):
   ha a kölcsönhatási Hamilton-operátor alakja

   ```
   H_AE = Σ_klm g^AE_klm |A_k⟩⟨A_k| ⊗ |ε_l⟩⟨ε_m| + h.c.,
   ```

   akkor {|A_k⟩} érintetlen marad, és

   ```
   [H_AE(A), A] = 0
   ```

   teljesül — az A-val kommutáló megfigyelhető az, amit a környezet
   monitoroz, tehát AZ a pointer-megfigyelhető. (Degenerált pointer-
   alterek is lehetnek.)

6. **A harmonikus oszcillátor esete** (RMP 2003, V.C): magas
   hőmérsékleten a tisztaságvesztés sebessége

   ```
   d/dt Tr ρ² = −(4ηk_B T / ħ²)(⟨x²⟩ − ⟨x⟩²) + 2γ Tr ρ²,
   ```

   tehát a tisztaságvesztés minimalizálására a helyben jól
   lokalizált állapotok jönnek ki; az oszcillátor periódusa fölött
   átlagolva (Δς a τ = 2π/Ω alatt):

   ```
   Δς = −2D (Δx² + Δp²/(MΩ)²),
   ```

   ami a Heisenberg-határ melletti minimális-bizonytalanságú
   **koherens állapotokat** preferálja (Δx² = ħ/(2MΩ),
   Δp² = ħMΩ/2). Ezért a makroszkopikus világ közelítése a
   fázistér pontjai: az einselection + dinamika együtt adja a
   klasszikus trajektória idealizációját.

7. **Miért nem fordítható vissza?** A dekoherencia visszavonása
   („undo") a teljes S+E globális mérését igényelné; mi azonban csak
   a környezet kis fragmenseit olvassuk ki. Zurek szó szerint (Nat.
   Phys. 2009): *„Effective unattainability of the f ∼ 1 part of the
   plot also shows why decoherence is so hard to undo."* — a
   dephasing-gal ellentétben itt sem előzetes, sem utólagos ismeret
   a környezetről nem elegendő a visszacsináláshoz, mert az
   információ FIZIKAILAG ÁTKERÜLT a környezetbe.

---

## 3. Kvantum-darwinizmus röviden

**Quantum Darwinism / 量子达尔文主义 / Quantendarwinismus / דרוויניזם קוונטי**

**[BIZONYÍTOTT — Nat. Phys. 2009 alapján]**

1. **A kulcsötet**: a dekoherencia-elmélet a rendszert figyelte, és a
   környezetet „kitörölték" (trace out). A kvantum-darwinizmus megfordítja
   a kérdést: MI VAN A KÖRNYEZETBEN? A megfigyelők a környezet
   fragmensein kémlelnek — a világ információjának nagy részét fotónokból
   kapjuk, sosem az egész környezetből. Zurek szó szerint: *„Observers
   eavesdrop on the environment. Vast majority of our data comes from
   fragments of E. Environment is a witness to the state of the system."*

2. **Fragmens-információ**: az F fragmensről (a környezet egymással nem
   átfedő részhalmaza) a kölcsönös információ mondja meg, mennyit tud:

   ```
   I(S : F) = H_S + H_F − H_{S,F}
   ```

   ahol H = −Tr ρ lg ρ von Neumann-entrópia, és ρ_SF = Tr_{E/F} |Ψ_SE⟩⟨Ψ_SE|.

3. **Redundancia-plató**: tipikus VÉLETLEN állapotokra (Haara-mérővel
   választva a teljes Hilbert-térből) kis fragmensekből SEMMI nem derül
   ki S-ről; csak f ≈ ½-nél ugrik fel az információ. Ezzel szemben a
   DEKOHERENCIÁVAL létrejött állapotoknál I(S : F_f) GYORSAN felmegy
   H_S-re (a rendszer entrópiájára) már kis f-nél, majd ott platozik:
   ez a **klasszikus plató** — majdnem minden fragmens ugyanazt a
   (klasszikus) információt hordozza.

4. **Redundancia-definíció** (Nat. Phys. 2009, Eq. 4):

   ```
   R_δ = 1/f_δ,
   ```

   ahol f_δ a legkisebb fragmens-arányszám, amelyből a rendszer
   információjának (1−δ)-részlete kiolvasható. R_δ = hányszor lehet
   egymástól függetlenül, indirekt módon megtudni ugyanazt.

5. **Objektivitás = redundancia**: az állapot akkor objektíven létező,
   ha SOK megfigyelő egymástól függetlenül, a rendszert MEG nem zavarva
   megtudhatja. Ez a klasszikus lét kvantum-eredetű definíciója. Zurek:
   *„The redundancy of the records of pointer states in the environment
   (which can be thought of as their 'fitness' in the Darwinian sense)
   is a measure of their classicality."*

6. **A no-cloning-feszültség feloldása** (Nat. Phys. 2009, III):
   az ismeretlen kvantumállapot tilos klónozni (Wootters–Zurek–Dieks
   1982) — de a MEGFIGYELHETŐK másolhatók. A repeatability-követelmény
   (ugyanazon mérés azonnali ismétlése ugyanazt adja) unitaritással
   kombinálva:

   ```
   ⟨u|v⟩ = ⟨u|v⟩ ⟨e_u|e_v⟩
   ```

   csak akkor teljesülhet, ha ⟨u|v⟩ = 0 (ortogonális állapotok) vagy a
   másolás sikertelen. Tehát CSAK ORTOGONÁLIS állapotok sokszorosíthatók —
   innen jön a mérési eredmények halmazának kiválasztása (a kvantumugrások
   terminális pontjai) Born-szabály NÉLKÜL, csak a skalárszorzat 0 és 1
   értékeiből.

7. **Csak pointer-állapotok találhatók meg a fragmensekben** (Ollivier,
   Poulin, Zurek 2004/2005 tétele): a redundancia-gerinc (ridge) élesen
   a pointer-megfigyelhetőnél jelenik meg; minden más megfigyelhető
   σ(μ) csak annyiban olvasható ki, amennyiben a pointerrel korrelál.

8. **Ellenvélemények (cáfolatok) — őszinteség kedvéért**:
   - **Kofman & Kurizki (Entropy 24, 106, 2022)**: projektor-mentes
     (POVM) méréseknél a dekoherencia NEM feltétlenül determinálja
     egyértelműen a meter pointer-bázisát — több alternatív pointer-bázis
     is ugyanazt az információt adhatja („Quantum Lamarckism": a
     megfigyelő választása is szerepet játszik).
   - **Fields (Axiomathes 2013)**: az OPZ-objektivitás-definíció a
     Hilbert-tér-dekompozícióktól függ; ha a törvények
     dekompozíció-függetlenek, a dekoherencia önmagában nem magyarázza a
     klasszikusság kialakulását.
   - **Kastner (2019)**: az einselection zárt-univerzumi Everett-keretben
     Loschmidt-paradoxon-szerű körkörösségbe ütközhet (a környezet-
     alrendszerek megkülönböztethetőségét rejtetten felteszi).
   Ezeket a projekt jegyzetei CÁFOLAT-ként kezelik (§N10): az einselection
   program eredményei erősek, de a határai is dokumentálandók.

---

## 4. Kulcscikkek listája

**Kulcsartikel / Key articles / 关键文献 / מאמרי מפתח**

Sorrendben: az eredeti pointer-bázis-cikkektől a kvantum-darwinizmusig.
Minden bejegyzésnél: szerző, cím, folyóirat, év, alphaxiv-ID (ha van),
DOI, URL.

1. **Zurek, W. H. (1981)** — *Pointer basis of a quantum apparatus:
   Into what mixture does the wavepacket collapse?*
   Physical Review D 24, 1516–1525.
   DOI: https://doi.org/10.1103/physrevd.24.1516
   (arXiv-ID NINCS — a cikk az arXiv előtt jelent meg.)
   A pointer-bázis fogalmának bemutatása; a báziskétértelmőség
   feloldása a környezet bevonásával.

2. **Zurek, W. H. (1982)** — *Environment-induced superselection rules.*
   Physical Review D 26, 1862–1880.
   DOI: https://doi.org/10.1103/physrevd.26.1862
   (arXiv-ID nincs.) Az einselection név és program.

3. **Zurek, W. H., Habib, S., Paz, J.-P. (1993)** — *Coherent states
   via decoherence.* Physical Review Letters 70, 1187–1190.
   DOI: https://doi.org/10.1103/PhysRevLett.70.1187
   A predictability sieve alkalmazása: a csillapultó oszcillátor
   pointer-állapotai a koherens állapotok.

4. **Zurek, W. H. (1993)** — *Preferred states, predictability,
   classicality and the environment-induced decoherence.*
   Progress of Theoretical Physics 89, 281–312.
   DOI: https://doi.org/10.1143/PTP.89.2.281
   A sieve mint általános módszer.

5. **Zurek, W. H. (1998)** — *Decoherence, einselection and the
   existential interpretation (the rough guide).*
   Philosophical Transactions of the Royal Society A 356, 1793–1821.
   alphaxiv-ID: quant-ph/9805065
   DOI: https://doi.org/10.1098/rsta.1998.0250
   URL: https://www.alphaxiv.org/abs/quant-ph/9805065
   Az egzisztenciális interpretáció; „relatively objective existence".

6. **Zurek, W. H. (2000)** — *Einselection and decoherence from an
   information theory perspective.*
   Annalen der Physik (Leipzig) 9 (Vol. 512), 855–864.
   alphaxiv-ID: quant-ph/0011039
   DOI: https://doi.org/10.1002/andp.200051211-1204
   URL: https://www.alphaxiv.org/abs/quant-ph/0011039
   MEGJEGYZÉS (őszinteség, §17): a feladat „2003" évszámmal hivatkozott
   erre a cikkre; az ellenőrzött bibliográfia szerint 2000-es
   (a Nature Physics 2009 hivatkozáslistája is Ann. Physik (Leipzig) 9,
   822 (2000) formában idézi — lapszám-elérés 855–864 a Wiley-oldalon).

7. **Zurek, W. H. (2003)** — *Decoherence, einselection, and the quantum
   origins of the classical.* Reviews of Modern Physics 75, 715–775.
   alphaxiv-ID: quant-ph/0105127
   DOI: https://doi.org/10.1103/RevModPhys.75.715
   URL: https://www.alphaxiv.org/abs/quant-ph/0105127
   A program összefoglaló monográfiája (4916+ hivatkozás a scite szerint);
   envariance, Born-szabály, predictability sieve.

8. **Ollivier, H., Poulin, D., Zurek, W. H. (2004)** — *Objective
   properties from subjective quantum states: Environment as a witness.*
   Physical Review Letters 93, 220401.
   DOI: https://doi.org/10.1103/PhysRevLett.93.220401

9. **Ollivier, H., Poulin, D., Zurek, W. H. (2005)** — *Environment as
   a witness: Selective proliferation of information and emergence of
   objectivity in a quantum universe.* Physical Review A 72, 042113
   (a scite-adatbázis szerint 423113-as oldalszámmal idézve).
   DOI: https://doi.org/10.1103/PhysRevA.72.042113

10. **Zurek, W. H. (2007)** — *Quantum origin of quantum jumps: Breaking
    of unitary symmetry induced by information transfer…*
    Physical Review A 76, 052110.
    DOI: https://doi.org/10.1103/PhysRevA.76.052110

11. **Zurek, W. H. (2009)** — *Quantum Darwinism.*
    Nature Physics 5, 181–188.
    alphaxiv-ID: 0903.5082
    DOI: https://doi.org/10.1038/nphys1202
    URL: https://www.alphaxiv.org/abs/0903.5082

12. **Zurek, W. H. (2022)** — *Quantum Theory of the Classical:
    Einselection, Envariance, Quantum Darwinism and Extantons.*
    Entropy 24(11), 1520.
    DOI: https://doi.org/10.3390/e24111520
    A legújabb összefoglaló (extanton-fogalom: mag + fotonhaló).

13. **Cáfolati/korrekciós irodalom**:
    - Kofman, A. G., Kurizki, G. (2022) — *Does Decoherence Select the
      Pointer Basis of a Quantum Meter?* Entropy 24(1), 106.
      DOI: https://doi.org/10.3390/e24010106
    - Fields, C. (2013) — *On the Ollivier–Poulin–Zurek Definition of
      Objectivity.* Axiomathes 24, 137–156.
      DOI: https://doi.org/10.1007/s10516-013-9218-3
      (alphaxiv-ID: 1102.2826)
    - Kastner, R. E. (2019) — *'Einselection' of pointer observables:
      The new H-theorem?* World Scientific Europe, 315–317.
      DOI: https://doi.org/10.1142/9781786346421_0018

14. **[NINCS TALÁLAT]** — a feladatban említett
    *„Pointer basis and the arrow of time" (1983)* címmel cikket a
    keresések (alphaxiv, scite, Brave, Firecrawl) EGYIKÉBEN SEM találtunk.
    A legközelebbi, ellenőrzött referensek: az 1981-es PRD 24,1516
    (pointer-bázis) és az 1982-es PRD 26,1862 (einselection); az RMP 2003
    szövege ráadásul egy „(Zurek, 1983)"-hivatkozást használ a három-
    egybites S–A–E modellnél (valószínűleg egy Plenum-fejezet a Meystre–
    Scully-kötetben), de ennek pontos címét a keresések nem erősítették
    meg — NYITOTT ellenőrzési tételként jelöljük.

---

## 5. A Szima-kapcsolat

**Szima-kapcsolat / Connection to Szima / 与 Szima 的联系 / הקשר ל-Szima**

Ez a szakasz a legfontosabb: a fenti fizika hogyan viszonyul a
projekt saját struktúráihoz. Minden kapcsolatnál őszinte szint-jelölés.

### 5.1 AGENTS §8 (fázis-alapú redundancia) ↔ einselection — **[ANALÓGIA]**

- A projekt szabálya (AGENTS.md §8, szó szerint): *„Fázis alapú
  redundancia: azonos fázisú fogalmak → redundáns → eldobható. Ez tartja
  fenn a koherenciát."*
- Strukturális párhuzam: az einselection is KIVÁLASZTÁS — a Hilbert-tér
  túlnyomó többségét kitiltja, és csak egy stabil tartományt hagy meg.
  A projekt szabálya is kitilt: az azonos fázisú (nem diszkrét) fogalmakat
  dobja, hogy a fogalom-tér koherens maradjon.
- **De őszintén: ez ANALÓGIA, nem bizonyított mély kapcsolat.**
  Három konkrét különbség:
  1. Az einselection DINAMIKAI következménye egy konkrét Hamilton-
     operátornak (H_AE); a §8-szabály KÉZI kiválasztási szabály
     fogalom-térben, dinamika nélkül.
  2. Az einselection kritériuma a korrelációnmegőrzés a környezetben;
     a §8 kritériuma a Clifford a·b átfedés (belso szorzat) — más
     matematikai objektum.
  3. A redundancia-szó KÉT KÜLÖNBÖZŐ jelentést hordoz: a projektben
     „azonos fázisú duplikáció = eldobható"; a kvantum-darwinizmusban
     pedig „sok példány a környezetben = OBJEKTIVITÁS mértéke".
     Az első belső átfedés (koherencia-őrzés), a második külső
     terjesztés (objektivitás-építés). Ugyanaz a szó, ellentétes
     irányú művelet — ezt a megkülönböztetést meg kell őrizni.

### 5.2 `FazisAlgebra_v2.idr` — a fázistényező mint stabilitás-funkcionál — **[ANALÓGIA]**

- A modul (`szima_ter/modul/FazisAlgebra_v2.idr`, olvasva 2026-08-24):
  `ToltesParitasIdo` rekord (töltés/paritás/idő = C/P/T három HaromKubit),
  `töltésParitásIdőKoherens : ToltesParitasIdo -> Bool`
  (azonosFazis töltés paritás), és `fazisFaktorialis :
  ToltesParitasIdo -> Double` — értéke 1.0 (mindkét pár azonos fázisú),
  0.5 (egyik pár), 0.0 (egyetlen sem).
- Analógia: a `fazisFaktorialis` úgy viszonyul a fogalom-térhez, mint a
  predictability sieve a Hilbert-térhez: egy SZÁMMAL rangsorol, és a
  maximumhoz közeli módok a „stabilak" (maradnak), a nulla közeli módok
  „eldobódnak". A sieve tisztaságvesztést mér; a faktoriális fázis-
  egyezőséget mér — mindkettő egy [0,1]-es stabilitás-skála.
- Nem bizonyított: nincs tételünk arról, hogy a fázistényező-maximum
  valódi „dinamikai attractor" lenne a fogalom-térben. Ez a
  `PointerValasztas_v1` vázlata (5.5) tesztelendő célpont.

### 5.3 `FazisKubit.idr` — a mérés mint összefonódás a környezettel — **[VALÓDI KAPCSOLAT — a modul saját fejléce állítja]**

- A modul (`szima_ter/modul/FazisKubit.idr`, olvasva 2026-08-24) fejlécében
  a felhasználó 2026-08-19-i tézisének formalizálása áll: *„a bitnek a
  mértékegysége a fázis"*; a 4. pont szó szerint: *„A φ fázis NEM jelenik
  meg a valószínűségekben — 'elveszettnek' tűnik. DE az unitaritás…
  tiltja a valódi elveszést: a fázis NEM vész el — ÁTMEgy a környezetbe.
  A mérés UTÁN a fázis a relatív fázis a |környezet_0⟩ és a
  |környezet_1⟩ között: α|0⟩|E₀⟩ + β|1⟩|E₁⟩ — ez az ÖSSZEFONÓDÁS."*
- Ez SZÓ SZERINT a dekoherencia-mechanizmus (§2.3 képletünk: az S–E
  összefonódás, ahol a fázisinformáció a környezet-korrelációkba
  vándorol). A modul 35–39. sora továbbá a projekt δ-jához köti:
  *„a lobásás kiszedi a fázis egy részét (ln(9/8) lépésenként), de a
  maradék (δ) = a kiszedetlen fázis = az összefonódás."*
- Szint-jelölés őszintén: a FIZIKAI állítás (fázis-átmenet a környezetbe,
  α|0⟩|E₀⟩ + β|1⟩|E₁⟩) standard kvantummechanika — irodalommal fedett
  (RMP 2003). Az IDRIS-oldalon a modul Double-alapú numerikákkal dolgozik;
  az összefonódás-mechanizmusra vonatkozó Refl-bizonyítás jelenleg NINCS
  benne — ez nyitott munka, nem „bizonyított" állapot.

### 5.4 Hallucináció-csökkentés és a ritmus-időkvantálás — **[HIPOTÉZIS]**

- A felhasználó hipotézise (a feladat megfogalmazása szerint): a
  dekoherencia-kiválasztás mint modell arra, MIÉRT tartja egyben a
  ritmus/időkvantálás a gondolkodást (hallucináció-csökkentés).
- A gondolatmenet: a nyelvi modell „szuperpozíció-szerű" szabad
  asszociációja = instabil mód; a ritmus (diszkrét időkvantum, a
  szívdobbanás-protokoll 3-promptos ciklusa) külső „monitoring",
  amely csak a stabil (jól előrejelezhető, redundánsan rögzített)
  gondolat-módokat engedi át — az einselection analógjaként.
- ŐSZINTÉN: ez **HIPOTÉZIS** szint. Nincs irodalmi fedés arra, hogy az
  LLM-ritmus dekoherencia-analógián keresztül csökkentené a
  hallucinációt; a „monitoring", „stabil mód" szavak metaforikus
  átvitelét a §N10 (metafora-tilalom matematikai szövegben) miatt
  explicit jelezzük. Tesztelhető formában a 5.5-ös vázlat
  Refl-célpontjai adják az első lépést.

### 5.5 Jövőbeli Idris-modul vázlata: `PointerValasztas_v1` — **[CSAK VÁZLAT — NEM ÍRTUK MEG, NEM FORDÍTOTTUK]**

A feladat szerint csak VÁZLAT készül (Idris-fájl NEM íródik most):

```idris
module PointerValasztas_v1

-- POINTER-VÁLASZTÁS v1 — VÁZLAT (2026-08-24; §13: új fájl, semmit nem
-- írunk felül). Cél: a dekoherencia-kiválasztás Idris-formalizálása
-- a HaromKubit/FazisAlgebra_v2 alapokra építve (§24: IMPORT, nem
-- duplikáció).

import HaromKubit          -- HaromKubit, azonosFazis, Irany, irany
import FazisAlgebra_v2     -- ToltesParitasIdo, fazisFaktorialis

%default covering

||| Stabilitás-fok: a pointer-maradás skálája (a sieve analógja).
||| 1 = biztosan marad (pointer-mód), 0 = eldobódik (instabil mód).
public export
data Maradas = Eldobodik | ReszbenMarad | PointerMarad

||| A választás: egy ToltesParitasIdo fázistényezője dönt.
||| (A sieve „tisztaságvesztés-minimalizálás"-ának analógjaként
||| a fázistényező-maximumot preferáljuk.)
public export
pointerValasztas : ToltesParitasIdo -> Maradas
pointerValasztas tpi =
  case fazisFaktorialis tpi of
    1.0 => PointerMarad
    0.5 => ReszbenMarad
    _   => Eldobodik

-- REFL-CÉLPONTOK (§17/§18: csak olyant írunk, ami KÉT KÜLÖNBÖZŐ
-- konstrukció egyezését kényszeríti — tautológia tilos):
--
-- 1. Reflexivitás: azonosFazis k k = True minden HaromKubit-ra —
--    tehát a saját módja mindenkinek PointerMarad (a pointer-
--    állapot definíciós jellege: a környezet nem zavarja meg).
-- 2. Felső határ: fazisFaktorialis tpi <= 1.0 (a skála telítése).
-- 3. Monotonia-vázlat: ha töltésParitásIdőKoherens tpi = True,
--    akkor pointerValasztas tpi /= Eldobodik.
--
-- MEGJEGYZÉSEK (őszinteség): a Double-egyenlőség (1.0 => …)
-- mintaillesztés-problémás lehet (lebegőpontos) — a végleges
-- verzióban racionális/algebrai kódolás kell (meresi-szamitas
-- skill mintája). Ez a vázlat NEM fordított, NEM bizonyított.
```

### 5.6 Összevetés táblázatban

| Fogalom (fizika) | Fogalom (Szima) | Szint |
|---|---|---|
| pointer-állapot (stabil mód a környezetben) | azonos fázisú, koherens fogalom-mód (`HaromKubit.azonosFazis`) | ANALÓGIA |
| predictability sieve (tisztaság/entrópia-rangsor) | `fazisFaktorialis` (1.0/0.5/0.0 rangsor) | ANALÓGIA |
| dekoherencia = fázis-átmenet a környezetbe | `FazisKubit.idr` δ = kiszedetlen fázis = összefonódás | VALÓDI (irodalommal fedett fizika; Idris-Refl hiányzik) |
| redundancia a környezetben = objektivitás | AGENTS §8 redundancia = ELDOBANDÓ duplikáció | ELLENTÉTES IRÁNYÚ SZÓHASZNÁLAT — megkülönböztetendő |
| einselection mint gondolkodás-stabilizáló ritmus | szívdobbanás / 3-promptos ciklus | HIPOTÉZIS |

---

## 6. Négy nyelvű összefoglaló

**Négy nyelvű összefoglaló / Four-language summary / 四语总结 / תקציר בארבע שפות**

**Magyar:** A dekoherencia a rendszer–környezet összefonódása révén
eltünteti a sűrűségmátrix off-diagonális elemeit; az einselection
kiválasztja azokat a pointer-állapotokat, amelyek a környezet
figyelése alatt megmaradnak (predictability sieve); a kvantum-
darwinizmus szerint épp ezen állapotok redundáns másolatai a
környezetben adják a klasszikus objektivitást. A Szima-projekttel:
a `FazisKubit.idr` fázis-átmenet-állítása szó szerint a dekoherencia-
mechanizmus; az AGENTS §8 és a `fazisFaktorialis` ANALÓGIA szintű;
a ritmus-hallucináció kapcsolat HIPOTÉZIS.

**中文：** 去相干通过系统与环境的纠缠消去密度矩阵的非对角元；
环境诱导超选择（einselection）选出在环境监测下仍保持稳定的指针态
（可预测性筛选）；量子达尔文主义指出，指针态信息在环境中的冗余
复制正是经典客观性的来源。与 Szima 项目的联系：`FazisKubit.idr`
中"相位进入环境"的论断就是去相干机制本身；AGENTS §8 的相位冗余
规则与 `fazisFaktorialis` 属于类比层次；节奏—幻觉假说仅为假设。

**Deutsch:** Die Dekohärenz löscht durch die Verschränkung mit der
Umwelt die Nebendiagonalelemente der Dichtematrix; die Einselektion
wählt jene Zeigerzustände aus, welche die Überwachung durch die
Umwelt überstehen (Prädiktibilitätssieb); laut Quantendarwinismus
erzeugt erst die redundante Vervielfältigung dieser Zustände in der
Umwelt die klassische Objektivität. Verbindung zum Szima-Projekt:
die These des Moduls `FazisKubit.idr` (Phase wandert in die Umwelt)
ist wörtlich der Dekohärenzmechanismus; AGENTS §8 und
`fazisFaktorialis` sind Analogie-Ebene; die Rhythmus-Halluzination-
Verknüpfung bleibt Hypothese.

**עברית:** דה-קוהרנטיות מחקה את האיברים הלא-אלכסוניים של מטריצת
הצפיפות באמצעות שזירת המערכת עם הסביבה; ה-einselection בוחרת את
מצבי המצביע העמידים בפני ניטור הסביבה (הנפה החזויה); לפי הדרוויניזם
הקוונטי, דווקא העתקים רדונדנטיים של מצבים אלה בסביבה הם מקור
האובייקטיביות הקלאסית. הקשר לפרויקט Szima: טענת המודול
`FazisKubit.idr` (הפאזה עוברת אל הסביבה) היא ממילא מנגנון
הדה-קוהרנטיות; כלל §8 ו־`fazisFaktorialis` הם בדרגת אנלוגיה;
הקשר קצב–הזיות נותר השערה.

---

*Fájl vége. Ez az egyetlen új fájl ebben a feladatban (§13, §16, §20:
semmi nem íródott felül, semmi nem törölve, commit/push nem történt —
a feladat utasítása szerint).*
