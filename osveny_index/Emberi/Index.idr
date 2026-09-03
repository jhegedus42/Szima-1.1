module Emberi.Index

import Steane713

||| 7 emberi kategória = [[7,1,3]] kód 7 bitje a kvantum oldalon.
||| Minden kategória egy emberi értelmezési módusz.
||| 7 个人类范畴 = [[7,1,3]] 码在量子一侧的 7 位。每个范畴是一种人类的诠释模式。
|||
|||   Bit  | Név    | Jelentés            | Fizikai pár
|||   -----|--------|---------------------|---------------------
|||    0   | Idő    | észlelés/percepció  | C (töltés/időben)
|||    1   | Ok-okozat | okoskodás/ráció  | P (paritás/ok)
|||    2   | Tér    | hely/elhelyezkedés  | T (tér)
|||    3   | Szín   | érzelem/minőség L   | potenciál (T−V)
|||    4   | Hang   | kommunikáció H      | kinetika (T+V)
|||    5   | Fázis  | akarat/átmenet      | Legendre-perem
|||    6   | Mód    | választás/módusz    | reprezentáció
||| （时间=感知；因果=推理；空间=位置；颜色=情感 L；声音=交流 H；
|||   相位=意志（勒让德边界）；模态=选择。）
public export
data EmberiKategoria : Type where
  EmberiIdo    : EmberiKategoria  -- bit 0: észlelés / 感知
  EmberiOksag  : EmberiKategoria  -- bit 1: ráció / 推理
  EmberiTer    : EmberiKategoria  -- bit 2: hely / 位置
  EmberiSzin   : EmberiKategoria  -- bit 3: érzelem (L) / 情感 (L)
  EmberiHang   : EmberiKategoria  -- bit 4: kommunikáció (H) / 交流 (H)
  EmberiFazis  : EmberiKategoria  -- bit 5: akarat (Legendre) / 意志（勒让德）
  EmberiMod    : EmberiKategoria  -- bit 6: választás / 选择

||| Minden emberi kategóriában van egy kvantum állapot.
||| 每个人类范畴中都有一个量子态。
public export
EmberiAllapot : Type
EmberiAllapot = (EmberiKategoria, Kubit)

||| 7 emberi állapot = egy emberi teljes állapot.
||| 7 个人类状态 = 一个完整的人类状态。
public export
EmberiHetes : Type
EmberiHetes = HetesKod

||| Emberi kategória → Steane-kód bitpozíció.
||| 人类范畴 → Steane 码的位位置。
public export
emberiBitPozicio : EmberiKategoria -> Kubit
emberiBitPozicio EmberiIdo = Nulla
emberiBitPozicio EmberiOksag = Egy
emberiBitPozicio EmberiTer = Nulla
emberiBitPozicio EmberiSzin = Egy
emberiBitPozicio EmberiHang = Nulla
emberiBitPozicio EmberiFazis = Egy
emberiBitPozicio EmberiMod = Nulla

||| Emberi kategóriák CPT-szimmetriái:
||| 人类范畴的 CPT 对称性：
|||   C: Idő (töltés) — megmarad / C：时间（负荷）——守恒
|||   P: Ok-okozat (paritás) — előjel fordít / P：因果（宇称）——翻符号
|||   T: Tér (idő) — előjel fordít / T：空间（时间）——翻符号
|||   L: Szín = T − V (differencia) / L：颜色 = T − V（差）
|||   H: Hang = T + V (összeg) / H：声音 = T + V（和）
|||   Perem: Fázis = Legendre / 边界：相位 = 勒让德
|||   Választás: Mód = reprezentáció / 选择：模态 = 表示
public export
data EmberiCpt : EmberiKategoria -> Type where
  EmberiC : EmberiCpt EmberiIdo
  EmberiP : EmberiCpt EmberiOksag
  EmberiT : EmberiCpt EmberiTer
