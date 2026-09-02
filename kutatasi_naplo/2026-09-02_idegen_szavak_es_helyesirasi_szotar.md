# Kutatási napló — 2026-09-02 — Idegen szavak + a helyesírási szótár letöltése

## A felhasználó utasítása szó szerint (§N5)

«Idegen-nyelvu szavak, maradjanak idegen nyelvuek, al agent-tel keress ra a
magyar helyesirasi szotarra es toltsd, le ha tudod, nezd meg milyen kereso
mcp-k vannak.»

## 1. Az irányelv: az idegen szavak idegenek maradnak

A korábbi döntésem (ÁVODEJ = az «Awodey» v-átírása, mert a w nem magyar
betű) ELVETVE. Az AkH-elv értelmében az idegen tulajdonnevek EREDETI
alakjukban maradnak — nem magyarosodnak. Kategóriaelméletileg: a magyar
nyelvász (44 graféma) egy RÉSZKATEGÓRIÁJA a latin betűs világának; az
idegen szavak nem ezen a részkategórián élnek, és a funktor (átírás)
nem identitás — az átírt szó NEM ugyanaz a szó.

A pilótában (LimitKolimitPilota.idr):
- `ávodejSzó` ELAVULT-jelöléssel megőrizve (MANTRA — nem törlünk),
  használói eltávolítva;
- a források: «nlab öt pont egy/kettő/három» (Awodey §5.1/5.2/5.3 a
  KOMMENTBEN, torzítás nélkül) és «nlab maclane harmadik fejezet negyedik
  szakasz» (Mac Lane §III.4 — a «maclane» a magyar grafémákkal EGYÉBRTÉLMŰ,
  torzítás NÉLKÜLI idegen név);
- exit 0, a tesztváltozat mindkét forrássor helyes.

## 2. A technikai nyitva maradt kérdés → 200.37-es tervezési lépés

Az idegen betűk (w, y, x, q…) hordozására a 44-es magyar Betű-rendszer
NEM alkalmas — ez típus-szintű szeparációra szólít:
`data IdegenBetű` (külön típus — a magyar 44 érintetlen marad!) +
`IdegenSzóDarab` konstruktor a MondatDarab-ban (a Határ-rétegben).
Új terv-lépés: **200.37** (GAN-os tervezéssel).

## 3. A magyar helyesírási szótár LETÖLTVE (al-ágens, §N12)

Az al-ágens (general) kereste és letöltötte — forrás: **LibreOffice
dictionaries-tükör** (Németh László magyarispell 1.9-je, **AkH.12 (2015)**
szerint):

| Fájl | Méret | Tartalom |
|---|---|---|
| `trail_index/szotar/hu_HU.dic` | 1,8 MB | **97 663** szó (affix-kódokkal + morfológiai mezőkkel) |
| `trail_index/szotar/hu_HU.aff` | 2,3 MB | 54 141 sor affix-szabály (ragozás, képzés) |
| `trail_index/szotar/README_hu_HU.txt` | 1,2 KB | eredeti licenc-leírás (MPLv2 / LGPLv3+ kettős licenc) |
| `trail_index/szotar/lepes-szotar-README.md` | 3 KB | saját magyar dokumentáció |

Minta-szavak a szótárból: virágfüzér, rózsafüzér, egybefűzés, átdolgozó,
üzletág — mind ékezetes, magyar helyesírási formában.

**Az MTA-portál (helyesiras.mta.hu) online-only** — csak lekérdezéses
eszközöket ad (Külön vagy egybe? / Helyes-e így? / Névkereső / Elválasztás),
letölthető szólistát vagy API-t NEM. Ezért a hunspell-fájl a kanonikus
gépi forrás. A minta-lekérdezések: «füzér», «átdolgoz», «fűzés» —
mind HELYES — független megerősítése a korábbi Füzér-auditnak!

## 4. A kereső MCP-k áttekintése (a felhasználó kérésére)

1. **brave-search** — brave_web_search + brave_local_search: általános
   web-keresés (gyors, hírek, tények).
2. **exa** — exa_web_search_exa + exa_web_fetch_exa: szemantikus
   (értelmű) keresés + oldal-olvasás — «blogbejegyzés, ami…» típusú
   kérdésekre.
3. **firecrawl** — a legszélesebb: firecrawl_search (web/hírek/github/
   research/pdf/developer kategóriákkal!), firecrawl_scrape (ismert URL
   kinyerése), firecrawl_map (webhely-feltérképezés), firecrawl_crawl
   (többoldalas bejárás), firecrawl_agent (aszinkron kutatási munka),
   firecrawl_developer_search (GitHub-issue/PR/README-index).
4. **alphaxiv** — 2,5M+ arXiv-anyag (számítás, matematika, fizika) —
   kutatási kérdésekre, PDF-olvasással.
5. **scite** — tudományos irodalom smart citation-nel (előfizetve!) —
   biomed + arXiv; APA-hivatkozásokkal.
6. **context7** — programozási könyvtár-dokumentáció (API-szintaxis,
   verziók).
7. **websearch/webfetch** — a session beépített keresője.
Plusz a **task** al-ágens-rendszer (general/explore), amely mindezt
összefoghatja — mint most a szótár-letöltésnél.

## 5. adminisztráció

- Az al-ágens commitja: ce82707 (szótár + saját naplója:
  kutatasi_naplo/plugin_naplo_2026-09-02_szotar_letoltes.md).
- A vonal: 74 lépés, 4 kész; új lépés 200.37; következő: 000.04.

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★