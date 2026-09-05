module KategoriaStruktura.OsztásProbe_v1

-- ╔══════════════════════════════════════════════════════════════════╗
-- ║ OSZTÁS-PROBE · v1 — hol számol rosszat a strukturális osztás?     ║
-- ║ 除法探针 · v1 — 结构除法在哪里算错？                               ║
-- ║ DIVISION PROBE · v1 — where does the structural division fail?    ║
-- ║ DIVISIONS-PROBE · v1 — wo rechnet die Strukturdivision falsch?    ║
-- ╚══════════════════════════════════════════════════════════════════╝
--
-- §24-JEGYZET: EZ A MÁSOLAT SZÁNDÉKOS diagnosztikai másolat — a
-- KategoriaStruktura.PrimekAnalizis_v2 maga HIBÁS (a Refl elkapta:
-- «Mismatch between: True and False»), ezért nem importálható; a
-- hiba megtalálásához a gépnek futnia KELL. Amint a hiba gyógyul,
-- ez a probe a tanulság-archívumban marad (§20: semmi törlés).
-- 这是刻意的诊断副本——原模块有错不可导入；修复后本探针留档不删。
-- This is a deliberate diagnostic copy — the original is broken and
-- cannot be imported; once fixed, this probe stays in the archive.
-- Dies ist eine beabsichtigte Diagnosekopie — das Original ist defekt.

%default partial

||| A PrimekAnalizis_v2.osztás EGY AZ EGYBEN vett másolata (diagnózis).
osztás : (n, d : Nat) -> (Nat, Nat)
osztás Z _ = (Z, Z)
osztás (S k) d =
  let (hányados, maradék) = osztás k d in
  if S maradék == d then (S hányados, Z) else (hányados, S maradék)

osztóE : (d, n : Nat) -> Bool
osztóE d n = maradékNullaE (osztás n d)
  where
    maradékNullaE : (Nat, Nat) -> Bool
    maradékNullaE (_, Z) = True
    maradékNullaE _      = False

sorbólSzöveg : Nat -> String
sorbólSzöveg d =
  "d = " ++ show d ++
  "  osztás 47 " ++ show d ++ " = " ++ show (osztás 47 d) ++
  "  osztóE = " ++ show (osztóE d 47)

main : IO ()
main = do
  putStrLn "=== OsztásProbe_v1 — n = 47, d = 2..46 (csak az osztó-kimenetek) ==="
  putStrLn (concat (map (\d => sorbólSzöveg d ++ "\n") [2 .. 46]))
