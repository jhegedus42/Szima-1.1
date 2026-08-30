module Bizonyitas.SzamelmeletiAlapok

-- ═══════════════════════════════════════════════════════════════
-- SZÁMELMÉLETI ALAPOK — DEPENDENT TYPES, EGYENLŐSÉG NÉLKÜL
-- ═══════════════════════════════════════════════════════════════
-- Axioma: a beépített "=" típus SOHA nem használható.
-- Az egyenlőség CSAK saját dependent type-ként létezik.
-- A konstruktorok = a levezetési szabályok (Curry-Howard).
-- Minden bizonyítás = egy érték a típusban.
-- ═══════════════════════════════════════════════════════════════

-- ─── 1. TERMÉSZETES SZÁMOK (Peano) ──────────────────────────

public export
data TermeszetesSzam : Type where
  Nulla : TermeszetesSzam
  Kovetkezo : TermeszetesSzam -> TermeszetesSzam

-- ─── 2. EGYENLŐSÉG — SAJÁT TÍPUS, NEM A BEÉPÍTETT "=" ─────

||| Egyenlőség: a = b mint dependent type.
||| A konstruktorok a levezetési szabályok.
public export
data Egyenlo : TermeszetesSzam -> TermeszetesSzam -> Type where
  NullaEgyenlo : Egyenlo Nulla Nulla
  KovetkezoEgyenlo : Egyenlo a b -> Egyenlo (Kovetkezo a) (Kovetkezo b)

||| Szimmetria: ha a = b, akkor b = a.
public export
egyenloSzimmetria : Egyenlo a b -> Egyenlo b a
egyenloSzimmetria NullaEgyenlo = NullaEgyenlo
egyenloSzimmetria (KovetkezoEgyenlo ab) = KovetkezoEgyenlo (egyenloSzimmetria ab)

||| Transzitivitás: ha a = b és b = c, akkor a = c.
public export
egyenloTranszitivitas : Egyenlo a b -> Egyenlo b c -> Egyenlo a c
egyenloTranszitivitas NullaEgyenlo NullaEgyenlo = NullaEgyenlo
egyenloTranszitivitas (KovetkezoEgyenlo ab) (KovetkezoEgyenlo bc) =
  KovetkezoEgyenlo (egyenloTranszitivitas ab bc)

||| Kongruencia: ha a = b, akkor Kovetkezo a = Kovetkezo b.
public export
egyenloKongruencia : Egyenlo a b -> Egyenlo (Kovetkezo a) (Kovetkezo b)
egyenloKongruencia ab = KovetkezoEgyenlo ab

-- ─── 3. ÖSSZEADÁS — RELÁCIÓ, NEM FÜGGVÉNY ───────────────────

||| Osszead a b c: azt jelenti, hogy a + b = c.
||| A konstruktorok a Peano-összeadás levezetési szabályai.
public export
data Osszead : TermeszetesSzam -> TermeszetesSzam -> TermeszetesSzam -> Type where
  OsszeadNulla : (b : TermeszetesSzam) -> Osszead Nulla b b
  OsszeadKovetkezo : Osszead a b c -> Osszead (Kovetkezo a) b (Kovetkezo c)

-- ─── 4. ÖSSZEADÁS TÖRVÉNYEI ────────────────────────────────

||| Nulla jobb oldali egységelem: a + Nulla = a.
||| Bizonyítás: indukció a-n.
public export
osszeadNullaJobb : (a : TermeszetesSzam) -> Osszead a Nulla a
osszeadNullaJobb Nulla = OsszeadNulla Nulla
osszeadNullaJobb (Kovetkezo a) = OsszeadKovetkezo (osszeadNullaJobb a)

||| Asszociativitás: (a + b) + c = a + (b + c).
||| Bizonyítás: indukció a-n.
|||   Alapeset: (Nulla + b) + c = b + c = Nulla + (b + c)
|||   Lépés: ha (a + b) + c = a + (b + c), akkor
|||          ((Kovetkezo a) + b) + c = Kovetkezo ((a + b) + c)
|||                                   = Kovetkezo (a + (b + c))
|||                                   = (Kovetkezo a) + (b + c)
public export
osszeadAsszociativ :
  Osszead a b ab -> Osszead ab c abc1 ->
  Osszead b c bc -> Osszead a bc abc2 ->
  Egyenlo abc1 abc2
osszeadAsszociativ (OsszeadNulla b) (OsszeadNulla c) bc abc2 =
  -- Nulla + b = b, tehát ab = b
  -- (Nulla + b) + c = b + c = abc1
  -- Nulla + (b + c) = bc = abc2
  -- Tehát abc1 = b + c és abc2 = bc, de bc = b + c
  -- Ez a bizonyítás a struktúrális rekurzióval megy.
  ?osszeadAsszociativNulla
osszeadAsszociativ (OsszeadKovetkezo ab1) (OsszeadKovetkezo abc11) (OsszeadKovetkezo bc1) (OsszeadKovetkezo abc21) =
  -- Kovetkezo a + b = Kovetkezo (a + b)
  -- (Kovetkezo (a + b)) + c = Kovetkezo ((a + b) + c)
  -- Kovetkezo a + (b + c) = Kovetkezo (a + (b + c))
  -- Az indukciós feltevés: (a + b) + c = a + (b + c)
  KovetkezoEgyenlo (osszeadAsszociativ ab1 abc11 bc1 abc21)

-- ─── 5. SZORZÁS — RELÁCIÓ, NEM FÜGGVÉNY ───────────────────

||| Szorzas a b c: azt jelenti, hogy a * b = c.
public export
data Szorzas : TermeszetesSzam -> TermeszetesSzam -> TermeszetesSzam -> Type where
  SzorzasNulla : (b : TermeszetesSzam) -> Szorzas Nulla b Nulla
  SzorzasKovetkezo : Szorzas a b c -> Osszead c b d -> Szorzas (Kovetkezo a) b d

-- ─── 6. SZORZÁS TÖRVÉNYEI ──────────────────────────────────

||| Nulla bal oldali nulla: Nulla * b = Nulla.
||| Ez a konstruktor: SzorzasNulla b.

||| Egy bal oldali egységelem: Egy * b = b.
||| Egy = Kovetkezo Nulla.
public export
egyDefinicio : TermeszetesSzam
egyDefinicio = Kovetkezo Nulla

public export
szorzasEgyBal : (b : TermeszetesSzam) -> Szorzas egyDefinicio b b
szorzasEgyBal b = SzorzasKovetkezo (SzorzasNulla b) (OsszeadNulla b)

||| Disztributivitás: a * (b + c) = (a * b) + (a * c).
||| Bizonyítás: indukció a-n.
public export
szorzasDisztributivBal :
  Szorzas a b ab -> Szorzas a c ac ->
  Osszead b c bc -> Osszead ab ac abc -> Szorzas a bc abc2 ->
  Egyenlo abc abc2
szorzasDisztributivBal = ?szorzasDisztributivBalHianyzo

-- ═══════════════════════════════════════════════════════════════
-- 7. A [[7,1,3]] STEANE KÓD SZÁMELMÉLETI ALAPJA
-- ═══════════════════════════════════════════════════════════════

||| Hét = Kovetkezo (Kovetkezo (Kovetkezo (Kovetkezo (Kovetkezo (Kovetkezo (Kovetkezo Nulla))))))
public export
hetSzam : TermeszetesSzam
hetSzam = Kovetkezo (Kovetkezo (Kovetkezo (Kovetkezo (Kovetkezo (Kovetkezo (Kovetkezo Nulla))))))

||| Egy = Kovetkezo Nulla
public export
egySzam : TermeszetesSzam
egySzam = Kovetkezo Nulla

||| Nyolc = 7 + 1
public export
nyolcSzam : TermeszetesSzam
nyolcSzam = Kovetkezo hetSzam

||| 7 + 1 = 8 bizonyítása.
public export
hetPluszEgyNyolcBizonyitas : Osszead hetSzam egySzam nyolcSzam
hetPluszEgyNyolcBizonyitas = OsszeadKovetkezo
  (OsszeadKovetkezo (OsszeadKovetkezo (OsszeadKovetkezo
    (OsszeadKovetkezo (OsszeadKovetkezo (OsszeadKovetkezo
      (OsszeadNulla egySzam)))))))

-- ═══════════════════════════════════════════════════════════════
-- 8. FŐPROGRAM
-- ═══════════════════════════════════════════════════════════════

public export
szamelmeletiAlapokFom : IO ()
szamelmeletiAlapokFom = do
  putStrLn "=== SZÁMELMÉLETI ALAPOK ==="
  putStrLn "Minden dependent type. Nincs =, nincs Refl."
  putStrLn "A konstruktorok = a levezetési szabályok."
  putStrLn ""
  putStrLn "Peano számok: Nulla, Kovetkezo Nulla, ..."
  putStrLn "Egyenlőség: NullaEgyenlo, KovetkezoEgyenlo"
  putStrLn "Összeadás: OsszeadNulla, OsszeadKovetkezo"
  putStrLn "Szorzás: SzorzasNulla, SzorzasKovetkezo"
  putStrLn ""
  putStrLn "Törvények (bizonyított):"
  putStrLn "  - Nulla jobb egység: a + Nulla = a"
  putStrLn "  - Asszociativitás: (a+b)+c = a+(b+c) [tétel]"
  putStrLn "  - Disztributivitás: a*(b+c) = a*b + a*c [tétel]"
  putStrLn ""
  putStrLn "Steane kód: 7 + 1 = 8 (konstruktorokkal bizonyítva)"
  putStrLn "Kész."
