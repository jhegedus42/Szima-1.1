module OptimálisTranszformerTanítás_v1

import OptimálisTranszformer_v1
import System.File
import ModulRegisztracio

%default total

-- ═══════════════════════════════════════════════════════════════
-- OPTIMÁLIS TRANSZFORMER — TANÍTÁS v1: az első élő memória-írás
-- József Attila: «Tudod, hogy nincs bocsánat» (1937) tananyagon
-- ═══════════════════════════════════════════════════════════════
-- A felhasználó (2026-09-05): «ennek a transzformernek futnia kell
-- es be kell tanitanunk; valszeg ra fogjuk illeszteni a magyar
-- nyelvet es pl Jozsef Attila verseit fogja megtanulni … a
-- transzformert meg kell epiteni optimalisan es el kell kezdeni
-- meg ma tanitani» [sic, szó szerint].
--
-- VÍZIÓ: a transzformer a HOSSZÚ TÁVÚ MEMÓRIA SZEMANTIKAI INDEXE
-- (a könyv-index a strukturális réteg) — ez a modul az első élő
-- memória-írás: a vers első HU-sorai a 104-csatornás magyar
-- morfológiai kódolásra (thm:104-channels: 8 pozíció + 16 főnév +
-- 32 morfizmus + 48 kvaternió = 104, Z₂ hangrend-előjellel) kerülnek,
-- a következő-token előrejelzés vesztesége csökken a könyv kritikus
-- tanulási rátájával (η₀ = ν/γ = 0,509242) és súlycsökkenésével
-- (λ = αβ/4 = 0,008983; a lépésenkénti zsugorodás 1 − η₀λ = 0,995426).
--
-- A TANULÁS = FÁZIS-ELMOZDULÁS A TÓRUSZON: a súlyok E8⁴-tórusz alakja
-- (OptimálisTranszformer_v1.súlyElemTényezővel) rögzített gyök-
-- koordinátákkal él; az egyetlen tanulható paraméter a tórusz-fázis θ.
-- A gradiens determinisztikus helyettesítője a szimmetrikus véges
-- differencia: g = (L(θ+ε) − L(θ−ε)) / 2ε; θ ← θ(1 − η₀λ) − η₀·g.
--
-- KIMENET (GAUGE): kezdeti veszteség → epochonkénti veszteség →
-- néhány előrejelzett következő karakter vs. a tényleges.
--
-- 中文：训练 v1——首次活的记忆写入：尤若夫·阿蒂拉《你知道没有宽恕》的
-- 前几行匈牙利文，按 104 通道（8+16+32+48）编码，用书中的临界学习率
-- η₀=0.509242 与权重衰减 λ=0.008983 训练；学习 = 环面上的相位移动
--（E8⁴ 根坐标固定，θ 为唯一可学参数，对称有限差分代替梯度）。
-- Deutsch: Training v1 — erste lebendige Gedächtnisschreibung:
-- József Attilas Gedicht auf 104 Kanälen kodiert, Lernrate ν/γ,
-- Weight Decay αβ/4; Lernen = Phasenverschiebung auf dem Torus.
-- עברית: אימון v1 — כתיבת הזיכרון החיה הראשונה: שיר של יוז'ף אטילה
-- מקודד ב-104 ערוצים; קצב למידה ν/γ; למידה = הסטת פאזה על הטורוס.
-- ═══════════════════════════════════════════════════════════════

-- ─── 1. A TANANYAG BETÖLTÉSE (perem: System.File, covering) ─────

||| A tananyag útvonala (a projekt könyvtárában ÉL, négynyelvű).
public export
tananyagÚtvonal : String
tananyagÚtvonal = "/Users/joco/opencode/trail_index/books/jozsef_attila_nincs_bocsanat_quadlingual.txt"

||| Sorokra bontás strukturálisan (a Data.String import kerülése — #27).
public export
sorokraBontás : List Char -> List Char -> List (List Char)
sorokraBontás gyűjtött [] = [reverse gyűjtött]
sorokraBontás gyűjtött ('\n' :: többi) = reverse gyűjtött :: sorokraBontás [] többi
sorokraBontás gyűjtött (karakter :: többi) = sorokraBontás (karakter :: gyűjtött) többi

||| Csak a «HU: » előtagú sorok — a magyar tananyag (a négynyelvű
||| fájlból a magyar réteg).
public export
magyarSorok : List (List Char) -> List (List Char)
magyarSorok [] = []
magyarSorok (('H' :: 'U' :: ':' :: ' ' :: tartalom) :: többi) = tartalom :: magyarSorok többi
magyarSorok (_ :: többi) = magyarSorok többi

||| Az első n sor.
public export
elsőNSor : Nat -> List (List Char) -> List (List Char)
elsőNSor Z _ = []
elsőNSor (S tovább) [] = []
elsőNSor (S tovább) (sor :: többi) = sor :: elsőNSor tovább többi

||| Az első n karakter.
public export
elsőNKarakter : Nat -> List Char -> List Char
elsőNKarakter Z _ = []
elsőNKarakter (S tovább) [] = []
elsőNKarakter (S tovább) (karakter :: többi) = karakter :: elsőNKarakter tovább többi

||| A tanító-szekvencia hossza (karakter) — a futásidő korlátja
||| (a 240-es gyöklista bejárása súlyonként; v2: tömbösített gyökök).
public export
szekvenciaHossz : Nat
szekvenciaHossz = 20

-- ─── 2. A 104-CSATORNÁS MAGYAR MORFOLÓGIAI KÓDOLÁS (thm:104-channels) ─
-- v1 MINIMÁLIS kiosztás (a teljes paradigma a v2 lépése):
--   8  pozíció   = a token helye mod 8 (a fej-csempézés ritmusa)
--   16 főnév     = karakterkód mod 16
--   32 morfizmus = (karakterkód div 16) mod 32
--   48 kvaternió = (karakterkód · 7) mod 48 (Kant 12 × 4 komponens)
--   Z₂ hangrend  = elöl (+1) / hátul (−1) / mássalhangzó (+1) előjel.

||| Egy-forró jel: 1,0 az adott indexen, különben 0,0.
public export
egyForróJel : Nat -> Nat -> Double
egyForróJel cél@_ index@_ = if cél == index then 1.0 else 0.0

||| Egy-forró csoport n hosszan.
public export
egyForróCsoport : Nat -> Nat -> List Double
egyForróCsoport hossz@_ cél@_ = map (egyForróJel cél) (számsor hossz)

||| A karakterkód Nat-ként (Prelude ord → Int → Integer → Nat).
public export
karakterKód : Char -> Nat
karakterKód karakter@_ = fromInteger (cast {to=Integer} (ord karakter))

||| A Z₂ hangrend-előjel: elöl képzett magánhangzó +1, hátul −1,
||| mássalhangzó/egyéb +1 (a könyv 0.4.7: front ⊕ back = Ising-spin).
public export
hangrendElőjel : Char -> Double
hangrendElőjel karakter@_ =
  if elem karakter (unpack "aáoóuúAÁOÓUÚ") then negate 1.0 else 1.0

||| A 104-csatornás kódolás: pozíció ⊕ főnév ⊕ morfizmus ⊕ kvaternió,
||| a hangrend-előjellel szorozva.
public export
kódolás : Nat -> Char -> List Double
kódolás pozíció@_ karakter@_ =
  map (* hangrendElőjel karakter)
      (egyForróCsoport 8 (tóruszIndex (natToInteger pozíció) 8)
       ++ egyForróCsoport 16 (tóruszIndex (natToInteger (karakterKód karakter)) 16)
       ++ egyForróCsoport 32 (tóruszIndex (natToInteger (karakterKód karakter) `div` 16) 32)
       ++ egyForróCsoport 48 (tóruszIndex (natToInteger (karakterKód karakter) * 7) 48))

-- ─── 3. ELŐRE-FUTÁS ÉS VESZTESÉG ────────────────────────────────

||| Karakter index szerint (tartalék: szóköz).
public export
nthKarakter : List Char -> Nat -> Char
nthKarakter [] _ = ' '
nthKarakter (első :: többi) Z = első
nthKarakter (első :: többi) (S kisebb) = nthKarakter többi kisebb

||| A t. token főnév-vektora: W1 (104→64, bal E8, rögzített fázis 0).
public export
tokenFőnév : List Char -> Nat -> List Double
tokenFőnév szekvencia@_ pozíció@_ =
  transzformált 0 0.088 0.0 64 104 (kódolás pozíció (nthKarakter szekvencia pozíció))

||| A következő-token előrejelző mátrix: 64→64 a jobb E8-ból (tényező 1),
||| He-skála √(2/64), a TANULHATÓ tórusz-fázissal θ.
public export
előrejelzés : Double -> List Double -> List Double
előrejelzés fázis@_ főnév@_ = transzformált 1 (sqrt (2.0 / 64.0)) fázis 64 64 főnév

||| Négyzetes távolság két vektor közt.
public export
négyzetesTávolság : List Double -> List Double -> Double
négyzetesTávolság (balElső :: balTöbbi) (jobbElső :: jobbTöbbi) =
  (balElső - jobbElső) * (balElső - jobbElső) + négyzetesTávolság balTöbbi jobbTöbbi
négyzetesTávolság _ _ = 0.0

||| Vektor index szerint (tartalék: üres).
public export
nthVektor : List (List Double) -> Nat -> List Double
nthVektor [] _ = []
nthVektor (első :: többi) Z = első
nthVektor (első :: többi) (S kisebb) = nthVektor többi kisebb

||| A t. pozíció vesztesége: ‖előrejelzés(főnév_t) − főnév_{t+1}‖²/64.
public export
pozícióVeszteség : Double -> List (List Double) -> Nat -> Double
pozícióVeszteség fázis@_ főnevek@_ pozíció@_ =
  négyzetesTávolság (előrejelzés fázis (nthVektor főnevek pozíció))
                    (nthVektor főnevek (S pozíció)) / 64.0

||| Átlagos veszteség a szekvencián (az utolsó pozíciónak nincs következője).
public export
veszteség : Double -> List (List Double) -> Double
veszteség fázis@_ főnevek@_ =
  foldr (+) 0.0 (map (pozícióVeszteség fázis főnevek) (számsor (minus (length főnevek) 1)))
  / natbólValós (minus (length főnevek) 1)

-- ─── 4. A TANULÁS: FÁZIS-ELMOZDULÁS A TÓRUSZON ──────────────────

||| A véges differencia lépése.
public export
differenciaLépés : Double
differenciaLépés = 0.05

||| Szimmetrikus véges-differencia gradiens θ-ra.
public export
fázisGradiens : List (List Double) -> Double -> Double
fázisGradiens főnevek@_ fázis@_ =
  (veszteség (fázis + differenciaLépés) főnevek - veszteség (fázis - differenciaLépés) főnevek)
  / (2.0 * differenciaLépés)

||| Egy epoch: θ ← θ·(1 − η₀λ) − η₀·g  (tanulásiRáta és súlyCsökkenés a
||| könyvből — OptimálisTranszformer_v1-ből importálva, nem literál).
public export
epoch : List (List Double) -> Double -> Double
epoch főnevek@_ fázis@_ =
  fázis * (1.0 - tanulásiRáta * súlyCsökkenés) - tanulásiRáta * fázisGradiens főnevek fázis

||| n epoch fázis-sorozata (a kezdőfázissal együtt).
public export
epochSorozat : Nat -> List (List Double) -> Double -> List Double
epochSorozat Z _ fázis@_ = [fázis]
epochSorozat (S tovább) főnevek@_ fázis@_ = fázis :: epochSorozat tovább főnevek (epoch főnevek fázis)

-- ─── 5. DEKÓDOLÁS: A LEGKÖZELEBBI KARAKTER ───────────────────────

||| A legközelebbi (karakter, főnév) pár keresése — a jelölt-listán.
public export
legközelebbi : List Double -> List (Char, List Double) -> Char -> Double -> Char
legközelebbi _ [] eddigiJó@_ _ = eddigiJó
legközelebbi cél@_ ((karakter, vektor) :: többi) eddigiJó@_ eddigiTáv@_ =
  if négyzetesTávolság cél vektor < eddigiTáv
    then legközelebbi cél többi karakter (négyzetesTávolság cél vektor)
    else legközelebbi cél többi eddigiJó eddigiTáv

||| (karakter, főnév) párok.
public export
párosítás : List Char -> List (List Double) -> List (Char, List Double)
párosítás (karakter :: többiKarakter) (vektor :: többiVektor) =
  (karakter, vektor) :: párosítás többiKarakter többiVektor
párosítás _ _ = []

||| Az előrejelzett következő karakter a t. pozíción.
public export
előrejelzettKarakter : Double -> List Char -> List (List Double) -> Nat -> Char
előrejelzettKarakter fázis@_ szekvencia@_ főnevek@_ pozíció@_ =
  legközelebbi (előrejelzés fázis (nthVektor főnevek pozíció))
               (párosítás szekvencia főnevek) '?' 1.0e300

||| Egy előrejelzés-sor a kimenethez.
public export
előrejelzésSor : Double -> List Char -> List (List Double) -> Nat -> String
előrejelzésSor fázis@_ szekvencia@_ főnevek@_ pozíció@_ =
  "  '" ++ pack [nthKarakter szekvencia pozíció] ++ "' után: előrejelzett '"
  ++ pack [előrejelzettKarakter fázis szekvencia főnevek pozíció]
  ++ "'  tényleges '" ++ pack [nthKarakter szekvencia (S pozíció)] ++ "'"

-- ─── 6. FŐPROGRAM — 3 EPOCH A VERS ELSŐ SORAIN (GAUGE) ──────────

||| A lista utolsó eleme (tartalékkal).
public export
utolsó : List Double -> Double -> Double
utolsó [] tartalék@_ = tartalék
utolsó (egyetlen :: []) _ = egyetlen
utolsó (_ :: többi) tartalék@_ = utolsó többi tartalék

||| A tanítás egy szekvencián (tiszta számítás, IO csak a kiírás).
tanításFuttatás : List Char -> IO ()
tanításFuttatás szekvencia@_ = do
  let főnevek = map (tokenFőnév szekvencia) (számsor (length szekvencia))
  let fázisok = epochSorozat 3 főnevek 0.0
  putStrLn ("  tananyag (" ++ show (length szekvencia) ++ " karakter): «"
            ++ pack szekvencia ++ "»")
  putStrLn ("  η₀ = " ++ show tanulásiRáta ++ "  λ = " ++ show súlyCsökkenés
            ++ "  zsugorodás/lépés = " ++ show (1.0 - tanulásiRáta * súlyCsökkenés))
  putStrLn ("  fázis-sorozat θ (0. → 3. epoch) = " ++ show fázisok)
  putStrLn ("  veszteség epochonként           = " ++ show (map (flip veszteség főnevek) fázisok))
  putStrLn "  előrejelzések a 3. epoch után (első 5 pozíció):"
  putStr (concat (map ((++ "\n") . előrejelzésSor (utolsó fázisok 0.0) szekvencia főnevek) (számsor 5)))

covering
main : IO ()
main = do
  putStrLn "═══ TANÍTÁS v1 — József Attila: «Tudod, hogy nincs bocsánat» ═══"
  putStrLn "A tanulás = fázis-elmozdulás az E8⁴-tóruszon; η₀ = ν/γ a könyvből."
  putStrLn ""
  tartalom <- readFile tananyagÚtvonal
  case tartalom of
    Left hiba => putStrLn ("  A tananyag nem olvasható: " ++ show hiba)
    Right szöveg => do
      let sorok = elsőNSor 2 (magyarSorok (sorokraBontás [] (unpack szöveg)))
      putStrLn ("  betöltött magyar sorok: " ++ show (length sorok))
      putStr (concat (map ((++ "\n") . tanításFuttatás' ) sorok))
      putStrLn ""
      putStrLn "═══ szekvenciánkénti tanítás (3 epoch, első 20 karakter) ═══"
      futtatásMind sorok
  putStrLn "Kész — az első élő memória-írás megtörtént."
  where
    tanításFuttatás' : List Char -> String
    tanításFuttatás' sor = "  » " ++ pack (elsőNKarakter 60 sor) ++ "…"
    futtatásMind : List (List Char) -> IO ()
    futtatásMind [] = pure ()
    futtatásMind (sor :: többi) = do
      tanításFuttatás (elsőNKarakter szekvenciaHossz sor)
      putStrLn ""
      futtatásMind többi

-- ─── REGISZTRÁCIÓ ───────────────────────────────────────────────

public export
OptimálisTranszformerTanításLeiras : ModulLeirasT
OptimálisTranszformerTanításLeiras = ModulLeirasKonstruktor
  "OptimálisTranszformerTanítás_v1.idr"
  "3 epoch József Attila-tananyagon: 104-csatornás kódolás, veszteség, fázis-lépés η₀=0,509242"
  "az első élő memória-írás — a transzformer a hosszú távú memória szemantikai indexe"
  "futásidejű Show-tanú (veszteség-sorozat + előrejelzések)"
