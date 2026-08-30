# AlapJegyzék — a szima csomag szilárd alapja (2026-08-21)
# 基础清册 · Fundament-Verzeichnis · מפקד היסוד

**Forrás (a felhasználó, 2026-08-21, szó szerint):**
> "legyen minden normalisan megalapozva, szethullott alapokra nehez epiteni, nem ?"

## A mérés (2026-08-21, gépi idő szerint)

| mutató | érték |
|---|---|
| .idr fájlok (modul/ gyökér + Alap/) | 50 |
| eredeti ellenőrzés: OK | 37 |
| eredeti ellenőrzés: HIBÁS | 13 |
| **szima.ipkg építés a mérés után** | **39/39 OK, 21 s, EGY paranccsal** |
| ellenőrző parancs | `idris2 --build szima_ter/szima.ipkg` |

## A 13 hibás anatómiája (ok + sors)

### A csoport — EGY hiba ÖT másolatban (`Neg Nat`: Nat-nincs-kivonás)
A `szindromaTer = e8Gyokok - steaneHilbertTer` minta (Nat − Nat) az
Idris 2 Prelude-ben nincs `Neg Nat` instance → nem fordul. ÖT modulban
élt MÁSOLATKÉNT (a duplikáció egy hibát ötszörös csapássá tett):
1. HaromKategoria_v2.idr — szindromaTer
2. KetoldaliE8Fa_v2.idr — szindromaTer
3. KetoldaliKategoria_v2.idr — szindromaTer
4. MagyarCarnotE9_v2.idr — SzindromaTer (+ nagybetűs)
5. MagyarCarnotE9_v2_2_CodatAlpha.idr — szindromaTer, buborekMeret
**Sors:** _v3 hullámban gyógyítandók (`minus`/Integer + közös
Alap-modulba emelés — §24). A v2-k a repóban maradnak (§13).

### B csoport — láncolt áldozatok (a gyökér MÁS modulban volt)
6. BetuE8_v2.idr — ÖNMAGÁBAN JÓ; a MagyarNyelvtan_v2 importja vitte rá
7. E8Fa_v2.idr — ugyanaz
8. PauliAlgebra_v2_Javaslat.idr — ugyanaz
9. Main_PiroskaTeljes_v2.idr — a PiroskaHolografikusKod49_v2_Teljes importja
**Gyökérok:** l. C csoport. A BetuE8_v2/E8Fa_v2/PauliAlgebra_v2_Javaslat
a MagyarNyelvtan_v3 meggyógyításával ÉLŐSKÖDÖSTŐL épülnek (nem kellett
hozzányúlni — csak az alap állt rosszul alattuk).

### C csoport — szintaxis-törések (izolált pró-bákkal felértékelve)
10. **MagyarNyelvtan_v2.idr** — HÁROM egymásra rakódó hiba:
    a) `data Digraf` konstruktorok egy sorban `|`-fal, típus-ascription
       nélkül (az Idris 0.8.0 elutasítja; ProbeDigraf vs. ProbeDigraf2);
    b) Prelude-duplikátumok (mapMaybe/null/filter) → "Ambiguous
       elaboration" (§24!);
    c) definíciók a használatuk UTÁN (showIgeido, showHangrend,
       showAspektus, showEvidencialis, showMaybe — a main-utáni-csapda
       rokona);
    d) `drop` import nélkül (Data.List).
    **Gyógyír (megtörtént): MagyarNyelvtan_v3.idr — 0 hiba.**
11. **PiroskaHolografikusKod49_v2_Teljes.idr** — HÁROM hiba:
    a) `x > (3 : Nat)` — a típus-ascription a `>` után zavarja a
       parsert ("Expected 'then'"; ProbeIf..ProbeIf4 izolálta);
    b) Nat − Nat (`length szo - 1`) — `Neg Nat` (megint);
    c) Nat/Int-ütközés a helyi strSubstr cast-típusával.
    **Gyógyír (megtörtént): PiroskaHolografikusKod49_v3_Teljes.idr —
    0 hiba, ÉS ékezetes azonosítókkal (§25 első alkalmazása:
    tolSzótárKeres, szóPeremKeres, részSzöveg, vagyBit, peremVagy).**

### D csoport — dokumentáltan nyugvó
12. **E8Gyokok.idr (v1)** — a nagy-Nat kernel-robbanás áldozata
    (696 729 600 unáris normalizálás; l. NagyNatEsArvaChezCsapda.md).
    A v2 váltotta fel, ami a csomagban ÉS fut. **Nyugvó — tanulsághordozó.**
13. **Main_PiroskaTeljes_v2.idr** — a Piroska v3 meggyógyításával az
    importlánc is gyógyul; ha mégsem épülne, _v3 követi (nyitott).

## A csomag (szima.ipkg) tagjai — 39 modul
Alap.AlphaKozos, AlphaE8Szigor, AlphaGCheck, AlphaLobaszas, AlphaSteane,
AlphaSteaneDashboard, AlphaSteaneE8, AlphaSteaneVegso, E8BelsoSzorzat,
E8FazisKapcsolat, E8Gyokok_v2, E8TizenhatPenge, FazisKubit, GCheck,
HolografikusKod49_v2_MantraModul, KomplexByte, Kvaternion,
MagyarKinaiAltInverz_v2, MagyarKinaiFazisBayes_v2, MagyarKinaiFolding_v2,
MagyarKinaiGenKod_v2, MagyarKinaiInverz_v2, MagyarKinaiPar_v2,
MagyarKinaiParkettazas_v2, MagyarKinaiTorvenyek_v3, MagyarNyelvtan_v3,
Main, Main_MagyarKinaiGenKod_v2, Main_MagyarKinaiInverz_v2,
Main_MagyarKinaiPar_v2, Main_PauliAlgebra_v2, Main_v2, Paragrafus,
PauliAlgebra_v2, PiroskaHolografikusKod49_v3_Teljes, PiroskaSztar,
PiroskaSztarTeljes, SzimaDashboard, TetrapodaTest

## A tanulságok (a mérésből)

1. **A duplikáció a hibákat is sokszorozza** — egy `Neg Nat` öt sebet ütött
   (§24 igazolása a gyakorlatban).
2. **A láncolt importok maszkíroznak** — 3 "hibás" modul tökéletes volt,
   csak rossz alap állt alattuk; a gyökér két szinttel lejjebb élt.
3. **Az izolált próba (probe) az igazság** — a "Expected 'then'" valójában
   a `(3 : Nat)` ascription volt; ProbeIf..ProbeIf4 bizonyította.
4. **Az ékezetes azonosítók élnek** (ProbeUnikod) — a §25 nem álom,
   a Piroska v3 már ékezetesen fut.
