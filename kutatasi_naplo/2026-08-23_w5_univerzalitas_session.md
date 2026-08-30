# Kutatási napló — 2026-08-23 — W5: univerzalitási osztályok + kritikus exponensek

## Bejegyzés 1 (W5 munkafolyam, `general` ügynök)

**KÉRDÉS (szó szerint):**

"`general` ügynök. Szima-projekt (`/Users/joco/opencode`). Munkafolyam W5:
univerzalitási osztályok + kritikus exponensek Idris-modulja.

ELŐSZÖR OLVASS (§N11): gyökér AGENTS.md, HOROG.md; `skills/idris-stilus/SKILL.md`,
`skills/magyar-matematika/SKILL.md`; `szima_ter/modul/E8Iranymutato_v1.idr` (a 2D
Ising exponensek MÁR BENNE VANNAK: α=0, β=1/8, γ=7/4, ν=1 — azt IMPORTÁLD, ne
írd újra, §24); lásd hogyan ábrázol a projekt törteket/Double-t (grep a modulokra).

KUTATÁS (rövid, §N12 — brave-search/exa/firecrawl): ellenőrizd mértékadó
forrásból a kritikus exponenseket: 3D Ising (α≈0.110, β≈0.326, γ≈1.237, ν≈0.630,
η≈0.036), 2D perkoláció (β=5/36, ν=4/3), 2D önkerülő séta (ν=3/4). Forrás-URL a
kommentekbe.

IDRIS MODUL `szima_ter/modul/E8Univerzalitas_v1.idr` (új fájl, §13; ékezetes
azonosítók §25; nincs rövidítés §0; négy nyelvű blokk-fejlécek §22):
- exponensek pontos törteként (skálázott egész, pl. nyolcadok/harminchatodok —
  a projekt stílusa szerint),
- skálacímkék Refl-bizonyítással, KÉT független úttal (§18, tautológia TILOS):
  Rushbrooke α+2β+γ=2 (2D Ising nyolcadokban: 0+2+14=16 ✓), hiperskálázás
  2−α=d·ν (2D: 2−0=2·1 ✓), Fisher γ=ν(2−η) (2D: negyedekben 1·(8−1)/4=7/4 ✓).
- 3D Ising közelítő értékek Double-ként + megjegyzés, hogy ezek nem pontosak
  (numerikus egyenlőtlenség-ellenőrzés a main-ben).

UTÁNA: olvasd `szima_ter/szima.ipkg`-t, add hozzá az új modult; futtasd
`idris2 --build szima_ter/szima.ipkg` → 0 hiba kötelező. NE commitolj, NE pusholj.

TÉRJ VISSZA: fájllista + fordítási eredmény + max 5 mondat összefoglaló."

**VÁLASZ (összefoglaló):**

1. **Boot-up olvasás** (§N11): HOROG.md, idris-stilus SKILL, magyar-matematika
   SKILL, E8Iranymutato_v1.idr elolvasva; grep a tört-ábrázolásra
   (tortreszSzamlalo/tortreszNevezo minta, Integer a Nat-robbanás ellen).
2. **Kutatás** (§N12): Wikipédia "Critical exponent" (skálacímkék:
   νd=2−α=2β+γ, 2−η=γ/ν), Wikipédia "Universality class" (3D Ising bootstrap:
   Chang et al. 2025, arXiv:2411.15300; SAW ν=3/4), Smirnov–Werner
   (arXiv:math/0109120, MRL 8 (2001) 529) a 2D perkolációra. Minden forrás-URL
   a modul fejléc-kommentjeiben.
3. **Új fájl**: `szima_ter/modul/E8Univerzalitas_v1.idr` (§13 — semmi felülírás):
   - `ExponensTört` rekord (számláló/nevező Integer — a perkoláció α=−2/3 negatív);
   - pontos konstansok NAGYBETŰS névvel (KisBetűsProjekcióCsapda): 2D Ising
     nyolcadokban (η negyedekben), 2D perkoláció hetvenkettedekben
     (lkkt 72), 2D önkerülő séta natív nevezőkkel (ν=3/4 Nienhuis);
   - 9 db kernel-Refl bizonyítás, mind két úttal (§18): Rushbrooke +
     hiperskálázás + Fisher mindhárom pontos osztályra (16=2·8;
     144=2·72; 128=2·64; 12384=72·172; 129=3·43; …);
   - 3D Ising közelítő Double-rekord bootstrap-értékekkel + maradék-számítás
     (Δ ≈ 10⁻⁸ < 10⁻⁶ tűrés — §17 szerint hibát a bizonytalansághoz mérve);
   - futásidejű egyezés-ellenőrzés az IMPORTÁLT E8Iranymutato_v1 ising* mezőivel
     (§24 — import, nem másolat) → IGAZ.
4. **ipkg**: `szima_ter/szima.ipkg` modullistájához hozzáadva az
   `E8Univerzalitas_v1`.
5. **Fordítás**: `idris2 --build szima_ter/szima.ipkg` → EXIT 0, 0 hiba (52/52
   modul). Futtatás (`--exec main`): minden skálacímke kimenete értelmes,
   3D maradékok ~10⁻⁸, minden ellenőrzés IGAZ.

**Létrejött fájlok:**
- `szima_ter/modul/E8Univerzalitas_v1.idr` (új modul)
- `szima_ter/szima.ipkg` (1 sor hozzáadás: modullista)
- `kutatasi_naplo/2026-08-23_w5_univerzalitas_session.md` (ez a fájl)

**Commit/push: NEM történt** (a felhasználó explicit utasítása:
"NE commitolj, NE pusholj").
