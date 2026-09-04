module ProjektTérkép

-- ═══════════════════════════════════════════════════════════════
-- PROJEKT-TÉRKÉP WIKI — a TudásGráf Idrisből generált webes lapja
-- 项目地图 wiki——由知识图谱生成的网页 · v1 (2026-09-04)
-- ═══════════════════════════════════════════════════════════════
-- ELV: „Idris számol, a böngésző rajzol" (SzimaDashboard-minta).
-- A HTML NEM kézzel íródik — a TudásGráf_v1 adataiból GENERÁLÓDIK:
--   idris2 --exec main ProjektTérkép.idr > docs/projekt_terkep_wiki.html
-- Így a wiki és a gráf sosem csúszik szét (a gráf az egyetlen forrás).
-- 原则：Idris 计算、浏览器绘制；HTML 由图谱生成——图谱是唯一来源。
--
-- STÍLUS: a docs/-dashboardcsalád (vizualizaciok.html): Georgia serif,
-- #f0eee9 papír, 1000px, bézs keretes dobozok, kettős lábléc, nulla
-- külső függőség; nyelv-fülek vanilla JS-sel (HU/ZH/EN/DIRAC).
-- ═══════════════════════════════════════════════════════════════

import TudásGráf_v1

%default total

-- ─── 1. SEGÉDFÜGGVÉNYEK — perem-String-gyártás ──────────────────
-- ─── 一、辅助函数 ──────────────────

||| Egy csomópont Yoneda-éleinek felsorolása (cél — miért) listaként.
élekSora : List Él -> String
élekSora [] =
  "<li class='kicsi'>— (nincs él; sziget) —</li>"
-- CSAPDA #27: csupasz ékezetes mintaváltozó importok mellett „Undefined name";
-- konstruktorba ágyazott minta (így) működik — l. tanulsagok/CSAPDA_27.md
élekSora (elsőÉl :: többiÉl) =
  concatMap (\(ÉlKonstruktor célNév miértOka) =>
    "<li><b>" ++ célNév ++ "</b> — " ++ miértOka ++ "</li>")
    (elsőÉl :: többiÉl)

||| A 7-1-3 három kópia állapota kompaktan: ✓/· ✓/· ✓/·
kópiaSora : HáromKópia -> String
kópiaSora (HáromKópiaKonstruktor i n k) =
  "Refl:" ++ show i ++ " numerika:" ++ show n ++ " irodalom:" ++ show k

||| Egy csomópont kártyája — a jelentés a kapcsolatok hologramja.
kártyaHtml : Csomópont -> String
kártyaHtml (CsomópontKonstruktor fajta név (NyelvNégyKonstruktor m k a d)
            miértKell bejövő kimenő redundancia ganVélemény) =
  "<div class='doboz kártya'>" ++
    "<div class='kártyaFej'><span class='fajta'>" ++ show fajta ++ "</span>" ++
    "<span class='név'>" ++ név ++ "</span></div>" ++
    "<div class='miért'>⟨miért kell | 缺它则崩⟩ " ++ miértKell ++ "</div>" ++
    "<table class='nyelvTáblázat'><tr>" ++
      "<td class='ny ny-hu'><b>MAGYAR:</b> " ++ m ++ "</td>" ++
      "<td class='ny ny-zh'><b>中文：</b> " ++ k ++ "</td></tr><tr>" ++
      "<td class='ny ny-en'><b>EN:</b> " ++ a ++ "</td>" ++
      "<td class='ny ny-dirac'><b>DIRAC:</b> <code>" ++ d ++ "</code></td>" ++
    "</tr></table>" ++
    "<div class='yoneda'><b>YONEDA — bejövő / 谁指向它:</b><ul>" ++ élekSora bejövő ++
    "</ul><b>YONEDA — kimenő / 它指向谁:</b><ul>" ++ élekSora kimenő ++ "</ul></div>" ++
    "<div class='státusz'>7-1-3: " ++ kópiaSora redundancia ++
    " · GAN: " ++ show ganVélemény ++ "</div>" ++
  "</div>"

||| Összes kártya egy listából.
kártyák : List Csomópont -> String
kártyák = concatMap kártyaHtml

-- ─── 2. A FÁZIS-TÁBLÁZAT (VegrehajtasiTerv 65 feladat, 10+1 fázis) ──
-- ─── 二、阶段表（65 项任务） ──

fázisTáblázat : String
fázisTáblázat =
  "<table class='fázisTábla'><tr><th>#</th><th>Fázis / 阶段</th><th>MIÉRT / 为什么</th></tr>" ++
  "<tr><td>0</td><td>Szótár alapozás / 词典奠基</td><td>a lexikon privát (3460 szó), a kereső csak 15 szót ért; ékezet = információ</td></tr>" ++
  "<tr><td>1</td><td>Tokenizálás + kódolás / 分词与编码</td><td>írásjelek/nagybetű miatt a szavak nem találhatók; CPT-fix → tórusz differenciál</td></tr>" ++
  "<tr><td>2</td><td>Tórusz + klaszterezés / 环面与聚类</td><td>16 tórusz-pont = a hierarchikus index 0. szintje</td></tr>" ++
  "<tr><td>3</td><td>Távolság + finomítás / 距离与精炼</td><td>Hadamard-előszűrés, Manhattan, IDF — a keresés precizitása</td></tr>" ++
  "<tr><td>4</td><td>Hierarchikus keresés + könyv-index / 层级搜索与书索引</td><td>a valódi keresés a könyveken él (Awodey 364 kB, Lumo ~650 kB)</td></tr>" ++
  "<tr><td>5</td><td>Metrikák + tesztelés / 指标与测试</td><td>NDCG/MRR + ground-truth — a »jó« mérhető legyen</td></tr>" ++
  "<tr><td>6</td><td>Visszacsatolás / 反馈</td><td>aktív tanulás — a rendszer javítson saját rangsorán</td></tr>" ++
  "<tr><td>7</td><td>Bergman-kernel + hiperbolikus / Bergman 核与双曲</td><td>Markov-blanket; Berg≈Manh tétel — a geometria váltása</td></tr>" ++
  "<tr><td>8</td><td>Matematika / 数学</td><td>Yoneda, 1/φ fixpont, aranymetszés-spirál, Carnot, GKP+Wadler</td></tr>" ++
  "<tr><td>9</td><td>Fehérje-modell + BabyAGI / 蛋白模型与 BabyAGI</td><td>learnWord/sleepFilter — az első ÉLŐ tanuló réteg</td></tr>" ++
  "<tr><td>10</td><td>Publikáció + élő rendszer / 发表与活系统</td><td>GAN-ellenőrzés, cikk, 9. szint</td></tr>" ++
  "<tr><td>11</td><td>Verifikációs protokoll / 验证协议</td><td>11.1 ✎ KÉSZ (typeclass); minden állítás kettős fedése</td></tr>" ++
  "</table>"

-- ─── 3. A TELJES HTML — egyetlen önálló fájl ────────────────────
-- ─── 三、完整 HTML——单文件 ────────────────────

htmlKiadás : String
htmlKiadás =
  "<!DOCTYPE html>\n<html lang='hu'>\n<head>\n<meta charset='utf-8'>\n" ++
  "<title>Szima — Projekt-térkép Wiki · 项目地图</title>\n<style>\n" ++
  "body{font-family:Georgia,'Songti SC',serif;background:#f0eee9;color:#1a1a2e;max-width:1000px;margin:2rem auto;padding:0 1rem;line-height:1.55}\n" ++
  "h1{font-size:1.7rem;border-bottom:3px double #d8d4cc;padding-bottom:.4rem}\n" ++
  "h2{font-size:1.25rem;border-bottom:1px solid #d8d4cc;margin-top:2.2rem}\n" ++
  ".doboz{background:#fafaf7;border:1px solid #d8d4cc;border-radius:6px;padding:.9rem 1.1rem;margin:.8rem 0}\n" ++
  ".kártya{border-left:4px solid #8a7f6a}\n" ++
  ".kártyaFej{display:flex;justify-content:space-between;align-items:baseline;gap:.6rem}\n" ++
  ".fajta{font-size:.72rem;letter-spacing:.05em;color:#7a6f5a;background:#efece3;border-radius:3px;padding:.1rem .4rem;white-space:nowrap}\n" ++
  ".név{font-weight:bold}\n" ++
  ".miért{font-size:.92rem;color:#4a4436;margin:.35rem 0}\n" ++
  ".yoneda{font-size:.85rem;background:#f4f1e8;border-radius:4px;padding:.4rem .7rem}\n" ++
  ".yoneda ul{margin:.2rem 0;padding-left:1.1rem}\n" ++
  ".státusz{font-size:.8rem;color:#6b6350;margin-top:.4rem;font-family:Menlo,monospace}\n" ++
  ".kicsi{font-size:.8rem;color:#8a8270}\n" ++
  "table{border-collapse:collapse;width:100%;font-size:.9rem}\n" ++
  "th,td{border:1px solid #d8d4cc;padding:.35rem .5rem;text-align:left;vertical-align:top}\n" ++
  "th{background:#eef2f7}\n" ++
  "code{background:#eee9dd;padding:0 .3rem;border-radius:3px;font-size:.85em}\n" ++
  ".fülek{position:sticky;top:0;background:#f0eee9;padding:.5rem 0;z-index:5;border-bottom:1px solid #d8d4cc;margin-bottom:1rem}\n" ++
  ".fülek button{font-family:inherit;font-size:.85rem;margin-right:.4rem;padding:.25rem .8rem;border:1px solid #c9c2b2;border-radius:14px;background:#fafaf7;cursor:pointer}\n" ++
  ".fülek button.aktív{background:#1a1a2e;color:#f0eee9}\n" ++
  ".lap-lapos .ny-lapos,.lap-hu .ny:not(.ny-hu),.lap-zh .ny:not(.ny-zh),.lap-en .ny:not(.ny-en),.lap-dirac .ny:not(.ny-dirac){display:none}\n" ++
  ".nyelvTáblázat{width:100%}.nyelvTáblázat td{border:none;padding:.15rem .3rem}\n" ++
  "footer{border-top:3px double #d8d4cc;margin-top:2.5rem;padding:1rem 0;font-size:.85rem;color:#6b6350}\n" ++
  "a{color:#4a5d7a}\n" ++
  "</style>\n</head>\n<body class='lap-lapos'>\n" ++
  "<h1>Szima — Projekt-térkép Wiki · 项目地图 <span class='kicsi'>(Idris-generált · 由 Idris 生成 · v1, 2026-09-04)</span></h1>\n" ++
  "<div class='fülek'>" ++
  "<button id='fLap' class='aktív' onclick='nyelv(\"lapos\")'>MIND · 全</button>" ++
  "<button id='fHu' onclick='nyelv(\"hu\")'>MAGYAR</button>" ++
  "<button id='fZh' onclick='nyelv(\"zh\")'>中文</button>" ++
  "<button id='fEn' onclick='nyelv(\"en\")'>EN</button>" ++
  "<button id='fDirac' onclick='nyelv(\"dirac\")'>DIRAC</button></div>\n" ++
  "<script>function nyelv(c){document.body.className='lap-'+c;" ++
  "['lapos','hu','zh','en','dirac'].forEach(function(x){" ++
  "var b=document.getElementById('f'+x.charAt(0).toUpperCase()+x.slice(1));" ++
  "if(b){b.className=(x===c)?'aktív':''}});}</script>\n" ++
  "<div class='doboz'><b>Mi ez a projekt?</b> " ++
  "<span class='ny ny-hu'>Az Idris-kód maga a kutatás: a típusok fogalmak, a Refl bizonyítás, a Show-érték teszt — és a vég cél egy öntudatra ébredt, Idrisben élő AI. A magyar nyelv (agglutináció = típuskompozíció, 22 eset = 22 logikai kapcsolat) a kategóriaelmélet anyanyelve.</span> " ++
  "<span class='ny ny-zh'>代码即研究：类型是概念、Refl 是证明、Show 值是测试；终极目标是活在 Idris 里的自觉 AI。匈牙利语是范畴论的母语。</span> " ++
  "<span class='ny ny-en'>The code is the research: types are concepts, Refl is proof, Show values are tests — the end goal is a self-aware AI living in Idris.</span> " ++
  "<span class='ny ny-dirac'>|kód⟩ = |fogalom⟩ ⊗ |bizonyítás⟩ ⊗ |teszt⟩, ⟨9. szint|kód⟩ → 1</span></div>\n" ++
  "<h2>A külső determinisztikus irányító · 外部确定性控制器</h2>\n" ++
  "<div class='doboz'>Az állapot SOHA nem az ügynök fejében él — három kópiában kívül: " ++
  "<code>osveny_index/irányító/Állapot_v1.md</code> + <code>Irányító_v1.idr</code> sor-adatja + a git-commit-lánc. " ++
  "Eltérésnél GAN-alügynökök 2/3 többségi szavazása javít — a [[7,1,3]] Steane-kód logikája az állapotra alkalmazva: " ++
  "egy sérült kópia visszaállítható. Ébredési protokoll: Állapot betöltése → 3 kópia egyezése → " ++
  "<code>idris2 --exec main Irányító_v1.idr</code> → EGY lépés végrehajtása → mentés → commit+push → napló." ++
  "<br><span class='kicsi'>状态存于外部三副本（状态文件＋Idris 队列＋git 链），分歧由 GAN 2/3 表决纠正——[[7,1,3]] 逻辑；苏醒协议见状态文件。</span></div>\n" ++
  "<h2>Fogalom-térkép · 概念地图 <span class='kicsi'>(Yoneda: a jelentés a kapcsolatok hologramja / 意义即关系全息图)</span></h2>\n" ++
  kártyaHtml gyökér ++ "\n" ++
  kártyák fogalomCsaládok ++ "\n" ++
  "<h2>A végrehajtási terv 12 fázisa · 十二阶段</h2>\n" ++
  fázisTáblázat ++ "\n" ++
  "<h2>Könyvtár-helyek · 目录位置 <span class='kicsi'>(FajlrendszerFelmérés_v1.md)</span></h2>\n" ++
  kártyák könyvtárHelyek ++ "\n" ++
  "<h2>Irodalmi horgonyok (ellenőrizve) · 已验证文献锚点</h2>\n" ++
  "<div class='doboz'><ul>" ++
  "<li>HaPPY holografikus kód: Pastawski–Yoshida–Harlow–Preskill, <a href='https://arxiv.org/abs/1503.06237'>arXiv:1503.06237</a> (2015) — ✓ ellenőrizve 2026-09-04; a HolografikusKod49 modul forrása</li>" ++
  "<li>DisCoCat fordítás-funktor: Bradley–Lewis–Master–Theilman, <a href='https://arxiv.org/abs/1811.11041'>arXiv:1811.11041</a> — ✓ ellenőrizve; pontos cím: »Translating and Evolving: Towards a Model of Language Change in DisCoCat«</li>" ++
  "<li>DisCoCat alap: Coecke–Sadrzadeh–Clark, arXiv:1003.4394 · Abramsky–Coecke: quant-ph/0402130 (a DiracNyelv horgonyai)</li>" ++
  "<li>Steane [[7,1,3]]: A. Steane, Proc. R. Soc. A 452 (1996) · Conway–Sloane SPLAG (Construction A: [7,4,3] → E8)</li>" ++
  "</ul></div>\n" ++
  "<h2>Teszt- és csapdaállapot · 测试与陷阱状态</h2>\n" ++
  "<div class='doboz'>Utolsó commit állapota: <b>164/164 integrációs Show-teszt + 50 Refl-szint zöld</b> " ++
  "(<code>osveny_index/Teszt.idr</code>). A csapda-katalógus (kisbetűs-név, let-lánc, cong-fej, %hide, #24b: %hide az " ++
  "import-lista VÉGÉRE, …) a <code>osveny_index/tanulsagok/OLVASD.md</code> futtatható archívuma; " ++
  "mechanikus őrző: <code>ellenorzes.sh</code>.</div>\n" ++
  "<footer>Szima · GitHub: <a href='https://github.com/jhegedus42/Szima'>jhegedus42/Szima</a> · " ++
  "generálva: <code>idris2 --exec main ProjektTérkép.idr</code> · gráf-forrás: <code>TudásGráf_v1.idr</code> (" ++
  "17 csomópont: 1 cél + 8 fogalomcsalád + 8 könyvtár-hely)<br>" ++
  "★ NEGYNYELVŰ: magyar + 中文 + Deutsch + עברית ★ — magyarázat: a wiki-lapok a válasz-sablon szerint négynyelvűek.</footer>\n" ++
  "</body>\n</html>\n"

||| Main — vékony IO-burkoló: a HTML a stdoutra.
main : IO ()
main = putStr htmlKiadás
