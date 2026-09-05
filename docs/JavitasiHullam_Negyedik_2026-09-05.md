# NEGYEDIK JAVÍTÓ-HULLÁM — három profi ágens + az ipkg 7-visszatérés
# 第四修复浪潮——三个专业代理＋ipkg 七项回归 · 2026-09-05
# FOURTH REPAIR WAVE — three pro agents + the ipkg 7-return
# VIERTE REPARATURWELLE — drei Profi-Agenten + die ipkg-7-Rückkehr

**Előzmény:** a felhasználó: «folytasd 3 profi idrisz agenttel» (idris-nyelv +
idris-stilus kötelező 0. lépésként). Három ágens + a fő ügynök ipkg-lépése.

---

## 1. LÁNC-ORVOS — a 7 kihagyott modul MINDJIKJÁNAK tiszta utódja

- **EvolutivKereso_v2 / Mondat_v2 / Muszerefal_v3 / Muszerefal_v4** —
  mind a négy `--check`: exit 0, EGYETLEN szó kimenet sem.
- **CSAPDA #30 (új, mért):** a `Data.List.sortBy` az Idris 0.8.0-ban csak
  `export` (NEM public export — base-0.8.0/Data/List.idr:747) → fordítási
  időben NEM redukál importáló modulból. Gyógyír: saját public-export
  beszúrásos rendezés, amit a futás ÉS a bizonyítás KÖZÖSEN hív (§24).
- **CSAPDA #27b (a #27 élesítése, 13 mért adatpont):** az igazi minta —
  az ÉKEZETES KEZDŐBETŰS csupasz kötőnév bukik (`útvonal, űr, ábra, ék`),
  az ASCII-kezdésű ékezetes ÁTMEGY (`gyök, béta, népességLista`) —
  **a §25 ékezetesség megőrizhető**. Gyógyír-rend: pont-stílus > @-minta >
  konstruktor-minta (nem megbízható!) > ASCII-kezdésű név.
- **A mélyebb igazság:** a v1 „bizonyítás-hibái" a #27 folyományai voltak —
  **az állítások végig IGAZAK voltak**, a négy Refl most mind zár.
- **Mondat_v2:** import → FazisAlgebra_v3, `időFázisba`, MINŐSÍTETTED
  `VilágKonstruktor` (két modul exportálja — a csupasz név kétértelmű lett
  volna), két-rekord híd (projekciókkal szedve, újraépítve).

## 2. KONVERTŐR — két konverzió + TUDOMÁNYOS SENZÁCIÓ

- **`ZetaKe9Szórás_v1.idr`:** ζ-gyök-referenciák + GUE-formula (P(1.5) =
  0.955…) + a K-mátrix spektruma KÉT ÚTON (Newton-identitásokból épített
  egész-karakterisztikum + Jacobi-forgatás, ~9 tizedesig egyeznek) —
  **és a megcáfolás: a .py „E9 Cartan-mátrixa" NEM Cartan-mátrix**
  (invertálható: det = −2; indefinit: −0.015316 sajátérték). A VALÓDI
  affin E8^(1): karok (1,2,5), Kac-jelölés [2,4,6,5,4,3,2,1,3] (Refl ✓,
  összeg 30 = h), spektruma **az ARANYMETSZÉST tartalmazza**:
  {0; 0.381966; 1; 1.381966; 2; 2.618034; 3; 3.618034; 4} = 0 ∪ 2±{2,φ,1,φ⁻¹}.
  A Berman x1 HERMITIAN (nem anti-), valós spektrum, maradék ~1e-16;
  2sin72° = √(2+φ) PONTOSAN (|·| = 0.0).
- **`KlasszikusKódok_v1.idr`:** a 24 magyar eset szindróma-táblája;
  ÚJ eredmények, amiket a .py SOHA nem számolt: a szindróma-leképezés
  INJEKTÍV (24/24), a „paritás"-mátrix GF(2)-n INVERTÁLHATÓ (256 felsorolás,
  mag = {0}), ÉS a konvolúciós demó DEGENERÁCIÓJA: 8 eset → csak 4
  különböző 16-bites szó (NOM/ACC/DAT/SUB mind a nullszóra futnak —
  **a „javító"-lépés az információt FELÜLÍRJA**; súlyok [0,0,6,4,0,0,6,4];
  min. táv 4; XOR-zártság 54/64).
- **5 új csapda:** a `**` érték-pozícióban DPair-ként parszol!; é/ú/á LHS-
  kötők tiszta függvényben is buknak; @-minta klauzula-VÉGÉN két mintának
  parszol (ASCII-kötő a robusztus); Horner-irány csapda (gyök-reciprok
  ujjlenyomat; `--client`-próba leplezte le); a #23 + ELAVULT .so-változat
  (`-o` mtime-ütközésnél régit futtat — gyógyír: `--client` + új név).

## 3. INTEGRÁTOR — Hullam4Teszt_v1: 12 modul, 17/17 ZÖLD + A KÉT-VILÁG HÍD

- **`Hullam4Teszt_v1.idr`:** mind a 12 kért modul importálva és tesztelve —
  **17/17 teszt ZÖLD** (ϱ-híd 3.99e-14; lexikon 3460; 47-prím; zene-
  asszociativitás konkrét nyilakon; Euler 0-szög; 6-lépéses sor; 17
  csomópont; lépésKép; koherencia; Triptofán→„Trp"; Metionin/Leucin).
- **A KÉT-VILÁG HÍD (nagy felfedezés):** a szima_ter/modul világ
  `IDRIS2_PATH=<másik világ>/build/ttc`-vel KERESZTVILÁG-importálható a
  prebuilt .ttc-ken át — ÉS nem csak fejléc-szinten: a kereszt-világ
  ÉRTÉKSZÁMÍTÁS bizonyított (lexikonCenzusHossza = 3460 külsőből kiszámolva).
  Az osveny_index ↔ szima_ter szimlink-híd futásidejű folytatása.
- **Állapot_v1.md frissítve:** lépésszám 4→11; ÚJ BFS-sor (hullám-5: a 51
  .py maradék jegyzéke, lexikon-optimalizálás, wiki-regenerálás).

## 4. AZ IPKG 7-VISSZATÉRÉS (fő ügynök, a Javító 1 javaslatára)

- 2 relatív szimlink (`modul/Alap/KeresoTabla_v2.idr`,
  `modul/Kategoriak/ZeneKategoria_v2.idr` — Hullam_3-minta);
- a `szima.ipkg` HULLAM_4 VISSZATÉRÉS blokkja: FazisAlgebra_v3, Mondat_v2,
  Muszerefal_v4, Muszerefal_v3, EvolutivKereso_v2, Alap.KeresoTabla_v2,
  Kategoriak.ZeneKategoria_v2;
- **A NAGY ELLENŐRZÉS: `idris2 --build szima.ipkg` → EXIT 0** — a
  build-gráf most **101 modul** (EvolutivKereso_v2 9/101, FazisAlgebra_v3
  20/101, Mondat_v2 21/101, Muszerefal_v4 26/101, Muszerefal_v3 35/101…);
  a két szimlinkes visszatérő külön is GAUGE-ellenőrizve (mindkettő
  „Building" + exit 0). **A kánon 7 kihagyásból 7 visszatért.**

## 5. ÖSSZEGZÉS A NÉGY HULLÁMRÓL / 四波总览

| Hullám | Commit | Hozam |
|---|---|---|
| 1. | d64e664 | 7 gyógyítás (5 ágens) |
| 2. | dd1659b | 4 gyógyítás (Planck 1-token; believe_me-mentes; AI-lánc magyar) |
| 3. | c525c44 | 6 tétel (lexikon-tanú, ipkg-alap, migráció, .py-rend, Δ-analízis) |
| 4. | e dokumentum | 7 ipkg-visszatérés + 2 konverzió + integrációs teszt (17/17) + a két-világ híd |
| **Összesen** | | **24 tétel, mind GAUGE-hitelesítve; a csapda-katalógus +11 → ~38 tétel** |

Maradó (hullám 5 jelöltek): az 51 .py maradék jegyzéke; a lexikon-lista
optimalizálása; a wiki regenerálása az új számokkal (101 modul!); az
EvolutivKereso/Muszerefal _v2-ek visszatesztje a Teljes Tesztben.

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★
