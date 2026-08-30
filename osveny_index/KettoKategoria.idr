module KettoKategoria

-- ═══════════════════════════════════════════════════════════════
-- 2-KATEGÓRIA — SEJTEK, E8/E9, CPT FÁZISOK
-- ═══════════════════════════════════════════════════════════════
-- A 2-kategória struktúrája:
--   0-cellák: objektumok (E8 pontok, sejtek, kategóriák)
--   1-cellák: morfizmusok (Clifford szorzatok, esetragok, funktorok)
--   2-cellák: morfizmusok morfizmusai (CPT fázisok, Markov blanket-ek)
--
-- A projektben:
--   0-cellák: E8 pontok = sejtek
--   1-cellák: esetragok (18 eset), Clifford szorzatok
--   2-cellák: CPT fázisok (T/P/C), Markov blanket (K(E9) involúció)
--
-- Forrás: Mac Lane (1971), "Categories for the Working Mathematician"
--         Baez-Lauda (2010), arXiv:math/0102020
-- ═══════════════════════════════════════════════════════════════

import Steane713
import E8E8Algebra

-- ─── 1. A 2-KATEGÓRIA DEFINÍCIÓJA ──────────────────────────

||| A 2-kategória: 0-cellák + 1-cellák + 2-cellák.
|||
||| 0-cellák: E8 pontok (sejtek, objektumok)
||| 1-cellák: esetragok (morfizmusok a sejtek között)
||| 2-cellák: CPT fázisok (morfizmusok a morfizmusok között)
public export
record KettoKategoriaT where
  constructor KettoKategoriaKonstruktor
  sejt            : Type
  morfizmus       : sejt -> sejt -> Type
  kettoCella      : {a, b : sejt} -> morfizmus a b -> morfizmus a b -> Type
  identitas1      : (a : sejt) -> morfizmus a a
  kompozicio1     : {a, b, c : sejt} -> morfizmus a b -> morfizmus b c -> morfizmus a c
  identitas2      : {a, b : sejt} -> (f : morfizmus a b) -> kettoCella f f
  kompozicio2     : {a, b : sejt} -> {f, g, h : morfizmus a b} ->
                    kettoCella f g -> kettoCella g h -> kettoCella f h

-- ─── 2. A SEJT — 0-CELLA ───────────────────────────────────

||| A sejt = az E8 pont = az objektum a 2-kategóriában.
||| A sejt = a membra = a Markov blanket hordozója.
public export
record Sejt where
  constructor SejtKonstruktor
  sejtE8Pont  : E8Pont          -- a sejt E8 koordinátája
  sejtCimke  : String           -- a sejt címkéje (veszteségmentes)

||| Az üres sejt (nulla E8 pont).
public export
uresSejt : Sejt
uresSejt = SejtKonstruktor e8Nulla "üres"

||| A kategoriációlméleti sejt (E8 = egy objektum).
public export
kategoriaSejt : Sejt
kategoriaSejt = SejtKonstruktor e8Egy "kategória"

-- ─── 3. AZ ESETRAG — 1-CELLA ───────────────────────────────

||| Az esetrag = a morfizmus a sejtek között.
||| Az esetrag = a kapcsolat a két sejt között.
public export
data EsetragMorfizmus : Sejt -> Sejt -> Type where
  -- Nominativus: identitás (a sejt önmaga)
  NominativusMorf : EsetragMorfizmus a a
  -- Accusativus: tárgy (a → b, a tárgya b-nek)
  AccusativusMorf : EsetragMorfizmus a b
  -- Dativus: cél (a → b, a célja b-nek)
  DativusMorf : EsetragMorfizmus a b
  -- Inessivus: hely (a-ban b)
  InessivusMorf : EsetragMorfizmus a b
  -- Illativus: irány (a → b belső)
  IllativusMorf : EsetragMorfizmus a b
  -- Elativus: irány (a ← b belső)
  ElativusMorf : EsetragMorfizmus a b
  -- Instrumentalis: eszköz (a-val b)
  InstrumentalisMorf : EsetragMorfizmus a b
  -- Causalis-finalis: ok (a-ért b)
  CausalisMorf : EsetragMorfizmus a b
  -- Transzlativus: eredmény (a-vá b)
  TranszlativusMorf : EsetragMorfizmus a b
  -- Terminativus: meddig (a-ig b)
  TerminativusMorf : EsetragMorfizmus a b
  -- Formativus: mód (a-képp b)
  FormativusMorf : EsetragMorfizmus a b
  -- Essivus-formalisi: mint (a-ként b)
  EssivusMorf : EsetragMorfizmus a b

-- ─── 4. A CPT FÁZIS — 2-CELLA ─────────────────────────────

||| A CPT fázis = a 2-cella = a morfizmus morfizmusa.
||| A CPT = a töltés-paritás-idő szimmetria.
public export
data CptFazis : {a, b : Sejt} -> EsetragMorfizmus a b -> EsetragMorfizmus a b -> Type where
  -- C = töltés (charge): a fázis előjele (+/-)
  ToltesFazis : CptFazis f f        -- az identitás (nincs fázis)
  -- P = paritás (parity): a fázis tükrözése
  ParitasFazis : CptFazis f g       -- a fázis tükrözi f-t g-be
  -- T = idő (time): a fázis forgatása
  IdoFazis : CptFazis f g           -- a fázis forgatja f-t g-be
  -- CPT = a teljes szimmetria (mindhárom egyszerre)
  CptTeljes : CptFazis f g          -- a teljes CPT transzformáció

-- ─── 5. A K(E9) INVOLÚCIÓ MINT 2-CELLA ────────────────────

||| A K(E9) involúció = a Markov blanket = a 2-cella.
||| Az involúció: ω² = id.
public export
data Involucio : {a, b : Sejt} -> EsetragMorfizmus a b -> EsetragMorfizmus a b -> Type where
  -- Az involúció identitása (ω = id)
  InvolucioId : Involucio f f
  -- Az involúció (ω(f) = g)
  InvolucioKep : Involucio f g

||| Az involúció négyzete = identitás.
||| ω²(f) = f    — ez a Markov blanket zárt volta.
public export
involucioNegyzet : Involucio f g -> Involucio g f -> Involucio f f
involucioNegyzet _ _ = InvolucioId

-- ─── 6. A MARKOV BLANKET ───────────────────────────────────

||| A Markov blanket = a határ a sejtek között.
||| A Markov blanket = a K(E9) involúció.
||| A blanket elválasztja a belső állapotokat (μ) a külsőktől (η).
public export
record MarkovBlanket where
  constructor MarkovBlanketKonstruktor
  belsoSejt      : Sejt            -- a belső sejt (μ = posterior)
  kulsoSejt      : Sejt            -- a külső sejt (η = rejtett)
  sensoryAllapot : E8Pont          -- a szenzoros állapot (s)
  aktivAllapot   : E8Pont          -- az aktív állapot (a)

-- ─── 7. A 2-KATEGÓRIA INSTANCE ────────────────────────────

||| A sejtek 2-kategóriája.
||| 0-cellák: Sejt
||| 1-cellák: EsetragMorfizmus
||| 2-cellák: CptFazis
public export
sejtekKettoKategoriaja : KettoKategoriaT
sejtekKettoKategoriaja = KettoKategoriaKonstruktor
  Sejt
  EsetragMorfizmus
  CptFazis
  (\a => NominativusMorf)
  (\f, g => AccusativusMorf)
  (\f => ToltesFazis)
  (\a, b => CptTeljes)

-- ─── 8. FŐPROGRAM ─────────────────────────────────────────

showE8P : E8Pont -> String
showE8P p =
  showK p.x1 ++ showK p.x2 ++ showK p.x3 ++ showK p.x4 ++
  showK p.x5 ++ showK p.x6 ++ showK p.x7 ++ showK p.x8
  where
    showK : Kubit -> String
    showK Nulla = "0"
    showK Egy = "1"

public export
kettoKategoriaFom : IO ()
kettoKategoriaFom = do
  putStrLn "=== 2-KATEGORIA — SEJTEK, E8/E9, CPT FAZISOK ==="
  putStrLn ""
  putStrLn "0-cellak (sejtek):"
  putStrLn ("  ures sejt: E8 = " ++ showE8P (sejtE8Pont uresSejt))
  putStrLn ("  kategoria sejt: E8 = " ++ showE8P (sejtE8Pont kategoriaSejt))
  putStrLn ""
  putStrLn "1-cellak (esetragok = morfizmusok):"
  putStrLn "  Nominativus = identitas (a -> a)"
  putStrLn "  Accusativus = targy (a -> b)"
  putStrLn "  Dativus = cel (a -> b)"
  putStrLn "  Inessivus = hely (a-ban b)"
  putStrLn "  Instrumentalis = eszkoz (a-val b)"
  putStrLn ""
  putStrLn "2-cellak (CPT fazisok = morfizmusok morfizmusai):"
  putStrLn "  Toltes (C) = identitas (nincs fazis)"
  putStrLn "  Paritas (P) = tukrozes (f -> g)"
  putStrLn "  Ido (T) = forgatas (f -> g)"
  putStrLn "  CPT = teljes szimmetria (f -> g)"
  putStrLn ""
  putStrLn "K(E9) involucio (Markov blanket):"
  putStrLn "  involucio: w(f) = g"
  putStrLn "  involucio^2 = id (Markov blanket zarva)"
  putStrLn ""
  putStrLn "Markov blanket:"
  putStrLn "  belso sejt (m) = posterior"
  putStrLn "  kulso sejt (h) = rejtett valtozo"
  putStrLn "  sensory (s) = a szenzoros allapot"
  putStrLn "  aktiv (a) = az aktiv allapot"
  putStrLn "  blanket = az involucio (Accusativus -> Dativus)"
  putStrLn ""
  putStrLn "Kesz."