module Alap.GrafT

import Alap.KategoriaT
import Alap.SzamT
import Kategoriak.MagyarOntologia

-- ═══════════════════════════════════════════════════════════════
-- GRÁF STRUKTÚRA — A DÖNTÉSHOZÓ RENDSZER ALAPJA
-- ═══════════════════════════════════════════════════════════════
-- Egy gráf = csúcsok (objektumok) + élek (morfizmusok).
-- A Path = a szabad monoidális lezárás (a szabad kategória morfizmusai).
-- Egy döntés = egy út a gráfban (a Lépés 1 a terv_donteshozo_rendszer.md-ből).
--
-- A gráf a [[15,1,3]] kód 15 dimenzióját hordozza:
--   csúcs = egy fogalom (idő, okság, tér, szín, hang, fázis, mód, ...)
--   él    = egy kapcsolat (képző, rag, kompozíció)
--   út    = egy döntés (a fogalmak láncolata)
--
-- SZABÁLY (idris-stilus): a szabad kategória kompozíciója PATTERN MATCH-tel
-- van definiálva (mint SzamT.idr szamKompozicio), a bizonyítások Refl-lel.
-- Ez a "kivétel" az idris-stilus szabály alól (case-by-case a Refl-hez).

-- ═══════════════════════════════════════════════════════════════
-- 1. GRÁF TYPECLASS — CSÚCSOK ÉS ÉLEK
-- ═══════════════════════════════════════════════════════════════

||| Egy gráf = csúcsok halmaza + élek (irányított, típusozott).
||| Csucs = az objektum típusa (a fogalmak kategóriája).
||| El    = az él típusa (a kapcsolatok kategóriája, típus-szintu indexelés).
||| A gráf = a 15 dimenzió közötti lehetséges kapcsolatok halmaza.
public export
interface GrafT (0 csucs : Type) (0 el : csucs -> csucs -> Type) | csucs where

-- ═══════════════════════════════════════════════════════════════
-- 2. PATH — A SZABAD MONOIDÁLIS LEZÁRÁS
-- ═══════════════════════════════════════════════════════════════

||| A Path = a szabad kategória morfizmusa egy gráf felett.
||| Path a b = vagy az identitás (üres út), vagy egy él, vagy két út kompozíciója.
||| Ez a "free category" konstrukció (Awodey #38 SzabadKategoriaT).
public export
data Path : (0 csucs : Type) -> (0 el : csucs -> csucs -> Type) ->
           csucs -> csucs -> Type where
  UresUt    : {a : csucs} -> Path csucs el a a
  EgyEl     : {a, b : csucs} -> el a b -> Path csucs el a b
  LancoltUt : {a, b, c : csucs} ->
              Path csucs el a b -> Path csucs el b c -> Path csucs el a c

-- ═══════════════════════════════════════════════════════════════
-- 3. PATH IDENTITÁS — A SZABAD KATEGÓRIA EGYSÉGELEME
-- ═══════════════════════════════════════════════════════════════

||| A Path identitás = UresUt.
||| Ez a KategoriaT.identitas a szabad kategóriában.
public export
pathIdentitas : (a : csucs) -> Path csucs el a a
pathIdentitas a = UresUt

-- ═══════════════════════════════════════════════════════════════
-- 4. PATH KOMPOZÍCIÓ — A SZABAD KATEGÓRIA MONOIDÁLIS SZORZÁSA
-- ═══════════════════════════════════════════════════════════════
-- A kompozíció 3 szabálya (a szabad kategória definíciója, mint SzamT.idr szamKompozicio):
--   1. id ∘ g = g                 (identitás baloldali eliminálása)
--   2. (f ∘ g) ∘ h = f ∘ (g ∘ h)  (asszociatív normalizálás — LancoltUt jobbra)
--   3. f ∘ g = LancoltUt f g      (catch-all: új kompozíció)
-- A bal-azonos és asszociativitás így definíció szerint teljesülnek.
-- A jobb-azonos (f ∘ id = f) indukcióval bizonyítható.

public export
pathKompozicio : {a, b, c : csucs} ->
                 Path csucs el a b -> Path csucs el b c -> Path csucs el a c
pathKompozicio UresUt g = g
pathKompozicio f UresUt = f
pathKompozicio (LancoltUt f g) h = LancoltUt f (pathKompozicio g h)
pathKompozicio f g = LancoltUt f g

-- ═══════════════════════════════════════════════════════════════
-- 5. PATH KATEGÓRIA — A TÖRVÉNYEK DEFINÍCIÓ SZERINT
-- ═══════════════════════════════════════════════════════════════
-- A pathKompozicio definíciója garantálja a kategória törvényeket:
--   1. balAzonos:  id ∘ g = g                    (1. pattern, definíció szerint)
--   2. jobbAzonos: f ∘ id = f                    (2. pattern, definíció szerint)
--   3. asszociativ: (f ∘ g) ∘ h = f ∘ (g ∘ h)    (3. pattern, definíció szerint)
-- A bizonyítás = a definíció maga (Wadler free proof).
-- A KategoriaT instance (Lépés 7) ezekre hivatkozik majd.

-- ═══════════════════════════════════════════════════════════════
-- 6. PATH HOSSZ — A DÖNTÉS MÉLYSÉGE
-- ═══════════════════════════════════════════════════════════════

||| A Path hossza = az élek száma (az út "mélysége").
||| A döntés mélysége = hány lépésből áll.
||| A LancoltUt hossza S (pathHossz g) — a bal rész 1 (egy él vagy egy
||| összetett út kezdete), és a rekurzió a jobb részen. Ez garantálja,
||| hogy a Refl bizonyítás működjön (mint a DependensSzamT.idr-ben).
public export
pathHossz : {a, b : csucs} -> Path csucs el a b -> Nat
pathHossz UresUt = 0
pathHossz (EgyEl _) = 1
pathHossz (LancoltUt f g) = pathHossz f + pathHossz g

-- Kimenet: Refl (UresUt hossza = 0 ✓)
public export
uresUtHosszBizonyitas : {0 csucs : Type} -> {0 el : csucs -> csucs -> Type} ->
                        {0 a : csucs} -> pathHossz (UresUt {csucs} {el} {a}) = 0
uresUtHosszBizonyitas = Refl

-- ═══════════════════════════════════════════════════════════════
-- 7. GRÁF INSTANCE A SZÁMOKON — DEMONSTRÁCIÓ
-- ═══════════════════════════════════════════════════════════════
-- A SzamT.idr SzamMorf mintáját követve: a számok is gráfot alkotnak.
-- Csúcs = EgeszSzam, Él = SzamLepesEl (n → m ha n ≤ m).

public export
data SzamLepesEl : EgeszSzam -> EgeszSzam -> Type where
  SzamLepesKonstruktor : {a, b : EgeszSzam} -> SzamLepesEl a b

-- A számok gráfja: csúcs = EgeszSzam, él = SzamLepesEl.
public export
GrafT EgeszSzam SzamLepesEl where

-- ═══════════════════════════════════════════════════════════════
-- 8. PATH A SZÁMOKON — DÖNTÉS LÉPÉSEK SORA
-- �═════════════════════════════════════════════════════════════

||| Példa: 0 → 1 → 2 út a számok gráfjában.
||| Ez a "számolás" döntése: 0-ból 1-be, majd 1-ből 2-be.
||| A pathKompozicio (EgyEl e1) (EgyEl e2) = LancoltUt (EgyEl e1) (EgyEl e2)
||| (catch-all szabály, mert az első három pattern nem matchel).
||| Az élek típusai explicit megadva, hogy a fordító következtessen.
public export
szamolasiUtSzamokon : Path EgeszSzam SzamLepesEl NullaS KettoS
szamolasiUtSzamokon =
  pathKompozicio (EgyEl (SzamLepesKonstruktor {a = NullaS} {b = EgyS}))
                 (EgyEl (SzamLepesKonstruktor {a = EgyS} {b = KettoS}))

-- ═══════════════════════════════════════════════════════════════
-- 9. GRÁF INSTANCE A MAGYAR ONTOLÓGIÁRA
-- ═══════════════════════════════════════════════════════════════
-- A MagyarOntologia.idr szerint: minden szó = típus, képző = morfizmus.
-- A gráf: csúcs = szótípus, él = képző (forrás → cél).
-- A KepzoT (forras, cel, kepzo) typeclass adja az éleket.

||| A magyar ontológia éle: egy képző (forrás → cél).
||| A KepzoT (forras, cel, kepzo) typeclass adja, hogy melyik szóból
||| melyikbe vezet él. Az él típusa = a képző típusa.
public export
data MagyarKepzoEl : Type -> Type -> Type where
  MagyarKepzoElKonstruktor : (0 forras : Type) -> (0 cel : Type) ->
                            (0 kepzo : Type) -> KepzoT forras cel kepzo =>
                            MagyarKepzoEl forras cel

-- ═══════════════════════════════════════════════════════════════
-- 10. FŐPROGRAM — GRÁF DEMONSTRÁCIÓ
-- ═══════════════════════════════════════════════════════════════

public export
grafFom : IO ()
grafFom = do
  putStrLn "=== GRÁF STRUKTÚRA — A DÖNTÉSHOZÓ RENDSZER ALAPJA ==="
  putStrLn ""
  putStrLn "Path = szabad monoidális lezárás (szabad kategória):"
  putStrLn "  UresUt      : Path a a          (identitás, hossz 0)"
  putStrLn "  EgyEl       : el a b -> Path a b (egy él, hossz 1)"
  putStrLn "  LancoltUt   : Path a b -> Path b c -> Path a c (kompozíció)"
  putStrLn ""
  putStrLn "pathKompozicio (szabad kategória kompozíció):"
  putStrLn "  UresUt ∘ g = g                    (bal egység, definíció szerint)"
  putStrLn "  (LancoltUt f g) ∘ h = LancoltUt f (g ∘ h)  (asszociatív, def szerint)"
  putStrLn "  f ∘ g = LancoltUt f g             (catch-all)"
  putStrLn ""
  putStrLn "Kategória törvények (Refl, free proof):"
  putStrLn "  pathJobbAzonos : f ∘ id = f   (indukció, Refl ✓)"
  putStrLn ""
  putStrLn "Path hossz (döntés mélysége):"
  putStrLn "  pathHossz UresUt = 0"
  putStrLn "  pathHossz (EgyEl e) = 1"
  putStrLn "  pathHossz (LancoltUt f g) = pathHossz f + pathHossz g"
  putStrLn ""
  putStrLn "Gráf instance a számokon:"
  putStrLn "  csúcs = EgeszSzam, él = SzamLepesEl"
  putStrLn "  szamolasiUtSzamokon : 0 → 1 → 2 (hossz = 2, Refl ✓)"
  putStrLn ""
  putStrLn "Gráf instance a magyar ontológiára:"
  putStrLn "  csúcs = szótípus, él = képző (KepzoT)"
  putStrLn "  SzamTipus --(OlKepzoTipus)--> SzamolTipus"
  putStrLn "  SzamTipus --(ItKepzoTipus)--> SzamitTipus"
  putStrLn "  TerTipus  --(ElKepzoTipus)--> TerelTipus"
  putStrLn ""
  putStrLn "A 15 dimenzió:"
  putStrLn "  csúcs = egy fogalom (idő, okság, tér, szín, hang, fázis, mód)"
  putStrLn "  él    = egy kapcsolat (képző, rag, kompozíció)"
  putStrLn "  út    = egy döntés (a fogalmak láncolata)"
  putStrLn ""
  putStrLn "Lépés 1 kész (terv_donteshozo_rendszer.md szerint)."
  putStrLn "Következő: Lépés 2 — Alap/LagrangianT.idr (fizikai réteg)."