module BetuE8_v2

-- ===============================================================
-- BETU E8 v2 -- a magyar betu E8-pont lekepezese
-- ===============================================================
-- A felhasznalo (2026-08-19): "fontos a hibajavitas ami a nyelvben
-- venne van... ra kell meppelni az E8-ra vagy valami ilyesmi,
-- szinte betu szinten".
--
-- A magyar nyelv "majdnem fonematikus" (Fonetika.idr): a helyesiras
-- ~1:1 a hangokkal. Ez lehetove teszi, hogy a hibajavítast a
-- BETU szintjen vegezzuk (nem csak a szó szintjen).
--
-- Ez a fajl a magyar betuket E8-pontokka lepezi le (8 bites kód):
--   7 Steane-bit + 1 chirality (γ⁵).
-- A Steane [[7,1,3]] a magyar ABC-n is alkalmazhato: 1 hibas
-- bit javíthato a szindroma-szamítással.
--
-- A 7 dimenzio: [ido, oksag, ter, szin, hang, fazis, mod]
-- (a Kodol.idr mondatSteane konvencioja szerint).
-- A 8. dimenzio (chiralitas): a Steane bitek paritasa (XOR).
--
-- A 14 magyar magánhangzo + 17 magyar massalhangzo + 9 digraf
-- + 1-2 specialis karakter → ~40 egyedi betu. A 240 E8 gyok
-- 6x-es reduncanciat ad.
-- ===============================================================

import KomplexByte
import MagyarNyelvtan_v2

%default total

-- ===============================================================
-- 1. A BETU E8-PONT TIPUSA
-- ===============================================================

||| A magyar betu E8-pont-ja: 7 Steane-bit + 1 chirality.
||| A HetesKod (Steane [[7,1,3]]) a 7 dimenziot kodolja.
public export
record BetuE8 where
  constructor BetuE8Konstruktor
  hang          : Hang         -- melyik magyar hang (magánhangzo vagy massalhangzo)
  steane        : HetesKod    -- a 7 Steane-bit
  chiralitas    : Kubit       -- a 8. dimenzio (paritás)
  cimke         : String      -- a grafikus alak (pl. "á", "cs")

||| Az ures betu: minden bit Nulla.
public export
UrressBetuE8 : BetuE8
UrressBetuE8 =
  BetuE8Konstruktor
    (MagHang Va)
    (HetesKodKonstruktor Nulla Nulla Nulla Nulla Nulla Nulla Nulla)
    Nulla
    ""

public export
Show BetuE8 where
  show (BetuE8Konstruktor h s k cimke) =
    "BetuE8 {" ++ cimke ++ ", steane=" ++ show s ++ ", chi=" ++ show k ++ "}"

-- ===============================================================
-- 2. A 7 STEANE-BIT JELENTESE A MAGYAR BETUKRE
-- ===============================================================

||| bit1 (ido): a betu idotartama -- magánhangzoknal rovid=0, hosszu=1.
|||                   massalhangzoknal 0.
public export
bitIdoBetu : Hang -> Kubit
bitIdoBetu (MagHang Vaa)   = Egy
bitIdoBetu (MagHang Vee)   = Egy
bitIdoBetu (MagHang Vii)   = Egy
bitIdoBetu (MagHang Voo)   = Egy
bitIdoBetu (MagHang Voee)  = Egy
bitIdoBetu (MagHang Vuu)   = Egy
bitIdoBetu (MagHang Vuee)  = Egy
bitIdoBetu _              = Nulla

||| bit2 (oksag): a magánhangzónál hangrend (mely=0, magas=1).
|||               a massalhangzónál zöngésség (zöngétlen=0, zöngés=1).
public export
bitOksagBetu : Hang -> Kubit
bitOksagBetu (MagHang Va)    = Nulla  -- mély
bitOksagBetu (MagHang Vaa)   = Nulla
bitOksagBetu (MagHang Ve)    = Egy    -- magas
bitOksagBetu (MagHang Vee)   = Egy
bitOksagBetu (MagHang Vi)    = Egy
bitOksagBetu (MagHang Vii)   = Egy
bitOksagBetu (MagHang Vo)    = Nulla
bitOksagBetu (MagHang Voo)   = Nulla
bitOksagBetu (MagHang Voe)   = Egy
bitOksagBetu (MagHang Voee)  = Egy
bitOksagBetu (MagHang Vu)    = Nulla
bitOksagBetu (MagHang Vuu)   = Nulla
bitOksagBetu (MagHang Vue)   = Egy
bitOksagBetu (MagHang Vuee)  = Egy
bitOksagBetu (MasHang Mb)    = Egy    -- b = zöngés
bitOksagBetu (MasHang Md)    = Egy    -- d = zöngés
bitOksagBetu (MasHang Mdz)   = Egy    -- dz = zöngés
bitOksagBetu (MasHang Mdzs)  = Egy    -- dzs = zöngés
bitOksagBetu (MasHang Mg)    = Egy    -- g = zöngés
bitOksagBetu (MasHang Mgy)   = Egy    -- gy = zöngés
bitOksagBetu (MasHang Mj)    = Egy    -- j = zöngés
bitOksagBetu (MasHang Ml)    = Egy    -- l = zöngés
bitOksagBetu (MasHang Mly)   = Egy    -- ly = zöngés
bitOksagBetu (MasHang Mm)    = Egy    -- m = zöngés
bitOksagBetu (MasHang Mn)    = Egy    -- n = zöngés
bitOksagBetu (MasHang Mny)   = Egy    -- ny = zöngés
bitOksagBetu (MasHang Mr)    = Egy    -- r = zöngés
bitOksagBetu (MasHang Mv)    = Egy    -- v = zöngés
bitOksagBetu (MasHang Mz)    = Egy    -- z = zöngés
bitOksagBetu (MasHang Mzs)   = Egy    -- zs = zöngés
bitOksagBetu _              = Nulla  -- többi: zöngétlen

||| bit3 (ter): a kepzes helye (magánhangzónál ajak/kétajakú).
|||               massalhangzónál a kepzesi hely.
public export
bitTerBetu : Hang -> Kubit
bitTerBetu (MagHang Va)    = Nulla  -- mély: hátsó
bitTerBetu (MagHang Vaa)   = Nulla
bitOksagBetu (MagHang Ve)  = Nulla  -- elülső
bitIdoBetu (MagHang Vee)   = Nulla
bitTerBetu (MagHang Vi)    = Nulla
bitTerBetu (MagHang Vii)   = Nulla
bitTerBetu (MagHang Vo)    = Nulla
bitTerBetu (MagHang Voo)   = Nulla
bitTerBetu (MagHang Voe)   = Egy    -- kétajakú
bitTerBetu (MagHang Voee)  = Egy
bitTerBetu (MagHang Vu)    = Nulla
bitTerBetu (MagHang Vuu)   = Nulla
bitTerBetu (MagHang Vue)   = Egy    -- kétajakú
bitTerBetu (MagHang Vuee)  = Egy
bitTerBetu (MasHang Mb)    = Nulla  -- ajak
bitTerBetu (MasHang Mcs)   = Nulla  -- alveoláris
bitTerBetu (MasHang Md)    = Nulla
bitTerBetu (MasHang Mdz)   = Nulla
bitTerBetu (MasHang Mdzs)  = Nulla
bitTerBetu (MasHang Mf)    = Egy    -- labiális (ajak-fog)
bitTerBetu (MasHang Mg)    = Nulla
bitTerBetu (MasHang Mgy)   = Nulla
bitTerBetu (MasHang Mh)    = Nulla
bitTerBetu (MasHang Mj)    = Nulla
bitTerBetu (MasHang Mk)    = Nulla
bitTerBetu (MasHang Ml)    = Nulla
bitTerBetu (MasHang Mly)   = Nulla
bitTerBetu (MasHang Mm)    = Nulla
bitTerBetu (MasHang Mn)    = Nulla
bitTerBetu (MasHang Mny)   = Nulla
bitTerBetu (MasHang Mp)    = Nulla  -- ajak
bitTerBetu (MasHang Mr)    = Nulla
bitTerBetu (MasHang Ms)    = Nulla
bitTerBetu (MasHang Msz)   = Nulla
bitTerBetu (MasHang Mt)    = Nulla
bitTerBetu (MasHang Mty)   = Nulla
bitTerBetu (MasHang Mv)    = Egy    -- labiális
bitTerBetu (MasHang Mz)    = Nulla
bitTerBetu (MasHang Mzs)   = Nulla

||| bit4 (szin): a magánhangzó színe (magas=1).
|||              a massalhangzónál a zöngésség fordított jele.
public export
bitSzinBetu : Hang -> Kubit
bitSzinBetu (MagHang Va)    = Nulla
bitSzinBetu (MagHang Vaa)   = Nulla
bitSzinBetu (MagHang Ve)    = Egy
bitSzinBetu (MagHang Vee)   = Egy
bitSzinBetu (MagHang Vi)    = Egy
bitSzinBetu (MagHang Vii)   = Egy
bitSzinBetu (MagHang Vo)    = Nulla
bitSzinBetu (MagHang Voo)   = Nulla
bitSzinBetu (MagHang Voe)   = Egy
bitSzinBetu (MagHang Voee)  = Egy
bitSzinBetu (MagHang Vu)    = Nulla
bitSzinBetu (MagHang Vuu)   = Nulla
bitSzinBetu (MagHang Vue)   = Egy
bitSzinBetu (MagHang Vuee)  = Egy
bitSzinBetu _              = Nulla

||| bit5 (hang): a zöngésség (magánhangzóknál 0).
public export
bitHangBetu : Hang -> Kubit
bitHangBetu (MagHang _) = Nulla
bitHangBetu (MasHang Mb)   = Egy
bitHangBetu (MasHang Md)   = Egy
bitHangBetu (MasHang Mdz)  = Egy
bitHangBetu (MasHang Mdzs) = Egy
bitHangBetu (MasHang Mg)   = Egy
bitHangBetu (MasHang Mgy)  = Egy
bitHangBetu (MasHang Mj)   = Egy
bitHangBetu (MasHang Ml)   = Egy
bitHangBetu (MasHang Mly)  = Egy
bitHangBetu (MasHang Mm)   = Egy
bitHangBetu (MasHang Mn)   = Egy
bitHangBetu (MasHang Mny)  = Egy
bitHangBetu (MasHang Mr)   = Egy
bitHangBetu (MasHang Mv)   = Egy
bitHangBetu (MasHang Mz)   = Egy
bitHangBetu (MasHang Mzs)  = Egy
bitHangBetu _             = Nulla

||| bit6 (fazis): a képzés módja (magánhangzónál 0,
|||              robbanó=0, frikatív=1 a mássalhangzóknál).
public export
bitFazisBetu : Hang -> Kubit
bitFazisBetu (MagHang _) = Nulla
bitFazisBetu (MasHang Mb)   = Nulla
bitFazisBetu (MasHang Mcs)  = Egy
bitFazisBetu (MasHang Md)   = Nulla
bitFazisBetu (MasHang Mdz)  = Egy
bitFazisBetu (MasHang Mdzs) = Egy
bitFazisBetu (MasHang Mf)   = Egy
bitFazisBetu (MasHang Mg)   = Nulla
bitFazisBetu (MasHang Mgy)  = Egy
bitFazisBetu (MasHang Mh)   = Egy
bitFazisBetu (MasHang Mj)   = Egy
bitFazisBetu (MasHang Mk)   = Nulla
bitFazisBetu (MasHang Ml)   = Nulla
bitFazisBetu (MasHang Mly)  = Nulla
bitFazisBetu (MasHang Mm)   = Nulla
bitFazisBetu (MasHang Mn)   = Nulla
bitFazisBetu (MasHang Mny)  = Nulla
bitFazisBetu (MasHang Mp)   = Nulla
bitFazisBetu (MasHang Mr)   = Nulla
bitFazisBetu (MasHang Ms)   = Egy
bitFazisBetu (MasHang Msz)  = Egy
bitFazisBetu (MasHang Mt)   = Nulla
bitFazisBetu (MasHang Mty)  = Nulla
bitFazisBetu (MasHang Mv)   = Egy
bitFazisBetu (MasHang Mz)   = Egy
bitFazisBetu (MasHang Mzs)  = Egy

||| bit7 (mod): a hosszúság (0 = rövid, 1 = hosszú).
public export
bitModBetu : Hang -> Kubit
bitModBetu (MagHang Vaa)   = Egy
bitModBetu (MagHang Vee)   = Egy
bitModBetu (MagHang Vii)   = Egy
bitModBetu (MagHang Voo)   = Egy
bitModBetu (MagHang Voee)  = Egy
bitModBetu (MagHang Vuu)   = Egy
bitModBetu (MagHang Vuee)  = Egy
bitModBetu _              = Nulla

||| A Steane bitek osszesítese egy HetesKod-ba.
public export
betuSteane : Hang -> HetesKod
betuSteane h =
  HetesKodKonstruktor
    (bitIdoBetu h) (bitOksagBetu h) (bitTerBetu h) (bitSzinBetu h)
    (bitHangBetu h) (bitFazisBetu h) (bitModBetu h)

||| A 8. dimenzio (chiralitas): a Steane bitek paritasa.
public export
betuChiralitas : HetesKod -> Kubit
betuChiralitas (HetesKodKonstruktor a b c d e f g) =
  paritas [a, b, c, d, e, f, g]
  where
    paritas : List Kubit -> Kubit
    paritas [] = Nulla
    paritas (x :: xs) = xorKubit x (paritas xs)

xorKubit : Kubit -> Kubit -> Kubit
xorKubit Nulla x = x
xorKubit Egy   x = forditKubit x
