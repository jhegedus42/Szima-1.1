#!/bin/bash
# ═══════════════════════════════════════════════════════════════
# ELLENŐRZÉS — mechanikus szabály-kikényszerítés az Idris kódokra
# ═══════════════════════════════════════════════════════════════
# Ezek empirikusan felderített Idris 2 (0.8.0) csapdák.
# Exit kód: 0 = tiszta, 1 = szabályszegés.
# FIGYELEM: az ||| doc-komment önmagában NEM hibás (a meglévő
# modulokban működik) — csak a hibásan tört folyósor az, de azt
# a fordító úgyis elkapja. Ezért itt NEM tiltjuk.
# ═══════════════════════════════════════════════════════════════

GYOKER="$(cd "$(dirname "$0")" && pwd)"
HIBAK_SZAMA=0

echo "─── ELLENŐRZÉS: Idris szabályok ───"

# 1. SZABÁLY: rövidítés-alias definíciók TILTOTTAK (MH, MS, DG, ...)
# A kódnak önmagában olvashatónak kell lennie.
RoviditesTalalatok=$(grep -rnE '^(MH|MS|DG|PH|KH|TR|VS|MP|FN|SZ) (=|:)' "$GYOKER"/osveny_index/*.idr 2>/dev/null | head -20)
RoviditesDb=$(grep -rnE '^(MH|MS|DG|PH|KH|TR|VS|MP|FN|SZ) (=|:)' "$GYOKER"/osveny_index/*.idr 2>/dev/null | wc -l | tr -d ' ')
if [ -n "$RoviditesTalalatok" ]; then
  echo "$RoviditesTalalatok" | while IFS= read -r sor; do
    fajl="${sor%%:*}"; fajl="${fajl##*/}"
    tobbi="${sor#*:}"; sorszam="${tobbi%%:*}"
    echo "HIBA [rövidítés-alias tiltott] $fajl:$sorszam — teljes név kell: MaganhangzoHang, nem MH"
  done
  HIBAK_SZAMA=$((HIBAK_SZAMA + RoviditesDb))
fi

# 2. SZABÁLY: kisbetűs konstansnév bizonyítástípusban (0.8.0 csapda)
# Ha a deklaráció típusában csupasz kisbetűs definiált név áll az =
# előtt, az elaborátor implicit argumentumnak köti → Refl elakad.
# Minta: "név : kisbetűsszó =" (az = előtt egyedüli token).
KisbetusTalalatok=$(grep -rnE '^[[:space:]]*[a-zA-ZáéíóöőúüűÁÉÍÓÖŐÚÜŰ][a-zA-Z0-9áéíóöőúüűÁÉÍÓÖŐÚÜŰ]*[[:space:]]*:[[:space:]]*[a-záéíóöőúüű][a-zA-Z0-9áéíóöőúüű]*[[:space:]]*=' "$GYOKER"/osveny_index/*.idr 2>/dev/null | grep -v '^[^:]*:[0-9]*:.*(' | head -20)
KisbetusDb=$(grep -rnE '^[[:space:]]*[a-zA-ZáéíóöőúüűÁÉÍÓÖŐÚÜŰ][a-zA-Z0-9áéíóöőúüűÁÉÍÓÖŐÚÜŰ]*[[:space:]]*:[[:space:]]*[a-záéíóöőúüű][a-zA-Z0-9áéíóöőúüű]*[[:space:]]*=' "$GYOKER"/osveny_index/*.idr 2>/dev/null | grep -v '^[^:]*:[0-9]*:.*(' | wc -l | tr -d ' ')
if [ -n "$KisbetusTalalatok" ]; then
  echo "$KisbetusTalalatok" | while IFS= read -r sor; do
    fajl="${sor%%:*}"; fajl="${fajl##*/}"
    tobbi="${sor#*:}"; sorszam="${tobbi%%:*}"
    echo "HIBA [kisbetűs konstans bizonyítástípusban] $fajl:$sorszam — a típusban álló név legyen nagybetűs, különben implicit kötés elakadja a Refl-t"
  done
  HIBAK_SZAMA=$((HIBAK_SZAMA + KisbetusDb))
fi

# 3. SZABÁLY: /tmp TILOS (AGENTS.md 1a) — figyelmeztetes friss .idr/.py fajlokra
# a /tmp-ben (az utobbi 60 percben): jelzes, hogy archivalni kell a tanulsagok/-ba.
if command -v find >/dev/null; then
  FrissTmpFajlok=$(find /private/tmp -maxdepth 1 -name '*.idr' -mmin -60 2>/dev/null | head -5)
  if [ -n "$FrissTmpFajlok" ]; then
    echo "FIGYELMEZTETÉS [/tmp-ben friss Idris-fájl] — AGENTS.md 1a TILOS:"
    echo "$FrissTmpFajlok" | sed 's/^/  /'
    echo "  → archiváld őket: cp /tmp/<név>.idr osveny_index/tanulsagok/"
  fi
fi

# 4. SZABÁLY: MINDEN számítás Idrisben (AGENTS.md 3) — Python CSAK
# web/API-hoz (SZABALY0-WEB-API) vagy ha Idrisben lehetetlen
# (SZABALY0-IDRISBEN-LEHETETLEN, indoklással). Float-számítás is Idrisben
# (Double, l. Komplex.idr); teljesítményhez codegen vagy C/Rust FFI.
MarkerNelkuliPy=$(find "$GYOKER" -name '*.py' -not -path '*/tanulsagok/*' -not -path '*/source/*' -not -path '*/horgony/szerver/*' 2>/dev/null | while IFS= read -r f; do
  grep -q 'SZABALY0-WEB-API\|SZABALY0-IDRISBEN-LEHETETLEN' "$f" || echo "$f"
done)
if [ -n "$MarkerNelkuliPy" ]; then
  echo "FIGYELMEZTETÉS [marker nélküli .py] — AGENTS.md 3: MINDEN számítás Idrisben:"
  echo "$MarkerNelkuliPy" | sed 's/^/  /'
  echo "  → Írd át Idrisbe (Double is megy: Komplex.idr minta); ha web/API:"
  echo "    '# SZABALY0-WEB-API'; ha valóban lehetetlen: '# SZABALY0-IDRISBEN-LEHETETLEN' + indok"
fi

if [ "$HIBAK_SZAMA" -eq 0 ]; then
  echo "─── TISZTA: minden mechanikus szabály rendben ───"
else
  echo "─── SZABÁLYSZEGÉS: $HIBAK_SZAMA db — javítsd, mielőtt commitolsz ───"
fi
exit $((HIBAK_SZAMA > 0 ? 1 : 0))
