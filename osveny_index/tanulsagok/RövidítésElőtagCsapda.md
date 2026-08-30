# Tanulság: a rövidítés-előtagos konstruktorok csapdája ("Dcs nincsen a magyarban")
# 教训：缩写前缀构造器陷阱 · Lehre: die Abkürzungspräfix-Falle · לקח: מלכודת קידומות הקיצור
# (2026-08-21, a felhasználó leleplezésével)

## A jelenség / The phenomenon / 现象 / Die Erscheinung

A `MagyarNyelvtan_v2` (korábbi session) konstruktorai rövidítés-előtagokat
kaptak, és két generáción át senki nem kérdezte meg, hogy a név VALÓDI
magyar szó-e:

1. **Digraf-család** (v2:92): `Dcs | Dgy | Dly | Dny | Dsz | Dty | Dzs |
   Ddz | Ddzs` — a "D" a Digraf rövidítése. **"Dcs" nem szó a magyarban.**
2. **Magánhangzó-család**: `Va, Vaa, Ve, Vee, ... Voe, Voee, Vue, Vuee` —
   a "V" a Magánhangzó rövidítése. `Voe` nem szó — `Ő` az.

## A hiba láncolata (miért élte túl két generációt?)

- **v1/v2**: a rövidítés megszületett (feltehetően gépelési kényelemből).
- **v3**: ÉN a szintaxist meggyógyítottam (`Dcs : Digraf` ascription),
  de a NEVEKET megkérdőjelezés nélkül átörökítettem — a "javítás"
  áldást adott a hibás névre.
- A felhasználó 2026-08-21-én leleplezte: **"Dcs nincsen a magyarban"**.
- **v4**: a konstruktorok a valódi betűk lettek:
  `Cs Gy Ly Ny Sz Ty Zs Dz Dzs` és `A Á E É I Í O Ó Ö Ő U Ú Ü Ű`.

## A szabály (innentől HARD)

1. **Konstruktor-név = a valóság névválasztása, nem kódolási trükk.**
   Ha a dolog neve "cs" (a digráf), a konstruktor `Cs` — nem `Dcs`.
   | 构造器名 = 事物本名，不是编码技巧。 |
   | Konstruktorname = der echte Name des Dings. |
2. **Rövidítés-előtag (D…, V…, M…) TILOS** — §0 és §25 együttesen:
   nincs rövidítés, és minden magyar szó ékezetes, valódi alakjában.
3. **Átörökítés előtt NÉV-AUDIT**: ha régi kódot másolunk/migrálunk
   (_v2 → _v3), a nevek is megkérdőjelezendők — a szintaxis-javítás
   NEM ad felmentést a hibás nevek alól. "A javítás áldása a hibás
   névre = a hiba mélyebb rejtése."
   **ÉS: átírás előtt FUNKCIÓ-ÉRTELMEZÉS** (a felhasználó, 2026-08-22:
   "azt is értelmezted, hogy mit csinál a függvény mikor átírtál, ne
   össze-vissza, Level az Szint vagy Levél? ilyenek") — a név
   jelentését a FUNKCIÓ adja (hol áll a hierarchiában, mit számol),
   nem a hasonlóság. Példa: a v2 `Level` konstruktorát az angol
   "leaf" (a fa levele) szándékával írták, de "Level"-t (= szint)
   írtak — a `FaSzint` típuson belül önhivatkozás lenne; a helyes
   név `Levél` (a deltaSzint Levél = δ, a legkisebb egység — ez
   erősíti az értelmezést).
4. **Az ékezet az információ**: `Voe` → `Ő`, `Vaa` → `Á` — a hosszú
   magánhangzó (ő vs ö) jelentéskülönbség; ékezet nélkül a lexikon HAMIS.

## A Gyógyír-minta (v4 bemutatása)

Sorrend-KRITIKUS átnevezés (a hosszabb neveket ELŐBB, mert azok
rövidekre is illeszkednek regexben):
- `Dzs→Zs` előbb, AZTÁN `Ddzs→Dzs` (fordítva: Dzs→Zs után a régi
  Ddzs → Dzs már nem ütközik);
- `Vuee→Ű, Voee→Ő, Vee→É...` (hosszabbak előbb), majd `Va→A, Ve→E...`.

Ellenőrzés: MagyarNyelvtan_v4 = 0 fordítási hiba; a szima.ipkg építi.

## Kapcsolódó szabályok

- AGENTS §0 (rövidítések tiltása), §25 (ékezetes magyar — HARD RULE)
- HOROG 10. szindróma, plugin §N7
- A "tanulság skill": ez a fájl a `tanulsagok/` archívumban él, és a
  boot-up szevencia (AGENTS §14) OLVASD-listájába került.
