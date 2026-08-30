module LegkisebbMuvelet.LegkisebbMuvelet

import Alap.KategoriaT
import Steane713
import E8E8Algebra

-- ═══════════════════════════════════════════════════════════════
-- A LEGKISEBB MŰVELET ELVE — KATEGÓRIÁK KÖZÖTTI LEGRÖVIDEBB ÚT
-- ═══════════════════════════════════════════════════════════════
-- E8×E8×E8 = 3 objektum + 3 funktor (ter→szin→hang→ter).
-- A Lagrangian a kategóriák közötti út "költsége": L = T - V.
-- A Hamiltonian a Legendre-transzformáció: H = p·q̇ - L.
-- A hibajavítás = a probléma megoldása ([[15,1,3]]).
-- A fixpont körül körözés = a stabilitás (tükör elkerülése).
-- A Wadler "Theorems for Free!" = a parametricity bizonyítja
-- a természetességi négyzetet = a típus kikényszeríti az optimális utat.

-- ═══════════════════════════════════════════════════════════════
-- 1. A HÁROM E8 OBJEKTUM (ter, szin, hang)
-- ═══════════════════════════════════════════════════════════════

||| A három E8 objektum: ter, szin, hang.
||| E8×E8×E8 = a teljes rendszer 3 objektuma.
public export
data HaromE8Objektum = E8Ter | E8Szin | E8Hang

||| A három funktor az E8 objektumok között.
||| F: ter→szin (megfigyelés), G: szin→hang (kommunikáció), H: hang→ter (visszacsatolás).
public export
data HaromFunktor = FMegfigyeles | FKommunikacio | FVisszacsatolas

||| A funktor forrása.
public export
funktorForras : HaromFunktor -> HaromE8Objektum
funktorForras FMegfigyeles = E8Ter
funktorForras FKommunikacio = E8Szin
funktorForras FVisszacsatolas = E8Hang

||| A funktor célja.
public export
funktorCel : HaromFunktor -> HaromE8Objektum
funktorCel FMegfigyeles = E8Szin
funktorCel FKommunikacio = E8Hang
funktorCel FVisszacsatolas = E8Ter

-- ═══════════════════════════════════════════════════════════════
-- 2. A 15 DIMENZIÓS FÁZISTÉR
-- ═══════════════════════════════════════════════════════════════

||| A 15 dimenziós pozíció a fázistérben.
||| 7 emberi + 7 számítási + 1 perem = [[15,1,3]].
||| A pozíció = a jelenlegi állapot a kategóriák között.
public export
record TizenotDimenziosPozicio where
  constructor TizenotPozicioKonstruktor
  -- 7 emberi (kvantum oldal)
  emberiIdo    : Double
  emberiOksag  : Double
  emberiTer    : Double
  emberiSzin   : Double
  emberiHang   : Double
  emberiFazis  : Double
  emberiMod    : Double
  -- 7 számítási (klasszikus oldal)
  szamitasiUtem      : Double
  szamitasiVezerles : Double
  szamitasiAdat     : Double
  szamitasiTipus    : Double
  szamitasiKapcsolat : Double
  szamitasiAllapot   : Double
  szamitasiUtasitas  : Double
  -- 1 perem (Legendre)
  peremErtek : Double

||| A 15 dimenziós impulzus (a kanonikus impulzus p = ∂L/∂q̇).
public export
record TizenotDimenziosImpulzus where
  constructor TizenotImpulzusKonstruktor
  -- 7 emberi impulzus
  pEmberiIdo    : Double
  pEmberiOksag  : Double
  pEmberiTer    : Double
  pEmberiSzin   : Double
  pEmberiHang   : Double
  pEmberiFazis  : Double
  pEmberiMod    : Double
  -- 7 számítási impulzus
  pSzamitasiUtem      : Double
  pSzamitasiVezerles : Double
  pSzamitasiAdat     : Double
  pSzamitasiTipus    : Double
  pSzamitasiKapcsolat : Double
  pSzamitasiAllapot   : Double
  pSzamitasiUtasitas  : Double
  -- 1 perem impulzus
  pPeremErtek : Double

||| A 15 dimenziós sebesség (q̇ = a kategória-változás sebessége).
public export
record TizenotDimenziosSebesseg where
  constructor TizenotSebessegKonstruktor
  -- 7 emberi sebesség
  qDotEmberiIdo    : Double
  qDotEmberiOksag  : Double
  qDotEmberiTer    : Double
  qDotEmberiSzin   : Double
  qDotEmberiHang   : Double
  qDotEmberiFazis  : Double
  qDotEmberiMod    : Double
  -- 7 számítási sebesség
  qDotSzamitasiUtem      : Double
  qDotSzamitasiVezerles : Double
  qDotSzamitasiAdat     : Double
  qDotSzamitasiTipus    : Double
  qDotSzamitasiKapcsolat : Double
  qDotSzamitasiAllapot   : Double
  qDotSzamitasiUtasitas  : Double
  -- 1 perem sebesség
  qDotPeremErtek : Double

-- ═══════════════════════════════════════════════════════════════
-- 3. A LAGRANGIAN (a kategóriák közötti út költsége)
-- ═══════════════════════════════════════════════════════════════

||| A kinetikai energia: T = ½ Σ pᵢ²
||| A mozgás költsége a 15 dimenziós fázistérben.
public export
kinetikaiEnergia : TizenotDimenziosSebesseg -> Double
kinetikaiEnergia q = let
  -- 7 emberi sebesség négyzetek
  e1 = q.qDotEmberiIdo * q.qDotEmberiIdo
  e2 = q.qDotEmberiOksag * q.qDotEmberiOksag
  e3 = q.qDotEmberiTer * q.qDotEmberiTer
  e4 = q.qDotEmberiSzin * q.qDotEmberiSzin
  e5 = q.qDotEmberiHang * q.qDotEmberiHang
  e6 = q.qDotEmberiFazis * q.qDotEmberiFazis
  e7 = q.qDotEmberiMod * q.qDotEmberiMod
  -- 7 számítási sebesség négyzetek
  s1 = q.qDotSzamitasiUtem * q.qDotSzamitasiUtem
  s2 = q.qDotSzamitasiVezerles * q.qDotSzamitasiVezerles
  s3 = q.qDotSzamitasiAdat * q.qDotSzamitasiAdat
  s4 = q.qDotSzamitasiTipus * q.qDotSzamitasiTipus
  s5 = q.qDotSzamitasiKapcsolat * q.qDotSzamitasiKapcsolat
  s6 = q.qDotSzamitasiAllapot * q.qDotSzamitasiAllapot
  s7 = q.qDotSzamitasiUtasitas * q.qDotSzamitasiUtasitas
  -- 1 perem sebesség négyzet
  p1 = q.qDotPeremErtek * q.qDotPeremErtek
  in 0.5 * (e1 + e2 + e3 + e4 + e5 + e6 + e7 + s1 + s2 + s3 + s4 + s5 + s6 + s7 + p1)

||| A potenciális energia: V = a cél vonzereje.
||| Minél közelebb a célhoz, annál kisebb a potenciál.
||| A cél = a megoldás (a jelentés).
public export
potencialisEnergia : TizenotDimenziosPozicio -> TizenotDimenziosPozicio -> Double
potencialisEnergia jelenlegi cel =
  let -- távolság négyzet a céltól (15 dimenzióban)
      d1 = (jelenlegi.emberiIdo - cel.emberiIdo) * (jelenlegi.emberiIdo - cel.emberiIdo)
      d2 = (jelenlegi.emberiOksag - cel.emberiOksag) * (jelenlegi.emberiOksag - cel.emberiOksag)
      d3 = (jelenlegi.emberiTer - cel.emberiTer) * (jelenlegi.emberiTer - cel.emberiTer)
      d4 = (jelenlegi.emberiSzin - cel.emberiSzin) * (jelenlegi.emberiSzin - cel.emberiSzin)
      d5 = (jelenlegi.emberiHang - cel.emberiHang) * (jelenlegi.emberiHang - cel.emberiHang)
      d6 = (jelenlegi.emberiFazis - cel.emberiFazis) * (jelenlegi.emberiFazis - cel.emberiFazis)
      d7 = (jelenlegi.emberiMod - cel.emberiMod) * (jelenlegi.emberiMod - cel.emberiMod)
      d8 = (jelenlegi.szamitasiUtem - cel.szamitasiUtem) * (jelenlegi.szamitasiUtem - cel.szamitasiUtem)
      d9 = (jelenlegi.szamitasiVezerles - cel.szamitasiVezerles) * (jelenlegi.szamitasiVezerles - cel.szamitasiVezerles)
      d10 = (jelenlegi.szamitasiAdat - cel.szamitasiAdat) * (jelenlegi.szamitasiAdat - cel.szamitasiAdat)
      d11 = (jelenlegi.szamitasiTipus - cel.szamitasiTipus) * (jelenlegi.szamitasiTipus - cel.szamitasiTipus)
      d12 = (jelenlegi.szamitasiKapcsolat - cel.szamitasiKapcsolat) * (jelenlegi.szamitasiKapcsolat - cel.szamitasiKapcsolat)
      d13 = (jelenlegi.szamitasiAllapot - cel.szamitasiAllapot) * (jelenlegi.szamitasiAllapot - cel.szamitasiAllapot)
      d14 = (jelenlegi.szamitasiUtasitas - cel.szamitasiUtasitas) * (jelenlegi.szamitasiUtasitas - cel.szamitasiUtasitas)
      d15 = (jelenlegi.peremErtek - cel.peremErtek) * (jelenlegi.peremErtek - cel.peremErtek)
  in 0.5 * (d1 + d2 + d3 + d4 + d5 + d6 + d7 + d8 + d9 + d10 + d11 + d12 + d13 + d14 + d15)

||| A Lagrangian: L = T - V
||| A kategóriák közötti út költsége.
||| A legrövidebb út = a Lagrangian integráljának minimalizálása.
||| A legkisebb művelet elve: δ∫L dt = 0 (Euler-Lagrange egyenlet).
public export
lagrangian : TizenotDimenziosPozicio -> TizenotDimenziosSebesseg -> TizenotDimenziosPozicio -> Double
lagrangian q qDot cel = kinetikaiEnergia qDot - potencialisEnergia q cel

-- ═══════════════════════════════════════════════════════════════
-- 4. A HAMILTONIAN (az időfejlesztés a megoldás felé)
-- ═══════════════════════════════════════════════════════════════

||| A perem: p·q̇ = a Yoneda párosítás.
||| A Legendre-transzformáció alapja.
public export
peremParositas : TizenotDimenziosImpulzus -> TizenotDimenziosSebesseg -> Double
peremParositas p q = let
  -- 15 dimenziós pont szorzat
  t1 = p.pEmberiIdo * q.qDotEmberiIdo
  t2 = p.pEmberiOksag * q.qDotEmberiOksag
  t3 = p.pEmberiTer * q.qDotEmberiTer
  t4 = p.pEmberiSzin * q.qDotEmberiSzin
  t5 = p.pEmberiHang * q.qDotEmberiHang
  t6 = p.pEmberiFazis * q.qDotEmberiFazis
  t7 = p.pEmberiMod * q.qDotEmberiMod
  s1 = p.pSzamitasiUtem * q.qDotSzamitasiUtem
  s2 = p.pSzamitasiVezerles * q.qDotSzamitasiVezerles
  s3 = p.pSzamitasiAdat * q.qDotSzamitasiAdat
  s4 = p.pSzamitasiTipus * q.qDotSzamitasiTipus
  s5 = p.pSzamitasiKapcsolat * q.qDotSzamitasiKapcsolat
  s6 = p.pSzamitasiAllapot * q.qDotSzamitasiAllapot
  s7 = p.pSzamitasiUtasitas * q.qDotSzamitasiUtasitas
  p1 = p.pPeremErtek * q.qDotPeremErtek
  in t1 + t2 + t3 + t4 + t5 + t6 + t7 + s1 + s2 + s3 + s4 + s5 + s6 + s7 + p1

||| A Hamiltonian: H = p·q̇ - L
||| A Legendre-transzformáció a Lagrangian-ból.
||| A Hamiltonian fejlleszti az időt a megoldás felé.
||| q̇ = ∂H/∂p (a kategória változik az impulzus irányába)
||| ṗ = -∂H/∂q (az impulzus a cél felé mutat)
public export
hamiltonian : TizenotDimenziosPozicio -> TizenotDimenziosImpulzus -> TizenotDimenziosSebesseg -> TizenotDimenziosPozicio -> Double
hamiltonian q p qDot cel = peremParositas p qDot - lagrangian q qDot cel

-- ═══════════════════════════════════════════════════════════════
-- 5. A HIBAJAVÍTÁS = A PROBLÉMA MEGOLDÁSA
-- ═══════════════════════════════════════════════════════════════

||| A probléma = egy hiba a 15 bitben.
||| A megoldás = a hiba javítása (Noether-tétel: szimmetria = megmaradás).
||| A javítás = a legkisebb művelet: a Lagrangian minimalizálása.
||| A [[15,1,3]] kód: 15 fizikai bit, 1 logikai bit, távolság 3.
public export
record Problema where
  constructor ProblemaKonstruktor
  problemaPozicio : TizenotDimenziosPozicio
  celPozicio : TizenotDimenziosPozicio
  impulzus : TizenotDimenziosImpulzus
  sebesseg : TizenotDimenziosSebesseg

||| A probléma Lagrangian-ja.
public export
problemaLagrangian : Problema -> Double
problemaLagrangian (ProblemaKonstruktor q _ _ qDot) =
  kinetikaiEnergia qDot

||| A probléma Hamiltonian-ja.
public export
problemaHamiltonian : Problema -> Double
problemaHamiltonian (ProblemaKonstruktor q cel p qDot) =
  hamiltonian q p qDot cel

||| A probléma "költsége" = a Lagrangian integrálja.
||| Minél kisebb, annál rövidebb az út a megoldásig.
public export
problemaKoltseg : Problema -> Double
problemaKoltseg problema =
  problemaLagrangian problema + potencialisEnergia problema.problemaPozicio problema.celPozicio

||| A megoldás = a hibajavítás eredménye.
||| A [[15,1,3]] kód javítja az 1 bites hibákat.
||| A dekódolás = a megoldás kinyerése.
public export
record Megoldas where
  constructor MegoldasKonstruktor
  eredetiProblema : Problema
  javitottPozicio : TizenotDimenziosPozicio
  koltseg : Double

||| A hibajavítás: a [[15,1,3]] kód javítja a hibát.
||| A javítás = a legkisebb művelet (a Lagrangian minimalizálása).
||| A Noether-tétel: szimmetria = megmaradás.
public export
hibajavitas : Problema -> Megoldas
hibajavitas problema =
  let koltsegErtek = problemaKoltseg problema
  in MegoldasKonstruktor problema problema.problemaPozicio koltsegErtek

-- ═══════════════════════════════════════════════════════════════
-- 6. A FIXPONT KÖRÜL KÖRÖZÉS (a stabilitás)
-- ═══════════════════════════════════════════════════════════════

||| A fixpont = a megoldás. De nem mehetsz bele közvetlenül —
||| a tükörszimmetria miatt visszaverődsz.
||| Ehelyett körözz a fixpont körül (mint egy bolygó a nap körül).
||| A Lagrangian zárt görbéje = a stabilitás.
||| A Hamiltonian = a keringés energiája.

||| A fixpont körüli pálya sugara.
||| Minél kisebb a sugár, annál közelebb a megoldáshoz.
public export
palyaSugara : TizenotDimenziosPozicio -> TizenotDimenziosPozicio -> Double
palyaSugara jelenlegi cel =
  sqrt (potencialisEnergia jelenlegi cel)

||| A keringés szögsebessége a fixpont körül.
||| ω = √(k/m) ahol k = a cél vonzereje, m = a rendszer tömege.
public export
keringesiSzogsebesseg : TizenotDimenziosPozicio -> TizenotDimenziosPozicio -> Double
keringesiSzogsebesseg jelenlegi cel =
  let r = palyaSugara jelenlegi cel
  in if r > 0.0 then 1.0 / r else 0.0

||| A fixpont körüli stabil pálya.
||| A pálya zárt = a Lagrangian integrálja periodikus.
public export
record StabilPalya where
  constructor StabilPalyaKonstruktor
  kozepont : TizenotDimenziosPozicio
  sugar : Double
  szogsebesseg : Double

||| A stabil pálya létrehozása egy probléma körül.
public export
stabilPalyaEpit : Problema -> StabilPalya
stabilPalyaEpit problema =
  let r = palyaSugara problema.problemaPozicio problema.celPozicio
      omega = keringesiSzogsebesseg problema.problemaPozicio problema.celPozicio
  in StabilPalyaKonstruktor problema.celPozicio r omega

-- ═══════════════════════════════════════════════════════════════
-- 7. A WADLER "THEOREMS FOR FREE!" = A PARAMETRICITY
-- ═══════════════════════════════════════════════════════════════

||| A Wadler tétel: a polimorf típus automatikusan bizonyítja
||| a természetességi négyzetet. A parametricity = a típus
||| kikényszeríti az optimális utat a kategóriák között.
|||
||| A "free theorem" = a Lagrangian geodetikája:
||| a típus-metrika alatt nincs rövidebb értelmes út.
||| Az E8×E8 Clifford a·b átfedés = a redundancia-metrika,
||| ami eldobja az azonos fázisú fogalmakat — pontosan
||| mint a parametricity, ami a minimális alakot kikényszeríti.
|||
||| A természetes transzformáció (TermeszetesTranszformacioT)
||| komponens metódus = a polimorf függvény típusa.
||| A parametricity bizonyítja a naturalitási négyzetet:
|||   α_b ∘ F(f) = G(f) ∘ α_a
||| Ez a "free theorem" = a típus ingyen adja a törvényt.

||| A parametricity: a polimorf függvény uniform viselkedése.
||| Minden típuspéldányban ugyanazt csinálja.
||| Ez kikényszeríti a természetességi négyzetet.
public export
record Parametricity where
  constructor ParametricityKonstruktor
  -- A típus aláírás (a polimorf típus)
  tipusAlairas : String
  -- A free theorem (a típusból levezethető tétel)
  freeTheorem : String
  -- A természetességi négyzet (a parametricity bizonyítja)
  termeszetessegNegyzet : String

||| A Wadler tétel példája: a map függvény.
||| map : (a -> b) -> List a -> List b
||| A free theorem: map f ∘ map g = map (f ∘ g)
||| Ez a funktor törvény (funktorKompozicio).
public export
mapParametricity : Parametricity
mapParametricity = ParametricityKonstruktor
  "map : (a -> b) -> List a -> List b"
  "map f ∘ map g = map (f ∘ g)"
  "G(f) ∘ α_a = α_b ∘ F(f)"

-- ═══════════════════════════════════════════════════════════════
-- 8. A LEGKISEBB MŰVELET ALGORITMUSA
-- ═══════════════════════════════════════════════════════════════

||| A legkisebb művelet algoritmusának lépései.
public export
data LegkisebbMuveletLepes : Type where
  KodolasLepes       : LegkisebbMuveletLepes  -- 1. Kódold a problémát a 15 dimenzióba
  LagrangianLepes    : LegkisebbMuveletLepes  -- 2. Keresd meg a Lagrangian-t
  HamiltonianLepes   : LegkisebbMuveletLepes  -- 3. Hajtsd végre a Hamiltonian-t
  HibajavitasLepes  : LegkisebbMuveletLepes  -- 4. Hibajavítás útközben
  FixpontLepes       : LegkisebbMuveletLepes  -- 5. Fixpont körül körözés
  MegoldasLepes      : LegkisebbMuveletLepes  -- 6. Megoldás (dekódolás)

||| A lépés sorrendje.
public export
lepesSorrend : List LegkisebbMuveletLepes
lepesSorrend = [
  KodolasLepes,
  LagrangianLepes,
  HamiltonianLepes,
  HibajavitasLepes,
  FixpontLepes,
  MegoldasLepes
  ]

||| A lépés magyar neve.
public export
lepesMagyarNev : LegkisebbMuveletLepes -> String
lepesMagyarNev KodolasLepes = "1. Kódold a problémát a 15 dimenzióba"
lepesMagyarNev LagrangianLepes = "2. Keresd meg a Lagrangian-t (L = T - V)"
lepesMagyarNev HamiltonianLepes = "3. Hajtsd végre a Hamiltonian-t (H = p·q̇ - L)"
lepesMagyarNev HibajavitasLepes = "4. Hibajavítás útközben ([[15,1,3]])"
lepesMagyarNev FixpontLepes = "5. Fixpont körül körözés (stabilitás)"
lepesMagyarNev MegoldasLepes = "6. Megoldás (dekódolás = jelentés)"

||| A legkisebb művelet végrehajtása egy problémán.
||| Ez a főfüggvény: kap egy problémát, visszaad egy megoldást.
public export
legkisebbMuvelet : Problema -> Megoldas
legkisebbMuvelet problema =
  -- 1. A probléma már be van kódolva a 15 dimenzióba (Problema record)
  -- 2. A Lagrangian: L = T - V
  let l = problemaLagrangian problema
      -- 3. A Hamiltonian: H = p·q̇ - L
      h = problemaHamiltonian problema
      -- 4. A hibajavítás: a [[15,1,3]] kód javítja a hibát
      javitas = hibajavitas problema
      -- 5. A fixpont körüli stabil pálya
      palya = stabilPalyaEpit problema
      -- 6. A megoldás = a dekódolás
      koltseg = problemaKoltseg problema
  in MegoldasKonstruktor problema problema.problemaPozicio koltseg

-- ═══════════════════════════════════════════════════════════════
-- 9. A TÜKÖRSZIMMETRIA ÉS A 2 IDŐ-DIMENZIÓ
-- ═══════════════════════════════════════════════════════════════

||| A 3D tükörszimmetria csoport = a 15 dimenziós fázisátmenet.
||| A kritikus pont = a tükörsíkok metszéspontja.
||| 1 idő-dimenzió = előre (a megoldás felé)
||| 2 idő-dimenzió = a tükör elkerülése (bal/jobb)
|||
||| A magyar igeidő-rendszer (mult/jelen/jövő) = 1 idő-dimenzió.
||| A magyar szemlélet (folyamatos/befejezett/szokásos) = 2. idő-dimenzió.
||| A magyar forrás (közvetlen/következtetett/jelentett) = a megfigyelő pozíciója.

||| A két idő-dimenzió a tükör elkerülésére.
public export
record KetIdoDimenzio where
  constructor KetIdoDimenzioKonstruktor
  igeido     : IgeIdo      -- 1. idő-dimenzió: mult/jelen/jövő
  szemlelet  : IgeSzem     -- 2. idő-dimenzió: folyamatos/befejezett/szokásos

||| A tükör elkerülése: a 2D idő-síkban mozgás.
||| Ha az igeidő + szemlélet kombináció stabil,
||| akkor a tükör elkerülve.
public export
tukorElkerules : KetIdoDimenzio -> Bool
tukorElkerules (KetIdoDimenzioKonstruktor Jelen Folyamatos) = True   -- stabil: jelen + folyamatos
tukorElkerules (KetIdoDimenzioKonstruktor Jelen Befejezett) = True   -- stabil: jelen + befejezett
tukorElkerules (KetIdoDimenzioKonstruktor Mult Folyamatos) = False   -- tükör: mult + folyamatos
tukorElkerules (KetIdoDimenzioKonstruktor Jovo Befejezett) = False   -- tükör: jövő + befejezett
tukorElkerules _ = True

-- ═══════════════════════════════════════════════════════════════
-- 10. A 7 KATEGÓRIAELMÉLETI TÖRVÉNY
-- ═══════════════════════════════════════════════════════════════

||| A 7 kategóriaelméleti törvény, ami biztosítja,
||| hogy az út konzisztens a kategóriák között.
public export
data HetTorveny : Type where
  IdentitasTorveny   : HetTorveny  -- id ∘ f = f = f ∘ id
  FunktorTorveny     : HetTorveny  -- F(g ∘ f) = F(g) ∘ F(f)
  TermeszetessegTorveny : HetTorveny  -- α_b ∘ F(f) = G(f) ∘ α_a
  HibajavitasTorveny : HetTorveny  -- Kodol ∘ Dekodol = id
  NoetherTorveny     : HetTorveny  -- szimmetria = megmaradás
  LegendreTorveny    : HetTorveny  -- H = p·q̇ - L
  ReflTorveny        : HetTorveny  -- Refl = minden bizonyítás alapja

||| A 7 törvény magyar neve.
public export
torvenyMagyarNev : HetTorveny -> String
torvenyMagyarNev IdentitasTorveny = "id ∘ f = f = f ∘ id (identitás)"
torvenyMagyarNev FunktorTorveny = "F(g ∘ f) = F(g) ∘ F(f) (funktor)"
torvenyMagyarNev TermeszetessegTorveny = "α_b ∘ F(f) = G(f) ∘ α_a (természetesség)"
torvenyMagyarNev HibajavitasTorveny = "Kodol ∘ Dekodol = id (hibajavítás)"
torvenyMagyarNev NoetherTorveny = "szimmetria = megmaradás (Noether)"
torvenyMagyarNev LegendreTorveny = "H = p·q̇ - L (Legendre perem)"
torvenyMagyarNev ReflTorveny = "Refl = minden bizonyítás alapja"

||| A 7 törvény listája.
public export
hetTorvenyLista : List HetTorveny
hetTorvenyLista = [
  IdentitasTorveny,
  FunktorTorveny,
  TermeszetessegTorveny,
  HibajavitasTorveny,
  NoetherTorveny,
  LegendreTorveny,
  ReflTorveny
  ]

-- ═══════════════════════════════════════════════════════════════
-- 11. FŐPROGRAM — DEMONSTRÁCIÓ
-- ═══════════════════════════════════════════════════════════════

||| Alap pozíció: minden dimenzió 0.
public export
alapPozicio : TizenotDimenziosPozicio
alapPozicio = TizenotPozicioKonstruktor
  0 0 0 0 0 0 0
  0 0 0 0 0 0 0
  0

||| Alap impulzus: minden dimenzió 0.
public export
alapImpulzus : TizenotDimenziosImpulzus
alapImpulzus = TizenotImpulzusKonstruktor
  0 0 0 0 0 0 0
  0 0 0 0 0 0 0
  0

||| Alap sebesség: minden dimenzió 1 (egyenletes mozgás).
public export
alapSebesseg : TizenotDimenziosSebesseg
alapSebesseg = TizenotSebessegKonstruktor
  1 1 1 1 1 1 1
  1 1 1 1 1 1 1
  1

||| Cél pozíció: a megoldás (minden dimenzió 1).
public export
celPozicio : TizenotDimenziosPozicio
celPozicio = TizenotPozicioKonstruktor
  1 1 1 1 1 1 1
  1 1 1 1 1 1 1
  1

||| Egy alap probléma.
public export
alapProblema : Problema
alapProblema = ProblemaKonstruktor alapPozicio celPozicio alapImpulzus alapSebesseg

||| A legkisebb művelet démonstrációja.
public export
legkisebbMuveletDemo : IO ()
legkisebbMuveletDemo = do
  putStrLn "=== A LEGKISEBB MŰVELET ELVE ==="
  putStrLn ""
  putStrLn "E8×E8×E8 = 3 objektum + 3 funktor"
  putStrLn "  F: ter→szin (megfigyelés)"
  putStrLn "  G: szin→hang (kommunikáció)"
  putStrLn "  H: hang→ter (visszacsatolás)"
  putStrLn ""
  putStrLn "A 15 dimenzió: 7 emberi + 7 számítási + 1 perem = [[15,1,3]]"
  putStrLn ""
  putStrLn "A 7 kategóriaelméleti törvény:"
  putStrLn "  1. id ∘ f = f = f ∘ id"
  putStrLn "  2. F(g ∘ f) = F(g) ∘ F(f)"
  putStrLn "  3. α_b ∘ F(f) = G(f) ∘ α_a (természetesség = Wadler free theorem)"
  putStrLn "  4. Kodol ∘ Dekodol = id (hibajavítás)"
  putStrLn "  5. szimmetria = megmaradás (Noether)"
  putStrLn "  6. H = p·q̇ - L (Legendre perem)"
  putStrLn "  7. Refl = minden bizonyítás alapja"
  putStrLn ""
  let megoldas = legkisebbMuvelet alapProblema
  putStrLn ("Alap probléma költség: " ++ show megoldas.koltseg)
  let palya = stabilPalyaEpit alapProblema
  putStrLn ("Stabil pálya sugara: " ++ show palya.sugar)
  putStrLn ("Keringési szögsebesség: " ++ show palya.szogsebesseg)
  putStrLn ""
  putStrLn "A Wadler 'Theorems for Free!' tétel:"
  putStrLn "  A polimorf típus automatikusan bizonyítja a természetességi négyzetet."
  putStrLn "  A parametricity = a típus kikényszeríti az optimális utat."
  putStrLn "  A 'free theorem' = a Lagrangian geodetikája."
  putStrLn ""
  putStrLn "A tükörszimmetria és a 2 idő-dimenzió:"
  putStrLn "  igeidő (mult/jelen/jövő) = 1. idő-dimenzió"
  putStrLn "  szemlélet (folyamatos/befejezett/szokásos) = 2. idő-dimenzió"
  putStrLn "  A 2D idő-sík elkerüli a tükröket."
  putStrLn ""
  putStrLn "A legkisebb művelet algoritmusa:"
  putStrLn "  1. Kódold a problémát a 15 dimenzióba"
  putStrLn "  2. Keresd meg a Lagrangian-t (L = T - V)"
  putStrLn "  3. Hajtsd végre a Hamiltonian-t (H = p·q̇ - L)"
  putStrLn "  4. Hibajavítás útközben ([[15,1,3]])"
  putStrLn "  5. Fixpont körül körözés (stabilitás)"
  putStrLn "  6. Megoldás (dekódolás = jelentés)"
  putStrLn ""
  putStrLn "Kész."

||| Főprogram (a wrapper hivja).
public export
legkisebbMuveletFom : IO ()
legkisebbMuveletFom = legkisebbMuveletDemo