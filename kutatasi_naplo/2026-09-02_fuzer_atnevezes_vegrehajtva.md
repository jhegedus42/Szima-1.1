# Kutatási napló — 2026-09-02 — A Füzér-átnevezés végrehajtva (AkH-audit lezárva)

## A felhasználó döntése szó szerint (§N5)

«olyan, hogy Fűzér, nem igazán van a magyarban...»

(Ez az előző kérdésre — «füzér vagy fűzér ?» — adett válasz folytatása és
a javasolt átnevezés engedélye: a hosszú ű-s alak nem szó, tehát a
típusnév sem maradhat így.)

## Amit végeztem

1. Teljes leltár (nagy- és kisbetűs együtt): 4 fájl, 69 előfordolás —
   CsomagoltTipusok.idr 39, Hatar.idr 25, HatarElottiGepiTeszt.idr 3,
   EgyVonalTerv_v1.idr 2 (+1 a 000.04 leírásában utólag).
2. Mechanikus átnevezés (edit replaceAll):
   - `Fűzér` → `Füzér` (a típus és `FűzérVége` → `FüzérVége`)
   - `fűzér` → `füzér` (füzérHossz, füzérTérkép, ... a tervben)
   - `Fűzés` ÉRINTETLEN — az igei származék hosszú ű-je HELYES (fűz → fűzés).
3. Ellenőrzés: maradvány 0; mind a négy modul exit 0:
   - Alap/CsomagoltTipusok.idr ✓
   - Alap/Hatar.idr ✓
   - HatarElottiGepiTeszt.idr ✓ (ELAVULT-jelölt, de fordul)
   - EgyVonalTerv_v1.idr ✓ (a következő lépés: 000.03 Pilóta)
4. Interaktív visszateszt (§N14/6): «hossz háznál»→hat ✓,
   «esetrag háznál»→(üres ∅ +) nál ✓, «kilépés»→vége ✓ —
   a viselkedés BYTE-IDENTIKUS, csak a nép neve magyarult el.

## A Curry-Howard-i tanulság (a why-chain-be)

A `Fűzés` (ige: cselekvés — a lánc ÉPÍTŐJE) és a `Füzér` (főnév: létező —
a lánc MAGA) mostantól helyesen ELTÉRŐ magánhangzót hordoz: a cselekvés
hosszú (fűzés), a létező rövid (füzér). A nyelv itt pontosan azt a
kategóriaelméleti különbséget kódolja, amit a kód is: morfizmus-építő
konstruktor vs. objektum-típus. A magyar nyelv = a kategóriaelmélet
anyanyelve (§0) — még a magánhangzó-hosszban is.

## NÉV-AUDIT-szabály (új, a Tanulság-Őrszem-gyűjteménybe)

Minden új típusnév ELŐTT:
1. Ige vagy főnév? (származék milyen képzővel?)
2. AkH-címszó-ellenőrzés (értelmező szótár / helyesiras.mta.hu).
3. A hosszú ékezet NEM szebb — a hiperkorrekció csapda (fűzér ✗, füzér ✓).

## Állapot

- A vonal: 74 lépés, 3 kész (000.00-000.02), a következő a 000.03 Pilóta
  (LimitKolimitPilota — a GAN-terv már kész és gépileg próházott,
  l. 2026-09-02_000.03_LimitKolimitPilota_GAN_terv.md).

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★