# Kutatási napló — 2026-09-02 — 000.03 KÉSZ: LimitKolimitPilota (a pilóta)

## A felhasználó utasításai szó szerint (§N5)

1. «folyasd a terv szerint, kovetve az utasitasokat»
2. «probald meg folytatni a munkat»

## A pilóta-modul (osveny_index/LimitKolimitPilota.idr, ~760 sor, exit 0)

A GAN-terv (gépileg próbázott) szerint megírt NEWTYPE-MENTES pilóta:
az öreg LimitKolimitDemo.idr (rekord-newtype Nat/String/List-csomagolással)
szerepét átvevette.

### Szerkezet
1. `data Fogalom` — 10 konstruktor (Végződés, Kezdet, Szorzat, Koprodukt,
   Egyenlítő, Koegyenlítő, Pullback, Pushout, ÁltalánosLimit,
   ÁltalánosKolimit) — a típus = a dokumentáció.
2. `fogalomSorszám : Fogalom -> Sorszám` (sorEgy..sorTíz kódolás).
3. `fogalomSzava` — 10 digráf-barát graféma-literál (szorzat=[Sz,O,R,Z,A,T],
   egyenlítő=[E,Gy,E,N,L,Í,T,Ő]).
4. `fogalomDuálisa` — az öt duális-pár tükrözése.
5. BIZONYÍTÁSOK (~60 Refl-sor): duálisInvolúció ×10 (a tükrözés involúció!),
   duálisNemFixpont ×10 (nincs önduális!), sorszámVisszafordít ×10
   (a Fogalom↔Sorszám kódolás bijektív!), fogalomListájaHossza (=sorTíz),
   duálisPárokHossza (=sorÖt) + 5 párTanú.
6. INSTANCE-OK: EgyenlőségT (a bizonyítások ELŐTT átrendezve — csapda #12!),
   RendezésT, MegjelenítésT — mind a sorszám-kódoláson át.
7. `füzérBejárás : {tag : Type} -> (tag -> IO ()) -> Füzér tag -> IO ()`
   — TOTAL (a GAN jóslata gépileg igazolódott).
8. `fogalomListája : Füzér Fogalom`, `duálisPárok : Füzér (Pár Fogalom Fogalom)`.
9. 14 szó-konstans (egySzava..tízSzava, kilépésSzava, mindSzava, duálisSzava,
   súgóSzava) — digráf-barát literálok (egy=[E,Gy], nyolc=[Ny,O,L,C]).
10. `számNév : Sorszám -> Szöveg`, `szókéntSor : Szöveg -> Talán Sorszám`
    (10-mély case-lánc), `számNévből : Szöveg -> Talán Fogalom`.
11. TANÚ-HÁLÓ — 14 Körút-bizonyítás: a kernel a `strCons`-szal épített
    sztringet és a mohó digráf-olvasót is redukálja — minden parancsszó
    fordítási idejű körútja (egy elírás a FORDÍTÁST buktatja).
12. Leírások és források SZAVAKBAN (Füzér Szöveg) — a Szöveg írásjelet és
    számjegyet nem hordoz; a jelek a Mondat-rétegen térnek vissza
    (mondatVégére + PontJel / FelkiáltójelJel). Források: nlab ávodej
    öt pont egy/kettő/három (=nLab + Awodey §5.1/5.2/5.3) és nlab maclane
    harmadik fejezet negyedik szakasz (=Mac Lane §III.4).
    MEGJEGYZÉS: «Awodey» w-je nem magyar betű — ÁVODEJ v-átírással
    (mint Wagner→Vágner); a YBetű/WBetű nem létezik a 44-ben.
13. INTERAKTÍV loop: covering feldolgoz (előre-típusdeklaráció) +
    covering fogadás + covering main; parancsok: számnevek egy–tíz,
    mind (mind a 10 fogalom), duális (5-páros táblázat), súgó, kilépés.

### Az interaktív teszt (§N14/6) — MINDEN válasz HELYES

| parancs | válasz |
|---|---|
| egy | «egy végződés. minden objektumból egyetlen morfizmus a végződésbe. nlab ávodej öt pont egy.» |
| öt | «öt egyenlítő. a két leképezés egyezik rajta. nlab ávodej öt pont három.» |
| nyolc | «nyolc pushout. duálisa a pullbacknek. nlab ávodej öt pont kettő.» |
| kilenc | «kilenc általánoslimit. kúp kompatibilitás univerzális tulajdonság. nlab maclane harmadik fejezet negyedik szakasz.» |
| tíz | «tíz általánoskolimit. duálisa az általánoslimitnek. …» |
| duális | «végződés duális kezdet. szorzat duális koprodukt. egyenlítő duális koegyenlítő. pullback duális pushout. általánoslimit duális általánoskolimit.» |
| xyz / tíd (ismeretlen) | súgó-üzenet ✓ |
| kilépés | «viszlát!» |

### A teszt során leleplezett és javított elírások (a kézi literál-gyengék)
- egyenlítő/koegyenlítő/egyenlítőnek: hiányzó Í betű (egyenltő ✗)
- szakasz: Sz,A,K,A,S,Z,S,Z (8) helyett Sz,A,K,A,Sz (5 graféma!)
- Felkiáltójel → FelkiáltójelJel (a Jel-utótag kötelező)

## ÚJ Idris 0.8.0-csapdák (#12–#13; a 000.01-essel együtt 13)

12. **AZ INSTANCE A BIZONYÍTÁS TÍPUSA ELŐTT ÁLLJON** — az interface-metódus
    (egyenlőE) a bizonyítás TÍPUSÁBAN csak akkor oldódik, ha az instance
    korábban szerepel a fájlban (duálisNemFixpont esete).
13. **String-literál a TÍPUSBAN nem redukálódik a kernelben** —
    `karakterláncbólSzöveg "egy" = …` NEM bizonyítható Refl-lel; de a
    `strCons`-szal épített sztring IGEN: `karakterláncbólSzöveg
    (strCons 'e' (strCons 'g' (strCons 'y' ""))) = Csak egySzava` ✓
    (a Hatar normalizáldNFD-bizonyítás mintája általánosult).

## A duplikáció-őrszem (§24)

A `füzérFűzés` (Füzér-append) a pilótában született meg a 000.04-es
terv-lépés ELŐZETESEKÉNT — a 000.04 végrehajtásakor a CsomagoltTipusok-ba
KÖLTÖZIK, és a pilóta onnantól IMPORTÁLJA (nincs duplikáció — a pilóta
most az egyetlen lakóhelye).

## adminisztráció

- LimitKolimitDemo.idr: ELAVULT-fejléc (nem törlés — MANTRA); még fordul.
- EgyVonalTerv_v1.idr: 000.03 → Kész; **a vonal: 74 lépés, 4 kész**;
  a következő lépés: **000.04 — Füzér teljes API** (füzérTérkép,
  füzérHajtás, füzérEleme, füzérElső, füzérTöbbi, füzérFűzés,
  füzérFordít + Data.List-megfeleltetés + literál-építők).

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★