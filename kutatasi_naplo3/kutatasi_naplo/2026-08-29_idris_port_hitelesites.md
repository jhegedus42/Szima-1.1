# Kutatási napló — 2026-08-29

## Mester session: Python fizikai konstansok → Idris2 port + független hitelesítés

### A felhasználó kérdései (szó szerint)

1. „csekkold le py kodot"
2. „igen" (megerősítés a csekkolásra)
3. „ird at hasskell-be" — majd „igen, minden idrisz-ben, ha lehet..."
4. „minden kulso konstants le kell ellenorizni fuggetlen forrasbol, idrisszel, csak ugy bizhat meg a felhasznalo abban, hogy a konstansok nem haluk"
5. „folytassa Mester, legyen kedves"

### A munka fázisai

#### I. Python csekkolás
- Fájl: `all_constants_exact.py` (534 sor, 21 fizikai konstans)
- `py_compile`: OK (szintaktikailag tiszta)
- Futtatás: OK (nincs kivétel, teljes output)
- Linter: nincs telepítve lokálisan (ruff/pyright/mypy hiányzik)
- Talált anomáliák (6, nem crash-ek):
  1. `vacuum_bits` önellentmondás: kód értéke ~0.00 bit, komment/print szerint „≈4.3 bit"
  2. „0% hiba" triviális: 19/21 konstansnál `derived = codata` (ugyanaz scipy érték), tehát hiba definíció szerint 0
  3. `undecium (11/8)` → 0.000000 a kimenetben (tet=0 az else ágban)
  4. Felesleges import: `TypeVar`, `T` definiálva, nem használva
  5. `FW[420] = A * B * C * D * A` (működik, de `A**2 * B * C * D` olvashatóbb)
  6. `error_is_zero: True` mindenhol (értelmetlen flag)

#### II. Idris2 port (`MindenKonstans.idr`)
- A felhasználó kifejezetten Idris-t kért (nem Haskell): „igen, minden idrisz-ben, ha lehet..."
- Új fájl (hozzáadás, nem módosítás — a `all_constants_exact.py` változatlan)
- Ékezetes magyar azonosítók: `horgony, szél, tükör, part, kapu, pithagorasziKomma, fenySebesseg` stb.
- Y kombinator: `Y f = f (Y f)` (partial default, mert nem total)
- Fordítási hibák és javítások:
  - `Data.Strings` → `Data.String` (egyes szám)
  - `mapM_` → `traverse_` (Idris2 Prelude)
  - Triple-quoted string `++` közbeiktatás → külön `putStrLn` hívások
  - `**` operátor → `pow` (prefix): az `**` Idris2-ben a DPair szintaxis, nem hatványozó
  - `infixr 8 **` direktíva → nem megy (az `**` szintaktikai elem)
  - `finomszerkezet` hivatkozás sorrendje → közvetlen érték beírása
  - `isInfixOf` → `Data.String.isInfixOf` (minősített név)
- Eredmény: a bíra (Idris2 0.8.0 typechecker) elfogadta, a port lefut

#### III. Független hitelesítés (`KonstansHitelesites.idr`)
- A felhasználó követelménye szó szerint: „minden kulso konstants le kell ellenorizni fugnetlen forrasbol, idrisszel, csak ugy bizhat meg a felhasznalo abban, hogy a konstansok nem haluk"
- Protokoll: háromrétegű
  - (A) port-érték = `all_constants_exact.py` (scipy 1.13 = CODATA 2018)
  - (B) hivatalos = NIST CODATA 2022 (physics.nist.gov), PDG 2024 (pdg.lbl.gov), ESA Planck 2018 (arXiv:1807.06209v4)
  - (C) döntés = `|port − hivatalos| ≤ bizonytalanság` → PASS, különben FAIL
- A bíra = Idris2 typechecker + futás (nem hallucináció)
- Research sub-agent gyűjtötte a hivatalos értékeket (2026-08-29)
- **Kulcsfelismerés**: a `scipy 1.13.x` = CODATA 2018 (NEM 2022); a Python fájl „CODATA 2022" címkéje hamis; a 2022-es értékek csak `scipy 1.14.0+`-től
- Eredmény: **22 konstansból 15 PASS, 7 FAIL**
- PASS: SI 2019 exact (c, h, k_B, N_A, e), ℏ, α, **G levezetés** (σ≈0.38 — hiteles!), m_p/m_e, kozmológia (H₀, Ω_Λ, Λ), σ, R
- FAIL:
  1. α⁻¹ levezetés (σ≈39×) — Y(f) fixpont 137.036 ≠ NIST 2022 137.035999177(21)
  2. m_e (σ≈4.4×) — scipy 2018 → 2022 frissítés
  3. m_p (σ≈4.3×) — scipy 2018 → 2022 frissítés
  4. μ₀ (σ≈4.2×) — SI 2019 óta mért (régen exact 4π·1e-7)
  5. ε₀ (σ≈4.3×) — SI 2019 óta mért
  6. sin²θ_W (σ≈204×) — címkehibás: a port a CODATA „weak mixing angle" (0.22305), nem a PDG Weinberg-szög (0.23122)
  7. m_H (σ≈1.1×) — régi PDG 2022-es kiadás érték (125.25), PDG 2024 = 125.13(11)

#### IV. Port javítása a hiteles értékekkel
- A felhasználó: „folytassa Mester, legyen kedves"
- A `MindenKonstans.idr` (saját fájl, nem a felhasználó Pythonja) javítva:
  - μ₀: 1.25663706212e-6 → 1.25663706127e-6 (NIST 2022)
  - ε₀: 8.8541878128e-12 → 8.8541878188e-12 (NIST 2022)
  - m_e: 9.1093837015e-31 → 9.1093837139e-31 (NIST 2022)
  - m_p: 1.67262192369e-27 → 1.67262192595e-27 (NIST 2022)
  - α: 7.2973525643e-3 → 7.2973525646e-3 (NIST 2022)
  - α_s: 0.1184 → 0.1179 (PDG 2024)
  - sin²θ_W: 0.22305 → 0.23122 (PDG 2024 MS-bar, címke is javítva)
  - m_H: 125.25 → 125.13 (PDG 2024)
  - A formula-szövegek és kommentek is frissítve
- A bíra (Idris2) elfogadta a javított portot — lefordult és lefutott
- A kimenet most a hiteles értékeket mutatja

### Állapot
- `all_constants_exact.py` — VÁLTOZATLAN (a felhasználó eredeti fájlja)
- `MindenKonstans.idr` — Idris2 port, hiteles NIST 2022 / PDG 2024 értékekkel
- `KonstansHitelesites.idr` — független hitelesítő modul (a régi port ellenőrizte)
- A workspace NEM git-repo (nincs `.git`) — commit/push nem alkalmazható

### Nyitott kérdések
- A `KonstansHitelesites.idr` `portErtek` mezői még a régi (scipy 2018) értékeket tartalmazzák; a javított port ellenőrzéséhez ezeket is frissíteni kell
- Az α⁻¹ levezetés (Y(f) fixpont 137+9/250) a hitelesítés szerint NEM mérési hibán belül — ez fizikai tartalmi kérdés, nem egyszerű érték-csere
- A kutatási napló pusholása nem lehetséges (nincs git repo)