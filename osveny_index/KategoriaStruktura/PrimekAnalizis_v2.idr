module KategoriaStruktura.PrimekAnalizis_v2

-- ╔══════════════════════════════════════════════════════════════════╗
-- ║ PRÍMELEMZÉS · v2 — a tautológiák VALÓDI tanúit pótolja (§18)       ║
-- ║ 素数分析 · v2 — 补上同义反复的真实见证                              ║
-- ║ PRIME ANALYSIS · v2 — real witnesses for the marked tautologies   ║
-- ║ PRIMANALYSE · v2 — echte Zeugen für die markierten Tautologien    ║
-- ╚══════════════════════════════════════════════════════════════════╝
--
-- MI EZ / 这是什么 / WHAT THIS IS:
-- A PrimekAnalizis.idr öt tautológiája (47 = 47, 29 = 29, 7 = 7,
-- 3 = 3, 2 = 2) fölé TAUTOLÓGIA-JELZÉS került (helyben, csak
-- komment). Ez az ÚJ fájl (§13) a jelzett VALÓDI állításokat
-- («a 47 prím», «a 29 prím», …) valódi tanúval pótolja: a tanú
-- TÍPUSA egy SZÁMÍTÓ keresés (minden lehetséges osztó jelölt
-- végigpróbálása), a jobb oldal független konstans (True) —
-- a §18 «két független konstrukció» mintája.
-- 本文件为被标记的同义反复补上真实见证：类型是可计算的除数搜索，
-- 右边是独立常量 True（§18 双构造模式）。
-- This new file replaces the marked tautologies with real witnesses:
-- the type is a COMPUTED divisor search; the right side is the
-- independent constant True.
-- Diese neue Datei ersetzt die markierten Tautologien durch echte
-- Zeugen: der Typ ist eine berechnete Teilersuche.
--
-- A SZÁMÍTÁS SZERKEZETE / 计算结构 / STRUCTURE:
--   osztás n d        = (hányados, maradék) — strukturális rekurzió
--                       az n S-konstruktorain (TOTAL, redukál!)
--   osztóE d n        = d osztója-e n-nek (a maradék nulla-e)
--   egyetlenOsztóSem n határ = minden d ∈ [2, határ]-ra d nem osztója
--                       n-nek (strukturális rekurzió a határon)
-- 除法用结构递归（全函数、可归约）；除数检验 + 有界搜索。
-- Division by structural recursion (total, reducing); divisor test
-- plus bounded search.
-- Division mit struktureller Rekursion (total, reduzierend).
--
-- A HÍD A MATEMATIKÁHOZ (kommentben, őszintén — §18.2) / 与数学的桥：
-- A típus azt mondja: «a [2, határ] egyetlen tagja sem osztója
-- n-nek». A prímséghez a klasszikus lemma kell: HA n összetett,
-- VAN osztója [2, n-1]-ben (n = a·b, 1 < a ≤ b < n — a kisebbik
-- tényező ≤ √n < n). Ezt a lemmát EZ A FÁJL NEM bizonyítja —
-- a tanú tehát a prímségnek pontosan azt a részet bizonyítja,
-- amit a típus mond (a teljes jelölt-tartomány kimerítése),
-- a lemma a kommentben él, további hullám feladata.
-- 类型证明的是「[2, határ] 中无 n 的除数」；合成⇒存在真除数的
-- 引理在注释中，是后续波次的任务。
-- The type proves exactly the exhaustion of the candidate range;
-- the composite-implies-divisor lemma lives in this comment.
-- Der Typ beweist genau die Erschöpfung des Kandidatenbereichs.
--
-- §24-JEGYZET (nem duplikáció): a PrimeLogic_v1_Szima.natMod PRIVÁT
-- (mérés: ModulhatárProbe_v1, 2026-09-04) és a szima_ter/fában él —
-- nem importálható; a Prelude-ben a Nat-hoz nincs `mod`
-- (Integral-instance nincs a Nat-ra — #11 csapda). Ezért helyi,
-- strukturális osztás készült — az egyetlen elérhető út.

import Alap.SzamT

%default total

-- ═══════════════════════════════════════════════════════════════════
-- A STRUKTURÁLIS OSZTÁS · 结构除法 · THE STRUCTURAL DIVISION
-- ═══════════════════════════════════════════════════════════════════

||| Egész osztás Nat-on: (hányados, maradék).
||| d = 0 esetén (0, n) — a függvény mindenképp TOTAL (az n-en
||| strukturálisan rekurzív), a d = 0 «eredménye» soha nem kerül
||| elő a tanúkban (minden jelölt d ≥ 2).
||| Nat 上的整除：(商，余数)。对 n 结构递归，全函数、编译期可归约。
public export
osztás : (n, d : Nat) -> (Nat, Nat)
osztás Z _ = (Z, Z)
osztás (S k) d =
  let (hányados, maradék) = osztás k d in
  if S maradék == d then (S hányados, Z) else (hányados, S maradék)

||| A pár maradék-tagja nulla-e. / 余数是否为零。
public export
maradékNullaE : (Nat, Nat) -> Bool
maradékNullaE (_, Z) = True
maradékNullaE _      = False

||| d osztója-e n-nek. / d 是否整除 n。
public export
osztóE : (d, n : Nat) -> Bool
osztóE d n = maradékNullaE (osztás n d)

||| Minden d ∈ [2, határ]-ra: d NEM osztója n-nek.
||| Strukturális rekurzió a határon — TOTAL és fordítási időben
||| redukál (a Refl-tanúk ezt használják).
||| 对一切 d ∈ [2, határ]：d 不整除 n（对 határ 结构递归）。
|||
||| CSAPDA-JEGYZET (saját hiba, amit a Refl ELKAPOTT — 2026-09-04):
||| Az első változat alapesete `egyetlenOsztóSem _ Z = True` volt,
||| a lépés pedig `… (S k) = not (osztóE (S k) n) && …` — ez a
||| d = határ, határ−1, …, **1** sorozatot próbálta, tehát az 1-ET IS,
||| ami MINDEN számot oszt → a keresés mindig False lett (a futásidő
||| OsztásProbe_v1-je csak az osztóE-t ellenőrizte, az jó volt — a
||| hiba a keresés alapesetében lapult). Gyógyír: a [2, 1] üres
||| tartomány külön alapesete (`S Z` — konstruktorba ágyazott minta,
||| a #27 csapda-gyógyír formája). A bisect-bizonyíték:
||| KategoriaStruktura/OsztásBisect_v1.idr (keresésHárom/keresésHét
||| elbuktak, az osztás/osztóE szintek átmentek).
public export
egyetlenOsztóSem : (n, határ : Nat) -> Bool
egyetlenOsztóSem _ Z         = True  -- a [2, 0] tartomány üres
egyetlenOsztóSem _ (S Z)     = True  -- a [2, 1] tartomány üres — a d = 1-et SOHA nem próbáljuk!
egyetlenOsztóSem n (S (S k)) = not (osztóE (S (S k)) n) && egyetlenOsztóSem n (S k)

-- ═══════════════════════════════════════════════════════════════════
-- A VALÓDI TANÚK · 真实见证 · THE REAL WITNESSES · DIE ECHTEN ZEUGEN
-- (a jelölt-tartomány TELJES kimerítése — az n-1-ig menő keresés)
-- ═══════════════════════════════════════════════════════════════════

-- Kimenet: Refl — a 2..46 tartomány 45 jelöltje egyetlen esetben sem
-- osztója a 47-nek (a gép mindegyikre kiszámolja a maradékot).
public export
negyvenhétPrímTanú : egyetlenOsztóSem 47 46 = True
negyvenhétPrímTanú = Refl

-- Kimenet: Refl — a 2..28 tartomány 27 jelöltje sem osztója a 29-nek.
public export
huszonkilencPrímTanú : egyetlenOsztóSem 29 28 = True
huszonkilencPrímTanú = Refl

-- Kimenet: Refl — a 2..6 tartomány 5 jelöltje sem osztója a 7-nek
-- (7 = 3·2+1, 7 = 2·3+1 — a maradékok 1).
public export
hétPrímTanú : egyetlenOsztóSem 7 6 = True
hétPrímTanú = Refl

-- Kimenet: Refl — az egyetlen jelölt (a 2) nem osztója a 3-nak
-- (3 = 1·2+1, maradék 1).
public export
háromPrímTanú : egyetlenOsztóSem 3 2 = True
háromPrímTanú = Refl

-- Kimenet: Refl — a 2-re a jelölt-tartomány [2, 1] ÜRES (az 1-nél
-- nagyobb és 2-nél kisebb szám nincs) — a hiányos keresés itt TELJES,
-- tehát a tanú a 2 prímségének teljes körű kimerítése.
public export
kettőPrímTanú : egyetlenOsztóSem 2 1 = True
kettőPrímTanú = Refl

-- ═══════════════════════════════════════════════════════════════════
-- AZ ÖSSZETETT PÉLDA (ellenőrzés, hogy a gép NEM csak True-t ad)
-- 合成数反例（验证机器并非总返回 True）· A COMPOSITE COUNTER-CHECK
-- ═══════════════════════════════════════════════════════════════════

-- Kimenet: Refl — a 10-re a 2 MÁR osztó (10 = 5·2, maradék 0),
-- tehát a keresés False-t ad — a tanúk a keresés MINDKÉT kimenetét
-- megbízhatóvá teszik (nem egy örökké-True gép).
public export
aKapuÖsszetettTanú : egyetlenOsztóSem 10 9 = False
aKapuÖsszetettTanú = Refl
