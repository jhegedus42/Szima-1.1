module SzabalyParszer

-- ═══════════════════════════════════════════════════════════════
-- SZABÁLY-PARSZER — általánosítható, TÍPUSOS (String-mentes mag)
-- ═══════════════════════════════════════════════════════════════
-- Alapelv (AGENTS.md): a mag típusokban NINCS String.
--   A SZÓ = Fonetika (Hang-konstruktorok listája):
--     meny = [Mm, Ve, Dny]   — szó szerint konstruktorok
--   A String csak a határon él (magyarHangok — a gauge),
--   és a Show-ban (megjelenítés).
--
-- Teszteset: AkH. 226.f (geminátum-elválasztás), de a szerkezet
-- ÁLTALÁNOS: bármely „Ha <feltétel>, <következmény>: <példák"
-- alakú szabályra, és a verifikáció mind a 9 digráfra paraméteres.
--
-- Rétegek:
--   NYELVI     — a mondat szerkezete típusokkal (feltétel/következmény)
--   FONETIKAI  — a példák Hang-listákként + geminátum-detektor
--   SZEMANTIKAI— eset-szerepek + VERIFIKÁCIÓ (a típusokon számolva)
-- ═══════════════════════════════════════════════════════════════

import Fonetika
import MagyarNyelvtan

%default total

-- ─── 1. A SZÓ MINT ADATTÍPUS (String-mentes!) ──────────────
-- A magyar szó = Hang-konstruktorok listája. Példák az AkH.
-- 226.f mondatából, kézzel konstruálva (a String sosem jelenik meg):

public export
szomeny : Fonetika                    -- „meny" = [m ɛ ɲ]
szomeny = [MassalhangzoHang Mm, MaganhangzoHang Ve, DigrafHang Dny]

public export
szonyi : Fonetika                     -- „nyi"  = [ɲ i]
szonyi = [DigrafHang Dny, MaganhangzoHang Vi]

public export
szoosz : Fonetika                     -- „ösz"  = [ø s]
szoosz = [MaganhangzoHang Voe, DigrafHang Dsz]

public export
szosze : Fonetika                     -- „sze"  = [s ɛ]
szosze = [DigrafHang Dsz, MaganhangzoHang Ve]

public export
szopogy : Fonetika                    -- „pogy" = [p o ɟ]
szopogy = [MassalhangzoHang Mp, MaganhangzoHang Vo, DigrafHang Dgy]

public export
szogyasz : Fonetika                   -- „gyász" = [ɟ aː s]
szogyasz = [DigrafHang Dgy, MaganhangzoHang Vaa, MassalhangzoHang Ms]

public export
szosity : Fonetika                    -- „szity" = [s i c]
szosity = [DigrafHang Dsz, MaganhangzoHang Vi, DigrafHang Dty]

public export
szotya : Fonetika                     -- „tya"  = [c ɒ]
szotya = [DigrafHang Dty, MaganhangzoHang Va]

public export
szoboty : Fonetika                    -- „Boty" = [b o c]
szoboty = [MassalhangzoHang Mb, MaganhangzoHang Vo, DigrafHang Dty]

public export
szotyan : Fonetika                    -- „tyán" = [c aː n]
szotyan = [DigrafHang Dty, MaganhangzoHang Vaa, MassalhangzoHang Mn]

public export
szohosz : Fonetika                    -- „Hosz" = [h o s]
szohosz = [MassalhangzoHang Mh, MaganhangzoHang Vo, DigrafHang Dsz]

public export
szoszu : Fonetika                     -- „szú"  = [s uː]
szoszu = [DigrafHang Dsz, MaganhangzoHang Vuu]

public export
szoily : Fonetika                     -- „Ily"  = [i l j]
szoily = [MaganhangzoHang Vi, MassalhangzoHang Ml, DigrafHang Dly]

public export
szolyes : Fonetika                    -- „lyés" = [j eː ʃ]
szolyes = [DigrafHang Dly, MaganhangzoHang Vee, MassalhangzoHang Ms]

-- ─── 2. FONETIKAI RÉTEG — geminátum-műveletek (általános) ──

public export
elsoHang : Fonetika -> Maybe Hang
elsoHang [] = Nothing
elsoHang (x :: _) = Just x

public export
utolsoHang : Fonetika -> Maybe Hang
utolsoHang [] = Nothing
utolsoHang [x] = Just x
utolsoHang (_ :: xs) = utolsoHang xs

--| Az első szó utolsó hangja és a második szó első hangja
--| UGYANAZ a digráf-e? (A geminátum szétoszlásának típusos tesztje.)
public export
geminaltPar : Fonetika -> Fonetika -> Maybe Digraf
geminaltPar elsoMasodik masodikElso = case (utolsoHang elsoMasodik, elsoHang masodikElso) of
  (Just (DigrafHang d1), Just (DigrafHang d2)) =>
    if d1 == d2 then Just d1 else Nothing
  _ => Nothing

--| Az egybeolvasott alak geminátumos-e? (szomszédos azonos hangok)
public export
geminatumosE : Fonetika -> Bool
geminatumosE [] = False
geminatumosE [_] = False
geminatumosE (x :: y :: xs) = (x == y) || geminatumosE (y :: xs)

-- ─── 3. A PÉLDA MINT TÍPUS ─────────────────────────────────

--| Egy elválasztási példa: két szó (Hang-lista) + a bennük
--| szétoszló geminátum-digráf. A String sehol.
public export
record GemPelda where
  constructor GemPeldaK
  elsoResz     : Fonetika    -- „meny"  = [m ɛ ɲ]
  masodikResz  : Fonetika    -- „nyi"   = [ɲ i]
  geminalt     : Digraf      -- ny

--| Példa konstrukciója VERIFIKÁLVA: csak akkor készül el,
--| ha a két rész között valóban ugyanaz a digráf oszlik meg.
--| (A rossz példa nem reprezentálható — a típus kizárja!)
public export
gemPelda : (elso, masodik : Fonetika) -> Maybe GemPelda
gemPelda e m = case geminaltPar e m of
  Just d  => Just (GemPeldaK e m d)
  Nothing => Nothing

--| A példa egybeolvasott alakja (a geminátum visszaáll).
public export
egybe : GemPelda -> Fonetika
egybe p = elsoResz p ++ masodikResz p

--| A példa teljesíti-e az AkH. 226.f-t: a geminátum
--    (a) valóban szétosztlik a határon,
--    (b) az egybeolvasott alakban tényleg geminátum áll,
--    (c) a szétosztott digráf mindkét oldalon TELJES.
public export
peldaTeljesitiAkH : GemPelda -> Bool
peldaTeljesitiAkH p =
  geminatumosE (egybe p) &&
  (case geminaltPar (elsoResz p) (masodikResz p) of
     Just _ => True
     Nothing => False)

public export
Show GemPelda where
  show p = show (elsoResz p) ++ "-" ++ show (masodikResz p)
        ++ " (" ++ show (geminalt p) ++ "-geminátum)"

-- ─── 4. A SZABÁLY MONDATÁNAK SZERKEZETE (általánosítható) ──

--| A szabály feltétel-elemei — az AkH. 226.f nyelvi tartalma
--    típusokként (nem szöveggé). ÁLTALÁNOS: bármely elválasztási
--    szabály ilyen elemek kombinációja lehet.
public export
data FeltetelElem =
    KettMagHangKozott          -- „két magánhangzó között"
  | HosszuMassalhangzoAll      -- „hosszú mássalhangzó"
  | EgyszerusitveKettozott     -- „egyszerűsítve kettőzött"
  | TobbjegyuBetu              -- „többjegyű betű"

public export
Show FeltetelElem where
  show KettMagHangKozott    = "két magánhangzó között (inessivus)"
  show HosszuMassalhangzoAll = "hosszú mássalhangzó áll"
  show EgyszerusitveKettozott = "egyszerűsítve kettőzött"
  show TobbjegyuBetu         = "többjegyű betű"

--| A következmény — a szabály előírása.
public export
data Kovetkezmeny =
    TeljesRovidSorVegen       -- „a sor végén a teljes rövid"
  | TeljesRovidSorElejen      -- „a következő sor elején a teljes rövid"

public export
Show Kovetkezmeny where
  show TeljesRovidSorVegen  = "a sor végén a teljes rövid (superessivus)"
  show TeljesRovidSorElejen = "a következő sor elején a teljes rövid (superessivus)"

--| Szemantikai eset-szerep: a szabály mondatában egy kifejezés
--    és az általa hordozott nyelvtani eset (a jelentés hordozója).
public export
record Szerep where
  constructor SzerepK
  eset  : Esetrag
  mit   : Fonetika   -- a kifejezés Hang-alakja (nem String!)

public export
Show Szerep where
  show sz = esetragNev (eset sz) ++ " ← " ++ show (mit sz)

-- A 226.f mondat szereplői (Hang-listaként):
public export
kifejezesKozott : Fonetika   -- „között" = [k ø z eː tː] fonémákban
kifejezesKozott = [MassalhangzoHang Mk, MaganhangzoHang Voe,
                   MassalhangzoHang Mz, MaganhangzoHang Vee,
                   MassalhangzoHang Mt]

public export
kifejezesVegen : Fonetika    -- „végén" = [v eː ɡ eː n]
kifejezesVegen = [MassalhangzoHang Mv, MaganhangzoHang Vee,
                  MassalhangzoHang Mg, MaganhangzoHang Vee,
                  MassalhangzoHang Mn]

public export
kifejezesElejen : Fonetika   -- „elején" = [ɛ l ɛ j eː n]
kifejezesElejen = [MaganhangzoHang Ve, MassalhangzoHang Ml,
                   MaganhangzoHang Ve, DigrafHang Dly,
                   MaganhangzoHang Vee, MassalhangzoHang Mn]

--| A nyelvtani szabály teljes típusos reprezentációja:
--    forrás, feltételek, következmény, példák (GemPelda!), szerepek,
--    és a VERIFIKÁCIÓ eredménye (a típusokon KISZÁMOLVA).
public export
record NyelvtaniSzabaly where
  constructor SzabalyK
  azonosito   : String          -- csak címke (Show-réteg)
  feltetelek  : List FeltetelElem
  kovetkezmeny : List Kovetkezmeny
  peldak      : List GemPelda
  szerepek    : List Szerep

--| A VERIFIKÁCIÓ: a szabály minden példán teljesül-e.
--| (Ez a szemantikai réteg érvényesítése — tisztán a típusokon.)
public export
szabalyTeljesul : NyelvtaniSzabaly -> Bool
szabalyTeljesul z = case peldak z of
  [] => False
  ps => mind ps
  where
    mind : List GemPelda -> Bool
    mind [] = True
    mind (p :: rest) = peldaTeljesitiAkH p && mind rest

public export
Show NyelvtaniSzabaly where
  show z = "═══ " ++ azonosito z ++ " ═══\n"
        ++ "FELTÉTELEK: " ++ show (feltetelek z) ++ "\n"
        ++ "KÖVETKEZMÉNY: " ++ show (kovetkezmeny z) ++ "\n"
        ++ "SZEREPEK (szemantika): "
        ++ concatMap (\s => show s ++ "; ") (szerepek z) ++ "\n"
        ++ "PÉLDÁK (fonetika): "
        ++ concatMap (\p => show p ++ "; ") (peldak z) ++ "\n"
        ++ "VERIFIKÁCIÓ: "
        ++ (if szabalyTeljesul z then "✓ MINDEN példán teljesül"
                                 else "✗ NEM teljesül")

-- ─── 5. AZ AKH. 226.f — típusosan definiálva ──────────────

public export
akH226fPeldak : List (Maybe GemPelda)
akH226fPeldak =
  [ gemPelda szomeny  szonyi    -- meny-nyi
  , gemPelda szoosz   szosze    -- ösz-sze
  , gemPelda szopogy  szogyasz  -- pogy-gyász
  , gemPelda szosity  szotya    -- szity-tya
  , gemPelda szoboty  szotyan   -- Boty-tyán
  , gemPelda szohosz  szoszu    -- Hosz-szú
  , gemPelda szoily   szolyes   -- Ily-lyés
  ]

public export
akH226fTiszttaPeldak : List GemPelda
akH226fTiszttaPeldak = mapMaybe id akH226fPeldak

public export
akH226f : NyelvtaniSzabaly
akH226f = SzabalyK
  "AkH. 226.f"
  [ KettMagHangKozott, HosszuMassalhangzoAll
  , EgyszerusitveKettozott, TobbjegyuBetu ]
  [ TeljesRovidSorVegen, TeljesRovidSorElejen ]
  akH226fTiszttaPeldak
  [ SzerepK InessivusE kifejezesKozott
  , SzerepK SuperessivusE kifejezesVegen
  , SzerepK SuperessivusE kifejezesElejen
  ]

-- ─── 6. ÁLTALÁNOSÍTÁS — mind a 9 digráf geminációja ────────
-- A szabály univerzuma: minden digráfra létezik (elvileg) példa.
-- Itt konstruálunk mindegyikre egy MINIMALIS típikus alakot:
-- X-Y alak, ahol az első rész magánhangzó+digráf, a második
-- digráf+magánhangzó (a szétoszlás kanonikus alakja).

public export
kanonikusGemPelda : Digraf -> Maybe GemPelda
kanonikusGemPelda d =
  gemPelda [MaganhangzoHang Ve, DigrafHang d]
           [DigrafHang d, MaganhangzoHang Ve]

public export
osszesDigraf : List Digraf
osszesDigraf = [Dcs, Dgy, Dly, Dny, Dsz, Dty, Dzs, Ddz, Ddzs]

--| Mind a 9 digráf kanonikus geminátuma (az oktonion teljes
--| imaginárius-rendszere geminációban!).
public export
oktonionGeminaciok : List (Maybe GemPelda)
oktonionGeminaciok = map kanonikusGemPelda osszesDigraf

public export
oktonionGeminaciokTisztta : List GemPelda
oktonionGeminaciokTisztta = mapMaybe id oktonionGeminaciok

-- ─── 7. A HATÁR-FÜGGVÉNY (gauge): String -> típus ──────────
-- Ez az EGYETLAN pont, ahol String szerepel: a külvilág
-- (szabálykönyv szövege) és a típusok közötti határ.
-- Bemenet: egy kötőjeles elválasztási példa szövegként.
-- Kimenet: a típusos GemPelda — vagy Nothing, ha nem sikerül.

kettoboSeged : Char -> List Char -> List (List Char)
kettoboSeged c [] = [[]]
kettoboSeged c (x :: xs) =
  if x == c
    then [] :: kettoboSeged c xs
    else case kettoboSeged c xs of
           (e :: t) => (x :: e) :: t
           [] => [[x]]

public export
kettobo : String -> Maybe (String, String)
kettobo s = case kettoboSeged '-' (unpack s) of
  [a, b] => Just (pack a, pack b)
  _ => Nothing

public export
peldatParszol : String -> Maybe GemPelda
peldatParszol s = do
  (a, b) <- kettobo s
  gemPelda (magyarHangok a) (magyarHangok b)

-- Hangsorok strukturális egyezősége
hangokEgyenlok : Fonetika -> Fonetika -> Bool
hangokEgyenlok [] [] = True
hangokEgyenlok (x :: xs) (y :: ys) = (x == y) && hangokEgyenlok xs ys
hangokEgyenlok _ _ = False

-- Strukturális egyezőség két Maybe GemPelda közt (Eq instance nélkül)
public export
egyezikE : Maybe GemPelda -> Maybe GemPelda -> Bool
egyezikE Nothing Nothing = True
egyezikE (Just p1) (Just p2) =
  hangokEgyenlok (elsoResz p1) (elsoResz p2) &&
  hangokEgyenlok (masodikResz p1) (masodikResz p2)
egyezikE _ _ = False


-- ─── 8. MAIN — vékony IO-burkoló (csak show!) ─────────────

main : IO ()
main = do
  putStrLn (show akH226f)
  putStrLn ""
  putStrLn ("── Az oktonion 9 digráfjának kanonikus geminációja ──")
  putStrLn (show oktonionGeminaciokTisztta)
  putStrLn ""
  putStrLn ("── Határ-teszt: a parser és a kézi típusok egyeznek-e? ──")
  putStrLn (show (egyezikE (peldatParszol "meny-nyi") (gemPelda szomeny szonyi)))