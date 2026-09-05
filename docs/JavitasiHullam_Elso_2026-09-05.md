# ELSŐ JAVÍTÓ-HULLÁM — öt ágens, hét hitelesített hiba gyógyítása
# 第一修复浪潮——五代理，七项已证实错误的医治 · 2026-09-05
# FIRST REPAIR WAVE — five agents healing the seven verified defects
# ERSTE REPARATURWELLE — fünf Agenten heilen die sieben verifizierten Fehler

**Előzmény:** `docs/AuditHaromAgens_Osszefoglalo_2026-09-05.md` (a hitelesített
hibalista) + a felhasználó utasítása: «menjunk vegig a terven es javitsunk
mindent … hogyan kell jol bizonyitani, induljon 5 subagent». Öt javító-ágens
futott; mindegyik a csapda-katalógussal, GAUGE-fegyelemmel, Python és törlés
nélkül; EGYSEM commitolt — az összesítést ez a dokumentum és a közös commit
zárja.

---

## 1. A HÉT GYÓGYÍTÁS EREDMÉNYE / 七项医治结果

| # | Tárgy | Eredmény | Tanú |
|---|---|---|---|
| 1 | **KeresoTabla_v2** (csonka fájl) | `osveny_index/Alap/KeresoTabla_v2.idr` — 525 sor; lezárt string; VALÓDI ProjektGráf (grep-igazolt élek; a v1 `CliffordSzorzat`-exportja nem is létezett); 6 szimlink-híd + 10 könyvtár-csomópont; `TöltésParitásIdőHáromRéteg` (CPT-rövidítés megszűnt); 3 valódi Refl; futás: `Kész.` + exit 0 | Javító 1 |
| 2 | **KisAI útvonal (#6)** | SZÁNDÉKOSAN NEM javítva: pontosan EGY importáló (`Dirac3D/Main3D.idr:19`), és a Main3D ÖNMAGA is #6-os (`module Main3D` a `Dirac3D/`-ben, 19 import) → csak KÖZÖS migráció jó (KiszoloAI_v2 + Main3D_v2) — dokumentálva | Javító 1 |
| 3 | **ZeneKategoria_v2** (indukció) | 40 klauzula (9 `cong` + 31 Refl), `public export total`; MÁSODIK hiba leplezve: az eredeti egyenlőség IRÁNYA fordított volt az interfészhez képest; az eredeti irány `zeneAsszociativTukorkep`-ként `sym`-mal megőrizve; check: `2/2 Building, EXIT=0` | Javító 2 |
| 4 | **Rendszer_v2** (4+3+2 rejtett) | gyökérok: a KodKonstruktor HÉT mezős, 5-tel hívták (a CliffordElem a harmadikE8-pozícióba esett); a deklarációnkénti első-hiba-szabály KÉT további hibát rejtett; becsületes Euler: mérés (`cos(π)+1 = 0.0 — kerekítés, NEM pontos egyenlőség`) + valódi 0-szög-Refl; §24-önjavítás: a saját legendre-példány törölve, a kanonikus (Perem/Index:57) maradt; check: `13/13, exit 0, 0 hiba 0 figyelmeztetés`; futás: 35+ értelmes sor | Javító 3 |
| 5 | **E8Kartan_v2** (4 hiba) | skálázási döntés: `A(i,j) = ⟨βi,βj⟩/4` (a /8-javaslat MATEMATIKAILAG ROSSZ volt: −4/8 = −½); a v1 mátrixa és gyöklistája HELYESNEK bizonyult (mind a 64 cella függetlenül újraszámolva) — a komment és a teszt volt rossz; 11 valódi Refl; futás: 5× `✓ OK` (szimmetria, átló=2, elemek∈{−1,0,2}, determináns=1, skálatörvény) | Javító 4 |
| 6 | **FazisAlgebra_v3** (név-skew) | a szima_ter-világ VIZSGÁLVA: a `HaromKubit` ott HALOTT (nincs `Alap.CsomagoltTipusok`) → a v3 helyben definiálja az Igazság-mintát + HaromKubit-tükröt, a KANONIKUS ÉKEZETES nevekkel (egyesítés-kompatibilis); a v1 TELJES tartalma + 7 valódi Refl; check tiszta | Javító 4 |
| 7 | **4 komment-tényhiba** (helyben) | CayleyDickson (sedenion: MÁR NEM divíziós, nulla-osztók + Hurwitz), Steane713 (a 16 kódszó a SAJÁT kódtért fedi le, nem a 22 esetet), SteaneHierarchia (tábla a kódhoz igazítva [[2,1,1]]/[[4,1,2]]), GeneralizedPauli („OSZTÁLYOZVA, nem bizonyítva" + 8 tautológia-jelzés) — a régi szöveg `-- RÉGI (HAMIS) … javítva 2026-09-05:` jelöléssel MEGMARADT; mind az 5 érintett fájl --check-je TISZTA | Javító 5 |

**Maradó (dokumentált, következő hullám):** a `DependensSzamT` két
believe_me-je HAMIS TANÚ (a 194. sor típusához egyetlen konstruktor sem illik —
futásidőben String-adat áll morfizmusnak álcázva; az 215. sor leképezése
definíció-átfedés miatt fel sem írható) → új konstruktor kell (pl.
`DimenzioKetLepes`), külön feladat; az AI-lánc ékezetesítése (top-20 szótár +
3 hullám + ~1 óra — a terv Javító 5-jelentésében); a **Planck-felezés** (Javító
3 GAUGE-lelete: öt Planck-mennyiség pontosan fele a referenciaértéknek, arány
2,0 — az eredeti Legendre-modul tartalma, új javítandó); a GeneralizedPauli
`main`-je futásidőben még „bizonyítva"-t ír (putStrLn = kód — a kimenet hazud a
javított kommentekhez képest) → _v2-ben igazítandó.

## 2. ÚJ CSAPDÁK (ma +11 tétel — a katalógus frissítve) / 新陷阱

**A CSAPDA_27 FELÜLVIZSGÁLVA** (`tanulsagok/CSAPDA_27_…md` bővítve): a
konstruktorba ágyazott minta NEM mindig véd; gyógyír-rend: pont-stílus >
@-minta (tiszta függvényen is, = #27b) > konstruktor-minta > ASCII csupasz név.
Újak: **#28** (a where-segéd nem látszik a másik klauzulából → felső szint);
**#29** (a `--check modul/X.idr` útvonal-prefixe modulnév-réssé válik →
`cd modul`-ból fordítani); pipe elrejti az exit-kódot; a deklarációnkénti
első-hiba-szabály későbbi hibákat rejt (a deklaráció minden hivatkozását
greppelni); rekord-mező nem hivatkozhat későbbi `data`-ra; instance-mező
egyenlőségi IRÁNYA az interfészt követi; catch-all változó a jobb-oldal-
ellenőrzéskor nem bontódik; Show-string-átnevezés csapdája (IUPAC-kódok
védendők); a saját-modulnévvel minősített konstruktor a hullámban átírandó;
„exit 0 + hibaüzenet" kettős tanú (ma kétszer élesben).

## 3. A BIZONYÍTÁS-TANULSÁG (a «hogyan kell jol bizonyitani» válasza) / 证明之学

- **Előbb a matematika, aztán a kód** (Javító 2): döntsd el, igaz-e és MIÉRT;
  írd meg a vázlatot (alapeset / indukciós lépés / melyik argumentumon
  rekurzálunk — a plusReduces-minta), és csak utána ülj a fordító elé.
- **Az üres Refl nem hiba, hanem HIÁNYZÓ TARTALOM** (Javító 3): ha a fordító
  cinkos (két oldal ugyanazon kerekítése), a Refl nem tanú, hanem kettős
  könyvelés. Gyógyír három rétegben: mérés elválasztása a bizonyítástól;
  definicionális egyenlőség csak KÜLÖNBÖZŐ konstrukciók közt; a valódi
  propozíciót a szimbolikus lánc hordozza.
- **A /8-javaslat cáfolata** (Javító 4): a jó matematikai érzés a javaslatot
  is ellenőrzi — −4/8 = −½ nem egész, tehát a /4-törvény a helyes (és a
  bizonyítás a szorzás-alakban: ⟨βi,βj⟩ = 4·A(i,j) — egész-aritmetika).

## 4. ÁLLAPOT / 状态

Minden új fájl fordul (GAUGE: kimenet olvasva); a v1/v2 örökölt fájlok
érintetlenek; semmi nem törlődött; az öt helyben-javított fájl csak
komment-sorokat változtat. Következő: a maradó-tétel-lista az Irányító
BFS-sorába, a Javító 5-féle AI-lánc-hullám külön ütemben.

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★
