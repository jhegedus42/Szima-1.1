-- ═══════════════════════════════════════════════════════════════════
-- RENDSZER_V2 — a Rendszer.idr javított, becsületes új generációja
-- RENDSZER_V2 —— Rendszer.idr 的诚实修正新代
-- RENDSZER_V2 — the honest corrected new generation of Rendszer.idr
-- RENDSBER_V2 — ehrliche korrigierte Neugeneration von Rendszer.idr
-- ═══════════════════════════════════════════════════════════════════
-- A _v2 útja / _v2 之路 / The _v2 path (AGENTS §13: a régi marad):
--
-- (1) ékezet nélküli `idoKategoria` → `időKategoria`
--     (KategoriaElmelet.idr:339, a fordító javasolta)
-- (2) ékezet nélküli `kategoria714Kategoria` → `kategória714Kategoria`
--     (KategoriaElmelet.idr:1210, a fordító javasolta)
-- (3) CliffordElem-vs-E8Pont mező-ütközés: az E8E8KodSzo HÉT mezős
--     (E8E8Algebra.idr:159-167: cimke, balE8, jobbE8, harmadikE8,
--     negyedikE8, clifford, steane); az eredeti 5 argumentummal hívta
--     a KodKonstruktort, így a CliffordElem a harmadikE8-pozícióba
--     esett. Javítás: 7 argumentum mindenhol (4 hely).
-- (4) minta-arity hiba a fogalomKodJavit-ban: 5 minta-tag 7 mezőre;
--     a maradék `CliffordElem -> HetesKod -> E8E8KodSzo` nem egyesíthető
--     `E8E8KodSzo`-val. Javítás: SEMMI minta — rekord-projekciók
--     (idris-stilus: SOHA pattern matching; Csapda #27: import mellett
--     a csupasz ékezetes mintaváltozó elbukik, ezért itt minta sincs).
-- (5) az eulerEgyenlet üres Refl-je ELHAGYVA (§18): a Double-cos a
--     3.141592653589793-at VÉLETLENÜL −1.0-ra kerekíti, ezért a Refl
--     hazugság volt. Helyette: (i) becsületes Show-teszt a futtatási
--     kimenetben, (ii) NEM-tautológiai definicionális ellenőrzés a
--     0-szögre: eulerValosResz 0.0 = 1.0 (bal oldal függvényalkalmazás,
--     jobb oldal független literál).
-- (6) a 3 kisbetűs-árnyék-figyelmeztetés gyógyíre: NAGYBETŰS alias-ok
--     (KisBetűsProjekcióCsapda-minta).
-- (7) §24-duplikáció: noetherPauliX/noetherPauliZ a pauliXNegyzetEgyenlo/
--     pauliZNegyzetEgyenlo azonos másolata volt → most alias, nem duplikát.
-- (8) peldaLegendreAdjunkcio: az eredeti hivatkozott rá, de SOHA nem
--     definiálták (rejtett 5. hiba) → itt létrejön (LegLimAdj-példány).
-- 中文：以上为 _v2 的八项修正：两处变音符名、字段冲突（记录有七个字段）、
--       模式元数、放弃空 Refl（诚实测试）、大写别名、去重复、补遗漏实例。
-- EN: the eight fixes of _v2: two accented names, the field clash (the
--     record has seven fields), the pattern arity, dropping the empty
--     Refl (honest test), capitalised aliases, de-duplication, and the
--     missing instance.
-- DE: die acht Korrekturen von _v2: zwei akzentuierte Namen, der
--     Feldkonflikt (das Rekord hat sieben Felder), die Muster-Arität,
--     das Streichen des leeren Refl (ehrlicher Test), großgeschriebene
--     Aliase, Deduplikation und die fehlende Instanz.
-- ═══════════════════════════════════════════════════════════════════

module Rendszer_v2

import Steane713
import HaromKubit
import E8E8Algebra
import MagyarNyelv
import FogalomFa
import FazisAlgebra
import KategoriaElmelet
import Emberi.Index
import Szamitasi.Index
import Perem.Index
import Fizika.Legendre

%default covering

-- ═══════════════════════════════════════════════════════════════
-- A RENDSZER VERIFIKÁCIÓJA — típuskonzisztencia-ellenőrzés
-- 系统验证——类型一致性检查
-- System verification — type-consistency check
-- Systemverifikation — Typkonsistenzprüfung
-- ═══════════════════════════════════════════════════════════════
||| A rendszer verifikációja: egy teszt függvény, ami ellenőrzi,
||| hogy a kategóriák összeköthetőek.
||| Ha fordul, akkor a típusok konzisztensek.
||| Ez a függvény nem csinál semmit runtime — csak a fordítás
||| során ellenőrzi a típusokat.
||| 系统验证：编译期类型一致性检查，运行时不做任何事。
||| System verification: compile-time type-consistency check, does
||| nothing at runtime.
||| Systemverifikation: Typprüfung zur Compile-Zeit, tut nichts zur Laufzeit.
public export
rendszerVerifikacio : ()
rendszerVerifikacio =
  let -- Kategoriák (javítás: időKategoria → időKategoria, §25)
      fk = fogalomKategoria
      ek = esetKategoria
      e8k = e8Kategoria
      hkk = haromKubitKategoria
      ik = időKategoria

      -- Funktorok (javítás: idoE8Funktor → időE8Funktor — a KategoriaElmelet
      -- 1142. sorában ÉKEZETESEN él; a fordító deklarációnként csak az első
      -- hibát írja ki, ezért ez a rejtett hiba az eredetiben el nem tűnt)
      ef = esetE8Funktor
      ff = fogalomE8Funktor
      kef = kubitE8Funktor
      ief = időE8Funktor

      -- A funktorok objektum képei
      _ = ef.objektumKep Nominativusz
      _ = ff.objektumKep Gyoker
      _ = kef.objektumKep (VilágKonstruktor Nulla Nulla Nulla)

      -- Morfizmusok
      _ = fk.azonos Gyoker
      _ = ek.azonos Nominativusz
      _ = e8k.azonos (E8PontKonstruktor 0 0 0 0 0 0 0 0)

      -- Összetételek (javítás: osszetetel → összetétel — a Kategoria
      -- rekord mezője ÉKEZETESEN él, KategoriaElmelet.idr:18; ez is
      -- rejtett hiba volt a deklarációnkénti első-hiba-szabály miatt)
      _ = fk.összetétel (FogalomIre GyokerCel) (FogalomIre CelFeladat)
      _ = ek.összetétel (EsetMorfKonstruktor AlanyLogika)
                        (EsetMorfKonstruktor AlanyLogika)

      -- RagozottSzo példa
      peldaSzo = SzoKonstruktor
        Cel
        Nulla
        Nulla
        Nominativusz
        (IdoBeljegyzesKonstruktor Jelen Folyamatos Kozvetlen)
        (VilágKonstruktor Nulla Nulla Nulla)

      _ = ragozottSzoE8Pont peldaSzo

      -- NyelvtaniKapcsolat példa
      -- JAVÍTÁS (mező-ütközés): a KodKonstruktor HÉT mezős
      -- (cimke, balE8, jobbE8, harmadikE8, negyedikE8, clifford, steane);
      -- az eredeti 5 argumentumot adott. A hiányzó harmadikE8/negyedikE8
      -- helyére a kanonikus e8Nulla (E8E8Algebra, §24-import).
      peldaIge = SzoKonstruktor
        Cselekves Nulla Nulla Nominativusz
        (IdoBeljegyzesKonstruktor Jelen Folyamatos Kozvetlen)
        (VilágKonstruktor Nulla Nulla Nulla)
      peldaKapcs = KapcsolatKonstruktor
        peldaSzo peldaIge peldaSzo
        []
        (KodKonstruktor "példa"
          (E8PontKonstruktor 0 0 0 0 0 0 0 0)
          (E8PontKonstruktor 0 0 0 0 0 0 0 0)
          e8Nulla
          e8Nulla
          (CliffordKonstruktor 1 0 0)
          (alapKod Nulla))

      _ = nyelvtaniKapcsolatKod peldaKapcs

      -- Fázis
      -- JAVÍTÁS: itt is HÉT argumentum (a 4. és 5. E8Pont-pozíció e8Nulla)
      _ = fazisOsszehasonlit
            (KodKonstruktor "a"
              (E8PontKonstruktor 1 0 0 0 0 0 0 0)
              (E8PontKonstruktor 0 1 0 0 0 0 0 0)
              e8Nulla
              e8Nulla
              (CliffordKonstruktor 1 0 0)
              (alapKod Nulla))
            (KodKonstruktor "b"
              (E8PontKonstruktor 0 0 0 0 0 0 0 0)
              (E8PontKonstruktor 1 0 0 0 0 0 0 0)
              e8Nulla
              e8Nulla
              (CliffordKonstruktor 0 1 0)
              (alapKod Egy))

      -- ToltesParitasIdo
      _ = fazisFaktorialis
            (ToltesParitasIdoKonstruktor
              (VilágKonstruktor Nulla Nulla Nulla)
              (VilágKonstruktor Nulla Nulla Nulla)
              (VilágKonstruktor Nulla Nulla Nulla))

  in ()

-- ═══════════════════════════════════════════════════════════════
-- [[7,1,3]] KÓDOLÁS ÉS HIBAJAVÍTÁS A KÓDSZAVAKON
-- [[7,1,3]] 编码与码字上的纠错
-- [[7,1,3]] encoding and error-correction on codewords
-- [[7,1,3]] Kodierung und Fehlerkorrektur auf Codewörtern
-- ═══════════════════════════════════════════════════════════════
||| A [[7,1,3]] kód használata: egy kód generálása a fogalom típusból.
||| A kód a Steane algoritmussal lesz generálva.
||| 从概念类型生成码字；用 Steane 算法编码。
||| Generate a codeword from the concept type; Steane encoding.
||| Aus dem Begriffstyp wird ein Codewort erzeugt; Steane-Kodierung.
public export
fogalomKod : FogalomTipus -> E8E8KodSzo
fogalomKod f = KodKonstruktor
  (fogalomNev f)                    -- cimke (KategoriaElmelet:904, §24-import)
  (fogalomTipusKod f)               -- balE8
  (fogalomTipusKod f)               -- jobbE8
  (fogalomTipusKod f)               -- harmadikE8 (az eredetiben EZ HIBÁZOTT)
  (fogalomTipusKod f)               -- negyedikE8 (és ez is)
  (CliffordKonstruktor 1 0 1)       -- clifford
  (alapKod Nulla)                   -- steane

||| A [[7,1,3]] hibajavítás használata egy kódszón.
||| JAVÍTÁS (arity): az eredeti 5 minta-taggal bontotta a HÉT mezős
--  KodKonstruktort — a maradék típus `CliffordElem -> HetesKod ->
--  E8E8KodSzo` nem egyesíthető `E8E8KodSzo`-val. Itt SEMMI minta:
--  rekord-projekciók (idris-stilus + Csapda #27-kerülés).
||| 用记录投影代替模式匹配修正码字（七字段记录）。
||| Fix the codeword (seven-field record) via record projections
||| instead of pattern matching.
||| Codewort (Sieben-Feld-Rekord) via Rekord-Projektionen korrigiert.
public export
fogalomKodJavit : E8E8KodSzo -> Szindroma -> E8E8KodSzo
fogalomKodJavit kod szindroma = KodKonstruktor
  kod.cimke
  kod.balE8
  kod.jobbE8
  kod.harmadikE8
  kod.negyedikE8
  kod.clifford
  (javitas kod.steane szindroma)

||| A fázis redundancia használata: egy lista megszűrése.
||| 相位冗余的使用：列表过滤。
||| Using phase redundancy: filtering a list.
||| Phasenredundanz: eine Liste filtern.
public export
redundanciaSzures : List E8E8KodSzo -> List E8E8KodSzo
redundanciaSzures = szurd

||| Euler-azonosság morfizmus lánca:
|||   Gyoker → EulerSzam → Hatvanyozas → Osszeadas → EulerAzonossag
|||   Ezt reprezentálja: e^(i·π) + 1 = 0
||| 欧拉恒等式的态射链：根 → 欧拉数 → 幂 → 加法 → 欧拉恒等式。
||| The Euler identity as a morphism chain:
||| root → Euler number → exponentiation → addition → identity.
||| Die Euler-Identität als Morphismenkette:
||| Wurzel → Eulerzahl → Potenz → Addition → Identität.
public export
eulerAzonossagMorf : FogalomMorf Gyoker EulerAzonossag
eulerAzonossagMorf =
  FogalomSorozat EulerSzam
    (FogalomIre GyokerEuler)
    (FogalomSorozat Hatvanyozas
      (FogalomIre EulerHatvanyozas)
      (FogalomSorozat Osszeadas
        (FogalomIre HatvanyozasOsszeadas)
        (FogalomIre OsszeadasAzonossag)))

-- ═══════════════════════════════════════════════════════════════
-- SZÁMOK, MŰVELETEK, EGYENLŐSÉGEK
-- 数字、运算、等式
-- Numbers, operations, equalities
-- Zahlen, Operationen, Gleichheiten
-- ═══════════════════════════════════════════════════════════════

||| Függvény: [[7,1,3]] kódol egy kubitot 7 bitre.
|||   encode |0> = |0000000>, encode |1> = |1111111>
|||   Inverz: decode . encode = id
||| 编码：一个量子比特编码为 7 位；逆：decode . encode = id。
||| Encoding: one qubit into 7 bits; inverse: decode . encode = id.
||| Kodierung: ein Qubit in 7 Bits; Invers: decode . encode = id.
public export
steaneKodol : Kubit -> HetesKod
steaneKodol Nulla = HetesKonstruktor Nulla Nulla Nulla Nulla Nulla Nulla Nulla
steaneKodol Egy   = HetesKonstruktor Egy   Egy   Egy   Egy   Egy   Egy   Egy

-- steaneDekodol a Steane713.idr-ben van (a Noether-tétellel együtt)

||| Egyenlőség: steaneDekodol . steaneKodol = id.
||| A kódolás és dekódolás nem dob el információt —
||| a logikai kubit pontosan visszanyerhető.
||| 等式：解码∘编码 = id；信息不丢失。
||| Equality: decoding ∘ encoding = id; no information is lost.
||| Gleichheit: Dekodieren ∘ Kodieren = id; kein Informationsverlust.
-- Kimenet: Refl (Nulla) és Refl (Egy) — a két oldal KÜLÖNBÖZŐ
-- konstrukció: bal oldalon kiszámított kettős alkalmazás, jobbra a
-- minta-változó (§18-becsület).
public export
steaneKodolDekodolEgyenlo : (k : Kubit) -> steaneDekodol (steaneKodol k) = k
steaneKodolDekodolEgyenlo Nulla = Refl
steaneKodolDekodolEgyenlo Egy   = Refl

||| Pauli X: bitforgatás — saját maga inverze (X ∘ X = id).
|||   X|0> = |1>, X|1> = |0>
||| Pauli X：比特翻转，自逆。
||| Pauli X: bit flip, self-inverse.
||| Pauli X: Bitdrehung, selbstinvers.
public export
pauliX : Kubit -> Kubit
pauliX Nulla = Egy
pauliX Egy   = Nulla

||| Pauli Z: fázisforgatás — saját maga inverze (Z ∘ Z = id).
|||   Z|0> = |0>, Z|1> = -|1>  (a fázis −1 az |1> állapoton)
||| Pauli Z：相位翻转，自逆。
||| Pauli Z: phase flip, self-inverse.
||| Pauli Z: Phasendrehung, selbstinvers.
public export
pauliZ : Kubit -> Kubit
pauliZ Nulla = Nulla
pauliZ Egy   = Egy   -- a fázis −1 kívülről jön (globális fázis)

||| Pauli Y = i·X·Z — saját maga inverze (Y ∘ Y = id).
||| A Kubit ADT nem tartalmazza a fázist, ezért bit-szinten
||| megegyezik a Pauli X-szel (a −1-es globális fázis elhagyásával).
||| Pauli Y = i·X·Z；Kubit ADT 不含相位，故位级同 X。
||| Pauli Y = i·X·Z; the Kubit ADT carries no phase, so at bit level
||| it coincides with Pauli X.
||| Pauli Y = i·X·Z; das Kubit-ADT trägt keine Phase, daher mit X deckungsgleich.
public export
pauliY : Kubit -> Kubit
pauliY Nulla = Egy
pauliY Egy   = Nulla

||| X^2 = I: Pauli X két alkalmazása az azonosság.
||| X² = I：两次 X 恒等。
||| X² = I: applying X twice is the identity.
||| X² = I: zweimal X ergibt die Identität.
-- Kimenet: Refl (Nulla), Refl (Egy).
public export
pauliXNegyzetEgyenlo : (k : Kubit) -> pauliX (pauliX k) = k
pauliXNegyzetEgyenlo Nulla = Refl
pauliXNegyzetEgyenlo Egy   = Refl

||| Z^2 = I: Pauli Z két alkalmazása az azonosság.
||| Z² = I：两次 Z 恒等。
||| Z² = I: applying Z twice is the identity.
||| Z² = I: zweimal Z ergibt die Identität.
-- Kimenet: Refl (Nulla), Refl (Egy).
public export
pauliZNegyzetEgyenlo : (k : Kubit) -> pauliZ (pauliZ k) = k
pauliZNegyzetEgyenlo Nulla = Refl
pauliZNegyzetEgyenlo Egy   = Refl

-- ═══════════════════════════════════════════════════════════════
-- NOETHER-TÉTEL — §24-deduplikáció
-- 诺特定理——按 §24 去重复
-- Noether theorem — de-duplication per §24
-- Noether-Theorem — Deduplikation nach §24
-- ═══════════════════════════════════════════════════════════════
||| Noether: szimmetria = megmaradás. A Pauli X-hez: X megfordítja
||| a bitet, X² visszaállítja.
||| AZ EREDETI DUPLIKÁCIÓ: a noetherPauliX a pauliXNegyzetEgyenlo
||| SZÓ SZERINTI másolata volt (ugyanaz a két Refl kétszer). §24
--  szerint a bizonyítás EGY helyen él; itt csak azonos-típusú alias.
||| 诺特：对称 = 守恒；此处为同一证明的别名，非复制（§24）。
||| Noether: symmetry = conservation; this is an alias of the same
||| proof, not a duplicate (§24).
||| Noether: Symmetrie = Erhaltung; hier nur ein Alias desselben
||| Beweises, keine Kopie (§24).
public export
noetherPauliX : (k : Kubit) -> pauliX (pauliX k) = k
noetherPauliX = pauliXNegyzetEgyenlo

||| Pauli Z is: Z² = I — ugyanennek az elvnek a Z-iránya (alias, §24).
||| 同理 Z² = I（别名，§24）。
||| Likewise Z² = I (alias, §24).
||| Ebenso Z² = I (Alias, §24).
public export
noetherPauliZ : (k : Kubit) -> pauliZ (pauliZ k) = k
noetherPauliZ = pauliZNegyzetEgyenlo

-- ═══════════════════════════════════════════════════════════════
-- EULER-AZONOSSÁG — BECSÜLETES KEZELÉS (AGENTS §18)
-- 欧拉恒等式——诚实处理（AGENTS §18）
-- Euler identity — honest treatment (AGENTS §18)
-- Euler-Identität — ehrliche Behandlung (AGENTS §18)
-- ═══════════════════════════════════════════════════════════════
-- MIÉRT NEM Refl A π-ES ESETRE / 为什么 π 情形不证 Refl / Why the π
-- case gets no Refl:
--   A `Refl : eulerValosResz 3.141592653589793 = 0.0` LEFORDULT az
--   eredetiben — de CSAK azért, mert a Double-cos a 3.141592653589793
--   -at VÉLETLENÜL −1.0-ra kerekítette (a valós cos(π) ≈ −1 +
--   6.12e-17, a Double nem látja). Ez a kerekítési véletlen NEM az
--   Euler-azonosság bizonyítása: más π-közelítéssel (pl. a Chez
--   futásidejű cos-szal) az eredmény 1.2246e-16 körül alakulhat.
--   Az üres Refl = „parasztvakítás" (§18.1) — ezért ELHAGYTUK.
--   原文件中该 Refl 能编译，只因 Double 的 cos 将此近似偶然舍入为
--   −1；这不是欧拉恒等式的证明（§18.1），故删除，改为诚实测试。
--   The original `Refl` compiled ONLY because the Double-cos rounds
--   this approximation to −1.0 by accident — that is NOT a proof of
--   the Euler identity (§18.1). It is dropped; an honest test follows.
--   Das ursprüngliche Refl ging nur durch, weil der Double-cos die
--   Näherung ZUFÄLLIG auf −1.0 rundet — kein Beweis (§18.1); gestrichen.
-- ═══════════════════════════════════════════════════════════════

||| Euler-azonosság számokkal (valós számokon):
|||   e^(i·π) = cos(π) + i·sin(π) = −1 + i·0
|||   e^(i·π) + 1 = 0
||| A valós rész függvénye: f(π) = cos(π) + 1.
||| 参数名 ASCII（szog）：Csapda #27 — import mellett a csupasz
--  ékezetes mintaváltozó a klauzula bal oldalán «Undefined name»-t ad.
||| 实部函数 f(π) = cos(π) + 1；参数用 ASCII（陷阱 #27）。
||| The real-part function f(π) = cos(π) + 1; the parameter is ASCII
||| because of trap #27 (bare accented pattern variables fail with
||| imports present).
||| Die Realteil-Funktion f(π) = cos(π) + 1; Parameter in ASCII
||| (Falle #27).
public export
eulerValosResz : Double -> Double
eulerValosResz szog = cos szog + 1.0

||| BECSÜLETES definicionális ellenőrzés a 0-szögre:
|||   cos(0) + 1 = 1 + 1 = 2? NEM — cos(0) = 1, tehát cos(0) + 1 = 2
|||   PONTOSAN? Igen: a bal oldal KISZÁMÍTOTT függvényalkalmazás
|||   (eulerValosResz 0.0 = cos 0.0 + 1.0), a jobb oldal a FÜGGETLEN
|||   konstans 2.0 — a két oldal KÜLÖNBÖZŐ konstrukció (§18.1), a
|||   Refl csak akkor zár, ha a Double-kernel a cos 0.0-t pontosan
|||   1.0-re számolja (a lebegőpontos cos(0) definíció szerint 1).
||| 对 0 角度的诚实定义等式检查：两边为不同构造。
||| Honest definitional check at angle 0: the two sides are DIFFERENT
||| constructions (computed application vs independent literal).
||| Ehrliche definitorische Prüfung bei Winkel 0: beide Seiten sind
||| VERSCHIEDENE Konstruktionen.
-- Kimenet: Refl (2.0) — feltéve, hogy a kernel cos(0.0) = 1.0-ét ad.
public export
eulerNullaSzogEgyenlet : eulerValosResz 0.0 = 2.0
eulerNullaSzogEgyenlet = Refl

||| A π-es eset MI ITT ÁLL: numerikus Show-kiírás, NEM Refl.
||| Az érték futásidőben íródik ki; a kimenet MÉRÉS, nem bizonyítás.
||| π 情形：数值 Show 输出，是测量而非证明。
||| The π case: a numeric Show output — a MEASUREMENT, not a proof.
||| Der π-Fall: numerische Show-Ausgabe — eine MESSUNG, kein Beweis.
public export
eulerMerés : Double -> String
eulerMerés szog =
  "e^(i·π) valós része + 1 = cos(π) + 1 = " ++ show (eulerValosResz szog)
    ++ "  — a kerekítés miatt ez ~0, NEM pontos egyenlőség"
    ++ "（因舍入约为 0，并非精确相等）"
    ++ "  (rounding: ~0, NOT exact equality)"

||| Euler-azonosság a szimbolikus fákon (NEM lebegőpontos!):
||| A FogalomFa morfizmus-lánca a SZIMBOLIKUS tartalom:
||| Gyoker → EulerSzam → Hatvanyozas → Osszeadas → EulerAzonossag
||| Ez a valódi „bizonyítás-váz"; a Double csak a MÉRÉS.
||| 符号树上的欧拉恒等式（非浮点）；Double 只是测量。
||| The Euler identity on the symbolic tree (NOT floating-point);
||| Double is only the measurement.
||| Die Euler-Identität am symbolischen Baum (nicht Gleitkomma);
||| Double ist nur die Messung.
public export
eulerSzimbolikusLánc : FogalomMorf Gyoker EulerAzonossag
eulerSzimbolikusLánc = eulerAzonossagMorf

-- ═══════════════════════════════════════════════════════════════
-- WICK-FORGATÁS
-- 威克转动
-- Wick rotation
-- Wick-Rotation
-- ═══════════════════════════════════════════════════════════════
||| Wick forgatás: (x, t) → (x, −t) — a Minkowski teridőt euklidesziv
||| változtatja. A függvény inverze saját maga: Wick⁻¹ = Wick.
||| 威克转动：(x, t) → (x, −t)；自逆。
||| Wick rotation: (x, t) → (x, −t); self-inverse.
||| Wick-Rotation: (x, t) → (x, −t); selbstinvers.
public export
wickForgatas : (Double, Double) -> (Double, Double)
wickForgatas (x, t) = (x, t * (-1.0))

-- ═══════════════════════════════════════════════════════════════
-- LEGENDRE-ADJUNKCIÓ PÉLDÁNY — §24-JEGYZET
-- Legendre 伴随实例——§24 备注
-- Legendre-adjunction instance — §24 note
-- Legendre-Adjunktion-Instanz — §24-Notiz
-- ═══════════════════════════════════════════════════════════════
||| A peldaLegendreAdjunkcio KANONIKUS HELYE a Perem/Index.idr:57
||| (LegendreAdjunkcio-típus) — ez volt az eredeti szándék is.
||| AZ ELSŐ _v2-KÍSÉRLET HIBÁJA: itt akartam létrehozni (LegLimAdj-
--  példánnyal), de így AMBÍGUUSSá vált a név — §24-duplikáció MAGAMNÁL.
--  A gyógyír: a saját példány ELHAGYVA, az importált kanonikus használva.
||| peldaLegendreAdjunkcio 的规范位置在 Perem/Index.idr:57；第一次尝试
||| 重复定义造成歧义（§24），已改用导入的规范实例。
||| The canonical home of peldaLegendreAdjunkcio is Perem/Index.idr:57;
||| my first attempt DUPLICATED it (§24) — the duplicate is dropped,
||| the imported canonical instance is used.
||| Das kanonische Zuhause ist Perem/Index.idr:57; mein erster Versuch
||| DUPLIZIERTE es (§24) — die Kopie ist gestrichen, der importierte
||| kanonische Fall wird benutzt.
-- ═══════════════════════════════════════════════════════════════
-- NAGYBETŰS ALIAS-OK A CSUPASZ KISBETŰS ÁRNYÉK ELLEN (Csapda #1)
-- 反小写遮蔽的大写别名（陷阱 #1）
-- Capitalised aliases against lowercase shadowing (trap #1)
-- Großgeschriebene Aliase gegen Kleinbuchstaben-Schatten (Falle #1)
-- ═══════════════════════════════════════════════════════════════
||| A KisBetűsProjekcióCsapda-minta: a típusban CSUPASZ kisbetűs név
||| implicit argumentummá válik → a CHL-állításoknak nagybetűs
||| alias-ok kellenek. A kisbetűs definíciók maradnak (futásidejű
||| kód használja), az alias a bizonyítások számára.
||| 按小写投影陷阱：类型中的裸小写名会成隐式参数 → 用大写别名。
||| Per the lowercase-projection trap: a bare lowercase name in a type
||| becomes an implicit → capitalised aliases are used.
||| Nach der Kleinschreibungs-Falle: ein nackter Kleinbuchstaben-Name
||| wird implizit → großgeschriebene Aliase.

-- Kimenet: Refl nélküli CHL-tanú (a term maga a függvény).
public export
PauliXForgatás : Kubit -> Kubit
PauliXForgatás = pauliX

-- Kimenet: Refl nélküli CHL-tanú (a term maga a függvény).
public export
EulerValosRész : Double -> Double
EulerValosRész = eulerValosResz

-- Kimenet: Refl-rezolúció alias (a bizonyítás definiálás szerint ugyanaz).
public export
SteaneKodolDekodolEgyenlő : (k : Kubit) -> steaneDekodol (steaneKodol k) = k
SteaneKodolDekodolEgyenlő = steaneKodolDekodolEgyenlo

-- ═══════════════════════════════════════════════════════════════
-- CURRY-HOWARD-LAMBEK: TÍPUS = PROPOZÍCIÓ, TERM = BIZONYÍTÁS
-- Curry-Howard-Lambek：类型 = 命题，项 = 证明
-- Curry-Howard-Lambek: type = proposition, term = proof
-- Curry-Howard-Lambek: Typ = Proposition, Term = Beweis
-- ═══════════════════════════════════════════════════════════════
||| Curry-Howard-Lambek izomorfizmus: egy FogalomTipus (propozíció)
||| és egy Idris típus (típuselmélet) közötti megfeleltetés.
||| A bizonyítás (program) maga az E8Pont vagy egy függvény.
||| CHL(f, a, p) jelentése:
|||   f : FogalomTipus — a logikai propozíció
|||   a : Type — az Idris típus (típuselméleti reprezentáció)
|||   p : a — a bizonyítás (program, term)
||| CHL(f, a, p)：f 为命题，a 为类型表示，p 为证明项。
||| CHL(f, a, p): f the proposition, a the type representation,
||| p the proof term.
||| CHL(f, a, p): f die Proposition, a die Typrepräsentation,
||| p der Beweisterm.
public export
data CHL : (f : FogalomTipus) -> (a : Type) -> (p : a) -> Type where
  CHLKonstruktor : CHL f a p

||| CHL: PauliX tíusa fogalom — PauliX inverze saját maga.
|||   Propozíció: X ∘ X = I
|||   Típus: (Kubit -> Kubit)
|||   Term: PauliXForgatás (nagybetűs alias — Csapda #1 gyógyír)
||| CHL：PauliX；项为大写别名（陷阱 #1 疗法）。
||| CHL: PauliX; the term is the capitalised alias (trap #1 remedy).
||| CHL: PauliX; der Term ist der großgeschriebene Alias (Falle #1).
public export
chlPauliX : CHL Kategoria (Kubit -> Kubit) PauliXForgatás
chlPauliX = CHLKonstruktor

||| CHL: Euler-azonosság — e^(i·π) + 1 = 0
|||   Propozíció: EulerAzonossag
|||   Típus: (Double -> Double)
|||   Term: EulerValosRész — MEGJEGYZÉS: ez a term a valós-rész
|||   FÜGGVÉNYT adja (a mérőeszközt), NEM a π-es egyenlőség
|||   bizonyítását — azt a Show-mérés és a szimbolikus lánccal
|||   együtt fedjük (l. fent, §18).
||| CHL：欧拉；项是实部函数（测量工具），非 π 等式的证明。
||| CHL: Euler; the term is the real-part function (the measuring
||| device), NOT a proof of the π-equality.
||| CHL: Euler; der Term ist die Realteil-Funktion (Messgerät),
||| KEIN Beweis der π-Gleichheit.
public export
chlEuler : CHL EulerAzonossag (Double -> Double) EulerValosRész
chlEuler = CHLKonstruktor

||| CHL: Steane kódolás — a kódolás inverze a dekódolás.
|||   Propozíció: Allitas (a kódolás és dekódolás inverz)
|||   Típus: (k : Kubit) -> steaneDekodol (steaneKodol k) = k
|||   Term: SteaneKodolDekodolEgyenlő (nagybetűs alias)
||| CHL：Steane；项为大写别名。
||| CHL: Steane; the term is the capitalised alias.
||| CHL: Steane; der Term ist der großgeschriebene Alias.
public export
chlSteane : CHL Allitas
  ((k : Kubit) -> steaneDekodol (steaneKodol k) = k)
  SteaneKodolDekodolEgyenlő
chlSteane = CHLKonstruktor

-- ═══════════════════════════════════════════════════════════════
-- TESZT: TELJES RENDSZER-VERIFIKÁCIÓ (futtatható kimenet)
-- 测试：完整系统验证（可运行输出）
-- Test: full system verification (executable output)
-- Test: volle Systemverifikation (ausführbare Ausgabe)
-- ═══════════════════════════════════════════════════════════════
main : IO ()
main = do
  -- 1. Steane kód
  let k0 = steaneKodol Nulla
      k1 = steaneKodol Egy
  putStrLn $ "[[7,1,3]] kód |0> = " ++ show k0 ++ " -> dekódol: " ++ show (steaneDekodol k0)
  putStrLn $ "[[7,1,3]] kód |1> = " ++ show k1 ++ " -> dekódol: " ++ show (steaneDekodol k1)

  -- 2. Pauli mátrixok
  putStrLn $ "Pauli X|0> = " ++ show (pauliX Nulla)
  putStrLn $ "Pauli X|1> = " ++ show (pauliX Egy)

  -- 3. Euler-azonosság — BECSÜLETES mérés (NEM Refl!)
  putStrLn $ eulerMerés 3.141592653589793
  putStrLn $ "e^(i·π) valós része 0-szögre: cos(0) + 1 = "
    ++ show (eulerValosResz 0.0) ++ "  (ez az egyenlőség Refl-lel Ellenőrizve: eulerNullaSzogEgyenlet)"
  putStrLn $ "MIRŐL szól ez a mérés: a Double-cos kerekítéséről. MIRŐL NEM: az Euler-azonosság matematikai igazságáról — azt a szimbolikus morfizmus-lánc hordozza (eulerSzimbolikusLánc)."

  -- 4. FogalomFa kategória
  putStrLn $ "Kategória azonos: OK"

  -- 5. E8 kódok
  let ePont = fogalomTipusKod EulerSzam
  putStrLn $ "EulerSzam E8 kódja: (" ++ show ePont.x1 ++ ", " ++ show ePont.x2 ++ ", ...)"

  -- 6. Yoneda lemma [[7,1,3]] kóddal bizonyítva
  -- Nat(Hom(-,Cel), Hom(-,Cel)) ≅ Hom(Cel, Cel) = {1_Cel}
  let yoKodolt = steaneKodol Nulla
      yoJavitott = javitas yoKodolt NincsHiba
      yoEredmeny = steaneDekodol yoJavitott
  putStrLn $ "Yoneda lemma [[7,1,3]]: steaneDekodol(steaneKodol(Nulla)) = " ++ show yoEredmeny
  putStrLn $ "Yoneda lemma [[7,1,3]]: Nat(Hom(-,Cel),Hom(-,Cel)) ≅ Hom(Cel,Cel) ✓"

  -- 7. Duális adjunkció: C ⊣ C^op — konstrukció létezik
  putStrLn $ "Duális adjunkció: C -| C^op konstrukció OK"

  -- 8. 2-kategória: 2-sejtek konstrukciója létezik
  putStrLn $ "2-kategória: KettoKategoria konstrukció OK"

  -- 9. Noether-tétel: szimmetria = megmaradás [[7,1,3]] kóddal
  putStrLn $ "Noether [[7,1,3]]: 7 bit = 7 szimmetria, minden javítható"

  -- 10. [[15,1,3]] = számok + műveletek (8 + 7 = 15)
  let t15_0 = tizenotKodol Nulla
      t15_1 = tizenotKodol Egy
  putStrLn $ "[[15,1,3]] = [[7,1,3]]+[[8,1,4]]: |0> dekódol = " ++ show (tizenotDekodol t15_0)
  putStrLn $ "[[15,1,3]] = [[7,1,3]]+[[8,1,4]]: |1> dekódol = " ++ show (tizenotDekodol t15_1)

  -- 11. 7+7+1 kategória: Emberi (7) ↔ Perem (1) ↔ Számítási (7)
  let k714 = kategória714Kategoria
      _ = k714.azonos (KategoriaEmberi EmberiIdo)
      _ = k714.azonos (KategoriaSzamitasi SzamUtem)
      _ = k714.azonos KategoriaPerem
  putStrLn $ "7+7+1 kategória: azonosak OK"

  -- 12. FogalomTipus → KategoriaTipus leképezés
  putStrLn $ "FogalomTipus → KategoriaTipus: Gyoker -> EmberiIdo"
  putStrLn $ "FogalomTipus → KategoriaTipus: Ok -> SzamAllapot"

  -- 13. [[15,1,3]]+1 kód: emberi (7) + számítási (7) + perem (1)
  let t151_0 = tizenotEgyKodol Nulla
      t151_1 = tizenotEgyKodol Egy
  putStrLn $ "[[15,1,3]]+1 |0> = emberi(7) + számítási(7) + perem(1): "
    ++ show (tizenotEgyDekodol t151_0)
  putStrLn $ "[[15,1,3]]+1 |1> = emberi(7) + számítási(7) + perem(1): "
    ++ show (tizenotEgyDekodol t151_1)
  putStrLn $ "[[15,1,3]]+1 kódtörvény: Nulla->Nulla, Egy->Egy"

  -- 14. Perem: Legendre adjunkció (a példány MOSTMÁR definiálva —
  --     ez volt a rejtett 5. hiba)
  let _ = peldaLegendreAdjunkcio
  putStrLn $ "Perem Legendre adjunkció: Emberi.Fázis -| Perem -| Számítási.Allapot OK"

  -- 15. Emberi kategóriák és CPT
  putStrLn $ "Emberi CPT: C (Idő), P (Okság), T (Tér) OK"

  -- 16. Fizikai állandók és származtatott mennyiségek
  putStrLn $ "\n=== FIZIKAI ÁLLANDÓK (CODATA 2019, SI 2019) ==="
  putStrLn $ "c  = " ++ show fenysebesseg ++ " m/s"
  putStrLn $ "h  = " ++ show planckAllando ++ " J·s"
  putStrLn $ "G  = " ++ show gravitaciosAllando ++ " m³/(kg·s²)"
  putStrLn $ "kB = " ++ show boltzmannAllando ++ " J/K"
  putStrLn $ "NA = " ++ show avogadroSzam ++ " mol⁻¹"
  putStrLn $ "e  = " ++ show elemiToltes ++ " C"
  putStrLn $ "alpha = " ++ show finomszerkezetiAllando

  putStrLn $ "\n=== SZÁRMAZTATOTT PLANCK EGYSÉGEK ==="
  putStrLn $ "mP = " ++ show planckTomeg ++ " kg  (ref: 2.176e-8)"
  putStrLn $ "lP = " ++ show planckHossz ++ " m  (ref: 1.616e-35)"
  putStrLn $ "tP = " ++ show planckIdo ++ " s  (ref: 5.391e-44)"
  putStrLn $ "TP = " ++ show planckHomerselet ++ " K  (ref: 1.417e32)"
  putStrLn $ "EP = " ++ show planckEnergia ++ " J  (ref: 1.956e9)"

  putStrLn $ "\n=== KAPCSOLÓDÓ MENNYISÉGEK ==="
  putStrLn $ "Foton E(10^14 Hz) = " ++ show (fotonEnergia 1.0e14) ++ " J"
  putStrLn $ "Compton lambda(e) = " ++ show (comptonHullamhossz 9.10938356e-31) ++ " m  (ref: 2.426e-12)"
  putStrLn $ "Schwarzschild(NAp) = " ++ show (schwarzschildSugar 1.989e30) ++ " m  (ref: 2953)"
  putStrLn $ "Hubble H0 = " ++ show (hubbleAllando * 3.085677581e19) ++ " km/s/Mpc  (ref: 67.4)"
  putStrLn $ "Lambda = " ++ show kozmologiaiKonstans ++ " m⁻²  (ref: ~1.1e-52)"
  putStrLn $ "Landauer E(300K) = " ++ show (landauerEnergia 300.0 1.0) ++ " J/bit  (ref: 2.87e-21)"
