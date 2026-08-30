module ModulRegisztracio

-- ═══════════════════════════════════════════════════════════════
-- MODUL-REGISZTRÁCIÓ — minden modul saját magát írja le
-- ═══════════════════════════════════════════════════════════════
-- A regisztrációs TÍPUS: minden Idris-modul, ami része a projektnek,
-- exportál egy `leiras : ModulLeirasT` értéket. Az Attekintes.idr
-- ezekből automatikusan építi a modullistát — nem kell kézzel
-- karbantartani.
--
-- Használat (egy modul végén):
--   import ModulRegisztracio
--   public export FonetikaLeiras : ModulLeirasT
--   FonetikaLeiras = ModulLeirasKonstruktor "Fonetika.idr" "..." "..." "65 teszt"
-- ═══════════════════════════════════════════════════════════════

%default total

public export
record ModulLeirasT where
  constructor ModulLeirasKonstruktor
  modulNeve    : String
  mitBizonyit  : String
  miertKell    : String
  allapotJele  : String

public export
Show ModulLeirasT where
  show m = modulNeve m ++ " [" ++ allapotJele m ++ "]"