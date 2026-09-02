# Kutatási napló — 2026-09-02 — 000.02 KÉSZ: a Határ-modul (az IO pereme)

## A felhasználó utasításai szó szerint (§N5)

1. «folytassuk, updateld a todo-t, idriszben, segitsen a GAN, hasznald a
   scite-ot, elofizettem ra»
2. «helyzetjelentest kerek»

## scite (§N12 — új eszköz, előfizetve)

Két keresés — a CÉL (fizikai állandók tiszta matematikából) irodalmi
horgonyai:

### Keresés 1: E8-egyesítés
- **Calmet, Hsu & Reeb (2008)**: E8×E8 unifikáció — a kvantumgravitációs
  hatások módosítják a csatolási állandók egyesülési feltételeit; nagy
  anyagtartalmú modellekben (E8×E8: 248 + 3875 Higgs-multiplettek!) a
  skála-újranormalizálás jelentős. Tanulság: az E8×E8 VALÓDI fizikai
  modell (húr-motivált) — a projekt E8×E8×E8 típusú kódkonstrukciója
  mellett ez a húr-fizikai párhuzam dokumentálandó.
- **Irwin (2019, QGR)**: «Toward the Unification of Physics and Number
  Theory» — simplex-egészek, E6/E8 rácsok, aranymetszés-kapcsolatok,
  kvázikristály-kód-formalizmus; «a számelmélet és a fizika egyesítő
  ötlete a KÓDELMELET». EZ A LEGKÖZELEBB ÁLLÓ MŰ a projekt saját
 útjához (E8 + hibajavító kódok + aranymetszés [KvantumY!] + kvázikristály
  [torusz!]). A 600-as fázis kulcs-irodalma.
- Lisi E8-elmélete említésszinten (Sfetcu 2019 filozófiai áttekintés).

### Keresés 2: finomszerkezet-konstans levezetések
- **Sherbon (2018, JAP)**: «Physical Mathematics and the Fine-Structure
  Constant» — EDDINGTON ELVE szó szerint: «A fizika minden mennyiségi
  állítása, vagyis a tudomány tiszta számjegyű állandóinak pontos értéke
  logikai következtetéssel levezethető minőségi állításokból, megfigyelésből
  származó mennyiségi adatok használata NÉLKÜL.» — EZ a projekt CÉL-jának
  filozófiai előzménye (1920-as évek!). Landé sinh(2π), aranymetszés-
  geometria, α⁻¹ ≈ 137.035999168; Pauli: «numerikus értékének elméleti
  értelmezése az atomfizika egyik legfontosabb megoldatlan problémája».
- **Sherbon (2018, SSRN)**: aranymetszés-geometria + prím-konstans.
- **Chakeres, Vento & Andrianarijaona (2017)**: konstansok levezetése
  2-ből és π-ből, harmonikus törtkitevők — relatív hiba 10⁻³–10⁻¹.
- **Pellis (2022)**: arany-szög/kettőhatvány formulák hatványtalan
  állandókra (μ, α, NA, αG...) — pontos szerkesztés, fizikai státusz
  bizonytalan.

**Értékelés**: ezek részben mainstream-közeli (Calmet), részben
peremvidéki (Pellis, Chakeres) munkák — a scite smart-citationjei
főleg «mentioning» típusúak. A projekt SZAKADATLAN magyar kód-útja
(Idris-bizonyítás!) ettől függetlenül önálló; az irodalom KONTEXTUS
és mérceláb (a CODATA-ügyelet a codata-skill szerint marad).

## GAN (§N14/1) — a 000.02 tervezése

Gépileg bizonyított csapdák: strUncons létezik ✓; '\x0301' hex-literál
érvényes ✓; String-rekurzió nem total → assert_smaller megoldja ✓.
Típus-korrekció a GAN-tervhez: **a c+z NEM digráf** (a „cz" régi
helyesírás; a dz = d+z) — a párosDigráf-táblából kimaradt.

## Alap/Hatar.idr — KÉSZ (exit 0, ~660 sor)

1. Írásjel 13 (AkH.12): Szóköz, Pont, Vessző, Pontosvessző, Kettőspont,
   Kérdőjel, Felkiáltójel, Zárójelek, GondolatJel (U+2013) ≠ KötőjelJel
   (U+002D), magyar idézőjelek („ U+201E / " U+201D).
2. MondatDarab (SzóDarab | JelDarab) + Mondat = Fűzér MondatDarab.
3. betűKarakterlánca 44 — DIGRÁF-BARÁT (CsBetű→„cs") — a kanonikus
   kiírás; karakterbőlBetű 35 (csak egykarakteresek; STRICT: ismeretlen
   → Semmi).
4. NFC: kombinálódó 18 sor (U+0301 hegyes, U+0308 kettős pont, U+030B
   kettős hegyes; kis- és nagybetűk) + normalizáld (strUncons +
   assert_smaller).
5. Mohó digráf-olvasó: karakterláncbólSzöveg (dzs→dz→pár→egyetlen);
   szavakKarakterláncból ('\r'-tűréssel); szavakbólMondat; mondatbólKarakterlánc.
6. IO-perem: határKiírás (Szöveg-alapú — a generikus constraint-fv LHS-e
   elhasal a 0.8.0-ban), határMondatKiírás, határSzavakOlvasás,
   határOlvasás (elsőSzóTalán segéddel).
7. BIZONYÍTÁSOK (Refl): körútBetű 44 sor (a digráf-barát kiírás miatt a
   digráfokra is teljesül!), jelKörút 13, normalizáldNFD («tér» NFD→é),
   normalizáldŐNFD.
8. INTERAKTÍV főprogram (§N14/6): súgó/hossz/betűk/rag/esetrag/kilépés
   + esetragDemo táblázat (a 18 rag felületi alakja) + ragTeszt.

## Az interaktív teszt — MINDEN válasz HELYES

| parancs | válasz | jelentés |
|---|---|---|
| hossz háznál | «hat» | 6 betű ✓ |
| hossz tér (NFD: e+U+0301) | «három» | **AZ NFC MŰKÖDIK** ✓ |
| betűk csont | cs, o, n, t | **A DIGRÁF-KÖRÚT MŰKÖDIK** (CsBetű→„cs") ✓ |
| rag háznál nál | «igen» | végEgyezzik ✓ |
| esetrag háznál | (üres sor) + «nál» | AlanyRag(∅) + KözelbenRag ✓ |
| kilépés | «vége» | ✓ |

A teszt során JAVÍTOTTAM: hosszSzó (a mohó olvasó a «hossz»-t
[H,O,S,Sz]-nak olvassa!), igenSzó (G nem Gy), búcsúszó («vége»).

## Új Idris 0.8.0-csapdák (9–11, a 000.01 nyolcáról folytatva)

9. **Kétszintű klauzula-minta nem számít lefedettnek** (Csak (Fűzés...),
   Fűzés (Párosít...)) → külső változó-minta + belső case.
10. **`||` (kétpipe) sor ÉRVÉNYTELEN komment** — csak `--` és `|||` létezik;
    a `||| ... \n || ...` dok-blokk második sora parse-hibát ad.
11. **Generikus constraint-fv LHS-elaborációja elhasal** ({t} =>
    Osztály t => t -> IO () — «Undefined name érték») → Szöveg-alapú
    változat + a megjelenít-et a hívó fűzi.
(+ a dok-komment nem állhat már típusdeklarált fv klauzula előtt — sima `--` kell.)

## adminisztráció
- HatarElottiGepiTeszt.idr: ELAVULT jelölés (nem törlés — MANTRA).
- EgyVonalTerv_v1.idr: 000.02 → Kész. **A vonal: 74 lépés, 3 kész.**
- Következő lépés: **000.03 — a pilóta (LimitKolimitDemo újraírása
  data-típusokkal, a newtype-változat elvetése)**.

## Referenciák (APA — scite)

- Calmet, X., Hsu, S. D. H., & Reeb, D. (2008). Quantum gravitational
  effects and grand unification. *AIP Conference Proceedings*.
  https://doi.org/10.1063/1.3051985
- Chakeres, D. W., Vento, R., & Andrianarijaona, V. M. (2017). A
  frequency-equivalent scale-free derivation of the neutron, hydrogen
  quanta, Planck time, and a black hole from 2 and π. *Journal of
  Applied Mathematics and Physics, 5*(5), 1073–1091.
  https://doi.org/10.4236/jamp.2017.55094
- Irwin, K. (2019). Toward the unification of physics and number
  theory. *Reports in Advances of Physical Sciences, 3*(1), 1950003.
  https://doi.org/10.1142/s2424942419500038
- Pellis, S. (2022). *Exact mathematical formula that connect 6
  dimensionless physical constants*. Authorea.
  https://doi.org/10.22541/au.163647177.74971779/v4
- Sherbon, M. A. (2018a). Fine-structure constant from golden ratio
  geometry. *SSRN Electronic Journal*. https://doi.org/10.2139/ssrn.3148761
- Sherbon, M. A. (2018b). Physical mathematics and the fine-structure
  constant. *Journal of Advances in Physics, 14*(3), 5758–5764.
  https://doi.org/10.24297/jap.v14i3.7760

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★