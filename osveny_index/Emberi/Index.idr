module Emberi.Index

import Steane713

||| 7 emberi kategori = [[7,1,3]] kod 7 bitje a kvantum oldalon.
||| Minden kategoria egy emberi ertelemzesi modusz.
|||
|||   Bit  | Nev    | Jelentes            | Fizikai par
|||   -----|--------|---------------------|---------------------
|||    0   | Ido    | eszleles/percepcio  | C (toltes/idoben)
|||    1   | Oksag  | okoskodas/racio     | P (paritas/ok)
|||    2   | Ter    | hely/elhelyezkedes  | T (ter)
|||    3   | Szin   | erzelem/minoseg L   | potencial (T-V)
|||    4   | Hang   | kommunikacio H      | kinetika (T+V)
|||    5   | Fazis  | akarat/atmenet      | Legendre perem
|||    6   | Mod    | valasztas/modus     | reprezentacio
public export
data EmberiKategoria : Type where
  EmberiIdo    : EmberiKategoria  -- bit 0: eszleles
  EmberiOksag  : EmberiKategoria  -- bit 1: racio
  EmberiTer    : EmberiKategoria  -- bit 2: hely
  EmberiSzin   : EmberiKategoria  -- bit 3: erzelem (L)
  EmberiHang   : EmberiKategoria  -- bit 4: kommunikacio (H)
  EmberiFazis  : EmberiKategoria  -- bit 5: akarat (Legendre)
  EmberiMod    : EmberiKategoria  -- bit 6: valasztas

||| Minden emberi kategoriaban van egy kvantum allapot.
public export
EmberiAllapot : Type
EmberiAllapot = (EmberiKategoria, Kubit)

||| 7 emberi allapot = egy emberi teljes allapot.
public export
EmberiHetes : Type
EmberiHetes = HetesKod

||| Emberi kategoria -> Steane kod bit pozicio.
public export
emberiBitPozicio : EmberiKategoria -> Kubit
emberiBitPozicio EmberiIdo = Nulla
emberiBitPozicio EmberiOksag = Egy
emberiBitPozicio EmberiTer = Nulla
emberiBitPozicio EmberiSzin = Egy
emberiBitPozicio EmberiHang = Nulla
emberiBitPozicio EmberiFazis = Egy
emberiBitPozicio EmberiMod = Nulla

||| Emberi kategoriak CPT szimmetriai:
|||   C: Ido (toltes) — megmarad
|||   P: Oksag (paritas) — elojel fordit
|||   T: Ter (ido) — elojel fordit
|||   L: Szin = T - V (differencia)
|||   H: Hang = T + V (osszeg)
|||   Perem: Fazis = Legendre
|||   Valasztas: Mod = reprezentacio
public export
data EmberiCpt : EmberiKategoria -> Type where
  EmberiC : EmberiCpt EmberiIdo
  EmberiP : EmberiCpt EmberiOksag
  EmberiT : EmberiCpt EmberiTer
