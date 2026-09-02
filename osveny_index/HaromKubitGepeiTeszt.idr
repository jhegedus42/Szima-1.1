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

azonosFazisTanú :
  HaromKubit.azonosFazis
    (VilagKonstruktor Steane713.Nulla Steane713.Egy Steane713.Nulla)
    (VilagKonstruktor Steane713.Egy Steane713.Nulla Steane713.Nulla) = Igaz
azonosFazisTanú = Refl

iranySajatMasikTanú :
  HaromKubit.irany
    (VilagKonstruktor Steane713.Egy Steane713.Egy Steane713.Nulla)
    (VilagKonstruktor Steane713.Nulla Steane713.Nulla Steane713.Egy) = SajatMasik
iranySajatMasikTanú = Refl

iranyNincsTanú :
  HaromKubit.irany
    (VilagKonstruktor Steane713.Egy Steane713.Egy Steane713.Egy)
    (VilagKonstruktor Steane713.Nulla Steane713.Nulla Steane713.Egy) = NincsIrany
iranyNincsTanú = Refl

-- ─── Futtatási ellenőrzés (§N14/3) ─────────────────────────────

main : IO ()
main = do
  putStrLn ""
  putStrLn "═══ HAROMKUBIT GÉPI TESZT (100.01) ═══"
  putStrLn "azonos fázis (Nulla-Nulla):"
  határKiírás (megjelenít (azonosFazis (VilagKonstruktor Steane713.Nulla Steane713.Egy Steane713.Nulla) (VilagKonstruktor Steane713.Egy Steane713.Nulla Steane713.Nulla)))
  putStrLn "különböző fázis (Nulla-Egy):"
  határKiírás (megjelenít (azonosFazis (VilagKonstruktor Steane713.Nulla Steane713.Nulla Steane713.Nulla) (VilagKonstruktor Steane713.Egy Steane713.Egy Steane713.Egy)))
  putStrLn "a tanúk mind Refl — a fordító bírálta el őket."
  putStrLn "═══ ═══ ═══"