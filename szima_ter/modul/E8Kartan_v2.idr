module E8Kartan_v2

-- ═══════════════════════════════════════════════════════════════
-- E8 KARTAN-MÁTRIX v2 — az egyszerű gyökök kapcsolati térképe
-- E8 CARTAN MATRIX v2 — the connection map of the simple roots
-- E8 嘉当矩阵 v2 — 单根的关系地图
-- E8-CARTAN-MATRIX v2 — die Beziehungskarte der einfachen Wurzeln
-- מטריצת קרטן של E8 גרסה 2 — מפת הקשרים של השורשים הפשוטים
-- ═══════════════════════════════════════════════════════════════
--
-- MIÉRT v2? (§13: a javítás ÚJ FÁJL — a v1, az E8Kartan.idr ÉRINTETLEN
-- MARAD, hűen őrzünk minden hibáját is tanulságként.)
--   A v1 NÉGY hibája, amit ez a modul JAVÍT:
--   (a) a 135. sor törött komment-határoló («── ─── 4. …» — sor eleji
--       `──` nem komment!): itt minden megjegyzés-sor `--`-ral indul.
--   (b) `iEdikGyok` KÉTSZER volt definiálva (164–168. sor): itt PONTOSAN
--       EGYSZER él, Z/S-szerkezeti rekurzióval.
--   (c) a v1 az `E8Gyök`/`E8GyökKonstruktor` neveket hívta, de az
--       importált modul `E8Gyok`-ot ad: itt CSAK az E8Gyokok_v2
--       `E8Gyok`/`E8GyokKonstruktor` nevei élnek.
--   (d) A v1 `kartanGyokKonzisztencia`-ja A(i,i)=2-t várt a NYERS
--       belső szorzattól, de a 2-szeres skálán ⟨α,α⟩ = 8 — a v1
--       konzisztencia-tesztje tehát HELYTELEN volt, nem a számítás.
--       A JAVÍTÁS: A(i,j) = ⟨βi,βj⟩ / 4 (l. lejjebb, matematikai
--       indoklással) — egész aritmetika, osztás nélkül: a teszt a
--       ⟨βi,βj⟩ = 4·A(i,j) ALAKOT ellenőrzi, ami osztás helyett
--       szorzás, tehát mindig egzakt.
--
-- MIÉRT PONT A /4 SKÁLÁZÁS? (a feladat által kért indoklás)
--   A Cartan-mátrix definíciója: A(i,j) = 2·(αi,αj)/(αj,αj), ahol
--   (,) a VALÓDI belső szorzat, és az egyszerű gyökök normája 2.
--   A mi modellünkben a gyökök a 2-SZERES EGÉSZ SKÁLÁN élnek:
--   βi = 2·αi, tehát a nyers dot ⟨βi,βj⟩ = 4·(αi,αj) és ⟨βj,βj⟩ = 8.
--   Ebből: A(i,j) = 2·⟨βi,βj⟩/8 = ⟨βi,βj⟩/4.
--   ELLENŐRZÉS: átlóra ⟨βi,βi⟩ = 8 → A(i,i) = 2 ✓; szomszédságra
--   ⟨βi,βj⟩ = −4 → A(i,j) = −1 ✓; nem-szomszédságra 0 → 0 ✓.
--   (A /8-os osztás — amit a feladat felvetett alternatívaként —
--   NEM JO: az −4/8 = −½, nem egész, tehát nem adná a Cartan-egészeket.
--   A /4 az egyetlen egész-aritmetikai osztó, ami mind a 64 cellán
--   egészet ad és egyben a definíció A(i,j)=2(αi,αj)/(αj,αj) pontos
--   átirása ezen a skálán.)
--
-- A GRÁF (a mátrixszal ÖSSZEHANGBAN — a v1 fejléc-kommentje ITT
-- ellentmondott a saját mátrixának, az a hiba is javítva):
--   Élek (ahol A(i,j) = −1, 1-alapú számozással):
--     1–2, 2–3, 3–4, 4–5, 5–6, 5–8, 6–7
--   Azaz: LÁNC 1–2–3–4–5–6–7, és a 8-AS CSOMÓPONT AZ 5-ÖN LÓG.
--   Karok az 5-ös elágazási ponttól: (4, 2, 1) hosszúak — ez az E8
--   Dynkin-gráfja ✓ (a 7-es a 6-on át az 5-höz csatlakozik).
--
-- A TULAJDONSÁGOK, AMIKET EZ A MODUL BIZONYÍT/ELLENŐRIZ:
--   (1) Szimmetria: A(i,j) = A(j,i) — a teljes mátrix a transzponáltjával
--       egyezik (Data.List.transpose — §24: a base-könyvtáré, nem újraírt!),
--       + Refl-tanúk kijelölt párokra.
--   (2) Átló: A(i,i) = 2 — Refl-tanúk + kimerítő futásidejű ellenőrzés.
--   (3) Sorösszeg-korlát: minden elem ∈ {−1, 0, 2}.
--   (4) Determináns = 1 (az E8 simply-laced, det = 1 — egyetlen
--       előjelhiba elrontaná; futásidejű kimerítő Laplace).
--   (5) GYÖK-KONZISZTENCIA: mind a 64 (i,j) cellán
--       ⟨βi,βj⟩ = 4·A(i,j), ahol βi az E8Gyokok_v2-beli egyszerű gyök.
--
-- SZÁRMAZÁS ÉS §24 (duplikáció-ellenőrzés, 2026-09-04):
--   - `belsoszorzat` IMPORTÁLVA az E8BelsoSzorzat.idr-ből (az ottani
--     2-szeres skálájú dot, értékterem {−8,−4,0,+4,+8} — KANONIKUS).
--   - `gyokNorma` IMPORTÁLVA az E8Gyokok_v2.idr-ből (KANONIKUS).
--   - `transzponál`-t NEM írtuk: a Data.List.transpose base-függvény él.
--   - `mátrixElem`/`determináns`/`minorOszlopNélkül` helyben élnek: a v1
--     azonos nevű segédei private-ok voltak ÉS a v1 importfája
--     (E8Gyokok v1) kernel-robbanó (Killed: 9, SOHA importálandó —
--     parancs), tehát a kanonikus otthon ELÉRHETETLEN — ezt a helyi
--     definíciót a §24 "HA ÉS CSAK HA más út nincs" ága fedezi.
--   - Az egyszerű gyökök a Wikipedia ±½ modell 2-szeres skáláján,
--     a v1 gyöklistájával AZONOSSZÁMÚL (az a rész a v1-nek helyes volt):
--     β1..β5, β8 = lánc, β6 = (…2,2…), β7 = (−1)⁸.
--
-- MINDEN SZÁMÍTÁS IDRISBEN (AGENTS §1.3): egészaritmetika, rekurzív
-- Laplace. SEMMI Python. SEMMI törlés — a v1 érintetlenül marad (§13, §20).
-- ═══════════════════════════════════════════════════════════════

import Data.List
import E8Gyokok_v2
import E8BelsoSzorzat

%default covering

-- ─── 1. A MÁTRIX ADATKÉNT / THE MATRIX AS DATA / 矩阵数据 ───

||| Az E8 Bourbaki-számozású Cartan-mátrixa, soronként.
||| Átlóban 2; szomszédokban −1; az élek: 1–2, 2–3, 3–4, 4–5, 5–6, 5–8, 6–7.
public export
kartanMátrix : List (List Integer)
kartanMátrix =
  [ [ 2, -1,  0,  0,  0,  0,  0,  0 ]
  , [-1,  2, -1,  0,  0,  0,  0,  0 ]
  , [ 0, -1,  2, -1,  0,  0,  0,  0 ]
  , [ 0,  0, -1,  2, -1,  0,  0,  0 ]
  , [ 0,  0,  0, -1,  2, -1,  0, -1 ]
  , [ 0,  0,  0,  0, -1,  2, -1,  0 ]
  , [ 0,  0,  0,  0,  0, -1,  2,  0 ]
  , [ 0,  0,  0,  0, -1,  0,  0,  2 ]
  ]

||| NAGYBETŰS alias a bizonyítás-típusok számára (a kisbetűs-konstans
||| csapda ellen — AGENTS: a csupasz kisbetűs KONSTANS a bizonyítás
||| TÍPUSÁBAN implicit argumentummá válik, még fv-argumentumként is).
public export
KartanMátrix : List (List Integer)
KartanMátrix = kartanMátrix

-- ─── 2. SEGÉDFÜGGVÉNYEK (egész mátrixműveletek) ──────────────

||| Egy lista n-edik eleme (0-tól számezve); üresnél 0 — felső szintű
||| segéd (a where-beli név nem látszik a többi klauzulából — ÚJ CSAPDA,
||| l. a jelentést), mind a mátrixElem, mind az átló-ellenőrzés ezt használja.
public export
sorElem : Nat -> List Integer -> Integer
sorElem _ Nil = 0
sorElem Z (x :: _) = x
sorElem (S k) (_ :: xs) = sorElem k xs

||| Mátrix (i,j)-edik eleme (i, j: 0-tól számozva).
||| Üres mátrix/üres sor esetén 0 — fedő definíció, nincs részleges.
public export
mátrixElem : Nat -> Nat -> List (List Integer) -> Integer
mátrixElem _ _ Nil = 0
mátrixElem Z j (sor :: _) = sorElem j sor
mátrixElem (S i) j (_ :: többi) = mátrixElem i j többi

||| Rekurzív Laplace-féle determináns (egész aritmetika, első sor szerint).
||| A j-edik elem előjele (−1)^j; minora: a többi sorból a j-edik oszlop kimarad.
public export
minorOszlopNélkül : Nat -> List (List Integer) -> List (List Integer)
minorOszlopNélkül _ Nil = Nil
minorOszlopNélkül j (sor :: többi) =
  oszlopotHagy j sor :: minorOszlopNélkül j többi
  where
    oszlopotHagy : Nat -> List Integer -> List Integer
    oszlopotHagy _ Nil = Nil
    oszlopotHagy Z (_ :: maradék) = maradék
    oszlopotHagy (S k) (x :: maradék) = x :: oszlopotHagy k maradék

public export
determináns : List (List Integer) -> Integer
determináns Nil = 1
determináns (sor :: többi) = elsőSorSzerinti 0 sor
  where
    elsőSorSzerinti : Nat -> List Integer -> Integer
    elsőSorSzerinti _ Nil = 0
    elsőSorSzerinti j (elem :: maradék) =
      (if mod (cast j) 2 == 0 then elem else negate elem)
        * determináns (minorOszlopNélkül j többi)
      + elsőSorSzerinti (S j) maradék

-- ─── 3. KIMERÍTŐ ELLENŐRZÉSEK (futásidejű, §18(b) szellemében) ──

||| Minden cella szimmetrikus-e: A(i,j) = A(j,i) — a teljes mátrix
||| egyezik a transzponáltjával (Data.List.transpose — §24).
public export
mindenSzimmetrikus : Bool
mindenSzimmetrikus = kartanMátrix == transpose kartanMátrix

||| Minden átlóbeli elem 2-e? (az i-edik sor i-edik eleme, 0-tól számozva)
public export
mindenÁtlóKetto : Bool
mindenÁtlóKetto = megy 0 kartanMátrix
  where
    megy : Nat -> List (List Integer) -> Bool
    megy _ Nil = True
    megy i (sor :: többi) = (sorElem i sor == 2) && megy (S i) többi

||| Minden elem a {−1, 0, 2} halmazból való-e?
public export
mindenElemÉrvényes : Bool
mindenElemÉrvényes = all (\sor => all érvényes sor) kartanMátrix
  where
    érvényes : Integer -> Bool
    érvényes e = e == 2 || e == 0 || e == (-1)

||| A determináns tétel: det(E8 Cartan) = 1.
||| (Futásidejű kimerítő Laplace — a 8! = 40320 út összeszámolva.)
public export
bizDeterminánsEgy : Bool
bizDeterminánsEgy = determináns kartanMátrix == 1

-- ─── 4. EGYSZERŰ GYÖKÖK — a Wikipedia ±½ modell (2-szeres skálán) ──

||| Az egyszerű gyökök a projekt E8Gyok típusában (2-szeres egész skálán).
||| Bourbaki-számozás: β1..β5 a lánc, β6 = (0⁵,2,2,0), β7 = (−1)⁸,
||| β8 = (0⁵,2,−2,0). Forrás: Wikipedia „E8 (mathematics)" simple roots,
||| 2-vel felszorozva (a ±½-kettesek egészre emelve).
public export
egyszerűGyökök : List E8Gyok
egyszerűGyökök =
  [ E8GyokKonstruktor   2  (-2)   0    0    0    0    0    0
  , E8GyokKonstruktor   0    2  (-2)   0    0    0    0    0
  , E8GyokKonstruktor   0    0    2  (-2)   0    0    0    0
  , E8GyokKonstruktor   0    0    0    2  (-2)   0    0    0
  , E8GyokKonstruktor   0    0    0    0    2  (-2)   0    0
  , E8GyokKonstruktor   0    0    0    0    0    2    2    0
  , E8GyokKonstruktor (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1)
  , E8GyokKonstruktor   0    0    0    0    0    2  (-2)   0
  ]

||| NAGYBETŰS alias a bizonyítás-típusok számára (kisbetűs-konstans
||| csapda — l. fent a KartanMátrix-nál).
public export
EgyszerűGyökökKonst : List E8Gyok
EgyszerűGyökökKonst = egyszerűGyökök

||| Az i-edik egyszerű gyök — PONTOSAN EGYSZER definiálva (a v1 (b)
||| hibájának javítása). Helytelen indexnél (i ≥ hossz) a Nulla-gyök.
public export
iEdikGyök : Nat -> List E8Gyok -> E8Gyok
iEdikGyök _ Nil = E8GyokKonstruktor 0 0 0 0 0 0 0 0
iEdikGyök Z (g :: _) = g
iEdikGyök (S k) (_ :: gs) = iEdikGyök k gs

-- ─── 5. REFL-TANÚK (nem tautológiák — §18: a két oldal KÜLÖNBÖZŐ
--      KONSTRUKCIÓ: bal = a mátrix/lista felsorolásából SZÁMÍTÓ út,
--      jobb = független konstans) ─────────────────────────────────

-- Kimenet: Refl (2 = 2 ✓) — a (1,1) cella a sor-felsorolásból.
public export
bizÁtlóKettoEgy : mátrixElem 0 0 KartanMátrix = 2
bizÁtlóKettoEgy = Refl

-- Kimenet: Refl (2 = 2 ✓) — a (5,5) cella, az elágazási pont.
public export
bizÁtlóKettoÖt : mátrixElem 4 4 KartanMátrix = 2
bizÁtlóKettoÖt = Refl

-- Kimenet: Refl (2 = 2 ✓) — a (8,8) cella, a lánc vége.
public export
bizÁtlóKettoNyolc : mátrixElem 7 7 KartanMátrix = 2
bizÁtlóKettoNyolc = Refl

-- Kimenet: Refl (−1 = −1 ✓) — az 1–2 él szimmetriája:
-- bal = az 1. sor 2. cellájából, jobb = a 2. sor 1. cellájából
-- (két KÜLÖNBÖZŐ felsorolási út ugyanarra a −1-re).
public export
bizSzimmetria12 : mátrixElem 0 1 KartanMátrix = mátrixElem 1 0 KartanMátrix
bizSzimmetria12 = Refl

-- Kimenet: Refl (−1 = −1 ✓) — az 5–8 él szimmetriája (a T-alak ága):
-- bal = az 5. sor 8. cellája, jobb = a 8. sor 5. cellája.
public export
bizSzimmetria58 : mátrixElem 4 7 KartanMátrix = mátrixElem 7 4 KartanMátrix
bizSzimmetria58 = Refl

-- Kimenet: Refl (−1 = −1 ✓) — a 6–7 él: az egyetlen él, ami a
-- 6–7 számpárra áll fenn; mindkét út a saját sorából számol.
public export
bizSzimmetria67 : mátrixElem 5 6 KartanMátrix = mátrixElem 6 5 KartanMátrix
bizSzimmetria67 = Refl

-- Kimenet: Refl (8 = 8 ✓) — a β7 = (−1)⁸ gyök normája KÉT ÚTON:
-- bal = a nyers dot (nyolc −1 szorzata össgezve), jobb = 8·1.
public export
bizBéta7NormaKétÚton : gyokNorma (E8GyokKonstruktor (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1)) = 8 * 1
bizBéta7NormaKétÚton = Refl

-- Kimenet: Refl (−4 = −4 ✓) — ⟨β1,β2⟩ = −4: a szomszéd-él nyers
-- dotja; ez a Cartan −1-esének a 4-szerese (l. az /4 skálázási törvényt).
public export
bizSzomszédNégy : belsoszorzat (E8GyokKonstruktor 2 (-2) 0 0 0 0 0 0)
                               (E8GyokKonstruktor 0 2 (-2) 0 0 0 0 0) = negate 4
bizSzomszédNégy = Refl

-- Kimenet: Refl (8 = 8 ✓) — A SKÁLÁZÁSI TÖRVÉNY átlóra, konkrétan:
-- ⟨β1,β1⟩ = 8 = 4·2 = 4·A(1,1). Ez a /4-osztás egzakttságát pinli.
public export
bizSkálaTörvényÁtló : belsoszorzat (E8GyokKonstruktor 2 (-2) 0 0 0 0 0 0)
                                   (E8GyokKonstruktor 2 (-2) 0 0 0 0 0 0) = 4 * 2
bizSkálaTörvényÁtló = Refl

-- Kimenet: Refl (−4 = −4 ✓) — a konzisztencia-törvény KONKRÉT párra,
-- az iEdikGyök listahozzáférésén KERESZTÜL (így a (b) javított
-- segéd is tanúsított): ⟨β1,β2⟩ = 4·A(1,2) = 4·(−1).
public export
bizKonzisztencia12 : belsoszorzat (iEdikGyök 0 EgyszerűGyökökKonst)
                                  (iEdikGyök 1 EgyszerűGyökökKonst) = 4 * mátrixElem 0 1 KartanMátrix
bizKonzisztencia12 = Refl

-- ─── 6. KONSZISZTENCIA-HÍD (a v1 (d) hibájának JAVÍTÁSA) ─────
-- Minden (i,j) cellán: ⟨βi,βj⟩ = 4·A(i,j)  ⟺  A(i,j) = ⟨βi,βj⟩/4
-- Ez a Cartan-definíció A(i,j) = 2(αi,αj)/(αj,αj) pontos átirása a
-- 2-szeres skálán (β = 2α, ⟨β,β⟩ = 8, l. a fejléc indoklását).
-- EGÉSZ aritmetika: osztás helyett a 4-SZORZÁSOS alakot ellenőrizzük.

||| A teljes 64-cellás konzisztencia: futásidejű, kimerítő.
public export
kartanGyökKonzisztencia : Bool
kartanGyökKonzisztencia = megy 0 0
  where
    megy : Nat -> Nat -> Bool
    megy i j =
      let joE = belsoszorzat (iEdikGyök i EgyszerűGyökökKonst)
                             (iEdikGyök j EgyszerűGyökökKonst)
                 == 4 * mátrixElem i j KartanMátrix
      in if j == 7
           then joE && (if i == 7 then True else megy (S i) 0)
           else joE && megy i (S j)

-- ─── 7. SHOW-JELENTÉS ÉS MAIN ─────────────────────────────────

||| Egy teszt eredményének megjelenítése.
tesztSor : String -> Bool -> String
tesztSor név ok =
  név ++ ": " ++ (if ok then "✓ OK" else "✗ HIBA")

||| A teljes Cartan-jelentés — futtatható ellenőrzés.
public export
kartanJelentés : String
kartanJelentés =
  "── E8 Kartan-mátrix v2 jelentés ──\n"
  ++ tesztSor "szimmetria (64 cella)" mindenSzimmetrikus ++ "\n"
  ++ tesztSor "átló = 2 (8 hely)" mindenÁtlóKetto ++ "\n"
  ++ tesztSor "elemek ∈ {−1,0,2}" mindenElemÉrvényes ++ "\n"
  ++ tesztSor "determináns = 1" bizDeterminánsEgy ++ "\n"
  ++ tesztSor "⟨βi,βj⟩ = 4·A(i,j) (64 cella)" kartanGyökKonzisztencia ++ "\n"

main : IO ()
main = putStrLn kartanJelentés
