module Szamitasi.Index

import Steane713
import Emberi.Index

||| 7 szamitasi kategoria = [[7,1,3]] kod 7 bitje a klasszikus oldalon.
||| Minden kategoria egy Neumann-architekturabeli komponens.
|||
|||   Bit  | Nev       | Jelentes            | Emberi par
|||   -----|-----------|---------------------|---------------------
|||    0   | Utem      | clock/ciklus        | Ido (percepcio)
|||    1   | Vezerles  | control flow        | Oksag (racio)
|||    2   | Adat      | memoria/tarolas     | Ter (hely)
|||    3   | Tipus     | type/encoding       | Szin (erzelem)
|||    4   | Kapcsolat | I/O/busz            | Hang (komm)
|||    5   | Allapot   | regiszter/status    | Fazis (akarat)
|||    6   | Utasitas  | utasitaskeszlet      | Mod (dontes)
public export
data SzamitasiKategoria : Type where
  SzamUtem      : SzamitasiKategoria  -- bit 0: clock
  SzamVezerles  : SzamitasiKategoria  -- bit 1: control
  SzamAdat      : SzamitasiKategoria  -- bit 2: memoria
  SzamTipus     : SzamitasiKategoria  -- bit 3: tipus
  SzamKapcsolat : SzamitasiKategoria  -- bit 4: I/O
  SzamAllapot   : SzamitasiKategoria  -- bit 5: regiszter
  SzamUtasitas  : SzamitasiKategoria  -- bit 6: utasitas

||| Minden szamitasi kategoriaban van egy klasszikus bit.
public export
SzamitasiAllapot : Type
SzamitasiAllapot = (SzamitasiKategoria, Kubit)

||| 7 szamitasi allapot = egy teljes szamitasi allapot (regiszter).
public export
SzamitasiHetes : Type
SzamitasiHetes = HetesKod

||| Szamitasi kategoria -> Steane kod bit pozicio.
public export
szamBitPozicio : SzamitasiKategoria -> Kubit
szamBitPozicio SzamUtem      = Nulla
szamBitPozicio SzamVezerles  = Egy
szamBitPozicio SzamAdat      = Nulla
szamBitPozicio SzamTipus     = Egy
szamBitPozicio SzamKapcsolat = Nulla
szamBitPozicio SzamAllapot   = Egy
szamBitPozicio SzamUtasitas  = Nulla

||| Szamitasi kategoriak Legendre parjai az emberi oldalon.
public export
emberiPar : SzamitasiKategoria -> EmberiKategoria
emberiPar SzamUtem      = EmberiIdo
emberiPar SzamVezerles  = EmberiOksag
emberiPar SzamAdat      = EmberiTer
emberiPar SzamTipus     = EmberiSzin
emberiPar SzamKapcsolat = EmberiHang
emberiPar SzamAllapot   = EmberiFazis
emberiPar SzamUtasitas  = EmberiMod
