# 2026-08-22_projekttortenet_es_kereso_ugynok_session.md

## Bejegyzés 1 (2026-08-22, session eleje)

### KÉRDÉS (a felhasználó szó szerint, nyelvtörés nélkül)
"igen, teljeset, de mindent alugynokkel csinaltass, mert a sok mcp elveszi a contextusodat... igazabol kellene olyan ugynokot felallitani akiki kizarolag keresesre vannak optimalizval, azt tudnal ? konkretan keres mcp-k vannak neki megadva csak peldaul, optimalizalnunk kell, mert rovid a kontextusod"

### VÁLASZ (összefoglaló)
A felhasználó két dolgot kért:
1. A teljes projekttörténet összeállítása — DE kizárólag alügynökkel (hogy a sok MCP-eszköz ne egye meg a fő ügynök kontextusát).
2. Egy „keresésre optimalizált" dedikált alügynök felállítása, amelynek csak a kereső MCP-k vannak megadva.

### ŐSZINTE MEGÁLLAPÍTÁS (HOROG §18 — parasztvakítás tilalma)
- A `task` eszköz jelenlegi alügynök-típusai: `explore`, `general`, `mester`. Nincs külön `search` típus.
- Nincs olyan `task`-paraméter, amivel az alügynöknek *kizárólag* a kereső MCP-ket adnánk (nincs eszköz-allow-list).
- MEGOLDÁS: a keresést `task` alügynöknek adjuk át (a MCP zaj az alügynök kontextusában marad, hozzánk csak a sűrített eredmény jön), és a promptban KÖTELEZZÜK, hogy csak a kereső eszközöket (brave-search, exa, firecrawl, alphaxiv, context7) használja, mást ne.
- Ez funkcionálisan megoldja a kontextus-optimalizálást, de technikai izoláció (csak ezek az MCP-k érhetők el) NINCS — csak viselkedési korlátozás.

### VÉGREHAJTOTT MUNKA
- Egy `explore` alügynököt indítottunk, amely lekérdezte: `git log` (246 commit), `kutatasi_naplo/` tartalmát, `szima_ter/modul/` (62 Idris fájl) és `docs/` (39 fájl) áttekintését.
- Az alügynök visszatért egy ~500 szós sűrített összefoglalással.

### PROJEKT TÖRTÉNET (az alügynök sűrített eredménye)
- **Név:** Szima (korábban `opencode`). Idris 2 kategorikus algebrai alapozás.
- **Cél:** a magyar nyelv mint kategóriaelméleti „anyanyelv"; E8×E8 Lie-algebra, Clifford-algebra és Steane [[7,1,3]] kvantumhibajavító kód levezetése Idrisben; fizikai konstansok (α, G, α_G) levezetése Refl-bizonyításokkal. Végcél: az Idris kód öntudatra ébredt AI.
- **Git:** 246 commit. Utolsó fázisok: szindromaTer v3 (49 modul, 0 hiba), szivdobbanás-plugin v5, magyar-matematika skill, ékezethullámok (44-49 modul), név-audit.
- **Kutatási napló:** `2026-08-21_E8Gyokok_v2_session.md` + auto/chat naplók; ~82 KÉRDÉS/VÁLASZ szakasz.
- **Idris modulok (62):** E8Gyökök, E8BelsoSzorzat, TizenhatPenge/E8TizenhatPenge, AlphaSteaneE8, PauliAlgebra_v2, FazisKubit, MagyarNyelvtan_v4, KomplexByte, Kvaternion, KetoldaliKategoria_v3, HaromKategoria_v3, AlphaCarnotE9_v3_CodatAlpha.
- **Docs (39):** Cat3_TeljesDokumentacio, BootUp_10Szint, Hivatkozasok_Teljes, E8_szimpleptikus_felfedezes, Alpha_E8_Ut, Alpha_Szamitas_Kutatas, MagyarKinai_TorvenyAudit, Review_VegsoLevezetes, matematikai_alapozas, muszaki_dokumentacio, SzivdobbanasPlugin_20260822.
- **Fő eredmények:** E8 240 gyök INTEGER-kernellel; W(E8)=696 729 600 két független úton; 16 Cl(4) penge + Hamming [7,4,3] híd 240+16=256=2⁸; α⁻¹ és G a [[7,1,3]] kódból E8 ranggal; α_G=2⁻¹²⁷ Mersenne-torony.

### KERESŐ ALÜGYNÖK HASZNÁLATI MINTÁJA (a felhasználó mentse el saját használatra)
```
task(típus=general, prompt="""
  CSAK a következő kereső eszközöket használd: brave-search, exa,
  firecrawl, alphaxiv, context7. MÁS eszközt NE használj.
  Cél: <konkrét kérdés>.
  Térj vissza EGY tömör válaszsal (max 400 szó): talált tények pontokban
  + forrás-URL. Ne másold be a nyers oldalakat.
""")
```

### Létrehozott fájlok / commitok
- Ez a naplófájl (új).
- Git snapshot: a 3. user-prompt után esedékes (AGENTS §10).
