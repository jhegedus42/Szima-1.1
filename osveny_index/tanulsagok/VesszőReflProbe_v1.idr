module VesszőReflProbe_v1

-- ═══════════════════════════════════════════════════════════════
-- VESSZŐ-REFL PROBE v1 — a #30-as csapda mérése (2026-09-04)
-- KÉRDÉS: zár-e Refl-lel a Double-összehasonlítás (`< 1.0`) a
-- kernelben, HA az |·| SAJÁT függvény (nem a Prelude `abs`)?
-- A feladat (2026-09-04): «eltérésAbszolútÉrtéke < 1.0 (Refl, mert
-- a |·| a saját doubleAux függvény — l. #30!)».
-- 中文：测量第 30 号陷阱——当绝对值是自写函数时，双重精度比较能否在
-- 内核里用 Refl 闭合？
-- EN: Probing trap #30 — does a Double comparison close with Refl
-- in the kernel when |·| is a hand-written function?
-- DE: Falle #30 messen — schließt ein Double-Vergleich mit Refl im
-- Kernel, wenn |·| eine eigene Funktion ist?
-- ═══════════════════════════════════════════════════════════════
-- MÉRT ESETEK:
--   A) abszolútÉrték (literál − literál) < 1.0 = True   [Refl?]
--   B) natbólValós-lánc literálra                        [Refl?]
--   C) eltérés-kicsiség a v1-stílusú pow-úttól           [nem zár — várva]
-- ═══════════════════════════════════════════════════════════════

%default total

||| Saját abszolútérték — az `if–then–else` alak (nem a Prelude `abs`).
abszolútÉrték : Double -> Double
abszolútÉrték x = if x < 0.0 then negate x else x

||| Nat → Double (a v1 peremmintája).
natbólValós : Nat -> Double
natbólValós n = fromInteger (natToInteger n)

-- A) Kimenet: Refl — HA a kernel a Double-`<`-t fordítási időben értékeli.
bizEsetA : abszolútÉrték (99.042 - 99.0) < 1.0 = True
bizEsetA = Refl

-- B) Kimenet: Refl — HA a natbólValós literálra redukálódik.
bizEsetB : abszolútÉrték (99.042 - natbólValós 99) < 1.0 = True
bizEsetB = Refl

||| A v1 stílusa: pow-ra épülő számított érték (a kernel a pow-t nem redukálja).
tokenMéretValósÚt : Double
tokenMéretValósÚt = pow 2.0 0.629971 * 64.0

||| A csonkítás (a v1 peremmintája).
csonkítás : Double -> Nat
csonkítás x = fromInteger (cast {to=Integer} (floor x))

-- C) Kimenet: ELVÁRÁS SZERINT NEM ZÁR (a pow-út nem redukálódik) —
-- ezt a --check MÉRI; ha mégis zárna, a #30-dokumentáció frissül.
-- bizEsetC : abszolútÉrték (tokenMéretValósÚt - natbólValós (csonkítás tokenMéretValósÚt)) < 1.0 = True
-- bizEsetC = ?lyuk

main : IO ()
main = do
  putStrLn "─── VesszőReflProbe_v1 — a #30-as csapda mérése ───"
  putStrLn ("  A) abszolútÉrték (99.042 - 99.0) < 1.0 = "
            ++ show (abszolútÉrték (99.042 - 99.0) < 1.0) ++ "  (Refl: zár)")
  putStrLn ("  B) abszolútÉrték (99.042 - natbólValós 99) < 1.0 = "
            ++ show (abszolútÉrték (99.042 - natbólValós 99) < 1.0))
  putStrLn ("  C) pow-út: 2^0.629971·64 = " ++ show tokenMéretValósÚt
            ++ "  (csonkítva: " ++ show (csonkítás tokenMéretValósÚt) ++ ")")
  putStrLn ("     C-eltérés = "
            ++ show (abszolútÉrték (tokenMéretValósÚt
                                    - natbólValós (csonkítás tokenMéretValósÚt))))
  putStrLn "  A Refl-tanú (A, B) a forrásban; a C futásidejű Show-tanú."
