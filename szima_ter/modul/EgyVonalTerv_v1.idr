module EgyVonalTerv_v1

-- ═══════════════════════════════════════════════════════════════════════
-- EGY VONALAS TERV v1 — a típuscsomagolás és a kutatás EGY lineáris sora
-- ═══════════════════════════════════════════════════════════════════════
-- A felhasználó TOP HARD RULE-ja (2026-09-02, szó szerint):
--   „1 vonal van ! semmi parhuzamositas, az egy vonalat megtervezzuk,
--    lepesrol lepesre, file-rol, file-ra, es az idriszt hasznaljuk
--    a todo es terv elkeszitesere, olvasd el az ehhez kapcsolodo
--    reszeket a projektben"
--
-- A terv EGY lineáris sorozat — nincs párhuzamosítás, nincs „három vonal".
-- Minden lépés EGY fájl (vagy EGY kohézis fájlcsoport), a sorrend a
-- függőségi gráf topologikus rendje:
--   000 AZ ALAP → 100 LEVELEK → 200 KÖZÉP → 300 NAGY FÁJLOK →
--   400 CSOMÓPONTOK (a végén!) → 500 ARCHIVÁLÁS → 600 A KUTATÁS FOLYTATÁSA
--
-- §24: NINCS duplikáció — a Feladat/Állapot/Prioritás típusokat a
--   SajatTodo_v1-ből IMPORTÁLJUK (az az EGYETLEN todo-típus).
-- §N8: a terv Idrisben (nem markdown, nem beépített todo).
-- A MODUL SORSA: ez az eszköz is a vonal része — amikor a migráció a
--   szima_ter fájlokhoz ér (300.03+), EZ A MODUL IS data-típusokra írható
--   át (önreflexív terv — a terv a saját fejlődésének tervét is tartalmazza).
-- ═══════════════════════════════════════════════════════════════════════
-- 单线计划 v1 — 用 Idris 制定的单一线性计划（无并行！）
-- ═══════════════════════════════════════════════════════════════════════

import SajatTodo_v1
import Data.List
import Data.String as SzövegMűvelet

%default total

-- ═══════════════════════════════════════════════════════════════════════
-- I. AZ EGY VONAL — a teljes lineáris sorozat
-- ═══════════════════════════════════════════════════════════════════════

public export
egyVonal : List Feladat
egyVonal = [

  -- ─── 000. ZÁRADÉK: AZ ALAP (a teljes rendszer fundamentuma) ───
  MkFeladat "000.00" "Az egyvonalas terv (ez a modul) — a terv Idrisben"
    Kész Magas "EgyVonalTerv_v1.idr",
  MkFeladat "000.01" "CsomagoltTípusok: minden data típus (Sorszám, Betű 44, Szöveg, Igazság, EgészSzám, Számjegy, Előjel, SzámjegyesSzám, MatematikaiKonstans, FizikaiKonstans, Kubit, Fűzér, Talán, Pár, E8Koordináta, Időbélyeg, VerzióSzám, Megbízhatóság, BájtláncIndex, Esetrag) + typeclassok (SzámsorT, SzövegT, IgazságT, KonstansT, MennyiségT, BetűT) + Refl-bizonyítások (De Morgan, dupla tagadás, Sorszám jobb-egység, Szöveg üres-egység, számjegy-normalizáció) + SteaneVektor : Sorszám → Type"
    Vár Magas "osveny_index/Alap/CsomagoltTipusok.idr",
  MkFeladat "000.02" "Határ-modul: határKiírás/határOlvasás — az EGYETLEN hely, ahol String megjelenik (a main IO határa)"
    Vár Magas "osveny_index/Alap/Határ.idr",
  MkFeladat "000.03" "Pilóta: LimitKolimitDemo újraírása data-típusokkal (a newtype-változat ELVETVE)"
    Vár Magas "osveny_index/LimitKolimitDemo.idr",

  -- ─── 100. LEVELEK (1–2 importáló, kis fájlok — a minta gyakorlása) ───
  MkFeladat "100.01" "HaromKubit átírása (1 meztelen)"
    Vár Közepes "osveny_index/HaromKubit.idr",
  MkFeladat "100.02" "Torusz átírása (2 meztelen)"
    Vár Közepes "osveny_index/Torusz.idr",
  MkFeladat "100.03" "GeneralizedPauli átírása (2 meztelen)"
    Vár Közepes "osveny_index/GeneralizedPauli.idr",
  MkFeladat "100.04" "Kérdőszó átírása (3 meztelen)"
    Vár Közepes "osveny_index/Kerdoszo.idr",
  MkFeladat "100.05" "Hipotetikus átírása (3 meztelen)"
    Vár Közepes "osveny_index/Hipotetikus.idr",
  MkFeladat "100.06" "KettőKategória átírása (3 meztelen)"
    Vár Közepes "osveny_index/KettoKategoria.idr",
  MkFeladat "100.07" "CayleyDickson átírása (5 meztelen)"
    Vár Közepes "osveny_index/CayleyDickson.idr",
  MkFeladat "100.08" "DiracGammaMátrixok átírása (3 meztelen)"
    Vár Közepes "osveny_index/DiracGammaMatricak.idr",
  MkFeladat "100.09" "LejeuneTranszformáció átírása (3 meztelen)"
    Vár Közepes "osveny_index/LejeuneTranszformacio.idr",
  MkFeladat "100.10" "ToruszTeszt + Steane713Dependent átírása"
    Vár Közepes "osveny_index/ToruszTeszt.idr",

  -- ─── 200. KÖZÉP (a Kodol a MagyarNyelv ELŐTT — GAN függőségi él!) ───
  MkFeladat "200.01" "Kodol átírása (19 meztelen) — a MagyarNyelv függ tőle!"
    Vár Magas "osveny_index/Kodol.idr",
  MkFeladat "200.02" "MagyarNyelv átírása (16 meztelen)"
    Vár Magas "osveny_index/MagyarNyelv.idr",
  MkFeladat "200.03" "MagyarNyelvtan átírása (15 meztelen)"
    Vár Közepes "osveny_index/MagyarNyelvtan.idr",
  MkFeladat "200.04" "FogalomFa átírása (12 meztelen)"
    Vár Közepes "osveny_index/FogalomFa.idr",
  MkFeladat "200.05" "FázisAlgebra + Fázis átírása (6+7 meztelen)"
    Vár Közepes "osveny_index/FazisAlgebra.idr",
  MkFeladat "200.06" "KategóriaElmélet átírása (6 meztelen) — a 10 limit/kolimit + GAN-kiegészítések megőrzése"
    Vár Magas "osveny_index/KategoriaElmelet.idr",
  MkFeladat "200.07" "KostantFelbontás_v2 átírása (11 meztelen)"
    Vár Közepes "osveny_index/KostantFelbontás_v2.idr",
  MkFeladat "200.08" "Komplex átírása (25 meztelen) — a numerika határprojekció (KonstansT)"
    Vár Közepes "osveny_index/Komplex.idr",
  MkFeladat "200.09" "KvantumY átírása (18 meztelen) — aranyMetszés → AranymetszésSzimbólum"
    Vár Közepes "osveny_index/KvantumY.idr",
  MkFeladat "200.10" "HadamardTávolság + Távolság + KörOsztás átírása (6+6+9)"
    Vár Közepes "osveny_index/HadamardTavolsag.idr",
  MkFeladat "200.11" "E8Gyökrendszer + E8Ellenőrző + E9Algebra átírása (19+10+6) — E8Koordináta {0,±1,±½}"
    Vár Magas "osveny_index/E8Gyokrendszer.idr",
  MkFeladat "200.12" "OktonionAlgebra átírása (10 meztelen)"
    Vár Közepes "osveny_index/OktonionAlgebra.idr",
  MkFeladat "200.13" "HánMagyarKódolás + NyelvtaniFa átírása (11+18) — Betű/Szöveg"
    Vár Magas "osveny_index/HanMagyarKodolas.idr",
  MkFeladat "200.14" "SzabályParszer + HtmlDsl átírása (18+23)"
    Vár Közepes "osveny_index/SzabalyParszer.idr",
  MkFeladat "200.15" "Kereső + TöbbnyelvűKereső átírása (25+31)"
    Vár Közepes "osveny_index/Kereso.idr",
  MkFeladat "200.16" "ÉrtelmezőSzótár + Szótár + Fonetika átírása (5+25+24) — végEgyezikE a 18 esetraghoz"
    Vár Magas "osveny_index/Szotar.idr",
  MkFeladat "200.17" "Áttekintés + Abdukció7 + Adjunkció átírása (10+4+15)"
    Vár Alacsony "osveny_index/Attekintes.idr",
  MkFeladat "200.18" "FordítóPrototípus + FordításCarnot átírása (10+6)"
    Vár Közepes "osveny_index/ForditasCarnot.idr",
  MkFeladat "200.19" "GUTPerkoláció + FanoParitás + Hierarchia7 átírása (8+9+8)"
    Vár Közepes "osveny_index/GUTPerkolacio.idr",
  MkFeladat "200.20" "Kant7x7 + KantNyelvtan + Kant/Index átírása (10+22)"
    Vár Közepes "osveny_index/Kant7x7.idr",
  MkFeladat "200.21" "K_E9_Idr átírása (36 meztelen)"
    Vár Alacsony "osveny_index/K_E9_Idr.idr",
  MkFeladat "200.22" "KategóriaGerinc + KategóriaElmélet64 átírása (6+27)"
    Vár Közepes "osveny_index/KatogorialGerinc.idr",
  MkFeladat "200.23" "LegkisebbMűvelet 6 fájl átírása (LegkisebbMűvelet 64 + IngyenesTételek 48 + FizikaiTáblázat 37 + ...)"
    Vár Magas "osveny_index/LegkisebbMuvelet/LegkisebbMuvelet.idr",
  MkFeladat "200.24" "Fizika/Legendre átírása (87 meztelen) — a Double-jei határprojekció"
    Vár Magas "osveny_index/Fizika/Legendre.idr",
  MkFeladat "200.25" "Geometria átírása (37 meztelen) — HosszMennyiség (a Hossz-névütközés feloldása)"
    Vár Közepes "osveny_index/Geometria.idr",
  MkFeladat "200.26" "LawvereGödel átírása (27 meztelen)"
    Vár Közepes "osveny_index/LawvereGodel.idr",
  MkFeladat "200.27" "Dirac3D 20 fájl átírása (KisAI 57, Steane153 38, ...)"
    Vár Közepes "osveny_index/Dirac3D/Dirac3D.idr",
  MkFeladat "200.28" "Emberi/Index + Számítási/Index + Perem/Index átírása"
    Vár Közepes "osveny_index/Emberi/Index.idr",
  MkFeladat "200.29" "MiértLánc + Bizonyítás/SzámelméletiAlapok átírása"
    Vár Közepes "osveny_index/MiertLanc/MiertLanc.idr",
  MkFeladat "200.30" "Alap/ maradék 4 (GrafT, KategoriaT, KeresoTabla, LagrangianT) kanonizálása — CsomagoltTipusok import"
    Vár Magas "osveny_index/Alap/GrafT.idr",
  MkFeladat "200.31" "trail_index 12 fájl átírása (Provenance, Tree, Index...) + FaVizualizáció-kettőzés egyesítése"
    Vár Közepes "trail_index/Provenance.idr",
  MkFeladat "200.32" "SteaneHamiltonian + SteaneHierarchia + Teszt fájlok átírása"
    Vár Alacsony "osveny_index/SteaneHamiltonian.idr",
  MkFeladat "200.33" "Rendszer + Vizualizációk + Könyv/KönyvKészítő átírása"
    Vár Alacsony "osveny_index/Rendszer.idr",

  -- ─── 300. NAGY FÁJLOK (a 78+ előfordulású szörnyek) ───
  MkFeladat "300.01" "KategóriaElméletUniverzális átírása (78 meztelen — a legnagyobb)"
    Vár Közepes "osveny_index/KategóriaElméletUniverzális.idr",
  MkFeladat "300.02" "szerver_hagyar/idris 11 fájl átírása (CategoryTheoryUniversal 78, CriticalExponents 53, ...)"
    Vár Alacsony "szerver_hagyar/idris/CategoryTheoryUniversal.idr",
  MkFeladat "300.03" "A szima_ter/modul 138 fájljának sorszámozása (alFeladatBeszúró) — a teljes lista generálása"
    Vár Magas "szima_ter/modul/SajatTodo_v1.idr",
  MkFeladat "300.04" "szima_ter: AlphaSteane sorozat átírása (AlphaE8Szigor 66, AlphaSteaneE8 40, ...)"
    Vár Közepes "szima_ter/modul/AlphaE8Szigor.idr",
  MkFeladat "300.05" "szima_ter: SzótárHíd_v2 + HungarianLexikon átírása (42+ meztelen) — végEgyezikE kritikus"
    Vár Magas "szima_ter/modul/SzotarHid_v2.idr",
  MkFeladat "300.06" "szima_ter: E8Gyökök + E8Univerzalitás + KönyvAdat_E8Gyökrendszer átírása (41+42+124!)"
    Vár Közepes "szima_ter/modul/E8Gyokok.idr",
  MkFeladat "300.07" "szima_ter: EpizodikusMemória + BabyAGI + Kémia + Műszerefal átírása (89+53+41)"
    Vár Közepes "szima_ter/modul/EpisodicMemory_v1_Szima.idr",
  MkFeladat "300.08" "szima_ter: a maradék fájlok átírása (a 300.03 lista szerint)"
    Vár Közepes "szima_ter/modul/",

  -- ─── 400. CSOMÓPONTOK (A LEGVÉGÉN — mindegyik EGY lépésben a teljes lánc!) ───
  MkFeladat "400.01" "E8E8Algebra átírása (13 meztelen, 23 importáló!) — EGY lépésben a teljes lánc"
    Vár Magas "osveny_index/E8E8Algebra.idr",
  MkFeladat "400.02" "ModulRegisztráció átírása (4 meztelen, 15 importáló)"
    Vár Magas "osveny_index/ModulRegisztracio.idr",
  MkFeladat "400.03" "Steane713 átírása (3 meztelen, 31 importáló!) — az UTOLSÓ csomópont, EGY lépésben"
    Vár Magas "osveny_index/Steane713.idr",

  -- ─── 500. ARCHIVÁLÁS (megőrzés, nem átírás — MANTRA: nem törlünk) ───
  MkFeladat "500.01" "tanulsagok/ 65 próbafájl + diagnosztika/ ARCHIVÁLÁSA (nem futó kód — megőrizzük, nem írjuk át)"
    Vár Alacsony "osveny_index/tanulsagok/",

  -- ─── 600. A KUTATÁS FOLYTATÁSA (a vonal folytatódik — a tiszta alapon) ───
  MkFeladat "600.01" "FÁZIS 1.2: monada/komonád család (5 fogalom: Monad, Komonád, Kleisli, Eilenberg-Moore, Szabad monada)"
    Vár Magas "osveny_index/KategoriaElmelet.idr",
  MkFeladat "600.02" "FÁZIS 1.3: morfizmus-típusok (4: Mono, Epi, Izomorfizmus, Retrakció)"
    Vár Közepes "osveny_index/KategoriaElmelet.idr",
  MkFeladat "600.03" "FÁZIS 1.4: funktor-típusok (4: Teljes, Hűséges, Ekvivalencia, Felejtő)"
    Vár Közepes "osveny_index/KategoriaElmelet.idr",
  MkFeladat "600.04" "FÁZIS 1.5: magasabb kategóriák (3: Bikategória, Profunktor, Kan-kiterjesztés)"
    Vár Közepes "osveny_index/KategoriaElmelet.idr",
  MkFeladat "600.05" "FÁZIS 1.6: kvantum/fizika (4: Dagger=CPT, KompaktZárt=E8×E8×E8, Szalagos=Fano, Nyom) — a SAJÁT hozzájárulás!"
    Vár Magas "osveny_index/KategoriaElmelet.idr",
  MkFeladat "600.06" "FÁZIS 1.7: toposz (4: Toposz, Részobjektum-osztályozó, Exponenciális, Grothendieck)"
    Vár Közepes "osveny_index/KategoriaElmelet.idr",
  MkFeladat "600.07" "FÁZIS 2: KutatásiGráf_v1 — a gráf-adatbázis (Csúcs/Él/Hiperél data-típusokkal)"
    Vár Magas "osveny_index/KutatasiGraf_v1.idr",
  MkFeladat "600.08" "FÁZIS 3–4: a koncepciók és morfizmusok felvétele a gráfba"
    Vár Közepes "osveny_index/KutatasiGraf_v1.idr",
  MkFeladat "600.09" "FÁZIS 5: Yoneda — a jelentés (a gazdag Hom-halmazokból)"
    Vár Magas "osveny_index/KutatasiGraf_v1.idr",
  MkFeladat "600.10" "FÁZIS 6: a magyar 18 esetrag-keresés (Betű/Szöveg típusokra)"
    Vár Magas "osveny_index/KutatasiGraf_v1.idr"
  ]

-- ═══════════════════════════════════════════════════════════════════════
-- II. A VONAL LEKÉRDEZÉSEI
-- ═══════════════════════════════════════════════════════════════════════

||| A következő lépés: az első nem-Kész feladat (a vonal elejéről keresve).
public export
következőLépés : Maybe Feladat
következőLépés = find (\f => feladatÁllapota f /= Kész) egyVonal

||| A kész lépések száma.
public export
készLépésekSzáma : Nat
készLépésekSzáma = length (filter (\f => feladatÁllapota f == Kész) egyVonal)

||| Az összes lépés száma.
public export
összesLépésSzáma : Nat
összesLépésSzáma = length egyVonal

||| Egy szakasz lépései (a sorszám eleje szerint — pl. „200" = a KÖZÉP).
public export
szakaszLépései : String -> List Feladat
szakaszLépései eleje = filter (\f => SzövegMűvelet.isPrefixOf eleje (feladatSzáma f)) egyVonal

-- ═══════════════════════════════════════════════════════════════════════
-- III. A FŐPROGRAM — kiírja az egy vonalat és a következő lépést
-- ═══════════════════════════════════════════════════════════════════════

main : IO ()
main = do
  putStrLn ""
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " EGY VONALAS TERV v1 — a típuscsomagolás és a kutatás egy sora"
  putStrLn " (nincs párhuzamosítás — lépésről lépésre, fájlról fájlra)"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn ("Összes lépés: " ++ show összesLépésSzáma
    ++ " | Kész: " ++ show készLépésekSzáma)
  putStrLn ""
  putStrLn "─── AZ EGY VONAL ───────────────────────────────────────────"
  traverse_ (\f => putStrLn (show f)) egyVonal
  putStrLn ""
  putStrLn "─── A KÖVETKEZŐ LÉPÉS ──────────────────────────────────────"
  case következőLépés of
    Just f  => putStrLn (show f)
    Nothing => putStrLn "A vonal végén vagyunk — minden lépés kész!"
  putStrLn ""