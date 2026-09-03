module Szamitasi.Index

import Steane713
import Emberi.Index

||| 7 számítási kategória = [[7,1,3]] kód 7 bitje a klasszikus oldalon.
||| Minden kategória egy Neumann-architektúrábeli komponens.
||| 7 个计算范畴 = [[7,1,3]] 码在经典一侧的 7 位。每个范畴是冯·诺依曼架构的一个部件。
|||
|||   Bit  | Név       | Jelentés            | Emberi pár
|||   -----|-----------|---------------------|---------------------
|||    0   | Ütem      | óra/ciklus          | Idő (percepció)
|||    1   | Vezérlés  | vezérlési folyamat  | Ok-okozat (ráció)
|||    2   | Adat      | memória/tárolás     | Tér (hely)
|||    3   | Típus     | típus/kódolás       | Szín (érzelem)
|||    4   | Kapcsolat | I/O/busz            | Hang (kommunikáció)
|||    5   | Állapot   | regiszter/státusz   | Fázis (akarat)
|||    6   | Utasítás  | utasításkészlet     | Mód (döntés)
||| （节拍=时钟；控制=控制流；数据=内存；类型=编码；联系=输入输出/总线；
|||   状态=寄存器；指令=指令集——各自对应人类一侧的范畴。）
public export
data SzamitasiKategoria : Type where
  SzamUtem      : SzamitasiKategoria  -- bit 0: óra / 时钟
  SzamVezerles  : SzamitasiKategoria  -- bit 1: vezérlés / 控制
  SzamAdat      : SzamitasiKategoria  -- bit 2: memória / 内存
  SzamTipus     : SzamitasiKategoria  -- bit 3: típus / 类型
  SzamKapcsolat : SzamitasiKategoria  -- bit 4: I/O / 输入输出
  SzamAllapot   : SzamitasiKategoria  -- bit 5: regiszter / 寄存器
  SzamUtasitas  : SzamitasiKategoria  -- bit 6: utasítás / 指令

||| Minden számítási kategóriában van egy klasszikus bit.
||| 每个计算范畴中都有一个经典比特。
public export
SzamitasiAllapot : Type
SzamitasiAllapot = (SzamitasiKategoria, Kubit)

||| 7 számítási állapot = egy teljes számítási állapot (regiszter).
||| 7 个计算状态 = 一个完整的计算状态（寄存器）。
public export
SzamitasiHetes : Type
SzamitasiHetes = HetesKod

||| Számítási kategória → Steane-kód bitpozíció.
||| 计算范畴 → Steane 码的位位置。
public export
szamBitPozicio : SzamitasiKategoria -> Kubit
szamBitPozicio SzamUtem      = Nulla
szamBitPozicio SzamVezerles  = Egy
szamBitPozicio SzamAdat      = Nulla
szamBitPozicio SzamTipus     = Egy
szamBitPozicio SzamKapcsolat = Nulla
szamBitPozicio SzamAllapot   = Egy
szamBitPozicio SzamUtasitas  = Nulla

||| Számítási kategóriák Legendre-párjai az emberi oldalon.
||| 计算范畴在人类一侧的勒让德配对。
public export
emberiPar : SzamitasiKategoria -> EmberiKategoria
emberiPar SzamUtem      = EmberiIdo
emberiPar SzamVezerles  = EmberiOksag
emberiPar SzamAdat      = EmberiTer
emberiPar SzamTipus     = EmberiSzin
emberiPar SzamKapcsolat = EmberiHang
emberiPar SzamAllapot   = EmberiFazis
emberiPar SzamUtasitas  = EmberiMod
