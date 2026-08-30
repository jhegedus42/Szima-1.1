module ErtelmezoSzotar

-- ═══════════════════════════════════════════════════════════════
-- ÉRTELMEZŐ SZÓTÁR — minden szó és toldalék ADATTÍPUS
-- ═══════════════════════════════════════════════════════════════
-- ELV: minden magyar szó nevesített Fonetika-érték, tisztán
-- Hang-konstruktorokból. NINCS String a magban. A String csak
-- a Show-ban (megjelenítés) jelenik meg.
--
-- A TOLDALÉK is típus: Rag rekord = (fonetika, eset).
-- Az agglutináció = list-összefűzés:
--   ragoz szóHáz ragBan = ház ++ ban = házban
--
-- ÉKSZ-definíció: „Az X olyan Y, amely Z."
--   X = szócím | Y = genus (nem-fogalom) | Z = differentia
--   A differentia ragjai Fillmore-mélyeset-slotok.
-- ═══════════════════════════════════════════════════════════════

import Fonetika
import MagyarNyelvtan
import FanoParitás
import ModulRegisztracio

%default total

-- ─── 1. A SZAVAK MINT NEVESÍTETT TÍPUSÉRTÉKEK ─────────────
-- (szóHáz, szóKör, szóVíz, szóÚt, szóHangvilla már FanoParitás-ban)

-- szócimek:
-- grafikusan: „entrópia"
public export szóEntropia : Fonetika
szóEntropia = [MaganhangzoHang Ve, MassalhangzoHang Mn, MassalhangzoHang Mt, MassalhangzoHang Mr, MaganhangzoHang Voo, MassalhangzoHang Mp, MaganhangzoHang Vi, MaganhangzoHang Va]

-- grafikusan: „kategória"
public export szóKategória : Fonetika
szóKategória = [MassalhangzoHang Mk, MaganhangzoHang Va, MassalhangzoHang Mt, MaganhangzoHang Ve, MassalhangzoHang Mg, MaganhangzoHang Voo, MassalhangzoHang Mr, MaganhangzoHang Vi, MaganhangzoHang Va]

-- grafikusan: „funktor"
public export szóFunktor : Fonetika
szóFunktor = [MassalhangzoHang Mf, MaganhangzoHang Vu, MassalhangzoHang Mn, MassalhangzoHang Mk, MassalhangzoHang Mt, MaganhangzoHang Vo, MassalhangzoHang Mr]

-- grafikusan: „komma"
public export szóKomma : Fonetika
szóKomma = [MassalhangzoHang Mk, MaganhangzoHang Vo, MassalhangzoHang Mm, MassalhangzoHang Mm, MaganhangzoHang Va]

-- grafikusan: „keresés"
public export szóKeresés : Fonetika
szóKeresés = [MassalhangzoHang Mk, MaganhangzoHang Ve, MassalhangzoHang Mr, MaganhangzoHang Ve, MassalhangzoHang Ms, MaganhangzoHang Vee, MassalhangzoHang Ms]

-- grafikusan: „energia"
public export szóEnergia : Fonetika
szóEnergia = [MaganhangzoHang Ve, MassalhangzoHang Mn, MaganhangzoHang Ve, MassalhangzoHang Mr, MassalhangzoHang Mg, MaganhangzoHang Vi, MaganhangzoHang Va]

-- grafikusan: „szótár"
public export szóSzótár : Fonetika
szóSzótár = [DigrafHang Dsz, MaganhangzoHang Voo, MassalhangzoHang Mt, MaganhangzoHang Vaa, MassalhangzoHang Mr]

-- genusok (nem-fogalmak):
-- grafikusan: „eszköz"
public export szóEszköz : Fonetika
szóEszköz = [MaganhangzoHang Ve, DigrafHang Dsz, MassalhangzoHang Mk, MaganhangzoHang Voe, MassalhangzoHang Mz]

-- grafikusan: „mérőszám"
public export szóMérőszám : Fonetika
szóMérőszám = [MassalhangzoHang Mm, MaganhangzoHang Vee, MassalhangzoHang Mr, MaganhangzoHang Voee, DigrafHang Dsz, MaganhangzoHang Vaa, MassalhangzoHang Mm]

-- grafikusan: „struktúra"
public export szóStruktúra : Fonetika
szóStruktúra = [MassalhangzoHang Ms, MassalhangzoHang Mt, MassalhangzoHang Mr, MaganhangzoHang Vu, MassalhangzoHang Mk, MassalhangzoHang Mt, MaganhangzoHang Vuu, MassalhangzoHang Mr, MaganhangzoHang Va]

-- grafikusan: „leképezés"
public export szóLeképezés : Fonetika
szóLeképezés = [MassalhangzoHang Ml, MaganhangzoHang Ve, MassalhangzoHang Mk, MaganhangzoHang Vee, MassalhangzoHang Mp, MaganhangzoHang Ve, MassalhangzoHang Mz, MaganhangzoHang Vee, MassalhangzoHang Ms]

-- grafikusan: „maradék"
public export szóMaradék : Fonetika
szóMaradék = [MassalhangzoHang Mm, MaganhangzoHang Va, MassalhangzoHang Mr, MaganhangzoHang Va, MassalhangzoHang Md, MaganhangzoHang Vee, MassalhangzoHang Mk]

-- grafikusan: „folyamat"
public export szóFolyamat : Fonetika
szóFolyamat = [MassalhangzoHang Mf, MaganhangzoHang Vo, DigrafHang Dly, MaganhangzoHang Va, MassalhangzoHang Mm, MaganhangzoHang Va, MassalhangzoHang Mt]

-- grafikusan: „mennyiség"
public export szóMennyiség : Fonetika
szóMennyiség = [MassalhangzoHang Mm, MaganhangzoHang Ve, MassalhangzoHang Mn, DigrafHang Dny, MaganhangzoHang Vi, MassalhangzoHang Ms, MaganhangzoHang Vee, MassalhangzoHang Mg]

-- grafikusan: „gyűjtemény"
public export szóGyűjtemény : Fonetika
szóGyűjtemény = [DigrafHang Dgy, MaganhangzoHang Vuee, MassalhangzoHang Mj, MassalhangzoHang Mt, MaganhangzoHang Ve, MassalhangzoHang Mm, MaganhangzoHang Vee, DigrafHang Dny]

-- differentia-betöltők (PATIENS szerepű szavak):
-- grafikusan: „hangot"
public export szóHangot : Fonetika
szóHangot = [MassalhangzoHang Mh, MaganhangzoHang Va, MassalhangzoHang Mng, MaganhangzoHang Vo, MassalhangzoHang Mt]

-- grafikusan: „jelet"
public export szóJelet : Fonetika
szóJelet = [MassalhangzoHang Mj, MaganhangzoHang Ve, MassalhangzoHang Ml, MaganhangzoHang Ve, MassalhangzoHang Mt]

-- grafikusan: „szót"
public export szóSzót : Fonetika
szóSzót = [DigrafHang Dsz, MaganhangzoHang Voo, MassalhangzoHang Mt]

-- grafikusan: „kérdést"
public export szóKérdést : Fonetika
szóKérdést = [MassalhangzoHang Mk, MaganhangzoHang Vee, MassalhangzoHang Mr, MassalhangzoHang Md, MaganhangzoHang Vee, MassalhangzoHang Ms, MassalhangzoHang Mt]

-- grafikusan: „hőmérőt"
public export szóHőmérőt : Fonetika
szóHőmérőt = [MassalhangzoHang Mh, MaganhangzoHang Voee, MassalhangzoHang Mm, MaganhangzoHang Vee, MassalhangzoHang Mr, MaganhangzoHang Voee, MassalhangzoHang Mt]

-- egyszótagú alapszavak (a teljes alap szókincs típusként):
-- grafikusan: „szó"
public export szóSzó : Fonetika
szóSzó = [DigrafHang Dsz, MaganhangzoHang Voo]

-- grafikusan: „tő"
public export szóTő : Fonetika
szóTő = [MassalhangzoHang Mt, MaganhangzoHang Voee]

-- grafikusan: „szív"
public export szóSzív : Fonetika
szóSzív = [DigrafHang Dsz, MaganhangzoHang Vii, MassalhangzoHang Mv]

-- grafikusan: „él"
public export szóÉl : Fonetika
szóÉl = [MaganhangzoHang Vee, MassalhangzoHang Ml]

-- grafikusan: „fény"
public export szóFény : Fonetika
szóFény = [MassalhangzoHang Mf, MaganhangzoHang Vee, DigrafHang Dny]

-- grafikusan: „kút"
public export szóKút : Fonetika
szóKút = [MassalhangzoHang Mk, MaganhangzoHang Vuu, MassalhangzoHang Mt]

-- grafikusan: „lét"
public export szóLét : Fonetika
szóLét = [MassalhangzoHang Ml, MaganhangzoHang Vee, MassalhangzoHang Mt]

-- grafikusan: „lé"
public export szóLé : Fonetika
szóLé = [MassalhangzoHang Ml, MaganhangzoHang Vee]

-- grafikusan: „fog"
public export szóFog : Fonetika
szóFog = [MassalhangzoHang Mf, MaganhangzoHang Vo, MassalhangzoHang Mg]

-- grafikusan: „nyelv"
public export szóNyelv : Fonetika
szóNyelv = [DigrafHang Dny, MaganhangzoHang Ve, MassalhangzoHang Ml, MassalhangzoHang Mv]

-- grafikusan: „hál"
public export szóHál : Fonetika
szóHál = [MassalhangzoHang Mh, MaganhangzoHang Vaa, MassalhangzoHang Ml]

-- grafikusan: „kép"
public export szóKép : Fonetika
szóKép = [MassalhangzoHang Mk, MaganhangzoHang Vee, MassalhangzoHang Mp]

-- grafikusan: „köt"
public export szóKöt : Fonetika
szóKöt = [MassalhangzoHang Mk, MaganhangzoHang Voe, MassalhangzoHang Mt]

-- grafikusan: „nő"
public export szóNő : Fonetika
szóNő = [MassalhangzoHang Mn, MaganhangzoHang Voee]

-- grafikusan: „ad"
public export szóAd : Fonetika
szóAd = [MaganhangzoHang Va, MassalhangzoHang Md]

-- grafikusan: „iszik"
public export szóIszik : Fonetika
szóIszik = [MaganhangzoHang Vi, DigrafHang Dsz, MaganhangzoHang Vi, MassalhangzoHang Mk]

-- ─── 2. A TOLDALÉKOK MINT TÍPUSOK ─────────────────────────

public export
record Rag where
  constructor RagK
  ragFonetika : Fonetika
  ragEset     : Esetrag

-- grafikusan: „-ban"
public export ragBan : Rag
ragBan = RagK [MassalhangzoHang Mb, MaganhangzoHang Va, MassalhangzoHang Mn] InessivusE

-- grafikusan: „-ben"
public export ragBen : Rag
ragBen = RagK [MassalhangzoHang Mb, MaganhangzoHang Ve, MassalhangzoHang Mn] InessivusE

-- grafikusan: „-ba"
public export ragBa : Rag
ragBa = RagK [MassalhangzoHang Mb, MaganhangzoHang Va] IllativusE

-- grafikusan: „-be"
public export ragBe : Rag
ragBe = RagK [MassalhangzoHang Mb, MaganhangzoHang Ve] IllativusE

-- grafikusan: „-ból"
public export ragBól : Rag
ragBól = RagK [MassalhangzoHang Mb, MaganhangzoHang Voo, MassalhangzoHang Ml] ElativusE

-- grafikusan: „-ből"
public export ragBől : Rag
ragBől = RagK [MassalhangzoHang Mb, MaganhangzoHang Voee, MassalhangzoHang Ml] ElativusE

-- grafikusan: „-nak"
public export ragNak : Rag
ragNak = RagK [MassalhangzoHang Mn, MaganhangzoHang Va, MassalhangzoHang Mk] DativusE

-- grafikusan: „-nek"
public export ragNek : Rag
ragNek = RagK [MassalhangzoHang Mn, MaganhangzoHang Ve, MassalhangzoHang Mk] DativusE

-- grafikusan: „-val"
public export ragVal : Rag
ragVal = RagK [MassalhangzoHang Mv, MaganhangzoHang Va, MassalhangzoHang Ml] InstrumentalisE

-- grafikusan: „-vel"
public export ragVel : Rag
ragVel = RagK [MassalhangzoHang Mv, MaganhangzoHang Ve, MassalhangzoHang Ml] InstrumentalisE

-- grafikusan: „-ra"
public export ragRa : Rag
ragRa = RagK [MassalhangzoHang Mr, MaganhangzoHang Va] SublativusE

-- grafikusan: „-re"
public export ragRe : Rag
ragRe = RagK [MassalhangzoHang Mr, MaganhangzoHang Ve] SublativusE

-- grafikusan: „-ért"
public export ragÉrt : Rag
ragÉrt = RagK [MaganhangzoHang Vee, MassalhangzoHang Mr, MassalhangzoHang Mt] CausalisFinalisE

-- grafikusan: „-tól"
public export ragTól : Rag
ragTól = RagK [MassalhangzoHang Mt, MaganhangzoHang Voo, MassalhangzoHang Ml] AblativusE

-- grafikusan: „-től"
public export ragTől : Rag
ragTől = RagK [MassalhangzoHang Mt, MaganhangzoHang Voee, MassalhangzoHang Ml] AblativusE

-- grafikusan: „-nál"
public export ragNál : Rag
ragNál = RagK [MassalhangzoHang Mn, MaganhangzoHang Vaa, MassalhangzoHang Ml] AdessivusE

-- grafikusan: „-nél"
public export ragNél : Rag
ragNél = RagK [MassalhangzoHang Mn, MaganhangzoHang Vee, MassalhangzoHang Ml] AdessivusE

-- grafikusan: „-ról"
public export ragRól : Rag
ragRól = RagK [MassalhangzoHang Mr, MaganhangzoHang Voo, MassalhangzoHang Ml] DelativusE

-- grafikusan: „-ről"
public export ragRől : Rag
ragRől = RagK [MassalhangzoHang Mr, MaganhangzoHang Voee, MassalhangzoHang Ml] DelativusE

-- grafikusan: „-ig"
public export ragIg : Rag
ragIg = RagK [MaganhangzoHang Vi, MassalhangzoHang Mg] TerminativusE

-- grafikusan: „-vá"
public export ragVá : Rag
ragVá = RagK [MassalhangzoHang Mv, MaganhangzoHang Vaa] TranszlativusE

-- grafikusan: „-vé"
public export ragVé : Rag
ragVé = RagK [MassalhangzoHang Mv, MaganhangzoHang Vee] TranszlativusE

-- grafikusan: „-ként"
public export ragKént : Rag
ragKént = RagK [MassalhangzoHang Mk, MaganhangzoHang Vee, MassalhangzoHang Mn, MassalhangzoHang Mt] EssivusFormalisE

-- ─── 3. AZ AGGLUTINÁCIÓ — LIST-ÖSSZEFŰZÉS ─────────────────
-- A ragozás = a szó és a rag fonetikájának összefűzése.
-- A hangrend-ellenőrzés (összhang) a FanoParitás-ból jön.

public export
ragoz : Fonetika -> Rag -> Fonetika
ragoz szó r = szó ++ ragFonetika r

-- ─── 4. SZÓFAJ ────────────────────────────────────────────

public export
data Szófaj = Főnév | Ige | Melléknév | Határozószó | Viszonyszó | Kérdőszó

public export
Show Szófaj where
  show Főnév      = "főnév"
  show Ige        = "ige"
  show Melléknév  = "melléknév"
  show Határozószó = "határozószó"
  show Viszonyszó = "viszonyszó"
  show Kérdőszó   = "kérdőszó"

esetNév : Esetrag -> String
esetNév NominativusE     = "ki? mi?"
esetNév AccusativusE     = "kit? mit? (PATIENS)"
esetNév DativusE         = "kinek? minek?"
esetNév InessivusE       = "ban/ben (hol?)"
esetNév ElativusE        = "ból/ből (honnan?)"
esetNév IllativusE       = "ba/be (hova?)"
esetNév SuperessivusE    = "on/en/ön (rafelhelyezve)"
esetNév AdessivusE       = "nál/nél (kinél?)"
esetNév DelativusE       = "ról/ről (kiről?)"
esetNév AblativusE       = "tól/től (kitől?)"
esetNév SublativusE      = "ra/re (mire?)"
esetNév AllativusE       = "hoz/hez/höz (mihez?)"
esetNév TerminativusE    = "ig (meddig?)"
esetNév InstrumentalisE  = "val/vel (mivel?)"
esetNév CausalisFinalisE = "ért (miért?)"
esetNév TranszlativusE   = "vá/vé (mivá?)"
esetNév FormativusE      = "képp (hogyan?)"
esetNév EssivusFormalisE = "ként (mint?)"

-- ─── 5. SZEREP = (mélyeset × betöltő) ─────────────────────

public export
record Szerep where
  constructor SzerepK
  melyEset : Esetrag
  betöltő  : Fonetika

public export
Show Szerep where
  show s = esetNév (melyEset s) ++ " ← " ++ ipaForma (betöltő s)

-- ─── 6. SZÓCIKK ───────────────────────────────────────────

public export
record Szócikk where
  constructor SzócikkK
  szóCím     : Fonetika
  szófaja    : Szófaj
  nemFogalom : Fonetika
  jegyek     : List Szerep

public export
szerepSor : List Szerep -> String
szerepSor [] = ""
szerepSor [x] = show x
szerepSor (x :: xs) = show x ++ "; " ++ szerepSor xs

public export
Show Szócikk where
  show c = ipaForma (szóCím c) ++ " [" ++ show (szófaja c) ++ "]\n"
        ++ "  nem-fogalom: " ++ ipaForma (nemFogalom c) ++ "\n"
        ++ "  jegyek: " ++ szerepSor (jegyek c)

-- ─── 7. A SZÓTÁR — 8 ÉKSZ-STÍLÚ SZÓCIKK ───────────────────

public export
értelmezőSzótár : List Szócikk
értelmezőSzótár =
  [ SzócikkK szóHangvilla Főnév szóEszköz
      [ SzerepK AccusativusE szóHangot ]
      -- A hangvilla olyan eszköz, amely hangot ad.
  , SzócikkK szóEntropia Főnév szóMérőszám
      [ SzerepK AccusativusE szóMaradék
      , SzerepK CausalisFinalisE szóEnergia ]
      -- Az entrópia olyan mérőszám, amely a maradékot méri az energiáért.
  , SzócikkK szóKategória Főnév szóStruktúra
      [ SzerepK InessivusE szóFolyamat ]
      -- A kategória olyan struktúra, amelyben folyamat van.
  , SzócikkK szóFunktor Főnév szóLeképezés
      [ SzerepK AccusativusE szóKategória ]
      -- A funktor olyan leképezés, amely kategóriát visz kategóriába.
  , SzócikkK szóKomma Főnév szóMaradék
      [ SzerepK DelativusE szóKör ]
      -- A komma olyan maradék, amely a körből marad meg.
  , SzócikkK szóKeresés Főnév szóFolyamat
      [ SzerepK AccusativusE szóSzót ]
      -- A keresés olyan folyamat, amely szót keres.
  , SzócikkK szóEnergia Főnév szóMennyiség
      [ SzerepK CausalisFinalisE szóFolyamat ]
      -- Az energia olyan mennyiség, amely folyamatra valót ad.
  , SzócikkK szóSzótár Főnév szóGyűjtemény
      [ SzerepK InessivusE szóSzó ]
      -- A szótár olyan gyűjtemény, amelyben szó van.
  ]

-- ─── 8. LEKÉRDEZÉSEK ──────────────────────────────────────

public export
cikketKeres : Fonetika -> List Szócikk
cikketKeres cím = filter (\c => szóCím c == cím) értelmezőSzótár

-- Melyik nem-fogalom alá tartozik?
public export
nemFogalma : Fonetika -> Maybe Fonetika
nemFogalma cím =
  case cikketKeres cím of
    (c :: _) => Just (nemFogalom c)
    []       => Nothing

-- Hány szócikk tartozik egy nem-fogalom alá?
public export
aláTartozók : Fonetika -> List Fonetika
aláTartozók nem =
  map szóCím
    (filter (\c => esetén (nemFogalma (szóCím c))
                     (\n => n == nem) False)
            értelmezőSzótár)
  where
    esetén : Maybe a -> (a -> b) -> b -> b
    esetén (Just x) f _ = f x
    esetén Nothing  _ alapeset = alapeset

public export
Show (Maybe Fonetika) where
  show Nothing  = "nincs"
  show (Just f) = ipaForma f

-- ─── 9. RAGOZÁSI BEMUTATÓ — a hangrend-ellenőrzéssel ──────

public export
ragozásJelentés : String
ragozásJelentés =
  "ház + ban = " ++ ipaForma (ragoz szóHáz ragBan)
  ++ " [" ++ show (összhang szóHáz toldalékBan) ++ "]\n"
  ++ "kör + ben = " ++ ipaForma (ragoz szóKör ragBen)
  ++ " [" ++ show (összhang szóKör toldalékBen) ++ "]\n"
  ++ "víz + be = " ++ ipaForma (ragoz szóVíz ragBe)
  ++ " [" ++ show (összhang szóVíz toldalékBe) ++ "]\n"

-- ─── 10. FŐ — vékony IO-burkoló ───────────────────────────

public export
főJelentés : String
főJelentés =
  "═══ ÉRTELMEZŐ SZÓTÁR — 8 szócikk ═══\n"
  ++ concatMap (\c => show c ++ "\n") értelmezőSzótár
  ++ "\n═══ RAGOZÁS (agglutináció = összefűzés) ═══\n"
  ++ ragozásJelentés

main : IO ()
main = putStrLn főJelentés


-- ─── REGISZTRÁCIÓ (ModulRegisztracio) ─────────────────────
public export
ErtelmezoSzotarLeiras : ModulLeirasT
ErtelmezoSzotarLeiras = ModulLeirasKonstruktor
  "ErtelmezoSzotar.idr" "8 ÉKSZ-szócikk; GAUGE: kézzel írt == független parser [teszt]" "a szócikkek genus-differentia szerkezete = a fogalom-gráf" "14 teszt"
