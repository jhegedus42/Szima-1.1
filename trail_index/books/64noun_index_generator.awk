# =====================================================================
# 64-Noun Stabilizer Code — szerkezeti index generátor (LaTeX → Markdown)
# Minta: kandel_index_generator.awk (azonos gondolatmenet, LaTeX-jelölőkre igazítva)
# Bemenet:  source/deepseekPage/paper/chapters/ch1-3.tex … ch16-18.tex
# Kimenet:  trail_index/books/64noun_index.md  (Markdown-táblázat)
# Használat:
#   awk -v datum=$(date +%F) -f 64noun_index_generator.awk \
#       ch1-3.tex ch4-6.tex ch7-9.tex ch10-12.tex ch13-15-app.tex ch16-18.tex \
#       > 64noun_index.md
# ---------------------------------------------------------------------
# Indexelt szerkezeti elemek:
#   % CHAPTER jelölők, \section, \subsection (a *-os változat is),
#   \begin{theorem}, \begin{definition}, \begin{lemma},
#   \begin{corollary}, \begin{proposition}, \begin{table},
#   \begin{equation} (CSAK ha van \label{...} a környezeten belül),
#   \begin{insightbox} (a könyvben summarybox formában él), \begin{proof}.
# A «Címke» oszlop a \label{...} tartalma (thm, def, eq, tab, sec, lem,
# cor, prop előtagok) — így az index grep-pel szűrhető.
# Megjegyzés: a könyvben NINCS insightbox környezet; a szerepét a
# summarybox tölti be (3 db), ezért mindkettőt indexeljük.
# =====================================================================

BEGIN {
  if (datum == "") datum = "2026-09-04"

  # nyomon követett környezettípusok → magyar név + elvárt címke-előtag
  kovTip["theorem"]     = "tétel";            kovElv["theorem"]     = "thm:"
  kovTip["definition"]  = "definíció";        kovElv["definition"]  = "def:"
  kovTip["lemma"]       = "lemma";            kovElv["lemma"]       = "lem:"
  kovTip["corollary"]   = "következmény";     kovElv["corollary"]   = "cor:"
  kovTip["proposition"] = "propozíció";       kovElv["proposition"] = "prop:"
  kovTip["table"]       = "táblázat";         kovElv["table"]       = "tab:"
  kovTip["equation"]    = "egyenlet";         kovElv["equation"]    = "BÁRMI"
  kovTip["proof"]       = "bizonyítás";       kovElv["proof"]       = ""
  kovTip["insightbox"]  = "insight-doboz";    kovElv["insightbox"]  = ""
  kovTip["summarybox"]  = "összefoglaló-doboz"; kovElv["summarybox"] = ""

  sorDb = 0        # kibocsátott táblázatsorok száma
  verem = 0        # nyitott környezetek vermének csúcsa
  utolsoSzakaszSor = 0
  utolsoSzakaszVonal = -100
}

# fájlváltás: a parancssori sorrend sorszáma + rövid fájlnév
FNR == 1 {
  fajlSorszam++
  darabDb = split(FILENAME, darabok, "/")
  fajlNev[fajlSorszam] = darabok[darabDb]
}

# ----- segédfüggvények ------------------------------------------------

# a nyitó zárójelhez tartozó (mélységszámlálóos) tartalom kinyerése
function zarolTartalom(sz, nyitoPos,    m, mely, i, c) {
  mely = 0
  for (i = nyitoPos; i <= length(sz); i++) {
    c = substr(sz, i, 1)
    if (c == "{") { mely++; if (mely == 1) m = i }
    else if (c == "}") {
      mely--
      if (mely == 0) return substr(sz, m + 1, i - m - 1)
    }
  }
  return substr(sz, nyitoPos + 1)
}

# LaTeX-hulladék tisztítás a Tartalom oszlophoz
function tisztit(sz) {
  gsub(/\\(label|ref|eqref|cref|Cref|cite|citep|citet)\{[^}]*\}/, "", sz)
  gsub(/~/, " ", sz)
  gsub(/\\[A-Za-z]+/, "", sz)   # parancsnevek (a kapcsos tartalom megmarad)
  gsub(/\\/, "", sz)
  gsub(/[{}]/, "", sz)
  gsub(/[\[\]]/, "", sz)
  gsub(/\$/, "", sz)
  gsub(/%/, "", sz)
  gsub(/\|/, "\\/", sz)          # markdown-tábla védelme
  gsub(/[ \t]+/, " ", sz)
  sub(/^ /, "", sz); sub(/ $/, "", sz)
  return sz
}

function vagas80(sz) {
  if (length(sz) > 80) sz = substr(sz, 1, 80) "…"
  return sz
}

# új táblázatsor felvétele; visszatér a sor sorszámával
function ujSor(tipus, cimke, tartalom) {
  sorDb++
  rTipus[sorDb]  = tipus
  rCimke[sorDb]  = cimke
  rTart[sorDb]   = tartalom
  rFajl[sorDb]   = fajlSorszam
  rVonal[sorDb]  = FNR
  return sorDb
}

# nyitott környezet felgörgetése a verműr
function veremNyit(tipus, cim) {
  verem++
  vTip[verem]   = tipus
  vCim[verem]   = cim
  vFajl[verem]  = fajlSorszam
  vVonal[verem] = FNR
  vLc1[verem]   = ""   # első bárminemű címke
  vLcm[verem]   = ""   # első előtag-illeszkedő címke
  vCap[verem]   = ""   # táblázatfelirat
  vTart[verem]  = ""   # nyers tartalom-puffer
  vAktiv[verem] = 1
}

# legbelső nyitott környezet sorszáma (vagy 0)
function belsoNyitott(    i) {
  for (i = verem; i >= 1; i--) if (vAktiv[i]) return i
  return 0
}

# ----- fősorfeldolgozás ----------------------------------------------

{
  sor = $0

  # (1) % CHAPTER jelölők (pl. "% CHAPTER 1: …", "%% CHAPTER 4: …",
  #     "%  CHAPTERS 16--18: …")
  if (sor ~ /^%+[ \t]*CHAPTER/) {
    fejlec = sor
    sub(/^%+[ \t]*/, "", fejlec)
    ujSor("fejezet", "", vagas80(tisztit(fejlec)))
    next
  }

  # (2) \subsection és \section (a *-os változat is) — sor eleji elhelyezés
  if (sor ~ /^[ \t]*\\subsection/) {
    cimSz = zarolTartalom(sor, index(sor, "{"))
    utolsoSzakaszSor = ujSor("alszakasz", "", vagas80(tisztit(cimSz)))
    utolsoSzakaszVonal = FNR
    next
  }
  if (sor ~ /^[ \t]*\\section/) {
    cimSz = zarolTartalom(sor, index(sor, "{"))
    utolsoSzakaszSor = ujSor("szakasz", "", vagas80(tisztit(cimSz)))
    utolsoSzakaszVonal = FNR
    next
  }

  # (3) tartalom-puffer feltöltése a legbelső nyitott környezethez
  #     (a \begin{…} / \end{…} tokenek argumentumát előtte kiszedjük,
  #      hogy a környezetnév ne szivárogjon be a Tartalom oszlopba)
  bi = belsoNyitott()
  if (bi > 0 && length(vTart[bi]) < 200 && sor !~ /^[ \t]*$/ ) {
    pufferSor = sor
    gsub(/^[ \t]*%.*/, "", pufferSor)
    gsub(/\\(begin|end)\{[^}]*\}/, " ", pufferSor)
    gsub(/\\(label|caption)\{[^}]*\}/, " ", pufferSor)
    if (pufferSor !~ /^[ \t]*$/) vTart[bi] = vTart[bi] " " pufferSor
  }

  # (4) token-szkenner: \begin{, \end{, \label{, \caption{ — soron belül sorrendben
  poz = 1
  while (poz <= length(sor)) {
    rs = substr(sor, poz)
    pb = index(rs, "\\begin{")
    pe = index(rs, "\\end{")
    pl = index(rs, "\\label{")
    pc = index(rs, "\\caption{")
    legk = 0; mi = 0
    if (pb > 0) { legk = pb; mi = 1 }
    if (pe > 0 && (legk == 0 || pe < legk)) { legk = pe; mi = 2 }
    if (pl > 0 && (legk == 0 || pl < legk)) { legk = pl; mi = 3 }
    if (pc > 0 && (legk == 0 || pc < legk)) { legk = pc; mi = 4 }
    if (mi == 0) break
    ap = poz + legk - 1   # token abszolút kezdőpozíciója

    if (mi == 1) {                                    # ---- \begin{típus}
      tp = substr(sor, ap + 7)
      tp = substr(tp, 1, index(tp, "}") - 1)
      hossz = 7 + length(tp) + 1                      # "\begin{típus}" hossza
      cim = ""
      if (substr(sor, ap + hossz, 1) == "[") {
        zaroIdx = index(substr(sor, ap + hossz), "]")
        if (zaroIdx > 0) {
          cim = substr(sor, ap + hossz + 1, zaroIdx - 2)
          # elhelyezési_specifikáció ([h], [ht], …) NEM cím
          if (tp == "table" && cim ~ /^[htbpHB!]+$/) cim = ""
        }
      }
      if (tp in kovTip) {
        veremNyit(tp, cim)
        poz = ap + hossz
        if (cim != "") poz = ap + hossz + 1 + length(cim) + 1
        continue
      }
      poz = ap + hossz
      continue
    }

    if (mi == 2) {                                    # ---- \end{típus}
      tp = substr(sor, ap + 5)
      tp = substr(tp, 1, index(tp, "}") - 1)
      hossz = 5 + length(tp) + 1                      # "\end{típus}" hossza
      # legfelső illeszkedő nyitott bejegyzés keresése
      talalt = 0
      for (i = verem; i >= 1; i--) if (vAktiv[i] && vTip[i] == tp) { talalt = i; break }
      if (talalt > 0) {
        vAktiv[talalt] = 0
        while (verem > 0 && !vAktiv[verem]) verem--
        elv = kovElv[tp]
        cimke = ""
        if (elv == "BÁRMI")      cimke = (vLcm[talalt] != "" ? vLcm[talalt] : vLc1[talalt])
        else if (elv != "")      cimke = vLcm[talalt]
        # egyenletet CSAK címkével indexelünk (a feladat előírása)
        if (!(tp == "equation" && cimke == "")) {
          tart = vCim[talalt]
          if (tp == "table" && vCap[talalt] != "") tart = vCap[talalt]
          if (tart == "") tart = vTart[talalt]
          if (tp == "proof") sub(/^[Pp]roof: /, "", tart)
          ujSor(kovTip[tp], cimke, vagas80(tisztit(tart)))
        }
      }
      poz = ap + hossz
      continue
    }

    if (mi == 3) {                                    # ---- \label{…}
      lc = zarolTartalom(sor, ap + 6)                 # "{" pozíciója: ap+6
      hossz = 7 + length(lc) + 1
      bi = belsoNyitott()
      if (bi > 0) {
        if (vLc1[bi] == "") vLc1[bi] = lc
        elv = kovElv[vTip[bi]]
        if (elv != "" && elv != "BÁRMI" && vLcm[bi] == "" && substr(lc, 1, length(elv)) == elv) vLcm[bi] = lc
      } else if (substr(lc, 1, 4) == "sec:" && utolsoSzakaszSor > 0 && rCimke[utolsoSzakaszSor] == "" && FNR - utolsoSzakaszVonal <= 3) {
        rCimke[utolsoSzakaszSor] = lc
      }
      poz = ap + hossz
      continue
    }

    if (mi == 4) {                                    # ---- \caption{…}
      cp = zarolTartalom(sor, ap + 8)                 # "{" pozíciója: ap+8
      hossz = 9 + length(cp) + 1
      bi = belsoNyitott()
      if (bi > 0 && vTip[bi] == "table" && vCap[bi] == "") vCap[bi] = cp
      poz = ap + hossz
      continue
    }
  }
}

# ----- kimenet ---------------------------------------------------------

END {
  # stabil beszúró rendezés (fájl-sorszám, sor-szám) szerint
  for (i = 2; i <= sorDb; i++) {
    j = i
    while (j > 1 && rFajl[j] * 100000 + rVonal[j] < rFajl[j - 1] * 100000 + rVonal[j - 1]) {
      # mezőcsere
      t1 = rTipus[j]; rTipus[j] = rTipus[j - 1]; rTipus[j - 1] = t1
      t2 = rCimke[j]; rCimke[j] = rCimke[j - 1]; rCimke[j - 1] = t2
      t3 = rTart[j];  rTart[j]  = rTart[j - 1];  rTart[j - 1]  = t3
      t4 = rFajl[j];  rFajl[j]  = rFajl[j - 1];  rFajl[j - 1]  = t4
      t5 = rVonal[j]; rVonal[j] = rVonal[j - 1]; rVonal[j - 1] = t5
      j--
    }
  }

  # ---- FEJLÉC (négy nyelv, §22a sablon) ----
  print "# 64-Noun Stabilizer Code — szerkezeti index / 结构索引"
  print ""
  print "**Készült:** " datum "  **|**  **Generátor:** `64noun_index_generator.awk` (awk, a kandel_index_generator.awk mintájára)  **|**  **Forrás:** `source/deepseekPage/paper/chapters/` (ch1-3 … ch16-18, 11 120 sor)"
  print ""
  print "**Magyar:** A «The 64-Noun Stabilizer Code» könyv hat LaTeX-fejezetfájljának"
  print "teljes szerkezeti indexe: fejezet-jelölők, szakaszok, alszakaszok, tételek,"
  print "definíciók, lemmák, következmények, propozíciók, táblázatok, címkés egyenletek,"
  print "összefoglaló-dobozok és bizonyítások — egy Markdown-táblázatban, fájlonként és"
  print "sorszámmonként rendezve. A «Címke» oszlop a `\\label{...}` tartalmát hordozza,"
  print "ezért az index grep-pel szűrhető az előtagok szerint (thm, def, eq, tab, sec,"
  print "lem, cor, prop — kettőponttal a sorokban)."
  print ""
  print "**中文：** 本书（《64-名词稳定子码》）六个 LaTeX 章节文件的结构索引：章节标记、"
  print "小节、定理、定义、引理、推论、命题、表格、带标签的公式、总结框与证明，"
  print "按文件与行号排序，可用 grep 按标签前缀过滤。"
  print ""
  print "**Deutsch:** Struktureller Index der sechs LaTeX-Kapiteldateien des Buches"
  print "«The 64-Noun Stabilizer Code»: Kapitelmarkierungen, Abschnitte, Theoreme,"
  print "Definitionen, Lemmata, Korollare, Propositionen, Tabellen, bezeichnete"
  print "Gleichungen, Zusammenfassungsboxen und Beweise — per grep nach Präfix filterbar."
  print ""
  print "**עברית:** מפתח מבני של ששת קובצי הפרקים ב-LaTeX של הספר: סימוני פרקים, סעיפים,"
  print "משפטים, הגדרות, למות, מסקנות, טבלאות, משוואות מתויגות והוכחות — ניתן לסינון ב-grep."
  print ""
  print "Példa szűrés: `grep 'eq:' 64noun_index.md` → az összes címkés egyenlet."
  print ""
  print "| Fájl | Sor | Típus | Címke | Tartalom |"
  print "|------|----:|-------|-------|----------|"

  # ---- TÁBLÁZAT ----
  for (i = 1; i <= sorDb; i++) {
    print "| " fajlNev[rFajl[i]] " | " rVonal[i] " | " rTipus[i] " | " rCimke[i] " | " rTart[i] " |"
  }

  # ---- STATISZTIKA (a kandel-minta (c) szakasza) ----
  print ""
  print "---"
  print ""
  print "## Statisztika / 统计"
  print ""
  print "| Típus | Elemek száma |"
  print "|-------|-------------:|"
  rendezes[1] = "fejezet";         rendezes[2] = "szakasz"
  rendezes[3] = "alszakasz";       rendezes[4] = "tétel"
  rendezes[5] = "definíció";       rendezes[6] = "lemma"
  rendezes[7] = "következmény";    rendezes[8] = "propozíció"
  rendezes[9] = "táblázat";        rendezes[10] = "egyenlet"
  rendezes[11] = "insight-doboz";  rendezes[12] = "összefoglaló-doboz"
  rendezes[13] = "bizonyítás"
  for (k = 1; k <= 13; k++) {
    szamlalo = 0
    for (i = 1; i <= sorDb; i++) if (rTipus[i] == rendezes[k]) szamlalo++
    if (szamlalo > 0) print "| " rendezes[k] " | " szamlalo " |"
  }
  print "| **Összesen / Total** | **" sorDb "** |"
  print ""
  print "*Megjegyzés: a könyvben `insightbox` környezet nincs — a szerepét a `summarybox`"
  print "tölti be (3 db), ezért a generátor mindkettőt kezeli. Az egyenletek közül csak a"
  print "címkés (\\label{eq:…}) került az indexbe, a feladat előírása szerint.*"
}
