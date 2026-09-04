module KorabbiNumerikusEllenorzes

import E8SteaneLevezetes

%default total

-- Az első, közvetlen Double-ellenőrzés megőrzött, rövid változata.
-- A képletek teljes kibontása és eredetük osztályozása az
-- E8SteaneLevezetes modulban található.

public export
korabbiNumerikusEredmenyekKiirasa : IO ()
korabbiNumerikusEredmenyekKiirasa = do
  putStrLn ("Finomszerkezeti állandó inverze: " ++
            show FinomszerkezetiAllandoInverzJelolt)
  putStrLn ("Dimenzió nélküli gravitációs csatolás: " ++
            show DimenzioNelKuliGravitaciosCsatolasJelolt)
