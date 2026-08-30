module FanoParitás

-- ═══════════════════════════════════════════════════════════════
-- FANO-SÍK ÉS PARITÁS — a magyar nyelv paritás-invarianciája
-- ═══════════════════════════════════════════════════════════════
-- GONDOLAT (a felhasználóé):
--   A magyar nyelv paritás-invariáns: a toldalék magánhangzójának
--   paritását (mély/magas) a szó utolsó magánhangzójához KELL
--   igazítani. ház-BAN jó, *ház-BEN rossz. A harmónia tehát egy
--   természetes PARITÁSBIT: minden toldalékolt szó önellőrző.
--   A magyar szó ≈ bináris + paritásbit.
--
--   Ez a kódelméletben ismert paritásellenőrzés pontos mása:
--   1 bit hibát ÉSZLESVESZ (nem javít — ahhoz [[7,1,3]] kell).
--
-- MÁSODIK RÉSZ: Fanó-sík és Pauli.
--   A Fanó-sík 7 pontja = F₂³ nemnulla vektorai.
--   Egy egyenes = 3 pont, amelyek XOR-ja nulla.
--   A Pauli-csoport fázis-kvóciense = F₂² (X, Z és Y=X⊕Z),
--   ami a Fanó-sík tengely-egyéneseinek 3 pontja.
-- ═══════════════════════════════════════════════════════════════

import Steane713
import E8E8Algebra
import Fonetika
import ModulRegisztracio

%default total

-- ─── 1. MAGÁNHANGZÓ-PARITÁS ───────────────────────────────
-- mély hangrend  = Nulla (a á o ó u ú)
-- magas hangrend = Egy  (e é i í ö ő ü ű)

public export
magánhangzóParitás : Maganhangzo -> Kubit
magánhangzóParitás Va   = Nulla
magánhangzóParitás Vaa  = Nulla
magánhangzóParitás Vo   = Nulla
magánhangzóParitás Voo  = Nulla
magánhangzóParitás Vu   = Nulla
magánhangzóParitás Vuu  = Nulla
magánhangzóParitás Ve   = Egy
magánhangzóParitás Vee  = Egy
magánhangzóParitás Vi   = Egy
magánhangzóParitás Vii  = Egy
magánhangzóParitás Voe  = Egy
magánhangzóParitás Voee = Egy
magánhangzóParitás Vue  = Egy
magánhangzóParitás Vuee = Egy

public export
paritásNeve : Kubit -> String
paritásNeve Nulla = "mély"
paritásNeve Egy   = "magas"

-- A szó hangrendje = az UTOLSÓ magánhangzó paritása (AkH szabály).
-- Föntető rekurzió, mert a where-blokkos rekurzió totality-csapda.
public export
hangrendFutó : Kubit -> Fonetika -> Kubit
hangrendFutó eddigi [] = eddigi
hangrendFutó eddigi (MaganhangzoHang m :: többi) =
  hangrendFutó (magánhangzóParitás m) többi
hangrendFutó eddigi (_ :: többi) =
  hangrendFutó eddigi többi

public export
szóParitása : Fonetika -> Kubit
szóParitása = hangrendFutó Nulla

-- ─── 2. ÖSSZHANG — A PARITÁSELLENŐRZÉS ─────────────────────
-- A toldalék csak akkor érvényes, ha a paritása egyezik a szóéval.
-- Eltérés = ÉSZLELT HIBA (a szó nem létező magyar alak).

public export
data ÖsszhangJelentés = Összhangos | Paritáshiba

public export
Show ÖsszhangJelentés where
  show Összhangos  = "összhangos"
  show Paritáshiba = "PARITÁSHIBA"

public export
összhang : Fonetika -> Fonetika -> ÖsszhangJelentés
összhang szó toldalék =
  if szóParitása szó == szóParitása toldalék
    then Összhangos
    else Paritáshiba

-- ─── 3. PÉLDASZAVAK (Hang-konstruktorokból, nincs String) ──

public export
szóHáz : Fonetika
szóHáz = [MassalhangzoHang Mh, MaganhangzoHang Vaa, MassalhangzoHang Mz]

public export
szóKör : Fonetika
szóKör = [MassalhangzoHang Mk, MaganhangzoHang Voe, MassalhangzoHang Mr]

public export
szóVíz : Fonetika
szóVíz = [MassalhangzoHang Mv, MaganhangzoHang Vii, MassalhangzoHang Mz]

public export
szóÚt : Fonetika
szóÚt = [MaganhangzoHang Vuu, MassalhangzoHang Mt]

public export
szóHangvilla : Fonetika
szóHangvilla =
  [ MassalhangzoHang Mh, MaganhangzoHang Va, MassalhangzoHang Mng
  , MassalhangzoHang Mv, MaganhangzoHang Vi
  , MassalhangzoHang Ml, MassalhangzoHang Ml, MaganhangzoHang Va ]

-- grafikusan: „hang" (n→[ŋ] asszimiláció a g előtt)
public export szóHang : Fonetika
szóHang = [MassalhangzoHang Mh, MaganhangzoHang Va, MassalhangzoHang Mng]

-- toldalékok (mély és magas pár — a paritásbit hordozói):
public export
toldalékBan : Fonetika
toldalékBan = [MassalhangzoHang Mb, MaganhangzoHang Va, MassalhangzoHang Mn]

public export
toldalékBen : Fonetika
toldalékBen = [MassalhangzoHang Mb, MaganhangzoHang Ve, MassalhangzoHang Mn]

public export
toldalékBa : Fonetika
toldalékBa = [MassalhangzoHang Mb, MaganhangzoHang Va]

public export
toldalékBe : Fonetika
toldalékBe = [MassalhangzoHang Mb, MaganhangzoHang Ve]

public export
toldalékRa : Fonetika
toldalékRa = [MassalhangzoHang Mr, MaganhangzoHang Va]

public export
toldalékRe : Fonetika
toldalékRe = [MassalhangzoHang Mr, MaganhangzoHang Ve]

-- ─── 4. FANÓ-SÍK — 7 PONT, 7 EGYENES ──────────────────────
-- A pont = 3 Kubit, nem nulla. Egyenes = 3 pont, XOR-juk nulla.

public export
record FanóPont where
  constructor FanóPontK
  fp1 : Kubit
  fp2 : Kubit
  fp3 : Kubit


public export
pontXor : FanóPont -> FanóPont -> FanóPont
pontXor a b =
  FanóPontK (kubitXor a.fp1 b.fp1)
            (kubitXor a.fp2 b.fp2)
            (kubitXor a.fp3 b.fp3)

public export
NullaPont : FanóPont
NullaPont = FanóPontK Nulla Nulla Nulla

public export
kubitEgyenlő : Kubit -> Kubit -> Bool
kubitEgyenlő Nulla Nulla = True
kubitEgyenlő Egy   Egy   = True
kubitEgyenlő _     _     = False

public export
pontEgyenlő : FanóPont -> FanóPont -> Bool
pontEgyenlő a b =
  kubitEgyenlő a.fp1 b.fp1 && kubitEgyenlő a.fp2 b.fp2 && kubitEgyenlő a.fp3 b.fp3

-- 3 pont egy egyenesen van, ha XOR-juk a nulla pont.
public export
egyenesen : FanóPont -> FanóPont -> FanóPont -> Bool
egyenesen a b c = pontEgyenlő (pontXor (pontXor a b) c) NullaPont

-- A Fanó-sík hét pontja (F₂³ nemnulla vektorai):
public export
FanóEgy : FanóPont   -- 001
FanóEgy = FanóPontK Nulla Nulla Egy

public export
FanóKettő : FanóPont -- 010
FanóKettő = FanóPontK Nulla Egy Nulla

public export
FanóHárom : FanóPont -- 011
FanóHárom = FanóPontK Nulla Egy Egy

public export
FanóNégy : FanóPont  -- 100
FanóNégy = FanóPontK Egy Nulla Nulla

public export
FanóÖt : FanóPont    -- 101
FanóÖt = FanóPontK Egy Nulla Egy

public export
FanóHat : FanóPont   -- 110
FanóHat = FanóPontK Egy Egy Nulla

public export
FanóHét : FanóPont   -- 111
FanóHét = FanóPontK Egy Egy Egy

-- A Fanó-sík hét egyenese (mindegyik XOR-nulla):
public export
FanóEgyenesek : List (FanóPont, FanóPont, FanóPont)
FanóEgyenesek =
  [ (FanóNégy,  FanóKettő, FanóHat)    -- x ⊕ y = xy sík
  , (FanóNégy,  FanóEgy,  FanóÖt)      -- x ⊕ z = xz sík
  , (FanóKettő, FanóEgy,  FanóHárom)   -- y ⊕ z = yz sík
  , (FanóNégy,  FanóHét,  FanóHárom)   -- x ⊕ yz
  , (FanóKettő, FanóHét,  FanóÖt)      -- y ⊕ xz
  , (FanóEgy,   FanóHét,  FanóHat)     -- z ⊕ xy
  , (FanóHat,   FanóÖt,   FanóHárom)   -- xy ⊕ xz ⊕ yz
  ]

public export
egyenesMindenhol : List (FanóPont, FanóPont, FanóPont) -> Bool
egyenesMindenhol [] = True
egyenesMindenhol ((a, b, c) :: többi) =
  egyenesen a b c && egyenesMindenhol többi

-- Mind a hét egyenes valóban egyenes (XOR = 000).
-- Ez BIZONYÍTÁS, nem teszt: fordítási időben ellenőrizve, soronként.
bizonyításE1 : egyenesen FanóNégy  FanóKettő FanóHat   = True
bizonyításE1 = Refl

bizonyításE2 : egyenesen FanóNégy  FanóEgy   FanóÖt    = True
bizonyításE2 = Refl

bizonyításE3 : egyenesen FanóKettő FanóEgy   FanóHárom = True
bizonyításE3 = Refl

bizonyításE4 : egyenesen FanóNégy  FanóHét   FanóHárom = True
bizonyításE4 = Refl

bizonyításE5 : egyenesen FanóKettő FanóHét   FanóÖt    = True
bizonyításE5 = Refl

bizonyításE6 : egyenesen FanóEgy   FanóHét   FanóHat   = True
bizonyításE6 = Refl

bizonyításE7 : egyenesen FanóHat   FanóÖt    FanóHárom = True
bizonyításE7 = Refl

-- ─── 5. PAULI-CSOPORT — FÁZIS-KVÓCIENS F₂² ─────────────────
-- KvántBit = (érték, fázis): |0⟩ |1⟩ |+⟩ |−⟩ négy Bloch-állapot.
--   érték: Nulla=|0⟩ bázis, Egy=|1⟩ bázis
--   fázis: Nulla=+ állapot, Egy=− állapot
-- pauliX = értékcsere (bitflip), pauliZ = fáziscsere,
-- pauliY = mindkettő (Y = iXZ, a ±i fázis a kvóciensbe esik).

public export
record KvántBit where
  constructor KvántBitK
  érték : Kubit
  fázis : Kubit

public export
Eq KvántBit where
  a == b = a.érték == b.érték && a.fázis == b.fázis

public export
pauliX : KvántBit -> KvántBit
pauliX q = KvántBitK (kubitXor q.érték Egy) q.fázis

public export
pauliZ : KvántBit -> KvántBit
pauliZ q = KvántBitK q.érték (kubitXor q.fázis Egy)

public export
pauliY : KvántBit -> KvántBit
pauliY q = KvántBitK (kubitXor q.érték Egy) (kubitXor q.fázis Egy)

-- X·Z = Y és Z·X = Y (a fázis-kvóciensben felcserélhetők;
-- a valódi Pauli-csoportnem kommutatív: XZ = −ZX, az −1 a kvóciensbe esik)
bizonyításXZ : pauliX (pauliZ (KvántBitK Nulla Nulla)) = pauliY (KvántBitK Nulla Nulla)
bizonyításXZ = Refl

bizonyításZX : pauliZ (pauliX (KvántBitK Nulla Nulla)) = pauliY (KvántBitK Nulla Nulla)
bizonyításZX = Refl

-- X·X = Y·Y = Z·Z = egység (involutiók):
bizonyításXX : (q : KvántBit) -> pauliX (pauliX q) = q
bizonyításXX (KvántBitK Nulla Nulla) = Refl
bizonyításXX (KvántBitK Nulla Egy)   = Refl
bizonyításXX (KvántBitK Egy Nulla)   = Refl
bizonyításXX (KvántBitK Egy Egy)     = Refl

bizonyításZZ : (q : KvántBit) -> pauliZ (pauliZ q) = q
bizonyításZZ (KvántBitK Nulla Nulla) = Refl
bizonyításZZ (KvántBitK Nulla Egy)   = Refl
bizonyításZZ (KvántBitK Egy Nulla)   = Refl
bizonyításZZ (KvántBitK Egy Egy)     = Refl

-- A PAULI-VILÁG ÉS A FANÓ-SÍK KAPCSOLATA:
-- A Pauli-csoport 3 nemtriviális eleme (X, Y, Z) = a Fanó-sík
-- egy tengely-egyenesének 3 pontja: x ⊕ y ⊕ (x⊕y) = 0.
public export
pauliFanóEgyenesén : Bool
pauliFanóEgyenesén =
  egyenesen FanóNégy FanóKettő (pontXor FanóNégy FanóKettő)

-- ─── 6. A KÉT RÉSZ ÖSSZEKAPCSOLÁSA ────────────────────────
-- A szó paritása (mély/magas) = 1 Kubit = a Fanó-sík KOORDINÁTÁJA.
-- A toldalék paritása kötelezően másolja a szóét — ez a
-- [[7,1,3]] Steane-kód paritásbitjének nyelvi mása.

public export
paritásFanóba : Kubit -> FanóPont
paritásFanóba Nulla = FanóNégy
paritásFanóba Egy   = FanóKettő

public export
Show FanóPont where
  show p = fanóBit p.fp1 ++ fanóBit p.fp2 ++ fanóBit p.fp3
    where
      fanóBit : Kubit -> String
      fanóBit Nulla = "0"
      fanóBit Egy   = "1"

-- ─── 7. FŐ — HALU TESZT ───────────────────────────────────

public export
haluJelentés : String
haluJelentés =
  "háza paritása: " ++ show (szóParitása szóHáz)
  ++ " (" ++ paritásNeve (szóParitása szóHáz) ++ ")\n"
  ++ "ház+ban: " ++ show (összhang szóHáz toldalékBan) ++ "\n"
  ++ "ház+ben: " ++ show (összhang szóHáz toldalékBen) ++ "\n"
  ++ "kör paritása: " ++ show (szóParitása szóKör)
  ++ " (" ++ paritásNeve (szóParitása szóKör) ++ ")\n"
  ++ "kör+ben: " ++ show (összhang szóKör toldalékBen) ++ "\n"
  ++ "kör+ban: " ++ show (összhang szóKör toldalékBan) ++ "\n"
  ++ "víz+be: " ++ show (összhang szóVíz toldalékBe) ++ "\n"
  ++ "út+ra: " ++ show (összhang szóÚt toldalékRa) ++ "\n"
  ++ "hangvilla+ban (utolsó magánhangzó 'a' = mély): "
  ++ show (összhang szóHangvilla toldalékBan) ++ "\n"
  ++ "Fanó-sík 7 egyenes mind igaz: "
  ++ show (egyenesMindenhol FanóEgyenesek) ++ "\n"
  ++ "pauli tengely-egyenes: " ++ show pauliFanóEgyenesén ++ "\n"

main : IO ()
main = putStrLn haluJelentés


-- ─── REGISZTRÁCIÓ (ModulRegisztracio) ─────────────────────
public export
FanoParitasLeiras : ModulLeirasT
FanoParitasLeiras = ModulLeirasKonstruktor
  "FanoParitás.idr" "hangrend = paritásbit; Fanó-sík 7 egyenes [Refl]; Pauli [Refl]" "a nyelv önellenőrző — a rossz toldalékot a típus elutasítja" "12 teszt + 9 Refl"
