module ToruszTeszt

-- ═══════════════════════════════════════════════════════════════════════
-- TÓRUSZ TESZT — a bináris tórusz (Z₂ × Z₈) tesztelése
-- ═══════════════════════════════════════════════════════════════════════
-- A felhasználó (2026-08-31): „ezeket ellenorizzuk valahogy ? pl. tesztekkel ?"
-- A felhasználó (2026-08-31): „futas ideju tesztek is kellenek mindenre,
-- peldakkal"
--
-- A tesztelés két szintje:
--   1. szint: FORDÍTÁSI BIZONYÍTÁS (Refl) — a típus-ellenőrző
--      kiméri a törvényeket (a Refl = a fordító bizonyítja).
--   2. szint: TISZTA SHOW-ÉRTÉKEK — a main kiírja az értékeket.
--      A logika tiszta, a main csak show-t hív.
--
-- §24: a Torusz.idr függvényeit IMPORTÁLJUK, nem duplikáljuk.
-- ═══════════════════════════════════════════════════════════════════════

import Torusz
import Fazis

%default total

-- ═══════════════════════════════════════════════════════════════════════
-- 1. TÓRUSZ PONTOK — konkrét példák (show-val)
-- ═══════════════════════════════════════════════════════════════════════
-- A 16 tórusz-pont (Z₂ × Z₈). Konkrét értékekkel, show-val kiírva.

-- KONKRÉT PÉLDA: az állítás pontja = (0, F0).
peldaÁllítás : ToruszPont
peldaÁllítás = MkToruszPont Pozíció0 F0

-- KONKRÉT PÉLDA: a kérdés pontja = (0, F2).
peldaKérdés : ToruszPont
peldaKérdés = MkToruszPont Pozíció0 F2

-- KONKRÉT PÉLDA: a feltevés pontja = (0, F4).
peldaFeltevés : ToruszPont
peldaFeltevés = MkToruszPont Pozíció0 F4

-- KONKRÉT PÉLDA: a következtetés pontja = (0, F6).
peldaKövetkeztetés : ToruszPont
peldaKövetkeztetés = MkToruszPont Pozíció0 F6

-- REFL: a mondatTóruszPont (importálva) kimenete = a konkrét pont.
bizPeldaÁllítás : mondatTóruszPont Állítás = MkToruszPont Pozíció0 F0
bizPeldaÁllítás = Refl

bizPeldaKérdés : mondatTóruszPont Kérdés = MkToruszPont Pozíció0 F2
bizPeldaKérdés = Refl

bizPeldaFeltevés : mondatTóruszPont Feltevés = MkToruszPont Pozíció0 F4
bizPeldaFeltevés = Refl

bizPeldaKövetkeztetés : mondatTóruszPont Következtetés = MkToruszPont Pozíció0 F6
bizPeldaKövetkeztetés = Refl

-- ═══════════════════════════════════════════════════════════════════════
-- 2. POZÍCIÓ-LÉPÉS — konkrét példák (importált függvény)
-- ═══════════════════════════════════════════════════════════════════════
-- A pozícióLépés (importálva a Torusz-ból) bit-flip: 0→1, 1→0.

-- KONKRÉT PÉLDA: (0, F0) → (1, F0) — az állítás pozíció-lépése.
peldaPozícióLépés0 : pozícióLépés (MkToruszPont Pozíció0 F0) = MkToruszPont Pozíció1 F0
peldaPozícióLépés0 = Refl

-- KONKRÉT PÉLDA: (1, F0) → (0, F0) — a megerősítés pozíció-lépése.
peldaPozícióLépés1 : pozícióLépés (MkToruszPont Pozíció1 F0) = MkToruszPont Pozíció0 F0
peldaPozícióLépés1 = Refl

-- KONKRÉT PÉLDA: (0, F2) → (1, F2) — a kérdés pozíció-lépése.
peldaPozícióLépés2 : pozícióLépés (MkToruszPont Pozíció0 F2) = MkToruszPont Pozíció1 F2
peldaPozícióLépés2 = Refl

-- REFL: a pozíció-lépés involúció (importálva) — (0, F0) kétszer = (0, F0).
bizPozícióLépésInvolúcióTeszt : pozícióLépés (pozícióLépés (MkToruszPont Pozíció0 F0)) = MkToruszPont Pozíció0 F0
bizPozícióLépésInvolúcióTeszt = Refl

-- ═══════════════════════════════════════════════════════════════════════
-- 3. FÁZIS-LÉPÉS — konkrét példák (importált függvény)
-- ═══════════════════════════════════════════════════════════════════════
-- A fázisLépés (importálva) Z₈ forgatás: F0→F1→...→F7→F0.

-- KONKRÉT PÉLDA: (0, F0) → (0, F1) — az állítás fázis-lépése.
peldaFázisLépés1 : fázisLépés (MkToruszPont Pozíció0 F0) = MkToruszPont Pozíció0 F1
peldaFázisLépés1 = Refl

-- KONKRÉT PÉLDA: (0, F1) → (0, F2) — a megfigyelés fázis-lépése.
peldaFázisLépés2 : fázisLépés (MkToruszPont Pozíció0 F1) = MkToruszPont Pozíció0 F2
peldaFázisLépés2 = Refl

-- KONKRÉT PÉLDA: (0, F7) → (0, F0) — az ok fázis-lépése (a 8. lépés).
peldaFázisLépés8 : fázisLépés (MkToruszPont Pozíció0 F7) = MkToruszPont Pozíció0 F0
peldaFázisLépés8 = Refl

-- ═══════════════════════════════════════════════════════════════════════
-- 4. GKP-KÓD — konkrét példák (importált függvény)
-- ═══════════════════════════════════════════════════════════════════════
-- A gkpTóruszPont (importálva) átalakítja a GKP-fázistért tórusz-ponttá.

-- KONKRÉT PÉLDA: GKP (0, F0) → tórusz-pont (0, F0).
peldaGKP0 : gkpTóruszPont (MkGKPFázistér Pozíció0 F0) = MkToruszPont Pozíció0 F0
peldaGKP0 = Refl

-- KONKRÉT PÉLDA: GKP (1, F6) → tórusz-pont (1, F6).
peldaGKP1 : gkpTóruszPont (MkGKPFázistér Pozíció1 F6) = MkToruszPont Pozíció1 F6
peldaGKP1 = Refl

-- ═══════════════════════════════════════════════════════════════════════
-- 5. MONDATTÍPUS → FÁZIS — konkrét példák (importált függvény)
-- ═══════════════════════════════════════════════════════════════════════
-- A mondatFázis (importálva) megadja a mondattípus fázisát.

-- KONKRÉT PÉLDA: Állítás → F0 (0°).
peldaÁllításFázis : mondatFázis Állítás = F0
peldaÁllításFázis = Refl

-- KONKRÉT PÉLDA: Kérdés → F2 (90° = i).
peldaKérdésFázis : mondatFázis Kérdés = F2
peldaKérdésFázis = Refl

-- KONKRÉT PÉLDA: Feltevés → F4 (180° = -1).
peldaFeltevésFázis : mondatFázis Feltevés = F4
peldaFeltevésFázis = Refl

-- KONKRÉT PÉLDA: Következtetés → F6 (270° = -i).
peldaKövetkeztetésFázis : mondatFázis Következtetés = F6
peldaKövetkeztetésFázis = Refl

-- ═══════════════════════════════════════════════════════════════════════
-- 6. POZÍCIÓ VÁLTÁS — konkrét példák (importált függvény)
-- ═══════════════════════════════════════════════════════════════════════
-- A pozícióVáltás (importálva) bit-flip: 0→1, 1→0.

-- KONKRÉT PÉLDA: Pozíció0 → Pozíció1.
peldaPozícióVáltás0 : pozícióVáltás Pozíció0 = Pozíció1
peldaPozícióVáltás0 = Refl

-- KONKRÉT PÉLDA: Pozíció1 → Pozíció0.
peldaPozícióVáltás1 : pozícióVáltás Pozíció1 = Pozíció0
peldaPozícióVáltás1 = Refl

-- REFL: a pozícióVáltás involúció (X² = I).
bizPozícióVáltásInvolúció0 : pozícióVáltás (pozícióVáltás Pozíció0) = Pozíció0
bizPozícióVáltásInvolúció0 = Refl

bizPozícióVáltásInvolúció1 : pozícióVáltás (pozícióVáltás Pozíció1) = Pozíció1
bizPozícióVáltásInvolúció1 = Refl

-- ═══════════════════════════════════════════════════════════════════════
-- 7. FŐPROGRAM — A TESZT KIÍRÁSA
-- ═══════════════════════════════════════════════════════════════════════

main : IO ()
main = do
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " TÓRUSZ TESZT — a bináris tórusz (Z₂ × Z₈) tesztelése"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "A felhasználó (2026-08-31):"
  putStrLn "  'ezeket ellenorizzuk valahogy ? pl. tesztekkel ?'"
  putStrLn "  'futas ideju tesztek is kellenek mindenre, peldakkal'"
  putStrLn ""
  putStrLn "§24: a Torusz.idr függvényeit IMPORTÁLJUK, nem duplikáljuk."
  putStrLn ""

  -- ── 1. Tórusz pontok ─────────────────────────────
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " 1. TÓRUSZ PONTOK (16 = Z₂ × Z₈)"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "  Konkrét példák (show-val kiírva):"
  putStrLn ("    peldaÁllítás       = " ++ show peldaÁllítás ++ "  (0, 0°)")
  putStrLn ("    peldaKérdés        = " ++ show peldaKérdés ++ "  (0, 90°)")
  putStrLn ("    peldaFeltevés      = " ++ show peldaFeltevés ++ "  (0, 180°)")
  putStrLn ("    peldaKövetkeztetés = " ++ show peldaKövetkeztetés ++ "  (0, 270°)")
  putStrLn ""
  putStrLn "  REFL: mondatTóruszPont Állítás = peldaÁllítás       ✓ (bizPeldaÁllítás)"
  putStrLn "  REFL: mondatTóruszPont Kérdés  = peldaKérdés        ✓ (bizPeldaKérdés)"
  putStrLn "  REFL: mondatTóruszPont Feltevés = peldaFeltevés      ✓ (bizPeldaFeltevés)"
  putStrLn "  REFL: mondatTóruszPont Következtetés = peldaKövetkeztetés  ✓ (bizPeldaKövetkeztetés)"
  putStrLn ("  Tórusz pontjainak száma = " ++ show toruszPontokSzáma)
  putStrLn ""

  -- ── 2. Pozíció-lépés ─────────────────────────────
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " 2. POZÍCIÓ-LÉPÉS (bit-flip: 0→1→0)"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "  Konkrét példák (importált függvény: pozícióLépés):"
  putStrLn ("    pozícióLépés (0, F0) = " ++ show (pozícióLépés (MkToruszPont Pozíció0 F0)) ++ "  (1, F0)")
  putStrLn ("    pozícióLépés (1, F0) = " ++ show (pozícióLépés (MkToruszPont Pozíció1 F0)) ++ "  (0, F0)")
  putStrLn ("    pozícióLépés (0, F2) = " ++ show (pozícióLépés (MkToruszPont Pozíció0 F2)) ++ "  (1, F2)")
  putStrLn ""
  putStrLn "  REFL: pozícióLépés (0, F0) = (1, F0)  ✓ (peldaPozícióLépés0)"
  putStrLn "  REFL: pozícióLépés (1, F0) = (0, F0)  ✓ (peldaPozícióLépés1)"
  putStrLn "  REFL: pozícióLépés (0, F2) = (1, F2)  ✓ (peldaPozícióLépés2)"
  putStrLn "  REFL: pozícióLépés² (0, F0) = (0, F0) ✓ (bizPozícióLépésInvolúcióTeszt)"
  putStrLn ""

  -- ── 3. Fázis-lépés ─────────────────────────────
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " 3. FÁZIS-LÉPÉS (Z₈ forgatás: F0→F1→...→F7→F0)"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "  Konkrét példák (importált függvény: fázisLépés):"
  putStrLn ("    fázisLépés (0, F0) = " ++ show (fázisLépés (MkToruszPont Pozíció0 F0)) ++ "  (0, F1)")
  putStrLn ("    fázisLépés (0, F1) = " ++ show (fázisLépés (MkToruszPont Pozíció0 F1)) ++ "  (0, F2)")
  putStrLn ("    fázisLépés (0, F7) = " ++ show (fázisLépés (MkToruszPont Pozíció0 F7)) ++ "  (0, F0)")
  putStrLn ""
  putStrLn "  REFL: fázisLépés (0, F0) = (0, F1)  ✓ (peldaFázisLépés1)"
  putStrLn "  REFL: fázisLépés (0, F1) = (0, F2)  ✓ (peldaFázisLépés2)"
  putStrLn "  REFL: fázisLépés (0, F7) = (0, F0)  ✓ (peldaFázisLépés8)"
  putStrLn "  REFL: 8 lépés (F0→...→F7→F0)       ✓ (bizFázisLépés1..8 a Torusz.idr-ben)"
  putStrLn ""

  -- ── 4. GKP-kód ─────────────────────────────
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " 4. GKP-KÓD FÁZISTÉR"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "  Konkrét példák (importált függvény: gkpTóruszPont):"
  putStrLn ("    gkpTóruszPont (0, F0) = " ++ show (gkpTóruszPont (MkGKPFázistér Pozíció0 F0)) ++ "  (0, F0)")
  putStrLn ("    gkpTóruszPont (1, F6) = " ++ show (gkpTóruszPont (MkGKPFázistér Pozíció1 F6)) ++ "  (1, F6)")
  putStrLn ""
  putStrLn "  REFL: gkpTóruszPont (0, F0) = (0, F0)  ✓ (peldaGKP0)"
  putStrLn "  REFL: gkpTóruszPont (1, F6) = (1, F6)  ✓ (peldaGKP1)"
  putStrLn ""

  -- ── 5. Mondattípus ─────────────────────────────
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " 5. MONDATTÍPUS → FÁZIS"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "  Konkrét példák (importált függvény: mondatFázis):"
  putStrLn ("    mondatFázis Állítás       = " ++ show (mondatFázis Állítás) ++ "  (0°, valós)")
  putStrLn ("    mondatFázis Kérdés        = " ++ show (mondatFázis Kérdés) ++ "  (90°, i)")
  putStrLn ("    mondatFázis Feltevés      = " ++ show (mondatFázis Feltevés) ++ "  (180°, -1)")
  putStrLn ("    mondatFázis Következtetés = " ++ show (mondatFázis Következtetés) ++ "  (270°, -i)")
  putStrLn ""
  putStrLn "  REFL: mondatFázis Állítás = F0       ✓ (peldaÁllításFázis)"
  putStrLn "  REFL: mondatFázis Kérdés = F2        ✓ (peldaKérdésFázis)"
  putStrLn "  REFL: mondatFázis Feltevés = F4      ✓ (peldaFeltevésFázis)"
  putStrLn "  REFL: mondatFázis Következtetés = F6 ✓ (peldaKövetkeztetésFázis)"
  putStrLn ""

  -- ── 6. Pozíció váltás ─────────────────────────────
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " 6. POZÍCIÓ VÁLTÁS (bit-flip: 0→1→0)"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "  Konkrét példák (importált függvény: pozícióVáltás):"
  putStrLn ("    pozícióVáltás Pozíció0 = " ++ show (pozícióVáltás Pozíció0) ++ "  (1)")
  putStrLn ("    pozícióVáltás Pozíció1 = " ++ show (pozícióVáltás Pozíció1) ++ "  (0)")
  putStrLn ""
  putStrLn "  REFL: pozícióVáltás 0 = 1           ✓ (peldaPozícióVáltás0)"
  putStrLn "  REFL: pozícióVáltás 1 = 0           ✓ (peldaPozícióVáltás1)"
  putStrLn "  REFL: pozícióVáltás² 0 = 0 (X²=I)   ✓ (bizPozícióVáltásInvolúció0)"
  putStrLn "  REFL: pozícióVáltás² 1 = 1 (X²=I)   ✓ (bizPozícióVáltásInvolúció1)"
  putStrLn ""

  -- ── Összegzés ─────────────────────────────
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " TESZT ÖSSZEGZÉS"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "  1. Tórusz pontok:        4 konkrét példa + 4 Refl  ✓"
  putStrLn "  2. Pozíció-lépés:        3 konkrét példa + 4 Refl  ✓"
  putStrLn "  3. Fázis-lépés:          3 konkrét példa + 3 Refl  ✓"
  putStrLn "  4. GKP-kód:              2 konkrét példa + 2 Refl  ✓"
  putStrLn "  5. Mondattípus → fázis:  4 konkrét példa + 4 Refl  ✓"
  putStrLn "  6. Pozíció váltás:       2 konkrét példa + 4 Refl  ✓"
  putStrLn ""
  putStrLn "  Összesen: 18 konkrét példa + 21 Refl bizonyítás"
  putStrLn "  Minden teszt lefordul — a compiler (a bíra) ellenőrzi."
  putStrLn ""
  putStrLn "  §24: a Torusz.idr függvényeit IMPORTÁLJUK, nem duplikáljuk. ✓"
  putStrLn "  A Fazis.idr (Z₈) importálva a Torusz.idr-ben. ✓"
  putStrLn ""
  putStrLn "  ★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★"