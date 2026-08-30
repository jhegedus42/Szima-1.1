module ProbeFogalomTavolsag

-- Probe 3 (bisect): a Fogalom_v1 pontos láncszemei külön-külön:
-- (1) belsoszorzat importból (where nélküli);
-- (2) jelentésTávolság importból (where-es);
-- (3) SAJÁT rekord + mező-függvény + importált where-es függvény.

import GyokSzo_v1
import E8BelsoSzorzat

-- (1) Kimenet: Refl — gyök-szintű szorzat importból.
bizProbeSzorzat :
  belsoszorzat (jel PéldaEgészSzó) (jel PéldaFélEgészSzó) = 4
bizProbeSzorzat = Refl

-- (2) Kimenet: Refl — jelentésTávolság közvetlen importból.
bizProbeKözvetlen :
  jelentésTávolság PéldaEgészSzó PéldaFélEgészSzó = SzorosanHasonló
bizProbeKözvetlen = Refl

-- (3) A Fogalom_v1 láncszeme: saját rekord, mező-név megegyezik.
record PróbaFogalom where
  constructor PróbaFogalomKonstruktor
  gyökSzó : GyökSzó

próbaTávolság : PróbaFogalom -> PróbaFogalom -> HasonlóságÖtSzint
próbaTávolság fogalomEgy fogalomKettő =
  jelentésTávolság (gyökSzó fogalomEgy) (gyökSzó fogalomKettő)

PróbaEgészFogalom : PróbaFogalom
PróbaEgészFogalom = PróbaFogalomKonstruktor PéldaEgészSzó

PróbaFélEgészFogalom : PróbaFogalom
PróbaFélEgészFogalom = PróbaFogalomKonstruktor PéldaFélEgészSzó

-- (3) Kimenet: Refl-e? — ez dönti el, hogy a mező-réteg+where a gond.
bizPróbaFogalomTáv :
  próbaTávolság PróbaEgészFogalom PróbaFélEgészFogalom = SzorosanHasonló
bizPróbaFogalomTáv = Refl
