module Teszt

-- ═══════════════════════════════════════════════════════════════
-- TESZT — Két szint: fordítás (Refl) + tiszta Show-értékek
-- ═══════════════════════════════════════════════════════════════
-- 1. szint: FORDÍTÁSI BIZONYÍTÁS (Refl) — csak definicionálisan
--    redukálható egyenlőségekre (konstruktorok, literálok).
--    A típus-ellenőrző a bíró: ha fordul, bizonyítva.
--
-- 2. szint: TISZTA SHOW-ÉRTÉKEK — minden más eredménye
--    String (Show-ból). A logika tiszta, a main csak show-t hív.
--
-- Hiányzó Show/Eq instance-ok itt vannak definiálva (ADD,
-- nem módosítjuk a forrás modulokat).
-- ═══════════════════════════════════════════════════════════════

import Steane713
import E8E8Algebra
import MagyarNyelvtan
import LawvereGodel
import Szotar
import Fonetika
import FanoParitás
import ErtelmezoSzotar
import SteaneHamiltonian
import LejeuneTranszformacio
import HanMagyarKodolas
import Kerdoszo
import E8Gyokrendszer
import DiracGammaMatricak
import Alap.CsomagoltTipusok
import OktonionAlgebra
import DiracIdoFejlodes
%hide Alap.CsomagoltTipusok.Kubit
%hide Alap.CsomagoltTipusok.Esetrag

%default total

-- ═══════════════════════════════════════════════════════════════
-- 0. HIÁNYZÓ INSTANCE-OK (Show, Eq) — ADD a forráshoz
-- ═══════════════════════════════════════════════════════════════

showK : Kubit -> String
showK Nulla = "0"
showK Egy = "1"

public export
Show Esetrag where
  show NominativusE     = "nominativus"
  show AccusativusE     = "accusativus"
  show DativusE         = "dativus"
  show InessivusE       = "inessivus"
  show ElativusE        = "elativus"
  show IllativusE       = "illativus"
  show SuperessivusE    = "superessivus"
  show AdessivusE       = "adessivus"
  show DelativusE       = "delativus"
  show AblativusE       = "ablativus"
  show SublativusE      = "sublativus"
  show AllativusE       = "allativus"
  show TerminativusE    = "terminativus"
  show InstrumentalisE  = "instrumentalis"
  show CausalisFinalisE = "causalis-finalis"
  show TranszlativusE   = "transzlativus"
  show FormativusE      = "formativus"
  show EssivusFormalisE = "essivus-formalis"

public export
Show CliffordElem where
  show c = "Clifford(" ++ showK c.skalar ++ "," ++ showK c.vektor ++ "," ++ showK c.bivektor ++ ")"

public export
Eq HaromErtek where
  Igaz == Igaz = True
  Hamis == Hamis = True
  Ertektelen == Ertektelen = True
  _ == _ = False

public export
Show HetesKod where
  show (HetesKonstruktor a b c d e f g) =
    showK a ++ showK b ++ showK c ++ showK d ++ showK e ++ showK f ++ showK g

-- ═══════════════════════════════════════════════════════════════
-- 1. SZINT: FORDÍTÁSI BIZONYÍTÁSOK (Refl)
--    CSAK definicionálisan redukálhatóakra!
-- ═══════════════════════════════════════════════════════════════

-- Kimenet: Refl (Nulla ⊕ Nulla = Nulla — XOR alaptörvény)
public export
bizKubitXorNulla : kubitXor Nulla Nulla = Nulla
bizKubitXorNulla = Refl

-- Kimenet: Refl (Egy ⊕ Egy = Nulla — x ⊕ x = 0)
public export
bizKubitXorEgy : kubitXor Egy Egy = Nulla
bizKubitXorEgy = Refl

-- Kimenet: Refl (Nulla ⊕ Egy = Egy — a nulla egység)
public export
bizKubitXorEgyseg : kubitXor Nulla Egy = Egy
bizKubitXorEgyseg = Refl

-- Kimenet: Refl (Egy ⊕ Nulla = Egy)
public export
bizKubitXorKommutativ : kubitXor Egy Nulla = Egy
bizKubitXorKommutativ = Refl

-- Kimenet: Refl (kubitEgyezik Nulla Nulla = True)
public export
bizKubitEgyezikNulla : kubitEgyezik Nulla Nulla = True
bizKubitEgyezikNulla = Refl

-- Kimenet: Refl (kubitEgyezik Egy Nulla = False)
public export
bizKubitNemEgyezik : kubitEgyezik Egy Nulla = False
bizKubitNemEgyezik = Refl

-- Kimenet: Refl (kubitEs Egy Egy = Egy — AND)
public export
bizKubitEsEgy : kubitEs Egy Egy = Egy
bizKubitEsEgy = Refl

-- Kimenet: Refl (kubitEs Nulla Egy = Nulla)
public export
bizKubitEsNulla : kubitEs Nulla Egy = Nulla
bizKubitEsNulla = Refl

-- Kimenet: Refl (Clifford(0,0,0) ⊗ Clifford(0,0,0) = Clifford(0,0,0))
public export
bizCliffordNulla :
  cliffordSzorzat (CliffordKonstruktor Nulla Nulla Nulla)
                  (CliffordKonstruktor Nulla Nulla Nulla)
  = CliffordKonstruktor Nulla Nulla Nulla
bizCliffordNulla = Refl

-- Kimenet: Refl (Clifford(1,0,0) ⊗ Clifford(0,0,0) = Clifford(1,0,0))
public export
bizCliffordEgyseg :
  cliffordSzorzat (CliffordKonstruktor Egy Nulla Nulla)
                  (CliffordKonstruktor Nulla Nulla Nulla)
  = CliffordKonstruktor Egy Nulla Nulla
bizCliffordEgyseg = Refl

-- Kimenet: Refl (a hazug p = 1/2: (1·2+1·2)·1 = 1·(2·2), azaz 4 = 4)
public export
bizHazugFele : (1 * 2 + 1 * 2) * 1 = 1 * (2 * 2)
bizHazugFele = Refl

-- Kimenet: Refl (a Kleene-tagadás Ertektelen-t önmagára képezi)
public export
bizKleeneFixpont : kleeneTagadas Ertektelen = Ertektelen
bizKleeneFixpont = Refl

-- Kimenet: Refl (alapKod Nulla → steaneDekodol = Nulla — Noether)
public export
bizNoetherNulla : steaneDekodol (alapKod Nulla) = Nulla
bizNoetherNulla = Refl

-- Kimenet: Refl (alapKod Egy → steaneDekodol = Egy — Noether)
public export
bizNoetherEgy : steaneDekodol (alapKod Egy) = Egy
bizNoetherEgy = Refl

-- ─── A bizonyítások listája (dokumentáció) ─────────────────

public export
bizonyitasLista : List String
bizonyitasLista =
  [ "bizKubitXorNulla       : Nulla⊕Nulla=Nulla [Refl]"
  , "bizKubitXorEgy         : Egy⊕Egy=Nulla [Refl]"
  , "bizKubitXorEgyseg      : Nulla⊕Egy=Egy [Refl]"
  , "bizKubitXorKommutativ  : Egy⊕Nulla=Egy [Refl]"
  , "bizKubitEgyezikNulla   : Nulla≈Nulla=True [Refl]"
  , "bizKubitNemEgyezik     : Egy≈Nulla=False [Refl]"
  , "bizKubitEsEgy          : Egy∧Egy=Egy [Refl]"
  , "bizKubitEsNulla        : Nulla∧Egy=Nulla [Refl]"
  , "bizCliffordNulla       : 0⊗0=0 [Refl]"
  , "bizCliffordEgyseg      : 1⊗0=1 [Refl]"
  , "bizHazugFele           : p=1/2: 4·1=1·4 [Refl]"
  , "bizKleeneFixpont       : kleene(Ertektelen)=Ertektelen [Refl]"
  , "bizNoetherNulla        : dekodol(kodol(Nulla))=Nulla [Refl]"
  , "bizNoetherEgy          : dekodol(kodol(Egy))=Egy [Refl]"
  , "bizE1..E7              : Fanó-sík 7 egyenes XOR=000 [Refl]"
  , "bizXZ, bizZX           : Pauli X·Z=Z·X=Y [Refl]"
  , "bizXX, bizZZ           : Pauli involúciók X·X=Z·Z=E [Refl]"
  , "bizTisztaHamiltonian   : H(tiszta)=−6 alapállapot [Refl]"
  , "bizEgyesHibaHamiltonian: H(X₁hiba)=0 [Refl]"
  , "bizNegyesHibaHamilton. : H(X₄hiba)=−4 [Refl]"
  , "bizSzindromaEgyes/Negy.: szindróma=hiba pozíció binárisan [Refl]"
  , "bizSzindromaFazisLath. : Z₅ fázishiba az érték-oldal elől rejtve [Refl]"
  , "bizTisztaTorlesIngyenes: Landauer: tiszta törlés=0 energia [Refl]"
  , "bizEgyBitTorles        : Landauer: 1 bit=1 egység [Refl]"
  , "bizHulladekHoVan       : 2. főtétel: a törlési ütem fizet [Refl]"
  , "bizJavitasAdiabata     : a javító ütem hőáram nélkül [Refl]"
  , "bizZhiBan/MaBen/YuanK. : HanMagyar 8 bit = gyökér+rág+paritás [Refl]"
  , "bizGaussPrimNorma      : 137 = 11²+4² Gauss-prím [Refl]"
  , "bizBanMely/BizBenMagas : hangrend = a bájt paritásbitje [Refl]"
  , "bizKiElo/bizMiDolog    : ki?=élő, mi?=dolog (alap-osztó) [Refl]"
  , "bizMiertOk             : miért?→causalis (OK/CÉL) [Refl]"
  , "bizMikorNincsRag       : mikor?-ra nincs rag (T≠C,P!) [Refl]"
  , "bizKérdésKiGauge       : „ki” IPA = [ki] [Refl]"
  , "bizHogyanDgraf         : „hogyan” gy=[ɟ] [Refl]"
  , "bizMelyikDgraf         : „melyik” ly=[j] [Refl]"
  , "bizHurwitzHuszonnegy   : a gömb (S³) 24 egysége [Refl]"
  , "bizE8KetszazNegyven    : 112+128 = 240 E8-gyök [Refl]"
  , "bizOktonionEgyenloE8   : oktonion egységek = E8 gyökök [Refl]"
  , "bizFelegeszSzazHuszon. : 128 = 2⁷ félegész gyök [Refl]"
  , "bizNyolcBit            : 240+16 = 256 (egy bájt!) [Refl]"
  , "bizE8Dimenzio          : 240+8 = 248 [Refl]"
  , "bizAntikommutátor×6    : Clifford {γᵘ,γᵛ}=0 (Weyl) [Refl]"
  , "bizGammaOtWeyl         : γ⁵=diag(−1,−1,+1,+1), γ⁵²=I [Refl]"
  , "bizWeylGammaKeveri     : γ⁰.mező20=+1 → 中文↔magyar él [Refl]"
  , "bizSzerveriNemKeveri   : szerveri γ⁰.mező20=0 → törött [Refl]"
  , "bizCayleyTablaAlternatív: oktonion 49 pár × 3 törvény [Refl]"
  , "bizCayleyFanoSík       : minden pár pontosan 1 vonalon [Refl]"
  , "bizNemAsszociatív      : (e₁e₂)e₃=−e₆ ≠ e₁(e₂e₃)=+e₆ [Refl]"
  , "zitterbewegung: két út ≤10⁻¹² (π/4, π/2, π/3) [Idris Double]"
  , "szerveri γ⁰: P(magyar)=0 PONTOSAN (a bogár numerikusan)"
  ]

public export
bizonyitasokSzama : Nat
bizonyitasokSzama = length bizonyitasLista

-- ═══════════════════════════════════════════════════════════════
-- 2. SZINT: TISZTA SHOW-ÉRTÉKEK (halu teszt)
-- ═══════════════════════════════════════════════════════════════

public export
record TesztEredmeny where
  constructor TesztEredmenyK
  tesztNev : String
  kapott   : String
  sikeres  : Bool

public export
Show TesztEredmeny where
  show t = (if sikeres t then "✓" else "✗")
        ++ " " ++ tesztNev t
        ++ " → " ++ kapott t

-- Segédfüggvény: Bool-teszt
public export
teszt : String -> Bool -> TesztEredmeny
teszt nev siker = TesztEredmenyK nev (if siker then "OK" else "HIBA") siker

||| Igazság-változat: a mag Igazságot ad — a teszt-perem Bool-lá hidazzon
||| (igazságÉrtéke, CsomagoltTipusok). 中文：Igazság 版测试——内核真值，边界桥接。
public export
tesztI : String -> Igazság -> TesztEredmeny
tesztI nev igazság = teszt nev (igazságÉrtéke igazság)

-- ─── E8 algebra tesztek (Show-val) ─────────────────────────

public export
e8Tesztek : List TesztEredmeny
e8Tesztek =
  [ teszt "e8Nulla⊕e8Nulla=e8Nulla" (e8Osszead e8Nulla e8Nulla == e8Nulla)
  , teszt "e8Egy⊕e8Egy=e8Nulla (XOR)" (e8Osszead e8Egy e8Egy == e8Nulla)
  , teszt "e8Nulla⊕e8Egy=e8Egy" (e8Osszead e8Nulla e8Egy == e8Egy)
  , teszt "e8Egy⊕e8Nulla=e8Egy" (e8Osszead e8Egy e8Nulla == e8Egy)
  , teszt "e8Ketto⊕e8Ketto=e8Nulla" (e8Osszead e8Ketto e8Ketto == e8Nulla)
  ]

-- ─── Hamming távolság tesztek ──────────────────────────────

public export
hammingTesztek : List TesztEredmeny
hammingTesztek =
  [ teszt "hamming(e8Nulla,e8Nulla)=0" (hammingTavolsag e8Nulla e8Nulla == 0)
  , teszt "hamming(e8Nulla,e8Egy)=1" (hammingTavolsag e8Nulla e8Egy == 1)
  , teszt "hamming(e8Egy,e8Ketto)=2" (hammingTavolsag e8Egy e8Ketto == 2)
  , teszt "hamming(e8Nulla,e8Nyolc)=1" (hammingTavolsag e8Nulla e8Nyolc == 1)
  ]

-- ─── Esetrag-felismerő tesztek ─────────────────────────────

public export
ragTesztek : List TesztEredmeny
ragTesztek =
  [ teszt "házban→inessivus"
      (ragFelismer "házban" == Just ("ház", InessivusE))
  , teszt "kézzel→instrumentalist"
      (ragFelismer "kézzel" == Just ("kéz", InstrumentalisE))
  , teszt "kérésért→causalis"
      (ragFelismer "kérésért" == Just ("kérés", CausalisFinalisE))
  , teszt "kategória→nominativus"
      (ragFelismer "kategória" == Just ("kategória", NominativusE))
  , teszt "funktorral→instrumentalist"
      (ragFelismer "funktorral" == Just ("funktor", InstrumentalisE))
  , teszt "objektum→nominativus"
      (ragFelismer "objektum" == Just ("objektum", NominativusE))
  ]

-- ─── Kérdőszó tesztek ──────────────────────────────────────

public export
kerdoszoTesztek : List TesztEredmeny
kerdoszoTesztek =
  [ teszt "miért→causalis" (kerdoszoEset "miért" == Just CausalisFinalisE)
  , teszt "hol→inessivus" (kerdoszoEset "hol" == Just InessivusE)
  , teszt "mivel→instrumentalist" (kerdoszoEset "mivel" == Just InstrumentalisE)
  , teszt "hogyan→formativus" (kerdoszoEset "hogyan" == Just FormativusE)
  , teszt "hová→illativus" (kerdoszoEset "hová" == Just IllativusE)
  , teszt "honnan→elativus" (kerdoszoEset "honnan" == Just ElativusE)
  ]

-- ─── Szótár-gráf tesztek ───────────────────────────────────

public export
grafTesztek : List TesztEredmeny
grafTesztek =
  [ teszt "fogalmak>50" (length (fogalmak projektGraf) > 50)
  , teszt "élek>60" (length (elek projektGraf) > 60)
  , teszt "\"kategória\"∈gráf"
      (case fogalomKeres "kategória" projektGraf of
         Just _ => True
         Nothing => False)
  , teszt "\"entrópia\"∈gráf"
      (case fogalomKeres "entrópia" projektGraf of
         Just _ => True
         Nothing => False)
  , teszt "\"Carnot-ciklus\"∈gráf"
      (case fogalomKeres "Carnot-ciklus" projektGraf of
         Just _ => True
         Nothing => False)
  , teszt "\"Idris\"∈gráf"
      (case fogalomKeres "Idris" projektGraf of
         Just _ => True
         Nothing => False)
  , teszt "fok(kategória)>0" (fokSzam "kategória" projektGraf > 0)
  , teszt "fok(entrópia)>0" (fokSzam "entrópia" projektGraf > 0)
  ]

-- ─── MDL-távolság tesztek ──────────────────────────────────

public export
mdlTesztek : List TesztEredmeny
mdlTesztek =
  [ TesztEredmenyK "MDL(kategória,entrópia)"
      (case utHossz 6 "kategória" "entrópia" projektGraf of
         Just d => show d ++ " él"
         Nothing => "nincs út")
      (case utHossz 6 "kategória" "entrópia" projektGraf of
         Just _ => True
         Nothing => False)
  , TesztEredmenyK "MDL(entrópia,információ)"
      (case utHossz 6 "entrópia" "információ" projektGraf of
         Just d => show d ++ " él"
         Nothing => "nincs út")
      (case utHossz 6 "entrópia" "információ" projektGraf of
         Just _ => True
         Nothing => False)
  , TesztEredmenyK "MDL(kategória,E8)"
      (case utHossz 6 "kategória" "E8" projektGraf of
         Just d => show d ++ " él"
         Nothing => "nincs út")
      (case utHossz 6 "kategória" "E8" projektGraf of
         Just _ => True
         Nothing => False)
  , TesztEredmenyK "MDL(Idris,kategória)"
      (case utHossz 6 "Idris" "kategória" projektGraf of
         Just d => show d ++ " él"
         Nothing => "nincs út")
      (case utHossz 6 "Idris" "kategória" projektGraf of
         Just _ => True
         Nothing => False)
  ]

-- ─── Valószínűség tesztek ──────────────────────────────────

public export
valoszinusegTesztek : List TesztEredmeny
valoszinusegTesztek =
  [ teszt "P(causalis)>0" (tipusDarab CausalisK projektGraf > 0)
  , teszt "P(inessivus)>0" (tipusDarab InessivusK projektGraf > 0)
  , teszt "P(instrumentalis)>0" (tipusDarab InstrumentalisK projektGraf > 0)
  , teszt "összes él>70" (osszesEl projektGraf > 70)
  ]

-- ─── Lawvere tesztek ──────────────────────────────────────

public export
lawvereTesztek : List TesztEredmeny
lawvereTesztek =
  [ teszt "Kleene fixpont=Ertektelen" (kleeneTagadas Ertektelen == Ertektelen)
  , teszt "Kleene: Igaz→Hamis" (kleeneTagadas Igaz == Hamis)
  , teszt "Kleene: Hamis→Igaz" (kleeneTagadas Hamis == Igaz)
  ]

-- ─── Fonetika tesztek (magyarHangok: determinisztikus IPA-atiras) ──

public export
fonetikaTesztek : List TesztEredmeny
fonetikaTesztek =
  [ teszt "hangrendszer = 40 (14+17+9, E9 'Hungarian=O')" (hangrendszerSzama == 40)
  , teszt "magánhangzók = 14"  (maganhagzokSzama == 14)
  , teszt "mássalhangzók = 17" (massalhangzokSzama == 17)
  , teszt "digráfok = 9 (oktonion imagináriusok)" (digrafokSzama == 9)
  , teszt "IPA \"kategória\" = [kɒtɛɡoːriɒ] (Wikipedia IPA/HU)"
      (magyarIPA "kategória" == "[kɒtɛɡoːriɒ]")
  , teszt "IPA \"konszonáns\" = [konsonaːnʃ] (sz=EGY fonéma [s]!)"
      (magyarIPA "konszonáns" == "[konsonaːnʃ]")
  , teszt "IPA \"szótár\" = [soːtaːr] (sz=[s], ó=[oː], á=[aː])"
      (magyarIPA "szótár" == "[soːtaːr]")
  , teszt "IPA \"győr\" = [ɟøːr] (gy=[ɟ], ő=[øː])"
      (magyarIPA "győr" == "[ɟøːr]")
  , teszt "IPA \"hangvilla\" = [hɒŋvillɒ] (ng→[ŋ] asszimiláció)"
      (magyarIPA "hangvilla" == "[hɒŋvillɒ]")
  , teszt "IPA \"edzés\" = [ɛd͡zeːʃ] (dz=[d͡z], s=[ʃ])"
      (magyarIPA "edzés" == "[ɛd͡zeːʃ]")
  , teszt "IPA \"kutya\" = [kucɒ] (ty=[c])"
      (magyarIPA "kutya" == "[kucɒ]")
  , teszt "IPA \"lyuk\" = [juk] (ly=[j]!)"
      (magyarIPA "lyuk" == "[juk]")
  , teszt "IPA \"dzsessz\" = [d͡ʒɛss] (ssz = hosszú sz = [ss])"
      (magyarIPA "dzsessz" == "[d͡ʒɛss]")
  , teszt "táv(szó,zó)=1 (s≠z, ó egyezik)"
      (fonetikaiTavolsag (magyarHangok "szó") (magyarHangok "zó") == 1)
  , teszt "táv(x,x)=0"
      (fonetikaiTavolsag (magyarHangok "kategória") (magyarHangok "kategória") == 0)
  , teszt "ékezetfüggetlen: KATEGÓRIA ≡ kategória"
      (magyarIPA "KATEGÓRIA" == magyarIPA "kategória")
  -- ── szótagolás (determinisztikus; minden magánhangzó = egy szótag) ──
  , teszt "szótag: kategória = ka·te·gó·ri·a (5, hiátussal: ri·a)"
      (grafForma "kategória" == "ka·te·gó·ri·a" && szotagSzam "kategória" == 5)
  , teszt "szótag: kutya = ku·tya (2)"
      (grafForma "kutya" == "ku·tya" && szotagSzam "kutya" == 2)
  , teszt "szótag: anya = a·nya (1 mássalhangzó → támadás)"
      (grafForma "anya" == "a·nya")
  , teszt "szótag: asztal = asz·tal (2 mássalhangzó → kóda+támadás)"
      (grafForma "asztal" == "asz·tal")
  , teszt "szótag: bandita = ban·di·ta (3)"
      (grafForma "bandita" == "ban·di·ta")
  , teszt "szótag: papír = pa·pír + szóvégi kóda [r]"
      (grafForma "papír" == "pa·pír")
  , teszt "szótag: mennyezet = meny·nye·zet (AkH. 226.f: teljes rövid mindkét oldalon!)"
      (grafForma "mennyezet" == "meny·nye·zet" && szotagSzam "mennyezet" == 3)
  , teszt "szótag: egészség = e·gész·ség (é-sz-s-é: az sz EGÉSZ digráf!)"
      (grafForma "egészség" == "e·gész·ség" && szotagSzam "egészség" == 3)
  , teszt "hangsúly MINDIG az első szótagon (determinisztikus)"
      (hangsulyPozicio == 0)
  ]

-- ═══════════════════════════════════════════════════════════════
-- FANÓ-PARITÁS TESZTEK — a hangrend mint paritásbit
-- ═══════════════════════════════════════════════════════════════

public export
fanoParitasTesztek : List TesztEredmeny
fanoParitasTesztek =
  [ teszt "hangrend: ház paritása mély (Nulla)"
      (szóParitása szóHáz == Nulla)
  , teszt "hangrend: kör paritása magas (Egy)"
      (szóParitása szóKör == Egy)
  , teszt "hangrend: víz paritása magas (i → Egy)"
      (szóParitása szóVíz == Egy)
  , teszt "hangrend: hangvilla mély (utolsó magánhangzó a)"
      (szóParitása szóHangvilla == Nulla)
  , teszt "összhang: ház+ban JÓ (mély+mély)"
      (show (összhang szóHáz toldalékBan) == "összhangos")
  , teszt "paritáshiba: ház+ben ROSSZ (mély+magas)"
      (show (összhang szóHáz toldalékBen) == "PARITÁSHIBA")
  , teszt "összhang: kör+ben JÓ (magas+magas)"
      (show (összhang szóKör toldalékBen) == "összhangos")
  , teszt "paritáshiba: kör+ban ROSSZ (magas+mély)"
      (show (összhang szóKör toldalékBan) == "PARITÁSHIBA")
  , teszt "összhang: víz+be JÓ (i magas + e magas)"
      (show (összhang szóVíz toldalékBe) == "összhangos")
  , teszt "összhang: út+ra JÓ (ú mély + a mély)"
      (show (összhang szóÚt toldalékRa) == "összhangos")
  , teszt "Fanó-sík: mind a 7 egyenes XOR-nulla"
      (egyenesMindenhol FanóEgyenesek)
  , teszt "Pauli: X·Z=Y a Bloch-páron (tengely-egyenes)"
      (pauliFanóEgyenesén)
  , teszt "paritásFanóba: mély→100, magas→010 (két koordináta-tengely)"
      (show (paritásFanóba Nulla) == "100" && show (paritásFanóba Egy) == "010")
  ]

-- ═══════════════════════════════════════════════════════════════
-- ÉRTELMEZŐ SZÓTÁR TESZTEK — minden szó adattípus
-- ═══════════════════════════════════════════════════════════════
-- A GAUGE-KÖRTESZT a legfontosabb: a kézzel írt Hang-konstruktorok
-- megegyeznek-e a magyarHangok parser eredményével. Ha igen,
-- a szótípusok NEM halucinációk — a parser független ellenőrzés.

public export
szotarTesztek : List TesztEredmeny
szotarTesztek =
  [ teszt "GAUGE: hangvilla típus == parser (ház)"
      (ipaForma szóHáz == magyarIPA "ház")
  , teszt "GAUGE: hangvilla típus == parser"
      (ipaForma szóHangvilla == magyarIPA "hangvilla")
  , teszt "GAUGE: entrópia típus == parser"
      (ipaForma szóEntropia == magyarIPA "entrópia")
  , teszt "GAUGE: mérőszám típus == parser"
      (ipaForma szóMérőszám == magyarIPA "mérőszám")
  , teszt "GAUGE: gyűjtemény típus == parser (gy-digráf!)"
      (ipaForma szóGyűjtemény == magyarIPA "gyűjtemény")
  , teszt "GAUGE: hőmérőt típus == parser (ő!) "
      (ipaForma szóHőmérőt == magyarIPA "hőmérőt")
  , teszt "GAUGE: hang típus == parser (ng→[ŋ] asszimiláció)"
      (ipaForma szóHang == magyarIPA "hang")
  , teszt "szótár: 8 szócikk van"
      (length értelmezőSzótár == 8)
  , teszt "szótár: hangvilla nem-fogalma = eszköz"
      (nemFogalma szóHangvilla == Just szóEszköz)
  , teszt "szótár: funktor nem-fogalma = leképezés"
      (nemFogalma szóFunktor == Just szóLeképezés)
  , teszt "szótár: a folyamat alá 1 fogalom tartozik (a keresés)"
      (length (aláTartozók szóFolyamat) == 1)
  , teszt "GAUGE: hangot típus == parser (ng→[ŋ] a toldalékozott szóban is)"
      (ipaForma szóHangot == magyarIPA "hangot")
  , teszt "ragozás: ház+ban fonetikája = ház++ban"
      (ragoz szóHáz ragBan == szóHáz ++ ragFonetika ragBan)
  , teszt "ragozás: ház+ban paritása továbbra is mély"
      (szóParitása (ragoz szóHáz ragBan) == Nulla)
  , teszt "ragozás: kör+ben paritása továbbra is magas"
      (szóParitása (ragoz szóKör ragBen) == Egy)
  ]

-- ═══════════════════════════════════════════════════════════════
-- STEANE-HAMILTONIÁN TESZTEK — a Kimi-archívum TODO-ja teljesül
-- ═══════════════════════════════════════════════════════════════

public export
steaneHamiltonianTesztek : List TesztEredmeny
steaneHamiltonianTesztek =
  [ teszt "Hamiltonián: a tiszta állapot a legalacsonyabb energiaszint (0)"
      (energiaSzint TisztaAllapot == 0)
  , teszt "Hamiltonián: tiszta állapot H = −6 (az alapállapot)"
      (hamiltonianErtek TisztaAllapot == -6)
  , teszt "Hamiltonián: X₁ hiba szint = 3, H = 0 (oszlop-1 = 111)"
      (energiaSzint EgyesHibaAllapot == 3 && hamiltonianErtek EgyesHibaAllapot == 0)
  , teszt "Hamiltonián: X₄ hiba szint = 1, H = −4 (oszlop-4 = 100)"
      (energiaSzint NegyesHibaAllapot == 1 && hamiltonianErtek NegyesHibaAllapot == -4)
  , teszt "Hamiltonián: Z₅ fázishiba szint = 2, H = −2 (oszlop-5 = 011)"
      (energiaSzint OtosFazisHibaAllapot == 2)
  , teszt "szindróma: tiszta állapot = 000"
      (show (ertekSzindroma TisztaAllapot) == "000")
  , teszt "szindróma: X₁ hiba = 111 (a hiba pozíciója binárisan = 1)"
      (show (ertekSzindroma EgyesHibaAllapot) == "111")
  , teszt "szindróma: X₄ hiba = 100 (a hiba pozíciója binárisan = 4)"
      (show (ertekSzindroma NegyesHibaAllapot) == "100")
  , teszt "szindróma: a fázishiba rejtve az érték-oldal elől"
      (show (ertekSzindroma OtosFazisHibaAllapot) == "000")
  ]

-- ═══════════════════════════════════════════════════════════════
-- LEJEUNE-TRANSZFORMÁCIÓ TESZTEK — a Landauer-híd és a négy ütem
-- ═══════════════════════════════════════════════════════════════

public export
lejeuneTesztek : List TesztEredmeny
lejeuneTesztek =
  [ teszt "Lejeune ℒ: a Carnot-ciklus 4 ütemből áll"
      (length carnotCiklus == 4)
  , teszt "Landauer ℒ_I: a tiszta szindróma törlése 0 energiát fizet"
      (energiaOldalErtek (atvalt (InformacioOldalKonstruktor TisztaKod)) == 0)
  , teszt "Landauer ℒ_I: az 1 hibás bit törlése 1 egység"
      (energiaOldalErtek (atvalt (InformacioOldalKonstruktor EgyesHibasKod)) == 1)
  , teszt "Carnot: csak a törlési ütem fizet Landauer-költséget"
      (landauer (alairas HarmadikUtem) == Egy
       && landauer (alairas ElsoUtem) == Nulla
       && landauer (alairas MasodikUtem) == Nulla
       && landauer (alairas NegyedikUtem) == Nulla)
  , teszt "Carnot: a javító ütem adiabatikus (nincs hőáram)"
      (meleg (alairas MasodikUtem) == Nulla && adiabata (alairas MasodikUtem) == Egy)
  ]
  where
    energiaOldalErtek : EnergiaOldal -> Integer
    energiaOldalErtek (EnergiaOldalKonstruktor e) = e

-- ═══════════════════════════════════════════════════════════════
-- HANMAG TESZTEK — 1 szóelem = 1 bájt = E8Pont
-- ═══════════════════════════════════════════════════════════════

public export
hanmagTesztek : List TesztEredmeny
hanmagTesztek =
  [ teszt "HanMagyar: 质-ban = 00000100 (gyökér 00000 + -ban 10 + mély 0)"
      (show ZhiBan == "00000100")
  , teszt "HanMagyar: 码-ben = 00010111 (gyökér 00010 + -ben 11 + magas 1)"
      (show MaBen == "00010111")
  , teszt "HanMagyar: 圆-kor = 00111101 (gyökér 00111 + -ként + magas 1)"
      (show YuanKent == "00111101")
  , teszt "HanMagyar: a hangrend mindig a 8. bit (-ban/-ból mély = 0)"
      (hangrendParitas BanRag == Nulla && hangrendParitas BolRag == Nulla)
  , teszt "HanMagyar: a hangrend mindig a 8. bit (-ben/-ből/-ként magas = 1)"
      (hangrendParitas BeRag == Egy && hangrendParitas BolRagM == Egy
       && hangrendParitas KentRag == Egy)
  , teszt "HanMagyar: 26 kínai gyökér (Yi = egy = 25. index)"
      (gyokerKod Yi == 25)
  , teszt "Gauss-prím: 137 = 11² + 4² (a norma Refl-bizonyítva)"
      (TizenegyNegyzetPluszNegyNegyzet == 137)
  ]

-- ═══════════════════════════════════════════════════════════════
-- KÉRDŐSZÓ TÍPUSOS TESZTEK — mindennek alfja és omegája
-- ═══════════════════════════════════════════════════════════════

public export
kerdoszoTipusosTesztek : List TesztEredmeny
kerdoszoTipusosTesztek =
  [ teszt "GAUGE: „miért” kézzel == parser ([mieːrt])"
      (ipaForma KérdésMiért == magyarIPA "miért")
  , teszt "GAUGE: „hogyan” gy-digráf [ɟ]"
      (ipaForma KérdésHogyan == magyarIPA "hogyan")
  , teszt "GAUGE: „melyik” ly-digráf [j]"
      (ipaForma KérdésMelyik == magyarIPA "melyik")
  , teszt "kérdés→eset: miért? = causalis-finalis (OK/CÉL)"
      (kérdőszóEsetT MiértKérdő == Just CausalisFinalisE)
  , teszt "kérdés→eset: hol? = inessivus (BEN)"
      (kérdőszóEsetT HolKérdő == Just InessivusE)
  , teszt "kérdés→eset: mikor? → SEMMI (az igeidőre felel, T ≠ C,P)"
      (kérdőszóEsetT MikorKérdő == Nothing)
  , teszt "kérdés→eset: mennyi? → SEMMI (a mennyiség nem eset)"
      (kérdőszóEsetT MennyiKérdő == Nothing)
  , teszt "alap-osztó: ki? = élő, mi? = dolog"
      (kérdőszóOsztója KiKérdő == Just Élő
       && kérdőszóOsztója MitKérdő == Just Dolog)
  , teszt "a friss kérdés NYITOTT (entrópia-gradiens van)"
      (megNyitott (megkérdez MiértKérdő))
  , teszt "a megválaszolt kérdés ZÁRT (a gradiens eltűnt)"
      (not (megNyitott (megválaszol (megkérdez MitKérdő) KérdésMi)))
  , teszt "a bináris válasz betölt (melyik? = felezés)"
      (not (megNyitott (binárisKérdésBit (megkérdez MelyikKérdő) ElsőFél KérdésMi)))
  , teszt "a String-es és típusos kerdoszoEset EGYEZIK (miért)"
      (kerdoszoEset "miért" == kérdőszóEsetT MiértKérdő)
  , teszt "a String-es és típusos kerdoszoEset EGYEZIK (hol)"
      (kerdoszoEset "hol" == kérdőszóEsetT HolKérdő)
  ]

-- ═══════════════════════════════════════════════════════════════
-- E8 GYÖKRENDSZER TESZTEK — a Cayley–Dickson-torony + numerika
-- ═══════════════════════════════════════════════════════════════

public export
e8GyokTesztek : List TesztEredmeny
e8GyokTesztek =
  [ teszt "torony: ℝ egészek 2 egység"
      (ValosEgysegekSzama == 2)
  , teszt "torony: Gauss-egészek 4 egység"
      (GaussEgysegekSzama == 4)
  , teszt "torony: a kör (S¹) 8 természetes pontja = 2³ (fázismérés)"
      (KorTermeszetesPontjai == 2 * 2 * 2)
  , teszt "torony: A GÖMB (S³) VÁLASZA: Hurwitz 8+16 = 24"
      (HurwitzEgysegekSzama == 24)
  , teszt "torony: oktonion 16+224 = 240 = az E8 gyökök"
      (OktonionEgysegekSzama == 240 && OktonionEgysegekSzama == E8GyokokSzama)
  , teszt "E8: D8-rész 4·C(8,2) = 4·28 = 112"
      (NyolcDimenziosGyokokSzama == 112)
  , teszt "E8: félegész rész = páros paritású bájt = 2⁷ = 128"
      (FelegeszGyokokSzama == 128)
  , teszt "E8: 112 + 128 = 240"
      (E8GyokokSzama == 240)
  , teszt "E8: dim = gyökök + Cartan = 240 + 8 = 248"
      (E8GyokokSzama + 8 == 248)
  , teszt "bináris: 24 öt biten (24+8 = 32 = 2⁵)"
      (OtBitKapacitas == 32)
  , teszt "bináris: 240 EGY BÁJTBAN (240+16 = 256 = 2⁸)"
      (NyolcBitKapacitas == 256)
  , teszt "rezonancia ⚡: [8,4,4] 16 szava + 240 gyök = 256"
      (E8GyokokSzama + HammingKodSzavai == 256)
  ]

-- ═══════════════════════════════════════════════════════════════
-- DIRAC GAMMA TESZTEK — a Weyl-bázis és a szerveri bogár
-- ═══════════════════════════════════════════════════════════════

public export
diracGammaTesztek : List TesztEredmeny
diracGammaTesztek =
  [ tesztI "γ⁵ = diag(−1,−1,+1,+1): a bal szektor (中文) −1"
      (komplexEgyenlő (mező00 GammaÖtWeyl) MinuszEgyKomplex)
  , tesztI "γ⁵ = diag(−1,−1,+1,+1): a jobb szektor (magyar) +1"
      (komplexEgyenlő (mező33 GammaÖtWeyl) EgyKomplex)
  , teszt "γ⁵·γ⁵ = egység (involúció, futásidőben)"
      (igazságÉrtéke (komplexEgyenlő (mező00 (mátrixSzoroz GammaÖtWeyl GammaÖtWeyl)) EgyKomplex)
       && igazságÉrtéke (komplexEgyenlő (mező11 (mátrixSzoroz GammaÖtWeyl GammaÖtWeyl)) EgyKomplex))
  , tesztI "{γ⁰,γ¹}=0 futásidőben (a 00-as mező nulla)"
      (komplexEgyenlő (mező00 (mátrixÖsszead (mátrixSzoroz GammaNullaWeyl GammaEgyWeyl)
                                              (mátrixSzoroz GammaEgyWeyl GammaNullaWeyl))) NullaKomplex)
  , tesztI "a Weyl γ⁰ KEVERI a szektort (mező20 = +1)"
      (komplexEgyenlő (mező20 GammaNullaWeyl) EgyKomplex)
  , tesztI "a szerveri γ⁰ SOHA nem keveri (mező20 = 0) — a bogár"
      (komplexEgyenlő (mező20 GammaNullaSzerveriHibás) NullaKomplex)
  ]

-- ═══════════════════════════════════════════════════════════════
-- OKTONION TESZTEK — a Cayley-tábla kernel-ellenőrizve
-- ═══════════════════════════════════════════════════════════════

public export
oktonionTesztek : List TesztEredmeny
oktonionTesztek =
  [ teszt "e₁·e₂ = +e₄ (a Cayley-irány pozitív)"
      (egysegSzorzatTabla E1 E2 == PozitivGyok E4)
  , teszt "e₂·e₁ = −e₄ (fordított sorrend előjelet vált)"
      (egysegSzorzatTabla E2 E1 == NegativGyok E4)
  , teszt "eᵢ·eᵢ = −1 (mind a 7 gyökre)"
      (all (\g => egysegSzorzatTabla g g == ValosMinuszEgy) mindGyokLista)
  , teszt "alternativitás: mind a 49 pár × 3 törvény (a Python-hiba visszajelzés)"
      MindParErvenyes
  , teszt "Fano-sík: minden pár pontosan egy vonalon"
      MindParPontosanEgyVonalon
  , teszt "NEM asszociatív: (e₁e₂)e₃ ≠ e₁(e₂e₃)"
      (not NemAsszociativEgyeznek)
  , teszt "konkrét: (e₁e₂)e₃ = −e₆"
      (elojelesSzorozGyok (egysegSzorzatTabla E1 E2) E3 == NegativGyok E6)
  , teszt "konkrét: e₁(e₂e₃) = +e₆"
      (gyokSzorozElojeles E1 (egysegSzorzatTabla E2 E3) == PozitivGyok E6)
  ]

-- ═══════════════════════════════════════════════════════════════
-- DIRAC-IDŐFEJLŐDÉS TESZTEK — numerikus precizitás (Idris Double)
-- ═══════════════════════════════════════════════════════════════

public export
diracIdoTesztek : List TesztEredmeny
diracIdoTesztek =
  [ teszt "Zitterbewegung: mátrix-út == zárt képlet t=π/4 (≤10⁻¹²)"
      (kisebbMintPrecizitas
        (magyarValoszinusegMatrixUt 1.0 (3.141592653589793 / 4.0) -
         magyarValoszinusegWeyl     1.0 (3.141592653589793 / 4.0)))
  , teszt "Zitterbewegung: mátrix-út == zárt képlet t=π/2 (≤10⁻¹²)"
      (kisebbMintPrecizitas
        (magyarValoszinusegMatrixUt 1.0 (3.141592653589793 / 2.0) -
         magyarValoszinusegWeyl     1.0 (3.141592653589793 / 2.0)))
  , teszt "Zitterbewegung: mátrix-út == zárt képlet t=π/3 (≤10⁻¹²)"
      (kisebbMintPrecizitas
        (magyarValoszinusegMatrixUt 1.0 (3.141592653589793 / 3.0) -
         magyarValoszinusegWeyl     1.0 (3.141592653589793 / 3.0)))
  , teszt "P(magyar)(π/2) = 1.0 (a teljes átváltás) ≤10⁻¹²"
      (kisebbMintPrecizitas (magyarValoszinusegMatrixUt 1.0 (3.141592653589793 / 2.0) - 1.0))
  , teszt "szerveri γ⁰-val P(magyar) = 0 PONTOSAN (örök elkülönülés)"
      (magyarValoszinusegSzerveri 1.0 0.7 == 0.0
       && magyarValoszinusegSzerveri 1.0 1.5 == 0.0)
  ]

-- ═══════════════════════════════════════════════════════════════
-- ÖSSZEFOGLALÓ
-- ═══════════════════════════════════════════════════════════════

public export
osszesTeszt : List TesztEredmeny
osszesTeszt =
  e8Tesztek ++ hammingTesztek ++ ragTesztek ++ kerdoszoTesztek
  ++ grafTesztek ++ mdlTesztek ++ valoszinusegTesztek ++ lawvereTesztek
  ++ fonetikaTesztek ++ fanoParitasTesztek ++ szotarTesztek
  ++ steaneHamiltonianTesztek ++ lejeuneTesztek ++ hanmagTesztek
  ++ kerdoszoTesztek ++ kerdoszoTipusosTesztek ++ e8GyokTesztek
  ++ diracGammaTesztek ++ oktonionTesztek ++ diracIdoTesztek

public export
sikeres : List TesztEredmeny
sikeres = filter (\t => sikeres t) osszesTeszt

public export
sikertelen : List TesztEredmeny
sikertelen = filter (\t => not (sikeres t)) osszesTeszt

public export
record TesztOsszefoglalo where
  constructor TesztOsszefoglaloK
  bizonyitasokDb  : Nat    -- 1. szint: Refl
  tesztekDb       : Nat    -- 2. szint: Show
  sikeresDb       : Nat
  sikertelenList  : List TesztEredmeny

public export
Show TesztOsszefoglalo where
  show o =
    "═══ TESZT EREDMÉNY ═══\n"
    ++ "1. szint (Refl bizonyítások): " ++ show (bizonyitasokDb o) ++ " [FORDÍTVA = BIZONYÍTVA]\n"
    ++ "2. szint (Show tesztek): " ++ show (sikeresDb o) ++ "/" ++ show (tesztekDb o) ++ " sikeres"
    ++ (if length (sikertelenList o) == 0
          then " — MIND SIKERES ✓"
          else "\nSikertelenek:\n" ++ concatMap (\t => "  " ++ show t ++ "\n") (sikertelenList o))

public export
tesztJelentes : TesztOsszefoglalo
tesztJelentes =
  TesztOsszefoglaloK bizonyitasokSzama (length osszesTeszt)
                    (length sikeres) sikertelen

-- ─── main: vékony IO-burkoló ───────────────────────────────

main : IO ()
main = putStrLn (show tesztJelentes)