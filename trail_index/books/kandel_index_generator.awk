# Kandel → Szima mester index generátor (azonosító-gyűjtő)
# Bemenet: /tmp/kandel_notes2.txt (id, FILE, CONCEPT, TYPE, TAGS, SUM blokkok)
#          /home/joco/dev/lab/Szima/trail_index/books/kandel_catmap_analysis.tsv
# Kimenet: kandel_e8_index.md

BEGIN {
  FS="\n"; RS=""

  # Kategóriák sorrendje és magyar/angol címkéje
  catorder[1]="MEM"; catorder[2]="SYN"; catorder[3]="NEU"; catorder[4]="PLA"
  catorder[5]="ARC"; catorder[6]="SEN"; catorder[7]="MOT"; catorder[8]="MEMO"
  catorder[9]="LAN"; catorder[10]="DEV"; catorder[11]="DEC"; catorder[12]="DIS"

  catname["MEM"]="Membrán biofizika (Membrane biophysics)"
  catname["SYN"]="Szinaptikus átvitel (Synaptic transmission)"
  catname["NEU"]="Neuromoduláció és másodlagos hírvivők (Neuromodulation & second messengers)"
  catname["PLA"]="Plaszticitás és tanulás (Plasticity & learning)"
  catname["ARC"]="Neurális jelzés és architektúra (Neuronal signaling & architecture)"
  catname["SEN"]="Érzékelési kódolás (Sensory coding)"
  catname["MOT"]="Motoros irányítás (Motor control)"
  catname["MEMO"]="Memória (Memory)"
  catname["LAN"]="Nyelv és érzelem (Language & emotion)"
  catname["DEV"]="Fejlődés (Development)"
  catname["DEC"]="Döntés és tudatosság (Decision & consciousness)"
  catname["DIS"]="Idégrendszeri zavarok (Disorders)"

  # E8 indexer sablon-hidak kategóriánként (magyar, 1 mondat, Szima modul hivatkozással)
  bridge["MEM"]="Szima-híd: a csatorna szelektív áteresztése az E8×E8 algebrai sűrűség-vektoraiként (bal E8 = tér, jobb E8 = szín) modellezhető; a membránfeszültség a FazisAlgebra „fazis" dimenziója, a mérés pedig a Steane713 [[7,1,3]] kód egy bitje."
  bridge["SYN"]="Szima-híd: a kvantált felszabadulás a [[7,1,3]] Steane-kód egy bitjének felel meg; a kémiai szinapszis felerősítése a KategoriaElmelet morfizmus-kompozíciójának (összetett függvény) és a szorzásnak (product) megfelelője."
  bridge["NEU"]="Szima-híd: a moduláció a FazisAlgebra „fazis" komponensének átállítása, amely a három kubit (saját/másik/fázis) kapcsolatirányát módosítja; a több modulátor konvergenciája a KategoriaElmelet kolimit (colimit) fogalma mint a bejövő nyílak univerzális összegzése."
  bridge["PLA"]="Szima-híd: a Hebb-szabály a KategoriaElmelet struktúraképző funktora — a gyakran együtt aktivált csomópontok éle megerősödik; az LTP a Steane713 kód szavának tartós, hibajavított újrakódolása."
  bridge["ARC"]="Szima-híd: az universális négykomponensű jelzési séma a KategoriaElmelet funktor-kompozíciója (bemenet→trigger→vezető→kimenet); az áramköri motivikumok az E8 gyökrendszerének ismétlődő, egyszerű mintázatai a nagyobb hálózatban."
  bridge["SEN"]="Szima-híd: a kérgi reprezentáció a KategoriaElmelet funktora (functor) az érzékelő térből a fogalomtérbe; az oszlopos térkép a termék (product), a duális frekvencia-koordináta-rendszerek az E8 gyöktér koordinátáinak felelnek meg."
  bridge["MOT"]="Szima-híd: a centrális mintageneráló hálózat (CPG) és az efferens másolat a FazisAlgebra időbeli fázis-vezérlése; a prediktív modell a KategoriaElmelet természetes transzformációja (natural transformation) az elvárt és észlelt állapot között."
  bridge["MEMO"]="Szima-híd: a tartós memória a Steane713 [[7,1,3]] kód hibajavított kód-szava (távolság 3 → 1 hiba javítható); a perzisztens aktivitás a KategoriaElmelet kolimitként, lépésről lépésre felhalmozódó állapot."
  bridge["LAN"]="Szima-híd: a szaglás–érzelem áramkör a Cayley–Dickson nyelvi leképezés (magyar = O, oktogonion) és a FazisAlgebra „saját tudat / másik fél" dimenzióinak területe — az érték (value) az affektív fázis."
  bridge["DEV"]="Szima-híd: a fejlődési molekuláris kódok a KategoriaElmelet funktoraiként írják le a sejtidentitást (objektum → típus); az elosztott és moduláris vezérlés az E8×E8 szimmetrikus monoidális kategória szerkezete, robusztusságot adva."
  bridge["DEC"]="Szima-híd: a bizonyíték-felhalmozódás a KategoriaElmelet katamorfizmusa (ana/cata, a monoid-homomorfizmus a log-valószínűségnél); a döntési változó a FazisAlgebra három kubitjának koherenciája, a tudatosság a perzisztens állapot „jelentése" (report)."
  bridge["DIS"]="Szima-híd: a zavar a Steane713 kód 1 hibája (a kód távolsága 3, így 1 hiba javítható) — a Szima-architektúra kvantum-hibajavító (QEC) ciklusa gyógyítja; a farmakológiai moduláció a FazisAlgebra fázis-kiegyenlítése."

  # kategoriaelmelet címkéjű jegyzetek — saját, gazdagabb híd
  custom["kandel_01_nmda"]="Kategoriaelmelet-híd: az NMDA receptor koaktivációja (pre+poszt) és a Mg-blokk eltávolítása egy span/kétoldali feltétel, amely a KategoriaElmelet leképezésében (pullback) egy univerzális objektumot ad — a szinaptikus súly a morfizmus, a Ca-beáramlás a struktúra képződése."
  custom["kandel_01_hebbian"]="Kategoriaelmelet-híd: a Hebb-szabály („együtt tüzelők összekapcsolódnak") a KategoriaElmelet gráf/kategória kompozíciójának élegyesítése: a gyakran együtt aktivált csomópontok közötti él (morfizmus) súlya nő, ez a fogalom-struktúra (ontology) kialakulása."
  custom["kandel_01_synaptic_plasticity"]="Kategoriaelmelet-híd: a „tanulás és memória a plaszticitástól függ" ok-okozat a KategoriaElmelet funktor-kompozíciójaként írható le — a viselkedés végobjektum (terminal) a szinaptikus súly-kategória egy leképezése."
  custom["kandel_01_circuit_motifs"]="Kategoriaelmelet-híd: a feed-forward hierarchia és a visszacsatolás (recurrent) áramköri motivikumok a KategoriaElmelet leképezései (functor) és természetes transzformációi — a hierarchikus feldolgozás egy nagyobb kategória részkategóriája."
  custom["kandel14_convergence"]="Kategoriaelmelet-híd: a több neuromodulátor konvergenciája ugyanarra a neuronra a KategoriaElmelet kolimit (colimit) fogalma — a különböző forrásokból érkező nyilak egy univerzális célobjektumban (a sejt válasza) egyesülnek; a polimorfizmus a funktor-többalakúság."
  custom["KANDEL12-007"]="Kategoriaelmelet-híd: a nemi dimorf viselkedés „moduláris genetikai irányítása" a KategoriaElmelet termékének (product) és a részobjektum-osztályozónak (subobject classifier) megfelelője — a különbség egy leképezés (functor) a tulajdonságtérbe."
  custom["KANDEL12-009"]="Kategoriaelmelet-híd: az elosztott (distributed) irányítás a KategoriaElmelet koproduktum (coproduct) szerkezete — a viselkedést több, egymást fedő áramkör (objektum) együttese adja, robusztusságot (a hiba kolimit-szintű elnyelését) eredményezve."
  custom["KANDEL13-006"]="Kategoriaelmelet-híd: a korlátos bizonyíték-felhalmozódás (drift-diffusion) a KategoriaElmelet katamorfizmusa (ana), ahol a rekurzív összegzés egy monoidon (a bizonyíték-érték) fut; a „megállás" a kolimit elérése."
  custom["KANDEL13-009"]="Kategoriaelmelet-híd: a log-valószínűségi hányados felhalmozódása a szorzás összegzéssé alakítása — ez egy monoid-homomorfizmus (a pozitív valószámok szorzása → az összeadás), a KategoriaElmelet alapművelete."
  custom["KANDEL13-011"]="Kategoriaelmelet-híd: a valószínűségi következtetés ugyanazt a katamorfizmust használja, mint a perceptuális döntés — a Bayes-frissítés a KategoriaElmelet ana/cata (fold) sémája a hiedelem-kategórián."
  custom["KANDEL13-015"]="Kategoriaelmelet-híd: a két anticorrelált felhalmozódás a bal/jobb lehetőségek duális (dual) reprezentációja — a KategoriaElmelet ellentétes kategória (opposite category) és a szimmetria (E8 gyökrendszer inverziója) struktúrája."

  # catmap betöltése
  while ((getline line < "/home/joco/dev/lab/Szima/trail_index/books/kandel_catmap_analysis.tsv") > 0) {
    split(line, a, "\t")
    map[a[1]] = a[2]
  }
  close("/home/joco/dev/lab/Szima/trail_index/books/kandel_catmap_analysis.tsv")
}

{
  # egy rekord = egy jegyzet
  id=""; file=""; conc=""; typ=""; tags=""; sum=""
  for (i=1; i<=NF; i++) {
    if ($i ~ /^### /)        { id   = substr($i, 5) }
    else if ($i ~ /^FILE:/)  { file = substr($i, 7) }
    else if ($i ~ /^CONCEPT:/) { conc = substr($i, 10) }
    else if ($i ~ /^TYPE:/)  { typ  = substr($i, 7) }
    else if ($i ~ /^TAGS:/)  { tags = substr($i, 7) }
    else if ($i ~ /^SUM:/)   { sum  = substr($i, 6) }
  }
  if (id == "") next
  idlist[++n] = id
  concept[id]=conc; type[id]=typ; tag[id]=tags; summ[id]=sum; fil[id]=file
  cat[id] = (id in map) ? map[id] : "ARC"

  # tag számlálás
  if (tags ~ /(^|[^A-Za-z])neocortex([^A-Za-z]|$)/)       cnt_neo++
  if (tags ~ /(^|[^A-Za-z])kategoriaelmelet([^A-Za-z]|$)/) cnt_kat++
  if (tags ~ /(^|[^A-Za-z])E8([^A-Za-z]|$)/)               cnt_e8++
  # E8 indexer: neocortex / kategoriaelmelet / E8
  if (tags ~ /(^|[^A-Za-z])(neocortex|kategoriaelmelet|E8)([^A-Za-z]|$)/) e8list[++m]=id
}

END {
  # ─── FEJLÉC ───────────────────────────────────────────────
  print "# Kandel — Szima Mester Index (E8 Indexer)"
  print ""
  print "**Magyar:** Ez a dokumentum a Kandel: *Principles of Neural Science* (6. kiadás) 15"
  print "kivonat-fájljából (kandel_extracted_chunk_01–15.md) kinyert összes ConceptNote"
  print "aggregált, kategorizált mester indexe a Szima projekt számára. A jegyzetek az"
  print "E8×E8 algebra, a kategóriaelmélet, a FazisAlgebra, a Steane713 és az OktonionAlgebra"
  print "Szima-modulokhoz kapcsolódva képezik a neokortex-szerű mesterséges intelligencia"
  print "biológiai/empírikus alapját."
  print ""
  print "**English:** Master index aggregating every ConceptNote extracted from the 15 Kandel"
  print "chunk files, organized for the Szima project (a neocortex-like AI grounded in category"
  print "theory + the E8 exceptional group). Each note is mapped onto the Szima knowledge"
  print "structure (E8×E8 algebra, category theory, phase algebra, Steane [[7,1,3]], octonions)."
  print ""
  print "**Forrás PDF:** `/home/joco/EricKandler.pdf`  **|**  **Kivonatok:**"
  print "`kandel_extracted_chunk_01..15.md`  **|**  **Magyar chunk-ok:** `kandel_chunk_01..15.txt`"
  print ""
  print "---"
  print ""

  # ─── (a) KATEGÓRIÁK SZERINT ──────────────────────────────
  print "## (a) Fogalmi jegyzetek kategóriák szerint / ConceptNotes by category"
  print ""
  for (c=1; c<=12; c++) {
    code = catorder[c]
    print "### " catname[code]
    print ""
    for (k=1; k<=n; k++) {
      id = idlist[k]
      if (cat[id] != code) continue
      printf "- **%s** — %s — *típus:* %s — *címkék:* %s\n", id, concept[id], type[id], tag[id]
      if (summ[id] != "") printf "  - %s\n", summ[id]
    }
    print ""
  }

  # ─── (b) E8 INDEXER ──────────────────────────────────────
  print "---"
  print ""
  print "## (b) E8 indexer — neocortex / kategoriaelmelet / E8 címkéjű jegyzetek"
  print ""
  print "**Magyar:** Az alábbiak minden olyan jegyzetet felsorolnak, amelyet `neocortex`,"
  print "`kategoriaelmelet` vagy `E8` címkével láttak el. Minden sorhoz 1–2 mondatos"
  print "**fogalmi híd** (conceptual bridge) tartozik a Szima célhoz: egy neokortex-szerű,"
  print "kategóriaelméletre és az E8 kivételes csoportra épülő mesterséges intelligencia."
  print "Megjegyzés: közvetlen `E8` címkével ellátott jegyzet nincs (számláló = 0); az"
  print "E8 híd a `neocortex`/`kategoriaelmelet` jegyzeteken keresztül valósul meg."
  print ""
  print "**English:** Every note tagged `neocortex`, `kategoriaelmelet`, or `E8`, each with a"
  print "1–2 sentence conceptual bridge to the Szima goal (a neocortex-like AI grounded in"
  print "category theory + E8). No note carries the bare `E8` tag, so the E8 bridge is reached"
  print "via the neocortex / category-theory notes."
  print ""
  for (c=1; c<=12; c++) {
    code = catorder[c]
    # van-e ebből a kategóriából E8-listás jegyzet?
    has=0
    for (k=1; k<=m; k++) { if (cat[e8list[k]]==code) { has=1; break } }
    if (!has) continue
    print "### " catname[code]
    print ""
    for (k=1; k<=m; k++) {
      id = e8list[k]
      if (cat[id] != code) continue
      printf "- **%s** — %s\n", id, concept[id]
      if (id in custom) printf "  - *kategoriaelmelet-híd:* %s\n", custom[id]
      else printf "  - *Szima-híd:* %s\n", bridge[code]
    }
    print ""
  }

  # ─── (c) ÖSSZEFOGLALÓ TÁBLÁZAT ───────────────────────────
  print "---"
  print ""
  print "## (c) Címke-statisztika / Tag summary table"
  print ""
  printf "| Címke / Tag | Jegyzetek száma / Notes |\n"
  printf "|-------------|--------------------------:|\n"
  printf "| neocortex   | %d |\n", cnt_neo
  printf "| kategoriaelmelet | %d |\n", cnt_kat
  printf "| E8          | %d |\n", cnt_e8
  printf "| **Összesen / Total** | **%d** |\n", n
  print ""
  print "---"
  print ""
  print "### Jegyzetek kategóriánként / Notes per category"
  print ""
  printf "| Kategória / Category | Szám / Count |\n"
  printf "|-----------------------|-------------:|\n"
  for (c=1; c<=12; c++) {
    code = catorder[c]; cc=0
    for (k=1; k<=n; k++) if (cat[idlist[k]]==code) cc++
    printf "| %s | %d |\n", catname[code], cc
  }
  printf "| **Összesen / Total** | **%d** |\n", n
}
