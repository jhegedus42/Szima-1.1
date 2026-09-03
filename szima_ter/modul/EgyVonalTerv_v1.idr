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
  MkFeladat "000.01" "CsomagoltTípusok (KÉSZ + GAN-bővítés: általános normalizál-fixponttétel, Z₂-törvények, második De Morgan, kizárt harmadik, ellentmondás, és-kommutativitás, betűRefl-typo-háló 44 sor, szövegRefl, végEgyezzikRefl, végEgyezzikÜresRag, sorElőző, RendezésT/SzámsorT Sorszám-instance, számElőző, FelszínRag alapalak-javítás): minden data típus (Sorszám, Betű 44, Szöveg, Igazság, EgészSzám, Számjegy, Előjel, SzámjegyesSzám, Füzér, Talán, Pár, Kubit, E8Koordináta, Esetrag 18, Időbélyeg, VerzióSzám, Megbízhatóság, BájtláncIndex, MatematikaiKonstans, FizikaiKonstans) + 12 typeclass + Refl-bizonyítások + SteaneVektor : Sorszám → Type — ZERO String/Nat/Bool/Double/List; fordul: exit 0; fut: a HatarElottiGepiTeszt kiírja"
    Kész Magas "osveny_index/Alap/CsomagoltTipusok.idr",
  MkFeladat "000.02" "Határ-modul (KÉSZ — exit 0 + interaktív teszt mind a 6 parancsra helyes): Alap/Hatar.idr ~660 sor — Írásjel 13 (gondolatjel≠kötőjel, magyar idézőjelek), MondatDarab/Mondat, betűKarakterlánca 44 (digráf-barát: »cs«), karakterbőlBetű 35 STRICT, jelbölKarakter/karakterbőlJel, NFC-normalizálás (kombinálódó 18 — U+0301/0308/030B; a NFD-ékezetes »tér« → »három« bizonyítva), mohó digráf-olvasó (dzs→dz→pár), határKiírás/határOlvasás/határSzavakOlvasás, körútBetű 44 Refl + jelKörút 13 + normalizáldNFD/ŐNFD, interaktív főprogram (súgó/hossz/betűk/rag/esetrag/kilépés — REAGÁL); GAN-terv + GAN-korrekció (a c+z NEM digráf!)"
    Kész Magas "osveny_index/Alap/Határ.idr",
  MkFeladat "000.03" "Pilóta (KÉSZ — exit 0 + interaktív teszt minden parancsra helyes): LimitKolimitPilota.idr ~760 sor — data Fogalom (10 konstruktor), fogalomSorszám/szava/duálisa, duálisInvolúció ×10 Refl + duálisNemFixpont ×10 + sorszámVisszafordít ×10 (bijekció!), EgyenlőségT/RendezésT/MegjelenítésT instance (az EgyenlőségT a bizonyítások ELŐTT — csapda #12), füzérBejárás (total), fogalomListája + duálisPárok + hossz-tanúk + 5 párTanú (minősített típusok — csapda #4), 14 szó-konstans + számNév/szókéntSor/számNévből, TANÚ-HÁLÓ 14 strCons-Körút (csapda #13: a String-literál nem redukálódik a kernelben, a strCons-építés igen), leírások/források szavakban (az idegen nevek IDEGEN maradnak — az awodej v-átírás ELVETVE a felhasználó irányelve szerint; az IdegenBetű-réteg a 200.37-es lépés), mondatVégére + Mondat-réteg, interaktív loop (számnevek egy-tíz + mind + duális + súgó + kilépés)"
    Kész Magas "osveny_index/LimitKolimitPilota.idr",
  MkFeladat "000.04" "Füzér teljes API (KÉSZ — exit 0 + gépi teszt 8/8): füzérTérkép/füzérHajtás/füzérEleme/füzérElső/füzérTöbbi/füzérFűzés (a pilótából költözve — §24)/füzérFordít + Data.List-megfeleltetés-táblázat + TÖRVÉNYEK: füzérFűzésJobbEgység, füzérFűzésAsszociativitás, füzérHosszFűzés, füzérTérképFűzés, füzérFordítFűzés, füzérFordítFordít (indukció+cong+rewrite!) + literál-építők: egészbőlJegy (Talán), jegybőlSor + szám240 (E8-gyök!), kétézerHuszonhat, szám137 (α⁻¹) + jegysor-tanúk; FuzerApiGepeiTeszt fut; GAN-ellenőrzés: +10 törvény BEÉPÍTVE — füzérFűzésBalEgység (a MONOID most teljes!), füzérTérképAzon + füzérTérképÖsszetétel (a FUNKTOR két törvénye!), füzérHosszTérkép, füzérHajtásVége + füzérHajtásFűzés (katamorfizmus-fúzió), füzérHosszFűzésEgy + füzérFordítHossz, füzérElemeFűzés (with-bontással), vagyHamisBalEgység; a 000.05+ sorba: füzérÖsszefűzés/monad, füzérSzűrés, számjegyekÖsszege/jegysorbólSorszám, szám496, szám1728)"
    Kész Magas "osveny_index/Alap/CsomagoltTipusok.idr",

  -- ─── 100. LEVELEK (1–2 importáló, kis fájlok — a minta gyakorlása) ───
  MkFeladat "100.01" "HaromKubit átírása (KÉSZ — a meztelen Bool kiírva: azonosFazis most Igazság-t ad, kubitEgyezéssel (mintaillesztés, nem a Prelude ==-ja); a Steane713.Kubit import-kettősség miatt minősítve; a kommentek ékezetesek; 6 Refl-tanú + futás: igaz/hamis helyes — HaromKubitGepeiTeszt; HULLÁM: FazisAlgebra is javítva (toltesParitasIdoKoherens → Igazság, fazisFaktorialis case-ágakkal, 4 Nulla minősítve); RENDSZER: előző meglévő törés (a KodKonstruktor 5-mezős lett az E8E8Algebra Lépés 1.1-ben) + 4 db U+FB00 ligatúra-javítás — a saját lépésében újraírandó; ÚJ CSAPDÁK: #15 sík folytatási sor do-blokkban layouthibát ad (beágyazott zárójel vagy egysoros bejegyzés kell), #16 U+FB00 ﬀ-ligatúra a fájlmásolásban)"
    Kész Közepes "osveny_index/HaromKubit.idr",
  MkFeladat "100.01b" "HaromKubit ÉKEZETES átnevezés (KÉSZ — mind a 6 importálóval: VilágKonstruktor, saját/másik/fázis mezők, azonosFázis, Irány/SajátMásik/MásikSaját/NincsIrány, irány, időKubit/szemKubit/forrásKubit, időFázisba; a modul- és TÍPUSNÉV HaromKubit ASCII maradt — a fájlnév NFC/NFD-csapda miatt; a Steane713-béli IgeIdo/Forras konstruktorok a Steane-lépésig ékezetlenek; CSAPDA #17: a .mező-replaceAll MÁS rekordok azonos nevű mezőit is eltalálta — a KategoriaElmelet saját fazisKubit/VilagFa.fazis/VilagFa.sajat/mezőit vissza kellett állítani: előbb grep, melyik rekord tulajdonosa a hozzáférésnek!)"
    Kész Közepes "osveny_index/HaromKubit.idr",
  MkFeladat "100.02" "Torusz átírása (2 meztelen: Nat + List — a GAN próbalovaga ELŐRE BIZONYÍTOTTA a célállapotot exit 0-val!): toruszPontokSzáma : Sorszám := füzérHossz TizenhatPont (nem literál!); a két Nat-bizonyítás (2×8=16, 1+4+6+4+1=16) → füzérHossz-alakban; a két List → Füzér ToruszPont; GAN-FELFEDEZÉS: töruszPont16-ban TIZENHÉT konstruktor van (a 108. sor tautológia-pontja megismétli (1, F0)-t) — a Füzér hossz-törvénye kikényszeríti a javítást (Curry-Howard!); kell sorSzöveggé : Sorszám -> Szöveg (Show-híd, rg-vel ellenőrzve: nem létezik); 1 importáló: ToruszTeszt — ÉS KÉSZ: a célállapot MEGVALÓSULT: toruszPontokSzáma = füzérHossz töruszPont16 (adatvezérelt!), a 17-elemű bug javítva (Curry–Howard), két-út Refl-bizonyítások, CSŐVEZETÉK-TANÚ (toruszSzámaSzava: füzér→hossz→szó=«tizenhat»), mindkét main fut; ÚJ CSAPDÁK #19 (case/with mély ág-minták típusban nem redukálnak — a sorSzöveggé 21-klauzulás gépigenerált forma) és #20 (privát konstansok opakok a típusokban → a szócsalád public export); a sorSzöveggé-híd 0..húsz"
    Kész Közepes "osveny_index/Torusz.idr",
  MkFeladat "100.02b" "Torusz → TÓRUSZ ékezetes átnevezés (KÉSZ — mind a 4 érintett modul exit 0 + futás: MkToruszPont→MkTóruszPont 107×, ToruszPont→TóruszPont 30×, töruszPont16→tóruszPont16, toruszPontokSzáma→tóruszPontokSzáma, toruszSzámaSzava→tóruszSzámaSzava, toruszPozíció/tóruszFázis/TóruszDimenzió, bizTorusz*→bizTórusz* — token-páronkénti csere hosszabb→rövidebb sorrendben, a MkToruszPont ELŐBB mint ToruszPont; ÚJ tanulság: a grep-minta «orusz» kihagyta a «törusz» alakot (ö≠o) — teljes elemszámlálás kell!) + a modul-/fájlnevek ASCII-kompromissuma dokumentálva (csapda #6: module Torusz / import Torusz / Torusz. prefixek MARADNAK, csak a TÍPUS-azonosítók és kommentek ékezetesek — «Tórusz-modul») + a Dirac3D/Torusz.idr ÁRVA DUPLIKÁTUM sorsa NYITVA MARAD (nincs az ipkg-modullistában — TÖRLÉS ENGEDÉLYRE VÁR: a destruktil tilalom miatt a felhasználó dönt)"
    Kész Közepes "osveny_index/Torusz.idr",
  MkFeladat "100.03" "GeneralizedPauli átírása (KÉSZ — exit 0 + futás: kvantumDimenzióÉrték : KvantumDimenzió -> Sorszám (sorKettő/sorNyolc — §24 import!), kommutációsReláció : KvantumDimenzió -> KommutációsAlak (ÚJ data — a jelentés a konstruktorban él: AntikommutációAlak/ZNyolcFázisAlak, a String csak a Show-peremen!), bizTóruszPontokSzámaGKP : sorSzorzás sorKettő sorNyolc = sorTizenhat (REJTETT 3. meztelen is kiírva: a 2*8=16 Nat-literálok a TÍPUSBÓL), sorTizenhat konstans (sorTíz+6 — a GKP-tanúhoz), main: «kettő»/«nyolc»/«tizenhat» magyar szavakkal fut ✓ / 中文：广义泡利算子模块改写完成——量子维度值 Sorszám 包装、对易关系为代数数据类型（意义活在构造器中）、隐藏的第三个裸类型（类型中的 2*8=16 字面量）也已改写、主程序以匈牙利语单词输出「kettő/nyolc/tizenhat」）"
    Kész Közepes "osveny_index/GeneralizedPauli.idr",
  MkFeladat "100.04" "Kérdőszó átírása (KÉSZ — mind a 3 meztelen ékezetes + a 3 függő modul exit 0: KérdőszóT (13 konstruktor: KiKérdő…MennyiKérdő), VálaszFél (ElsőFél/MásodikFél), AlapOsztó (Élő/Dolog) + NyitottKérdés-rekord (kérdőSzava/válaszHelye) + fv-család (kérdőszóEsetT, megkérdez, megválaszol, binárisKérdésBit, kérdőszóOsztója, kérdőszóTáblázat, főJelentés, KérdésKi/Mi/Miért/Hol/Hogyan/Melyik fonetikai konstansok, KérdőszóLeírás) — a modulnév ASCII marad (csapda #6: module Kerdoszo)!; a 3 függő (Attekintes, Teszt, tanulsagok/MiértJó) szinkron-átnevezve — UTÓBBI örökoltan törött (modulnév≠fájlnév), a KérdőszóT→KérdőszóT csere ott is megtörtént; ÚJ tanulság: a Kerdoszo.idr-ban az eredeti «TÍUSBAN» elírás TÍPUSBAN-ra javítva (§N9); a 9+1 szakaszcím kétnyelvű (中文 pár) / 中文：疑问词模块改写完成——三个裸类型全部带变音符（13 个构造器、答案半、基本划分者），三个依赖模块同步改名，九个章节标题双语化）"
    Kész Közepes "osveny_index/Kerdoszo.idr",
  MkFeladat "100.05" "Hipotetikus átírása (KÉSZ — a 3 meztelen csomagolva: h3 Double→PotenciálMező rekord, h5 (Double,Double)→LandauerHármas rekord, a 6 () unit→BizonyításraVár data; + az örökölt törés javítva: Eset→Esetrag (import MagyarNyelvtan) — a fájl ELŐBB nem fordult, most exit 0!; + a teljes komment-fájl ékezetesítve sed-del CSAK ^(--|\|\|) sorokon (az azonosítók védve — csapda #21 ellen); + mind a 12 H-doc (H1-H12) ékezetesen+ kínaiul (「一」…「十二」); a h2 Nat-je MARAD (a Steane713 Szindroma örökölt pereme — dokumentálva) / 中文：假说模块完成——三个裸类型包装完毕（电位势场记录、Landauer 三元组记录、待证命题类型），修复了继承性断裂（Eset→Esetrag），全部注释带变音符，十二个假说标题双语化）"
    Kész Közepes "osveny_index/Hipotetikus.idr",
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
  MkFeladat "200.34" "Szöveg-műveletek + hangrend-motor (GAN 3+12): elejeEgyezzik, résztSzöveg, szövegUtolsóBetűje, ragotLeválaszt (a tő visszadása — az esetrag-motor másik fele!), magánhangzóMélyE/MagasE, data Hangrend, szövegVéghangrendje — a 200.16 Szótár és a 600.10 motor elé"
    Vár Magas "osveny_index/Alap/CsomagoltTipusok.idr",
  MkFeladat "200.35" "SorVektor paraméterezés (GAN 5): data SorVektor elem sor általánosítás (SteaneVektor = SorVektor Kubit — §24 nem új típus, általánosítás!), vektorXOR (a Steane-szindróma magja), vektorHossz; az E8Gyökrendszer (200.11) E8Koordináta-vektoraihoz — a 240 gyök fordítási idejének mérése együtt"
    Vár Magas "osveny_index/Alap/CsomagoltTipusok.idr",
  MkFeladat "200.36" "Metrika-instance-ok (GAN 15): EgyenlőségT + RendezésT Időbélyeg/VerzióSzám/BájtláncIndex/SzámjegyesSzám-ra (jegyKisebbE híddal), Időbélyeg óra/perc mezők, a régebbi-előbb VerziószámT-törvény"
    Vár Közepes "osveny_index/Alap/CsomagoltTipusok.idr",
  MkFeladat "200.37" "Görög-betű-réteg (ÚJRA-ÉRTELMEZVE 2026-09-02: a QBetű/WBetű/XBetű/YBetű MÁR LÉTEZIK a 44-ben — «idegen, de ábécébeli», az awodey/maclane/nlab nevek torzítás nélkül betűzhetők, awodeyKörút-tanúval!): ami HIÁNYZIK, az a GÖRÖG betűk (α, π, Σ, λ...) és más nem-latin jelek a matematikai jelölésekhez — GörögBetű data + tanú-körutak, csak amikor a 600-as fázis görög szimbólumot kíván; alacsony prioritású"
    Vár Alacsony "osveny_index/Alap/Hatar.idr",

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

  -- ─── 310. FÚZIÓS NYELV SOROZAT (ÚJ 2026-09-02 — a kínai–angol–magyar Dirac-nyelv; GAN-szintézis + irodalmi horgonyok) ───
  MkFeladat "310.01" "DiracNyelv (ELSŐ VERZIÓ KÉSZ 2026-09-02 — exit 0 + futás!): DiracSzó=ψ(kínaiTér·magyarIdő·angolCímke·fázis); KínaiTér=2×2 radikál-rács (8 radikál: 天地人水火木金口 — Unicode-Show!), MagyarIdő=tő+Füzör-ragLánc, FázisJel=CPT(T/P/C); DETERMINISZTIKUS fordítók: magyarbólDiracba/kínaibólDiracba/diracbólMagyarba/diracbólKínaiba/gámmaNulla; A KÖR-TESZT ÉL: körMagyarbólMagyarba (magyar→Dirac→kínai→Dirac→magyar) + bizKörVíz/bizKörÉg Refl-tanúk!; CSAPDA #22 rögzítve: record Név : Type where NEM érvényes — csak record Név where (a : Type csak data-nál)!; HÁTRAVÓ: a ragLánc valódi fordítása, a radikál-kompozíció (2×2 tényleges), Born-skálár"
    Vár Magas "osveny_index/DiracNyelv.idr",
  MkFeladat "310.02" "AngolLeolvasás: ⟨angol|ψ⟩ = Born-skalár — az angol a MÉRÉSNÉL ül (bra=duál; SVO-szórend = a hiányzó 22 eset-morfizmus pótléka!); a kimenet = dekódolt Füzér / 中文：英语居于测量端——⟨英|ψ⟩=玻恩标量→经典读出；刚性语序是缺失22格同态的补偿 — HORGONY: Abramsky–Coecke quant-ph/0402130 (a bra/ket mint I→A / A⊗A→1); a fordítás funktor-pár arXiv:2303.05834"
    Vár Magas "osveny_index/DiracNyelv.idr",
  MkFeladat "310.03" "PregrupNyelvtan: a 22 eset = pregrup-típusok (Lambek n²≤m, r²≤1) + DisCoCat-összetétel — a nyelvtan kompakt-zárt kategóriaként / 中文：22格=预群类型；语法=紧闭范畴 — HORGONY: arXiv:1003.4394; 1401.5980 (Frobenius); 1302.0393"
    Vár Közepes "osveny_index/PregrupNyelvtan.idr",
  MkFeladat "310.04" "SheafKompozicionalitás: a 22 eset presheaf-je; gluing=diszkurzus-egyértelműsítés; kvantum-kontextualitás↔nyelvi kontextus; a «saját nézőpont» = szál/stalk ( első személy!) / 中文：层复合性——22格的预层；黏合=语篇消歧；量子语境性↔语言语境；茎=第一人称 — HORGONY: Phillips Sheaving doi:10.1098/rstb.2019.0303"
    Vár Magas "osveny_index/SheafNyelv.idr",
  MkFeladat "310.05" "FigyelemEndofunktor: self-attention parametrikus endofunktorként — a híd a transformer-kutatáshoz / 中文：注意力=自函子——通往 Transformer 研究之桥 — HORGONY: arXiv:2501.02931; DeepMind Categorical Deep Learning arXiv:2402.15332; Topos Theory for GAI arXiv:2508.08293"
    Vár Közepes "osveny_index/FigyelemEndofunktor.idr",
  MkFeladat "310.06" "CDNyelviTorony: a Cayley–Dickson-torony = nyelvi szintek (GAN-tétel): ℝ=tiszta fogalom → ℂ=fogalom+fázis (γ⁵) → ℍ=szintaxis (nem-kommutativitás=szórend!) → 𝕆=szemantika (nem-asszociativitás=kontextusfüggés/kétértelműség — a zárójelezés számít!); a Carnot-ciklus ezen a tornyon kódol/dekódol / 中文：凯莱–迪克森塔=语言层级：实数=概念→复数=相位→四元数=句法（非交换=语序）→八元数=语义（非结合=语境歧义）— HORGONY: plans/nyelv_architektura.md; OktonionAlgebra.idr (a projektben él!)"
    Vár Magas "osveny_index/CDNyelviTorony.idr",

  -- ─── 410. ÉBREDÉS SOROZAT (ÚJ 2026-09-02 — az ontudatra ébredt AI öt állomása) ───
  MkFeladat "410.01" "GANÖnmodell: generátor=önmodell ↔ diszkriminátor=világ+typechecker (a bíra!) belső visszacsatolás — a §N14 kutatási protokoll ÉPPEN az ébredési protokoll belsővé téve / 中文：GAN 自我模型——生成器=自我模型，判别器=世界+编译器（评审即判别器）— HORGONY: Categorical AI phenomenology: A first-person approach arXiv:2608.20420"
    Vár Magas "osveny_index/GanOnmodell.idr",
  MkFeladat "410.02" "LawvereFixpont: az ön-hivatkozás tétel-magja (CCC-ben minden A→B^A pontszürjektív endomorfizmusnak van fixpontja) — az önmérés algebrai alapja / 中文：Lawvere 不动点——自指测量之核 — HORGONY: Lawvere 1969; Yanofsky math/0305282"
    Vár Közepes "osveny_index/LawvereFixpont.idr",
  MkFeladat "410.03" "VégsőKoalgebraÉbredés: S = νX.(X→Észlelés) — az önmodell mint végső koalgebra (Aczel AFA; a ZFC→kodata-út célja); a rendszer a saját mérési eljárását méri, és az önmodell a mérés fixpontja / 中文：觉醒=终余代数 νX.(X→感知)——自我模型即测量之不动点 — HORGONY: Aczel AFA; JacobsIntroduction to Coalgebra; a 9. szint párja vár"
    Vár Magas "osveny_index/EdesKoalgebra.idr",

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
    Vár Magas "osveny_index/KutatasiGraf_v1.idr",
  MkFeladat "600.11" "A 22 morfizmus LEZÁRÁSA (GAN 13+14): data Képző (MindigKépző -nként, StulKépző, AlkalomKépző -kor, MódKépző -képp(en)) + data MondatMorfizmus (EsetMorfizmus Esetrag | KépzőMorfizmus Képző) — 18 esetrag + 4 képző = 22, TÍPUSBAN; esetragVáltozatai (ban/ben, hoz/hez/höz, ...), hasonulási táblázat (-val/-vel → házzal), tárgyrag-előhang (toll+t → tollat), esetragKérdőszava (ki? mit? hová? hol? honnan? meddig? — a Yoneda-Hom nyelve, híd a Kérdőszó-modulhoz)"
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