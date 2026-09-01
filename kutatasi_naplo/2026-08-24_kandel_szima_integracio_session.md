# Kutatási napló — Kandel integrálása a Szima projektbe

**Dátum / Date:** 2026-08-24T12:35–12:45 (CEST)
**Téma / Topic:** Kandel "Principles of Neural Science" → Szima projekt, E8 indexelés, magyar fordítás

---

## KÉRDÉS (szó szerint / verbatim)

> "look at Kandel and connect it to Szima project, index it with E8 indexer, translate to hungarian"

> "use sub agents - your context is small"

**Környezeti utasítás (szó szerint):** "kinait felejtsd el, csak magyar es angol" — tehát a válasz nyelve: magyar + angol, kínai nélkül.

---

## VÁLASZ (összefoglaló / summary)

A felhasználó azt kérte, hogy a `/home/joco/EricKandler.pdf` (Eric R. Kandel et al.:
*Principles of Neural Science*, 6. kiadás, 1693 oldal) könyvet kapcsoljam a Szima projekthez,
indexáljam az "E8 indexer" módszerrel, és fordítsam le magyarra. A Szima projekt szabályai
(AGENTS.md Rule 11) szerint a könyvet csak alügynök olvashatja, ezért a feldolgozást
`task` alügynökökre bíztam, hogy a saját kontextusom kicsi maradjon.

**Lépések / Steps:**

1. **Szövegkivonat (mechanikus):** `pdftotext` a teljes PDF-ből →
   `trail_index/books/kandel_principles_of_neural_science.txt` (10,3 MB). A nyers szöveg
   lap-tartományokra darabolva 15 chunkra (`kandel_chunk_01..15.txt`, ~120 oldalanként).

2. **15 alügynök párhuzamosan:** minden alügynök egy chunkból két fájlt készített:
   - `kandel_extracted_chunk_NN.md` — ConceptNotes (YAML séma a book_processor.md szerint:
     id, source, concept, type, summary, related, causes, caused_by, resolves, tags).
     Összesen **115 ConceptNote** a teljes könyvből.
   - `kandel_magyar_chunk_NN.txt` — a chunk elbeszélő prózájának **magyar fordítása**
     (angol szakkifejezés-zárójellel). Megjegyzés: a fordítás mintaszerűen a fejezet/fejezetszakasz
     elejét öleli fel, és megjelöli a megállási pontot — a teljes 1693 oldal szószerinti lefordítása
     még nem kész, az alügynökök a legjelentősebb részt fordították le.

3. **Mester-E8 index (alügynök):** `kandel_e8_index.md` — a 115 ConceptNote kategorizálva
   (12 kategória), benne az "E8 indexer" szakasz a címkézett jegyzetekkel és fogalmi hidakkal.
   Címke-statisztika: **neocortex = 107, kategoriaelmelet = 11, E8 = 0, összesen = 115**.
   Az E8 = 0 őszinte eredmény: az idegtudományban nincs közvetlen E8 gyök-rács párhuzam,
   a hidakat csak valós fogalmi kapcsolatnál tettük fel.

4. **Szima-kapcsolat (alügynök):** `kandel_szima_kapcsolat.md` — leírja, hogy a könyv a Szima
   neokortex-cél biológiai alapja, felsorolja az 5 releváns Idris modult (E8E8Algebra,
   KategoriaElmelet, FazisAlgebra, Steane713, OktonionAlgebra), és hivatkozik a forrás PDF-re
   (`/home/joco/EricKandler.pdf`) és a 15+15 chunk fájlra.

5. **Globális kutatási térkép:** korábban a `PDF_TERKEP.md` Neuro/kognitív szakaszába bejegyeztem
   a Kandelt (186 PDF összesen).

6. **Nyers szövegek áthelyezve:** `kandel_chunk_*.txt`, a teljes szöveg és a segédfájlok a
   gitignore-olt `trail_index/build/` mappába kerültek (nem commitolódnak, de megőrződnek).

**Létrejött fájlok / Files created (trail_index/books/):**
- `kandel_extracted_chunk_01.md` … `kandel_extracted_chunk_15.md` (115 ConceptNote)
- `kandel_magyar_chunk_01.txt` … `kandel_magyar_chunk_15.txt` (magyar fordítás, mintás)
- `kandel_e8_index.md` (mester-E8 index)
- `kandel_szima_kapcsolat.md` (Szima-kapcsolat)

**Nyitott kérdés / Open question:** A magyar fordítás még nem fedi le a teljes könyvet
(szavas próza helyett mintás, fejezetenkénti részfordítás). Ha a felhasználó a teljes
szöveges lefordítást kéri, további alügynök-batch indítható a megállási pontoktól folytatva.

---

## HASZNÁLT ESZKÖZÖK / Tools used
- `pdftotext` (poppler) — szövegkivonat
- `task` (15+1 alügynök) — kivonat, fordítás, index összeállítás
- `git` — Szima repo snapshot commit
