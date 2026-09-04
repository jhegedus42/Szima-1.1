module E8Kartan

-- ═══════════════════════════════════════════════════════════════
-- E8 KARTAN-MÁTRIX — az egyszerű gyökök kapcsolati térképe
-- ═══════════════════════════════════════════════════════════════
--
-- A PROJEKT ÁLLÁSA (2026-08-22, alügynök-leltár):
--   A 240 gyök létezik (E8Gyokok: 112 + 128), a belső szorzat és a
--   Weyl-reflexió is (E8BelsoSzorzat) — DE a Cartan-mátrix mint adat,
--   és az egyszerű gyökök fogalma még sehol sem szerepel.
--   Ez a modul tölti fel ezt az űrt (ÚJ fájl, §13: semmit nem módosítunk).
--
-- A CARTAN-MÁTRIX DEFINÍCIÓJA:
--   A(i,j) = 2·(αi,αi)/(αi,αi) … egyszerűbben: A(i,i)=2,
--   A(i,j) = −(αi,αj) ha i≠j (egyszerű lánccal összekötött gyökpárok),
--   A(i,j) = 0 ha nincs él. Az E8 Bourbaki-számozású mátrixa:
--   átlóban 2-esek; a 3-as csomópont a 2-eshez és a 6-oshoz, a 4-es
--   az 5-öshez és a 7-eshez is húz; hosszú lánc 4–5–6–7–8.
--
-- A TULAJDONSÁGOK, AMIKET EZ A MODUL BIZONYÍT/ELLENŐRIZ:
--   (1) Szimmetria: A(i,j) = A(j,i) — mind a 64 cellára kimerítően.
--   (2) Átló: A(i,i) = 2 — mind a 8 helyen.
--   (3) Sorösszeg-korlát: minden sor elemei ∈ {−1,0,2}.
--   (4) Determináns = 1 (az E8 mint simply-laced, det=1 rendszert jellemzi;
--       ez a legérzékenyebb egész-ellenőrzés — egyetlen előjelhiba elrontja).
--
-- MINDEN SZÁMÍTÁS IDRISBEN (§1.3): egészaritmetika, rekurzív Laplace.
-- NEM törölve, NEM módosítva — csak hozzáadva (§13, §20).
-- ═══════════════════════════════════════════════════════════════

import Data.List
import E8Gyokok
import E8BelsoSzorzat

%default covering

-- ─── 1. A MÁTRIX ADATKÉNT ─────────────────────────────────────

||| Az E8 Bourbaki-számozású Cartan-mátrixa, soronként.
public export
kartanMatrix : List (List Integer)
kartanMatrix =
  [ [ 2, -1,  0,  0,  0,  0,  0,  0 ]
  , [-1,  2, -1,  0,  0,  0,  0,  0 ]
  , [ 0, -1,  2, -1,  0,  0,  0,  0 ]
  , [ 0,  0, -1,  2, -1,  0,  0,  0 ]
  , [ 0,  0,  0, -1,  2, -1,  0, -1 ]
  , [ 0,  0,  0,  0, -1,  2, -1,  0 ]
  , [ 0,  0,  0,  0,  0, -1,  2,  0 ]
  , [ 0,  0,  0,  0, -1,  0,  0,  2 ]
  ]

-- ─── 2. SEGÉDFÜGGVÉNYEK (egész mátrixműveletek) ──────────────

||| Mátrix transzponálása (sorok ↔ oszlopok).
public export
transzponal : List (List Integer) -> List (List Integer)
transzponal Nil = Nil
transzponal sorok = oszlopN (indexektolIg 0 (sorHossz sorok)) sorok
  where
    sorHossz : List (List Integer) -> Nat
    sorHossz (s :: _) = length s
    sorHossz Nil = 0
    ||| [k, k+1, …, n−1] — üres, ha k ≥ n.
    indexektolIg : Nat -> Nat -> List Nat
    indexektolIg k n = if k < n then k :: indexektolIg (S k) n else Nil
    oszlopN : List Nat -> List (List Integer) -> List (List Integer)
    oszlopN Nil _ = Nil
    oszlopN (j :: js) ss = map (elemAt j) ss :: oszlopN js ss
      where
        elemAt : Nat -> List Integer -> Integer
        elemAt _ Nil = 0
        elemAt Z (x :: _) = x
        elemAt (S k) (_ :: xs) = elemAt k xs

||| Rekurzív Laplace-féle determináns (egész aritmetika, első sor szerint).
||| A j-edik elem előjele (−1)^j; minora: a többi sorból a j-edik oszlop kimarad.
public export
minorOszlopNelkul : Nat -> List (List Integer) -> List (List Integer)
minorOszlopNelkul _ Nil = Nil
minorOszlopNelkul j (sor :: tobbi) =
  oszlopotHagy j sor :: minorOszlopNelkul j tobbi
  where
    oszlopotHagy : Nat -> List Integer -> List Integer
    oszlopotHagy _ Nil = Nil
    oszlopotHagy Z (_ :: maradek) = maradek
    oszlopotHagy (S k) (x :: maradek) = x :: oszlopotHagy k maradek

public export
determinans : List (List Integer) -> Integer
determinans Nil = 1
determinans (sor :: tobbi) = elsoSorSzerinti 0 sor
  where
    elsoSorSzerinti : Nat -> List Integer -> Integer
    elsoSorSzerinti _ Nil = 0
    elsoSorSzerinti j (elem :: maradek) =
      (if mod (cast j) 2 == 0 then elem else negate elem)
        * determinans (minorOszlopNelkul j tobbi)
      + elsoSorSzerinti (S j) maradek

-- ─── 3. KIMERÍTŐ ELLENŐRZÉSEK (futásidejű, §18(b) szellemében) ──

||| Minden cella szimmetrikus-e: A(i,j) = A(j,i).
public export
mindenSzimmetrikus : Bool
mindenSzimmetrikus = kartanMatrix == transzponal kartanMatrix

||| Minden átlóbeli elem 2-e? (az i-edik sor i-edik eleme)
public export
mindenAtloKetto : Bool
mindenAtloKetto = go 0 kartanMatrix
  where
    go : Nat -> List (List Integer) -> Bool
    go _ Nil = True
    go i (sor :: tobbi) = atloElem i sor == 2 && go (S i) tobbi
      where
        atloElem : Nat -> List Integer -> Integer
        atloElem _ Nil = 0
        atloElem Z (x :: _) = x
        atloElem (S k) (_ :: xs) = atloElem k xs

||| Minden elem a {−1, 0, 2} halmazból való-e?
public export
mindenElemErvenyes : Bool
mindenElemErvenyes = all (\sor => all ervenyes sor) kartanMatrix
  where
    ervenyes : Integer -> Bool
    ervenyes e = e == 2 || e == 0 || e == (-1)

||| A determináns tétel: det(E8 Cartan) = 1.
public export
bizDeterminansEgy : Bool
bizDeterminansEgy = determinans kartanMatrix == 1

── ─── 4. EGYSZERŰ GYÖKÖK — a Wikipedia-féle ±½ modell (2-szeres skálán) ──

||| Az egyszerű gyökök a projekt E8Gyök típusában (2-szeres egész skálán).
||| Forrás: Wikipedia „E8 (mathematics)" simple-roots mátrix, 2026-08-22-i állapot.
public export
egyszeruGyokek : List E8Gyök
egyszeruGyokek =
  [ E8GyökKonstruktor   2  (-2)   0    0    0    0    0    0
  , E8GyökKonstruktor   0    2  (-2)   0    0    0    0    0
  , E8GyökKonstruktor   0    0    2  (-2)   0    0    0    0
  , E8GyökKonstruktor   0    0    0    2  (-2)   0    0    0
  , E8GyökKonstruktor   0    0    0    0    2  (-2)   0    0
  , E8GyökKonstruktor   0    0    0    0    0    2    2    0
  , E8GyökKonstruktor (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1)
  , E8GyökKonstruktor   0    0    0    0    0    2  (-2)   0
  ]

||| Mátrix (i,j)-edik eleme.
matrixElem : Nat -> Nat -> List (List Integer) -> Integer
matrixElem i j Nil = 0
matrixElem i j (sor :: tobbi) =
  if i == 0 then sorEleme j sor else matrixElem (pred i) j tobbi
  where
    sorEleme : Nat -> List Integer -> Integer
    sorEleme _ Nil = 0
    sorEleme Z (x :: _) = x
    sorEleme (S k) (_ :: xs) = sorEleme k xs

||| Az i-edik egyszerű gyök.
iEdikGyok : Nat -> List E8Gyök -> E8Gyök
iEdikGyok i (g :: _) = g  -- biztonsági visszatérés helytelen indexnél: első
iEdikGyok _ Nil = E8GyökKonstruktor 0 0 0 0 0 0 0 0
iEdikGyok Z (g :: _) = g
iEdikGyok (S k) (_ :: gs) = iEdikGyok k gs

||| KONSZISZTENCIA-HÍD a meglévő kódhoz:
||| minden i≠j-re: belsőszorzat(αi,αj) = −A(i,j)
||| és átlóra: belsőszorzat(αi,αi) = 2·A(i,i)/2 = 2 (egységnyi hossz).
public export
kartanGyokKonzisztencia : Bool
kartanGyokKonzisztencia = go 0 0
  where
    n : Nat
    n = 8
    go : Nat -> Nat -> Bool
    go i j =
      let ai = iEdikGyok i egyszeruGyokek
          aj = iEdikGyok j egyszeruGyokek
          szorzat = belsoszorzat ai aj
          varhato = if i == j then 2 else negate (matrixElem i j kartanMatrix)
          joE = szorzat == varhato
      in if j >= pred n then (if i >= pred n then joE else go (S i) 0)
         else (joE && go i (S j))

-- ─── 4. SHOW-JELENTÉS ÉS MAIN ─────────────────────────────────

||| Egy teszt eredményének megjelenítése.
tesztSor : String -> Bool -> String
tesztSor nev ok =
  nev ++ ": " ++ (if ok then "✓ OK" else "✗ HIBA")

||| A teljes Cartan-jelentés — futtatható ellenőrzés.
public export
kartanJelentes : String
kartanJelentes =
  "── E8 Kartan-mátrix jelentés ──\n"
  ++ tesztSor "szimmetria (64 cella)" mindenSzimmetrikus ++ "\n"
  ++ tesztSor "átló = 2 (8 hely)" mindenAtloKetto ++ "\n"
  ++ tesztSor "elemek ∈ {−1,0,2}" mindenElemErvenyes ++ "\n"
  ++ tesztSor "determináns = 1" bizDeterminansEgy ++ "\n"
  ++ tesztSor "egyszerű gyökök ↔ Cartan konzisztencia" kartanGyokKonzisztencia ++ "\n"

main : IO ()
main = putStrLn kartanJelentes
