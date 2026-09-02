# Kutatási napló — 2026-09-02 — «füzér vagy fűzér ?» (helyesírázi audit)

## A felhasználó kérdése szó szerint (§N5)

«füzér vagy fűzér ?»

## A válasz: **füzér** (rövid ü-vel) — AkH.12 szerint

### A bizonyítékforrások (§N12 — netes keresés, 2026-09-02)

1. **Czuczor–Fogarasi** (A magyar nyelv szótára, 1862):
   «FŰZÉR, FÜZÉR, (1), (fűz-ér) fn. tt. fűzér-t, tb. ~ěk. Fonálra,
   zsinórra, madzagra, zsinegre stb. fűzött valami, pl. paprika-,
   füge-, szömörcsök-, dohányfüzér. Gyöngyfűzér.» — a régi nyelvben
   MINDKÉT alak élt (kettős írás); a szó etimológiája: fűz + -ér.
2. **A magyar nyelv értelmező szótára** (AkH-címszó): **füzér** —
   összetételei: füzérvirágzat, dalfüzér, gyöngyfüzér, hagymafüzér,
   rózsafüzér, virágfüzér — VALAMENNYI rövid ü-vel.
3. **szinonimak.hu** (helyesírási kockázati adatlap): «A leggyakoribb
   kettő helyesírási hiba: **fűzér** • fuzer» — tehát a hosszú ű-s
   «fűzér» alak a szó KÉT LEGGYAKORIBB ELÍRÁSA KÖZÜL AZ EGYIK.
4. A Word-helyesírás-ellenőrző körüli fórumzaj is mutatja, hogy a
   kettőség élő probléma (a hosszú ű-s alakot hibásnak jelölik).

### A nyelvtani magyarázat

- Az IGE: **fűz** (hosszú ű) — fűzni, fűzés, fűzött — a szótagbeli
  magánhangzó hosszú marad az igei származékokban is.
- A FŐNÉV: **füzér** (rövid ü) — a régi fűz-ér származék főnévi
  rövidüléssel ragadt meg (mint sok régi képzős származék: az -ér
  képző rövid magánhangzót vonz). A modern standard egyedül ezt
  fogadja el.

## A kód helyzete (inventárum, 2026-09-02)

| azonosító | darab | ítélet |
|---|---|---|
| `Fűzés` (konstruktor, az igéből) | 58 + 42 előfordulás | ✅ HELYES (fűzés = hosszú ű, igeneves származék) |
| `Fűzér` (típus) | CsomagoltTipusok 29, Hatar 25, HatarElottiGepiTeszt 2 = **56** | ❌ HELYTELEN — helyesen `Füzér` |
| `FűzérVége` (konstruktor) | benne a fenti számokban | ❀ automatikusan javulna (`FüzérVége`) |
| `Füzér` (ütközés-ellenőrzés) | 0 előfordulás | ✅ a helyes alak SZABAD — tiszta átnevezés lehetséges |
| `fűzérHossz` + a GAN-terv `fűzérBejárás`-a | (származékok) | a jövőbeli kódban `füzérHossz`, `füzérBejárás` |

## A következmény (javaslat — engedélyre vár)

A MANTRA («ne törölj, csak adj hozzá») és a «ne változtass megkérdezés
nélkül» szabály miatt a típus ÁTNEVEZÉSE (Fűzér → Füzér, 56 előfordulás,
3 fájl, mechanikus replaceAll + újrafordítás + teszt + commit) CSAK a
felhasználó engedélyével végezhető el. A javaslatom: végezzük el MOST,
még mielőtt a 341 fájlos migráció tovább terjesztené a hibás alakot —
a git-előzmény a biztonság hálója, a típus beltartalma (a lista-
kategória objektuma) VÁLTOZATLAN marad, csak a név igazodik AkH-hoz.
Az ékezet információ (§25) — és itt kiderült, hogy a HELYTESEN hosszú
ékezet is félreinformáció.

## Tanulság (a why-chain-be)

1. A rövidítés-előtag-csapda (Dcs/Voe) után itt a MÁSODIK név-audit-
   típus: a **hiperkorrekciós ékezet-csapda** — a hosszú ű « szebbnek»
   tűnik, pedig a főnév rövid ü-t kíván. NÉV-AUDIT minden új típusnévhez:
   ige vagy főnév? származék milyen képzővel? AkH-címszó-ellenőrzés.
2. Az ige (fűz→Fűzés) és a főnév (füzér→Füzér) ELTÉRŐ magánhangzója
   szétválasztja a konstruktor-családot — ez INFORMÁCIÓ, nem hiba:
   a Fűzés morfizmus-építő (ige: cselekvés), a Füzér objektum (főnév:
   létező lánc). A Curry-Howard-i sor: a cselekvés hosszú, a létező
   rövid — mint az életben.

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★