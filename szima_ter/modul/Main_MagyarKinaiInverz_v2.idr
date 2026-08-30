module Main_MagyarKinaiInverz_v2

-- ═══════════════════════════════════════════════════════════════
-- A magyar ↔ kínai inverz-vizsgálat demója
-- ═══════════════════════════════════════════════════════════════
-- A fordítóprogram az alábbiakat ellenőrizte:
--   - ✅ Azon Refl-bizonyítások, ahol az oda-vissza egyezik
--   - ❌ Azon esetek, ahol a Refl NEM fordul le (informáveszteség)

import KomplexByte
import MagyarKinaiPar_v2
import MagyarKinaiInverz_v2

%default total

main : IO ()
main = do
  putStrLn "============================================"
  putStrLn "MAGYAR ↔ KÍNAI INVERZ-VIZSGÁLAT"
  putStrLn "============================================"

  putStrLn ""
  putStrLn "1. Jobb inverz (forditG ∘ forditF = id_magyar):"
  putStrLn "   ✅ MagyarJelen+Imperfectum+Kijelento oda-vissza egyezik."
  putStrLn "   ❌ MagyarMult elveszik (a forditF elveszti az igeidőt)."
  putStrLn "   ❌ MagyarJovo elveszik (a forditF elveszti az igeidőt)."

  putStrLn ""
  putStrLn "2. Bal inverz (forditF ∘ forditG = id_kinai):"
  putStrLn "   ✅ KinaiZhe (durativ) oda-vissza egyezik."
  putStrLn "   ✅ KinaiGuo (tapasztalati) oda-vissza egyezik."
  putStrLn "   ✅ KinaiLe (perfectiv) oda-vissza egyezik."
  putStrLn "   ❌ KinaiZai (progresszív) → KinaiZhe (durativ)."

  putStrLn ""
  putStrLn "3. Információveszteség (kritikus):"
  putStrLn "   ❌ A KinaiZai elveszik (progresszív → durativ)."
  putStrLn "   ❌ A tonalitás elveszik (mindig 1. tonem)."
  putStrLn "   ❌ A KinaiLeM (változás) elveszik (→ KinaiDe, állítás)."
  putStrLn "   ❌ A KinaiMa (kérdés) elveszik (→ KinaiDe, állítás)."

  putStrLn ""
  putStrLn "4. Az eredmény:"
  printLn magyarKinaiInverzEredmenye

  putStrLn ""
  putStrLn "5. A Cat² 2-sejtje (természetes transzformáció):"
  putStrLn magyarKinai2SejtMegjegyzes

  putStrLn ""
  putStrLn "6. A magyar ↔ kínai rendszer a Cat² szintje (a Cat^∞ hierarchiában):"
  printLn magyarKinaiRendszerSzintje

  putStrLn ""
  putStrLn "============================================"
  putStrLn "KÖVETKEZTETÉS"
  putStrLn "============================================"
  putStrLn ""
  putStrLn "A magyar ↔ kínai rendszer NEM inverz functor-pár."
  putStrLn "Az információveszteség 4 területen:"
  putStrLn "  1. a magyar Múlt/Jövő igeidő elveszik,"
  putStrLn "  2. a kínai Zai (progresszív) → Zhe (durativ),"
  putStrLn "  3. a kínai tonalitás elveszik (mindig 1. tonem),"
  putStrLn "  4. a kínai LeM/Ma modalitás → De (állítás)."
  putStrLn ""
  putStrLn "Ez a Cat² struktúra: a functor-pár információveszteséggel,"
  putStrLn "ÉS NEM inverz. A Cat^∞ hierarchiában ez a Cat² szintje."
  putStrLn ""
  putStrLn "Kesz."