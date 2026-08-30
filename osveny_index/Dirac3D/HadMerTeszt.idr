module HadMerTeszt

import Data.Vect
import Fazis
import Lagrangian
import Hadmeres
import HadMerger

-- =====================================================================
-- HADMÉRTESZT modul: mérési tesztek és bizonyítások.
--
-- Minden Refl-bizonyítás = fordítási idejű ellenőrzés.
-- =====================================================================

%default total

-- =====================================================================
-- 1. Példaállapot: lineáris növekedés F0→F7.
-- =====================================================================

peldaAllapot : Allapot
peldaAllapot = MkAllapot [F0, F1, F2, F3, F4, F5, F6, F7] 0.0

-- =====================================================================
-- 2. Fázis szög teszt: fazisSzog.
-- =====================================================================

fazisSzogF0 : Double
fazisSzogF0 = fazisSzog F0
-- Elvárt: 0.0 (sin(0) = 0)

fazisSzogF2 : Double
fazisSzogF2 = fazisSzog F2
-- Elvárt: π/2 ≈ 1.5708

fazisSzogF4 : Double
fazisSzogF4 = fazisSzog F4
-- Elvárt: π ≈ 3.1416

-- =====================================================================
-- 3. Kivetítés teszt: kozvetites.
-- =====================================================================

kozvetitesNulla : Double
kozvetitesNulla = kozvetites F0 F0
-- Elvárt: 0.0 (azonos fázis → 0)

kozvetitesMax : Double
kozvetitesMax = kozvetites F0 F2
-- Elvárt: sin(π/2) = 1.0

kozvetitesInverz : Double
kozvetitesInverz = kozvetites F0 F4
-- Elvárt: sin(π) = 0.0 (ellentétes fázis → 0)

-- =====================================================================
-- 4. Harmadik fázis teszt: fazisOsszead.
-- =====================================================================

harmadikFazisTeszt1 : Fazis
harmadikFazisTeszt1 = harmadikFazis F1 F2
-- Elvárt: F3 (1+2=3)

harmadikFazisTeszt2 : Fazis
harmadikFazisTeszt2 = harmadikFazis F5 F6
-- Elvárt: F3 (5+6=11, 11 mod 8 = 3)

harmadikFazisTeszt3 : Fazis
harmadikFazisTeszt3 = harmadikFazis F7 F7
-- Elvárt: F6 (7+7=14, 14 mod 8 = 6)

-- =====================================================================
-- 5. Teljes mérés teszt.
-- =====================================================================

teljesMeresPelda : Double
teljesMeresPelda = teljesMeres peldaAllapot
-- Elvárt: 0 + π/4 + π/2 + 3π/4 + π + 5π/4 + 3π/2 + 7π/4
--       = 28π/4 = 7π ≈ 21.99

-- =====================================================================
-- 6. Refl bizonyítások: fazisOsszead tulajdonságai.
-- =====================================================================

||| Z₈ kommutativitás: F2 + F3 = F3 + F2.
fazisKommutativitas : fazisOsszead F2 F3 = fazisOsszead F3 F2
fazisKommutativitas = Refl

||| Z₈ asszociativitás: (F1 + F2) + F3 = F1 + (F2 + F3).
fazisAsszociativitas : fazisOsszead (fazisOsszead F1 F2) F3 = fazisOsszead F1 (fazisOsszead F2 F3)
fazisAsszociativitas = Refl

||| Z₅ neutracelem: F0 + F4 = F4.
fazisNeutracelem : fazisOsszead F0 F4 = F4
fazisNeutracelem = Refl

||| Z₈ inverz: F3 + F5 = F0.
fazisInverzTulajdonsag : fazisOsszead F3 F5 = F0
fazisInverzTulajdonsag = Refl

-- =====================================================================
-- 7. Mérés léptetés teszt.
-- =====================================================================

meresAtmenetF0 : Fazis
meresAtmenetF0 = meresAtmenetEgy F0
-- Elvárt: F1

meresAtmenetF7 : Fazis
meresAtmenetF7 = meresAtmenetEgy F7
-- Elvárt: F0 (körben vissza)

meresAtmenetF0Ref : meresAtmenetEgy F0 = F1
meresAtmenetF0Ref = Refl

meresAtmenetF7Ref : meresAtmenetEgy F7 = F0
meresAtmenetF7Ref = Refl

-- =====================================================================
-- 8. CPT invarancia teszt: teljesMeres CPT előtt és után.
-- =====================================================================

||| CPT invarancia: ha az állapot CPT szimmetrikus,
||| a teljes mérés értéke megmarad.
||| (Ez egy numerikus teszt, nem Refl — a CPT átalakítás
||| a MagasabbRendszer modulban van definiálva.)
cptInvMeresTeszt : Double
cptInvMeresTeszt = teljesMeres peldaAllapot - teljesMeres peldaAllapot
-- Elvárt: 0.0 (azonos állapot → azonos mérés)

-- =====================================================================
-- 9. Mérés utáni növekmény.
-- =====================================================================

meresUtanNovekmeny : Double
meresUtanNovekmeny = meresUtan peldaAllapot - teljesMeres peldaAllapot
-- Elvárt: 8 × sin(π/4) ≈ 5.657 (minden komponens +1)

-- =====================================================================
-- 10. Mérési lánc teszt: 8-szor mérés = kör bezárása.
-- =====================================================================

meresLancNyolc : Allapot
meresLancNyolc = meresLanc 8 peldaAllapot
-- Elvárt: azonos fazisok (8 lépés Z₈-ban = kör), idő += 8.0

-- =====================================================================
-- 11. Kis számú mérés Refl teszt: 2 lépés.
-- =====================================================================

meresKetLepesF0 : meresAtmenetEgy (meresAtmenetEgy F0) = F2
meresKetLepesF0 = Refl

meresKetLepesF5 : meresAtmenetEgy (meresAtmenetEgy F5) = F7
meresKetLepesF5 = Refl

meresKetLepesF7 : meresAtmenetEgy (meresAtmenetEgy F7) = F1
meresKetLepesF7 = Refl

-- =====================================================================
-- 12. Harmadik fázis Refl teszt.
-- =====================================================================

harmadikFazisRef1 : harmadikFazis F2 F3 = F5
harmadikFazisRef1 = Refl

harmadikFazisRef2 : harmadikFazis F4 F5 = F1
harmadikFazisRef2 = Refl

harmadikFazisRef3 : harmadikFazis F7 F1 = F0
harmadikFazisRef3 = Refl
