module HaromKubitGepeiTeszt

-- ═══════════════════════════════════════════════════════════════
-- HAROMKUBIT GÉPI TESZT (100.01 — §N14/2 tanúk + §N14/3 futás)
-- / 三量子比特机检 / Drei-Qubits-Maschinentest / בדיקת מכונה ═════
-- ═══════════════════════════════════════════════════════════════

import Steane713
import HaromKubit
import Alap.CsomagoltTipusok
import Alap.Hatar

-- ─── Fordítási idejű tanúk (a bíra = a typechecker) ─────────────

kubitEgyezésNullaTanú :
  HaromKubit.kubitEgyezés Steane713.Nulla Steane713.Nulla = Igaz
kubitEgyezésNullaTanú = Refl

kubitEgyezésEgyTanú :
  HaromKubit.kubitEgyezés Steane713.Egy Steane713.Egy = Igaz
kubitEgyezésEgyTanú = Refl

kubitEgyezésKülönbségTanú :
  HaromKubit.kubitEgyezés Steane713.Nulla Steane713.Egy = Hamis
kubitEgyezésKülönbségTanú = Refl

azonosFázisTanú :
  HaromKubit.azonosFázis
    (VilágKonstruktor Steane713.Nulla Steane713.Egy Steane713.Nulla)
    (VilágKonstruktor Steane713.Egy Steane713.Nulla Steane713.Nulla) = Igaz
azonosFázisTanú = Refl

iranySajátMásikTanú :
  HaromKubit.irány
    (VilágKonstruktor Steane713.Egy Steane713.Egy Steane713.Nulla)
    (VilágKonstruktor Steane713.Nulla Steane713.Nulla Steane713.Egy) = SajátMásik
iranySajátMásikTanú = Refl

iranyNincsTanú :
  HaromKubit.irány
    (VilágKonstruktor Steane713.Egy Steane713.Egy Steane713.Egy)
    (VilágKonstruktor Steane713.Nulla Steane713.Nulla Steane713.Egy) = NincsIrány
iranyNincsTanú = Refl

-- ─── Futtatási ellenőrzés (§N14/3) ─────────────────────────────

main : IO ()
main = do
  putStrLn ""
  putStrLn "═══ HAROMKUBIT GÉPI TESZT (100.01) ═══"
  putStrLn "azonos fázis (Nulla-Nulla):"
  határKiírás (megjelenít (azonosFázis (VilágKonstruktor Steane713.Nulla Steane713.Egy Steane713.Nulla) (VilágKonstruktor Steane713.Egy Steane713.Nulla Steane713.Nulla)))
  putStrLn "különböző fázis (Nulla-Egy):"
  határKiírás (megjelenít (azonosFázis (VilágKonstruktor Steane713.Nulla Steane713.Nulla Steane713.Nulla) (VilágKonstruktor Steane713.Egy Steane713.Egy Steane713.Egy)))
  putStrLn "a tanúk mind Refl — a fordító bírálta el őket."
  putStrLn "═══ ═══ ═══"