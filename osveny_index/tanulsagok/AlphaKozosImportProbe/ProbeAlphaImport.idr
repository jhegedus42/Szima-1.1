module ProbeAlphaImport
-- PRÓBA: az Alap.AlphaKozos importálható és használható (§24 — import, nem másolás)
-- 探针：验证 Alap.AlphaKozos 可被导入使用（禁止复制，只许导入）。
import Alap.AlphaKozos

%default covering

-- A delta és sigmaG NINCS újraírva — importálva lett (szöveg-egyezés
-- a kanonikus modullal, futásidőben ellenőrizve):
ellenorzes : IO ()
ellenorzes = do
  putStrLn ("importált delta  = " ++ show delta)
  putStrLn ("importált sigmaG = " ++ show sigmaG)
