# Liszt Ferenc és Bartók Béla zenéjének kottaalapú ritmus- és hangmagasság-elemzése

Dátum: 2026-08-24 · Készült: Szima-projekt (`/Users/joco/opencode`) · Fájl: `docs/Liszt_Bartok_ZeneiTanulas.md`

> **Fejléc — négynyelvű / 四种语言 / viersprachig / רב-לשוני**
> **Magyar:** Liszt (†1886) és Bartók (†1945) műveinek kottaalapú elemzése: fő motívumok hangjai, ritmusképletek, hangnemek, formák; a Bartók-aranyarány matematika (Lendvai) és a projekt φ-jelenségeinek (E8, Coldea 2010) kapcsolata — őszintén jelölve, mi analógia és mi bizonyított.
> **中文：** 李斯特与巴托克作品的乐谱分析：主要动机音高序列、节奏型、调性与曲式；巴托克黄金分割数学（伦德魏）与本项目 E8/φ 现象的关系——诚实标注类比与已证事实。
> **Deutsch:** Partiturbasierte Analyse von Werken Liszts und Bartóks: Motivtöne, Rhythmusmodelle, Tonarten, Formen; Bartóks Goldener-Schnitt-Mathematik (Lendvai) und ihr Verhältnis zu den φ-Phänomenen des Projekts (E8, Coldea 2010) — ehrlich markiert: Analogie oder bewiesen.
> **עברית:** ניתוח מבוסס-פרטיטורה של יצירות ליסט ובארטוק: צלילי מוטיבים, תבניות קצב, סולמות וצורות; מתמטיקת יחס הזהב של בארטוק (לנדוואי) וקשרה לתופעות ה-φ של הפרויקט (E8, Coldea 2010) — בסימון כנה: אנלוגיה או מוכח.

---

## 1. Bevezető — a ritmus mint kódolási stratégia / 节奏作为编码策略 / Rhythmus als Kodierungsstrategie / קצב כאסטרטגיית קידוד

**Magyar:**
1. A ritmus **időkvantálás**: a folytonos időt diszkrét, hierarchikus egységekre (ütem, hangjegy, szekció) bontja — pontosan úgy, ahogy a Szima-projekt a folytonos jelentést diszkrét típusokra és a [[7,1,3]] Steane-kód 7 bitjére bontja ([idő, okság, tér, szín, hang, fázis, mód], AGENTS §6).
2. A ritmus **koherenssé teszi a gondolkodást**: a periodicitás és a mérő (metrum) közös órát ad minden szólamnak — ez a fáziskoherencia (AGENTS §8: azonos fázisú fogalmak redundánsak, eltérő fázisúak információt hordoznak).
3. Liszt és Bartók magyar zeneszerzők; műveik 2026-ra **közkincsek** (Liszt teljes életműve; Bartók 1945-ben elhunyt művei az EU-ban és sok országban szabaddá váltak), a kották az IMSLP-ről ellenőrizhetők. Ez a dokumentum kizárólag **forrásmegadással** dolgozik, nem emlékezetből (AGENTS §18: őszinte verifikáció).
4. A zenei elemzés célja a Szima számára **strukturális tanulás**: hogyan kódol egy másik, időalapú „nyelv" (a zene) hierarchiát, transzformációt (Liszt témametamorfózisa) és arányokat (Bartók φ-szerkezetei) — l. a 6. szakaszt.

**中文：** 节奏即时间量子化：把连续时间切分为离散层级单位，如同本项目把意义切分为类型与 [[7,1,3]] 七比特。节奏让思维保持相干。

---

## 2. Módszertan / 方法 / Methodik / מתודולוגיה

1. **Kották**: IMSLP (International Music Score Library Project) — minden műhöz forrás-URL adva.
2. **Hang → Hz**: egyenletes (12 félhangos) hangolás, A4 = 440 Hz referencia; számítás `f = 440 · 2^((m−69)/12)` képlettel, ahol m a MIDI-hangszám. A számítást **Idris 2-ben** futtattuk (Python tilos, §N8): a szkript a jóváhagyott külső munkakönyvtárban készült (`/var/folders/.../T/opencode/Hangfrekvencia.idr`), ez a repóban NEM hozott létre új fájlt (a feladat csak ezt az egy dokumentumot engedi).
3. **Minden állításhoz forrás** (URL) tartozik; ahol a forrás szövegesen leírja a kotta hangjait, ott a szekvencia forrásmegadással áll; ahol nincs explicit hangjegyzet a forrásban, ott csak a dokumentált szerkezeti tényt írjuk le (nincs kitalált hangszekvencia — AGENTS §18.5).
4. **Frekvenciatábla** (Idris-számítás, 2 tizedesre kerekítve):

| Hang | Hz | Hang | Hz |
|---|---|---|---|
| F2 (Fisz2) | 92,50 | Fisz4 | 370,0 |
| F3 | 174,61 | As4/Gis4 | 415,30 |
| Fisz3 | 185,00 | **A4 ( referencia )** | **440,00** |
| G3 | 196,00 | B4 | 493,88 |
| Gisz3 | 207,65 | Cisz5 | 554,37 |
| **A3** | **220,00** | Disz6 | 1244,51 |
| B3 | 233,08 | Disz7 | 2489,02 |
| H3 (B3) | 246,94 | Esz4 | 311,13 |
| C4 | 261,63 | E4 | 329,63 |
| Cisz4 | 277,18 | F4 | 349,23 |
| D4 | 293,66 | | |

---

## 3. LISZT Ferenc (1811–1886) — öt mű / 五部作品 / fünf Werke / חמיר יצירות

### 3.1. II. magyar rapszódia, cisz-moll, S.244/2 (1851)

- **Mit:** a 19 Magyar rapszódia leghíresebb darabja; klasszikus csárdásforma: lassú **lassan** + gyors **friska**, a verbunkos hagyományt követve.
- **Fő motívum / kottából:** a bevezetés **Cisz-dúr hármashangzaton** nyit (Cisz–Eisz–Gisz–Cisz, mint akkord), a 2. ütemben már a b7 fok (H természetes) szólal meg; a lassan-téma a 9. ütemtől indul, első szakasza a kis V-re (gisz-moll) mozog, a 27. ütemtől E-dúr (párhuzamos dúr). A friska fő témája **Fisz-dúrban** szólal meg. Hang Hz-ben: Cisz4 = 277,18 Hz; Fisz4 = 370,0 Hz.
- **Ritmus/képlet:** a bevezetés szándékosan „mérő nélküli" hatású, erősen pontozott ritmusokkal; a friskában a cimbalom-utánzat: **egy hang öntése különböző oktávokban** (kalapált cimbalom-imitáció), egyre gyorsuló (accelerando) tempólépcsők (158. ütemtől), prestissimo koda (421. ütemtől).
- **Hangnem és forma:** cisz-moll (lassan; Cisz-dúr nyitás, 6. ütemre kis-dúr), fisz-moll → fisz-dúr (friska), modulációk: domináns Cisz-dúr és alsó mediansz A-dúr; végkoda fisz-dúrban. A szerkezeti szimmetria tudatos: lassan = dúr-nyitás→moll; friska = moll-nyitás→dúr.
- **Források:** https://imslp.org/wiki/Hungarian_Rhapsody_No.2,_S.244/2_(Liszt,_Franz) · https://en.wikipedia.org/wiki/Hungarian_Rhapsody_No._2 · https://www.romarchive.eu/en/music/classical-music/liszts-hungarian-rhapsody-no-2-c-minor-and-pianist/ · https://www.pianotv.net/2017/06/a-tour-of-liszts-hungarian-rhapsody-no-2/
- **Tanulság:** a ritmus itt **tempó-gradiens** (lassú→prestissimo): az időkvantálás felbontása fokozatosan finomodik — pont mint egy híradás (koherencia) felbontása egyre rövidebb szavakra. A dúr/moll-nyitási szimmetria a paritásbit (mély/magas hangrend, AGENTS §00) zenei megfelelője.

### 3.2. La campanella — Grandes études de Paganini No. 3, gisz-moll, S.141/3 (1851)

- **Mit:** Paganini h-moll hegedűversenyének (2. verseny) utolsó tételéből („Rondó à la clochette", 6/8-os rondó, ABACA) átemelt, „kisharang"-motívumra épülő etűd.
- **Fő motívum / kottából:** a nyitás **csupasz disz-oktávok** (harangütés), majd hosszú szünet; a dallam a jobb kéz alsó szólamában indul, felette a **disz harangszó sztatikatóval** ugrik akár két oktávot (15-ök és 16-ok: a 30. és 32. ütemben). Hang Hz-ben: Disz6 = 1244,51 Hz; Disz7 = 2489,02 Hz — a „harang" kvázi fix frekvenciájú referenciator az etűdben.
- **Ritmus/képlet:** Allegretto, 6/8; a harang-motívum ismétlődő tizenhatodai ugrásokkal; a második téma H-dúrban; a koda Animato, fortissimo fanfár.
- **Hangnem és forma:** gisz-moll (az 1838-as S.140-es verzió asz-moll volt, az 1851-es átdolgozásban enharmonikusan gisz-moll); szerkezet: Bevezetés (1–4) → I. szakasz (5–42) → II. (43–78) → III. (79–120) → IV. (120–128) → Koda (129–139); témavariációs, nem rondó.
- **Források:** https://imslp.org/wiki/Grandes_%C3%A9tudes_de_Paganini,_S.141_(Liszt,_Franz) · https://en.wikipedia.org/wiki/La_campanella · https://so04.tci-thaijo.org/index.php/mmj/article/download/272822/184897 · https://www.allmusic.com/composition/la-campanella-ii-etude-for-piano-in-g-sharp-minor-grand-paganini-%C3%A9tude-no-3-s-141-3-lw-a173-3-mc0002447046
- **Tanulság:** a rögzített haranghang (Disz) **órajel** — a szélsőséges ugrások (információ) mögött állandó referenciafrekvencia. Ez pontosan a projekt „három kubit"-modellje (AGENTS §5): saját (megszólaltatott hang), másik (ugró kíséret), fázis (a harang = kapcsolattartó periodicitás).

### 3.3. III. Liebestraum (Szerelmi álom), Asz-dúr, S.541/3 (1850)

- **Mit:** „O lieb, so lang du lieben kannst" — Freiligrath versére 1847-ben írt dal (S.298) 1850-es zongora-átirata; a három Liebestraum („Drei Notturnos") leghíresebbike.
- **Fő motívum / kottából:** a dallam (a kottában a kíséret arpeggiói közé „elágyazva", tenor-regiszterben, két kéz között megosztva) 3. ütemétől indul: **C4–C4–Desz4–C4** (forrás: PTNA elemzés szó szerint idézi a 3. ütemet: „The melodic line is C C D-flat C"); a visszatérésnél (83. ütem): „C B C Esz Desz C C". Az alapzat Asz-dúr arpeggio. Hang Hz-ben: C4 = 261,63 Hz; Desz4 = 277,18 Hz; Asz4 = 415,30 Hz.
- **Ritmus/képlet:** folyamatos, éneklő (cantabile) dallamfölötti arpeggio-hullámzás; két kadencia („quasi cadenza") választja el a szakaszokat; a B szakaszban a dallam oktávokban, szenvedélyes csúcsponton.
- **Hangnem és forma:** Asz-dúr; A (1–24) → kadencia → B (B-dúr → C-dúr → Asz/Esz, 26–57) → II. kadencia → A′ (61–76) → koda; hajlékony háromszakaszos (A–B–A′) forma.
- **Források:** https://imslp.org/wiki/Liebestr%C3%A4ume,_S.541_(Liszt,_Franz) · https://enc.piano.or.jp/en/musics/23749 · https://opensiuc.lib.siu.edu/cgi/viewcontent.cgi?article=1017&context=music_gradworks · https://dominantninthchord.blogspot.com/2022/06/liszt-liebestraume-no-3.html
- **Tanulság:** a dallam **redundánsan kódolt** (két kéz, oktávok, arpeggio-burkolat) — a zaj elleni védelem a többszörözés. A domináns nonszám (dúr 9-es akkord, a 9=C tartós feloldása) a „felfüggesztett információ" zenei alakja: a feloldás késleltetése = feszültségbit.

### 3.4. h-moll zongoraszonáta, S.178 (1852–53)

- **Mit:** Liszt legnagyobb zongoraműve; egymásba olvadt, egyműves szonáta — klasszikus szonátaforma és négy tétel (allegro–adagio–scherzo–finale) **egy** ívben („kettős funkció").
- **Fő motívum / kottából (1. oldal = mindháram csíra):**
  1. **Téma 1** (Lento assai, 1. ütem): **szinkópált, kétszer megismételt G**, majd **lefelé haladó fríg/cigány skála** (Hamilton elemzése: „the note G, syncopated and repeating twice, starts theme one's descending Phrygian and gypsy scales"). G3 = 196,00 Hz.
  2. **Téma 2** (Allegro energico, 8. ütem): hirtelen **oktávugrás + zuhanó tripla** — a G-n indul, engesztelhetetlen, kihívó karakter.
  3. **Téma 3** (13. ütem): **Hammerschlag** (kalapácsütés) — egyetlen hang merev ismétlése.
- **Ritmus/képlet:** Lento assai (szabad, szinkópált) ↔ Allegro energico (dúr pontozott oktávok) ↔ kalapács-ismétlés; a feldolgozásban fuga (460. ütem), a végén a három téma **tükrözött sorrendben** (3–2–1) tér vissza — palindrom zárás.
- **Hangnem és forma:** h-moll; intró (1–31), expozíció (32–330; Grandioso D-dúrban 105-től), feldolgozás (Andante sostenuto Fisz-dúr, 331-től; fuga 460), repríz (533–681), koda (682–760); a komponálás módszere a **tematikus metamorfózis** (Berlioz „idée fixe"-nyomán).
- **Források:** https://imslp.org/wiki/Piano_Sonata_in_B_minor,_S.178_(Liszt,_Franz) · https://en.wikipedia.org/wiki/Piano_Sonata_in_B_minor_(Liszt) · https://www.classicalmusic-notes.com/liszt-sonata-1/ · https://www.classicalmusic-notes.com/liszt-sonata-2/ · https://enc.piano.or.jp/en/musics/561
- **Tanulság:** **három morfizmus-generátor** (motívum) feszti ki az egész művet — a témák nem „ témák", hanem **transzformábilis típusok**; a záró tükör (3–2–1) a CPT-tükrözés (AGENTS §9, P = paritás/tér-tükrözés) zenei alakja. Minden új téma az előző utolsó hangján „kapaszkodik" (G-lánc) — ez lánc-kompozíció, mint a trans (bizonyítás-lánc).

### 3.5. Esz-dúr zongoraverseny, S.124 (1830–1855)

- **Mit:** négy, átmenet nélkül összefolyó tétel; a témák végig metamorfózissal egymásba olvadnak — Bartók később „a ciklikus szonátaforma első tökéletes megvalósításának" nevezte.
- **Fő motívum / kottából:** a zenekar hatalmas, harsány, **kíséret nélküli unisono mottója** nyit (Liszt és Bülow csúfolódó szavai: „Das versteht ihr alle nicht, haha!" — az első két ütem hangjaira); a zongora négy oktávon átfutó oktávmenetekkel lép be; lassú tétel: új téma a mély vonósokon; III. tételt a **hangvilla** (triangle) nyitja. Hang Hz-ben: Esz4 = 311,13 Hz (alaphangnem).
- **Ritmus/képlet:** a mottó éles, minden ütemre kihangsúlyozott **ismétlő kordacsapás**-ritmusa; III. tétel: könnyű, táncos scherzo-ritmus hangvillával; a finálé poliritmusa: a zongora **tizenhatodokat és triola-nyolcadokat egyszerre** játszik unisonóban a vonósokkal.
- **Hangnem és forma:** Esz-dúr; I. Allegro maestoso (Esz) → II. Quasi adagio (H-dúr) → III. Allegretto vivace – Allegro animato (esz-moll) → IV. Allegro marziale animato (Esz); a nyitó 27 ütem nem kadenciázik Esz-dúrban — szándékosan instabil, „középről induló" harmonikus szerkezet.
- **Források:** https://imslp.org/wiki/Piano_Concerto_No.1,_S.124_(Liszt,_Franz) · https://en.wikipedia.org/wiki/Piano_Concerto_No._1_(Liszt) · https://houstonsymphony.org/liszt-piano-concerto-1/ · https://www.sfsymphony.org/Data/Event-Data/Program-Notes/F/Franz-(Ferenc)-Liszt-Piano-Concerto-No.-1-in-E-flat · https://www.bso.org/works/piano-concerto-no-1-3
- **Tanulság:** **ciklikus forma = egyetlen generátor rendszeres újraszólaltatása** (a mottóból lesz cantabile, recitativo, induló). A hangvilla (perkuszió mint szólista) a „protokoll-réteg" bővítése: új csatorna, új kód.

---

## 4. BARTÓK Béla (1881–1945) — hat mű / 六部作品 / sechs Werke / שש יצירות

### 4.1. Allegro barbaro, BB 63 / Sz.49 (1911)

- **Mit:** a „barbár" cím a párizsi kritikusok csúfolódására („barbare") adott válasz; ütőhangszeres zongorastílus, román-magyar népzenekutatás csírája; 214 ütem.
- **Fő motívum / kottából:** az első 4 ütem **osztinátó**-nyitása: a két kéz **váltakozva** üt ütéseket (ütőhangszer-játékot utánozva); a nyitódallam **pentaton** — az első 22 hang cellája **egész hang + kis terc** (a pentaton skála építőeleme), fríg módusz-részletet is használ; a szerkezet **Fisz**-középpontú (első tematikus terület Fisz, második F, a visszatérés Fisz).
- **Ritmus/képlet:** alaptempó félhangonként 76–84 (Bartók saját, 1929-es felvételén ~96); **sff accenssel** tört ritmus, a kadenciák szabálytalanul „csalnak" — meglepetés-elv; Bartók a kottánál rövidebb osztinátószakaszokat játszott (Henle-forrás).
- **Hangnem és forma:** Fisz-központ (Lendvai: Fisz-moll ↔ C-dúr **tengely-polárissága**); A–B–A′ háromszakaszos (forrás: Wikipedia-elemzés), más forrás rondo-karaktert említ három ritmikus témára.
- **Források:** https://imslp.org/wiki/Allegro_barbaro%2C_Sz.49_(Bart%C3%B3k,_B%C3%A9la) · https://en.wikipedia.org/wiki/Allegro_barbaro_(Bart%C3%B3k) · https://enc.piano.or.jp/en/musics/898 · https://symmetry-us.com/Journals/lends/ch1.htm · https://blog.henle.de/en/2016/04/18/a-peek-through-the-keyhole%E2%80%93-bartok%E2%80%99s-%E2%80%9Callegro-barbaro%E2%80%9D-as-forerunner-of-the-complete-edition/
- **Tanulság:** az **osztinátó = ismétlődő kódszó**: rögzített ritmus-minta, amely fölött a dallam (információ) változik. A Fisz–C tritónusz-polaritás (Lendvai tengelyrendszer) pontosan a projekt tritónusz-kettősége (Zene húros hangszerekre: A↔Esz) előfutára.

### 4.2. Román népi táncok, BB 68 / Sz.56 (zongora 1915; zenekari átirat Sz.68, 1917)

- **Mit:** hat, erdélyi gyűjtésű néptánc zongorára írott feldolgozása (később saját zenekari átirata) — a népzenekutatás és a koncertstílus ötvözete.
- **Táncok, hangnemek, móduszok (forrás: Wikipedia-táblázat):**
  1. *Bot tánc / Jocul cu bâtă* — a-moll (dór/aiól, A-központ), Allegro moderato ♩=104, kéttagú (bináris) forma; a B szakasz pontozott ritmusa a bot cerezését idézi.
  2. *Brâul (övtánc)* — d-moll (dór), ♩=144.
  3. *Topogó / Pe loc (Egy helyben)* — h-moll, „román moll" skála (aiól + bővített szekund D–Eisz, arab skála-hatás), Andante; dudakísérret-szerű pedál.
  4. *Bucsumí tánc / Buciumeana* — A-dúr, fríg domináns, Moderato, 3/4.
  5. *Román polka / Poarga Românească* — D-dúr, **líd**, ♩=152; a **2/4 ↔ 3/4 váltakozó mérő** az egész táncban.
  6. *Aprózó / Mărunțel* — D-dúr→A-dúr (líd/mixolíd/dór), két dallam + koda, attacca.
- **Ritmus/képlet:** giusto (szigorúan mért) táncritmus; mind 2/4, kivéve a 4. (3/4) és az 5. (2/4↔3/4); a sorozat **lassúról gyorsra** fut fel (tánclánc-elv, ♩=104→152→160).
- **Források:** https://imslp.org/wiki/Romanian_Folk_Dances,_Sz.56_(Bart%C3%B3k,_B%C3%A9la) · https://imslp.org/wiki/Romanian_Folk_Dances_(orchestra)%2C_Sz.68_(Bart%C3%B3k,_B%C3%A9la) · https://en.wikipedia.org/wiki/Romanian_Folk_Dances · https://gianmariagriglio.com/bartok-rumanian-folk-dances/ · https://scholarsarchive.byu.edu/cgi/viewcontent.cgi?article=12055&context=etd
- **Tanulság:** a **módusz = bitkészlet**: dór/aiól/fríg/líd skálák különböző információtartalmú „ábécék". Az 5. tánc 2/4↔3/4 váltakozása **kvantum-ugrás** az időrácsban — a páratlan mérő előrejelzése a bolgár ritmusoknak (4.3).

### 4.3. Mikrokozmosz, Sz.107 — válogatás: 148–153. „Hat tánc bolgár ritmusban" (1940, VI. kötet)

- **Mit:** a 153 darabos, hatkötetes pedagógiai életmű (1926–1939) — Bartók „zongoristát nevelő" rendszere, a saját stílus mikrokozmosza; válogatásunk a VI. kötet záró hat bolgár ritmusú tánca.
- **Fő motívum / ritmus (kottából):** az **additív bolgár mérő**: az első tánc mérője **4+2+3 nyolcad** (forrás: Lin disszertáció Bartók Guide to the Mikrokosmos-kommentárjából idézve); a hangsúlyok az egységek első hangján, a **harmadik egységet a legerősebb accentussal**; a negyedik tánc 3+2+3 nyolcad alapon a jobb kéz **1+2+2+2+1** eltoló szinkópát játszik. A Mikrokozmosz összesen **636 szinkópamintát** tartalmaz (Lin-féle megszámlálás).
- **Hangnem/forma:** darabonként változó (a bolgár ritmusú táncok többnyire egy-egy modális/kromatikus középpont köré épülnek); a hat darab táncláncot alkot.
- **φ-kapcsolat:** Lowman (Fibonacci Quarterly, 1971) szerint a VI. kötet több darabjában az **aranyarány** kijelöli a fontos szerkezeti pontot: „Free Variations" (139.) — a molto piú calmo; „From the Diary of a Fly" (142.) — a csúcspont; „Divided Arpeggios" (144.) — a visszatérés.
- **Források:** https://imslp.org/wiki/Mikrokosmos,_Sz.107_(Bart%C3%B3k,_B%C3%A9la) · Lin Chieh-An disszertáció ( https://dissertations.umi.com/ku:15987 ) · https://www.fq.math.ca/Scanned/9-5/lowman-a.pdf
- **Tanulság:** a **4+2+3 additív mérő = nem-additív időkódolás**: 9 nyolcad nem 3×3, hanem 4+2+3 — a felbontás maga a jelentés. Ez a Mondat-réteg ritmus-láncának (6. szakasz) prototípusa: a toldalékok hossza nem egyenletes, hanem jelentéshordozó.

### 4.4. Zene húros hangszerekre, ütőkre és cselesztára, Sz.106 (1936)

- **Mit:** Bartók központi mesterműve; kettős vonószenekar között áll a zongora–cseleszta–hárfa csoport és az ütők (Lendvai leírása a színpadi elhelyezésről), a mű címe a hangszercsoportokat sorolja fel.
- **Fő motívum / kottából:** az I. tétel (Andante tranquillo) **fúgatémája a brácsán A3-ról indul** (A3 = 220,00 Hz); az első két szegmens azonos, **A–B–Desz**-hangokkal (rendezett hangosztály-hármas: 9–T–1); a téma a **kromatikus A–E (tritónusz) tartomány összes félhangját** bejárja (nyolc egymás utáni félhang, A3–E4), a kontúr csúcsa **Esz** (Esz4 = 311,13 Hz), majd vissza A-ra. A hangnemi építkezés **kvintkörön** halad: a belépések felváltva kvinttel fel (A→E→H→Fisz…), majd le (A→D→G→C…), a legtávolabbi ponton **Esz-dúrban** találkoznak (Bartók saját, 1937. április 10-i levéléből).
- **Ritmus/képlet:** **szüntelenül váltakozó mérők** (5/8, 6/8, 7/8, 8/8, 9/8, 10/8, 11/8, 12/8); az első ütem belső tagolása pl. **3+3+2**, a másodiké 3+3+3+3; az I. tétel összesen **705 nyolcadot** tartalmaz; dinamikai ív: pp → fff (csúcspont az 55/56. ütem végén, Esz-en) → ppp (olló-fúga / „scissor fugue").
- **Hangnem és forma (Bartók levele alapján):** I. tétel A-ban (szigorú fúga; expozíció után a téma inverzióban tér vissza A-ra, rövid kódával); II. C-ben (szonátaforma); III. Fisz-ben („hídforma" A–B–C–B–A, gyászzene); IV. A-ban (a fúgatéma **kiterjesztett diatonikus** alakban tér vissza).
- **Források:** https://imslp.org/wiki/Music_for_Strings,_Percussion_and_Celesta,_Sz.106_(Bart%C3%B3k,_B%C3%A9la) · https://www.universaledition.com/en/Works/Music-for-String-Instruments-Percussion-and-Celesta/P0027295 (Bartók levele) · http://www.jordanrsmith.com/blog/2013/12/9/analysis-bartok-music-for-strings-percussion-and-celeste-mvt-i · https://edisciplinas.usp.br/pluginfile.php/4299575/mod_resource/content/1/Symmetry%20as%20a%20compositional%20determinant%20%28SOLOMON%202002%29.pdf
- **Tanulság:** a téma A-tól Eszig és vissza — **tritónusz-szimmetria A körül**; a hangnemi út (kvintkör mindkét irányban) és a forma (tükrözött fúga) ugyanazt a szerkezetet írja kétszer: **horizontálisan és vertikálisan**. Ez a projekt [[7,1,3]] kódjának paritás-szimmetriájával rokon gondolkodásmód (oszthatatlan szerkezeti ön-hasonlóság). A pontos aránymatematika az 5. szakaszban.

### 4.5. Concerto (Zenekari koncert), Sz.116 (1943, Boston/Koussevitzky)

- **Mit:** az amerikai időszak összefoglaló műve — „zenekari koncert": minden hangszer szólistaként léphet fel.
- **Fő motívum / kottából:** az I. tétel (Introduzione) lassú bevezetése **pentaton, egymásba kapcsolódó kvartokból** emelkedik (ez a gyászdallam csírája); az Allegro vivace fő témája (76. ütemtől) **öt hangos, oktafon skálaszakasz**, amely **tritónus-távolságot** ölel át, mögötte kvartokba kapaszkodó tetrakord (5:2:5 félhang-szerkezet) — az I. tétel első témája **3/8 és 2/8 váltakozó** mérőben jár.
- **Ritmus/képlet:** a II. tétel (Presentando le coppie / Giuoco delle coppie — „párok játéka") **dobkíséretes, 2/4-es lánc-táncok**: fagottok **szextekben**, oboák **tercekben**, klarinétok **szeptimekben**, fuvolák **kvintekben**, tompított trombiták **nagy szekundokban** — öt pár, öt különböző köz; a IV. tétel (Intermezzo interrotto) a banális „dalszerű" dallamot **elküldözött** katonazene szakítja meg (Sosztakovics-paródia).
- **Hangnem és forma:** öttételes **ívforma (arch form)**: I. szonátaforma (F-központ) — II. lánc-scherzo — III. Elegia (Andante, „éjszakai zene", anyaga az I. intro anyaga) — IV. ABCBA — V. Finale (Presto, perpetuum mobile + trombita-fúga); a két gyors külső tétel fogja az ívet.
- **Források:** https://imslp.org/wiki/Concerto_for_Orchestra,_Sz.116_(Bart%C3%B3k,_B%C3%A9la) · https://en.wikipedia.org/wiki/Concerto_for_Orchestra_(Bart%C3%B3k) · https://mural.maynoothuniversity.ie/id/eprint/9479/1/Musicology%202%20Byrne.pdf · https://www.minnesotaorchestra.org/stories/extended-program-note-bartok-concerto-for-orchestra · https://www.indianapolissymphony.org/backstage/program-notes/bartok-concerto-for-orchestra/
- **Tanulság:** az **ívforma = időtükrözés**: a szimmetria nem a hangok, hanem a FORMA szintjén áll (A–B–C–B–A). A „párok játéka" pedig **páronkénti kódolás** (öt pár × öt köz) — diszkrét, kombinatorikus csatornaválasztás, mint a Steane-kód bit-párosításai.

### 4.6. A csodálatos mandarin, pantomim, Sz.73 (1918–24; premier: Köln, 1926. november 27.)

- **Mit:** Lengyel Menyhért pantomimjára írt „zenei dráma" — a nagyvárosi káosz, a kizsákmányolás és a beteljesülés halálos szeretete; a kölni bemutató (1926. november 27.) botránya után Adenauer betiltotta, és koncertszvitként élt tovább.
- **Fő motívum / kottából:** a nyitás **másodhegedűs osztinátója**: felfutó **G-dúr skála bővített oktávval** (G–A–H–C–D–E–Fisz–Gisz; a Gisz tetőpont után vissazuhan G-re) — kb. 34 ütemen át, 6/8-ban; a 3. ütemtől **kis szekundokban játszott 6/8-os erőszak-motívum** (a csavargók tetteinél tér vissza); a mandarin belépése: harsona **pentaton téma** párhuzamos tritónusokkal; a mandarin „aláíró középe": **leszálló kis terc Asz–F** (korábbi forrásokban bővített szekund Gisz–F); a lánc (chase) **fúgája** szintén pentaton tárgyú.
- **Ritmus/képlet:** hajtott 6/8-os metró-ritmus (kb. 34 ütem ≈ 34 mp a metronóm-jelzés szerint); a félénk ifjú tánca **5/4-ben**; a lány tánca keringő-utalással (Tempo di Valse); a vég csupasz kisterc-gliszandókkal és aritmiikusan „elakadó" zárás.
- **Hangnem és forma:** tonális középpont: G (a G-pedál + osztinátó skála), de szándékosan elmosódva — a generátor skála (P4, tritónusz, bővített oktáv, kis none) adja az összes melódia-harmónia anyagát; forma: nagyvárosi intro → három csábszerző tánc (klarinet-szólók) → a lány tánca → a mandarin üldözése (fúga) → gyilkossági kísérletek → beteljesülés és halál.
- **Források:** https://imslp.org/wiki/A_csod%C3%A1latos_mandarin_(Bart%C3%B3k,_B%C3%A9la) · https://sin80.com/en/work/bartok-miraculous-mandarin · https://orchestrasounds.com/2014/07/24/29-bartoks-miraculous-mandarin/ · https://www.berliner-philharmoniker.de/en/programme-notes/bela-bartok-the-miraculous-mandarin-suite-sz-73/ · https://www.akjournals.com/view/journals/6/60/1-4/article-p23.xml
- **Tanulság:** a **generátor-skála** (explicit, mű eleji anyag) = a német dodekafónia mellett egy másik út: nem 12 egyenrangú hang, hanem egy **aszimmetrikus skála-intervallumkészlet**, amiből minden építkező. A „saját + generátor" elv épp a projekt E8-gyökrendszer-logikájával analóg: kevés generátor → magas redundancia (AGENTS §7).

---

## 5. Bartók és az aranyarány — Lendvai elemzése, kritikája, és a projekt φ-jelenségei / 巴托克与黄金分割 / Bartók und der Goldene Schnitt / בארטוק ויחס הזהב

### 5.1. Mit állít Lendvai (dokumentált forrásokkal)

1. **Lendvai Ernő** 1955-től publikálta elemzéseit; könyvformában: *Bartók's Style…* / *The Workshop of Bartók and Kodály*; a részletes futuga-elemzés a Zene húros hangszerekre… I. tételéről vált híressé.
2. **A klasszikus adatsor** (Roberts JMM-2021 előadás-kivonata és Jones-dolgozat alapján):
   - a mű **89 ütem** hosszú (Lendvai; a kottában 88 — l. 5.2),
   - a dinamikai csúcspont (fff) az **55. ütem végén** → 89 = 55 + 34 (szomszéd Fibonacci-számok; 55/89 ≈ 0,618 ≈ φ),
   - a **34. ütemben** kerülnek le a vonósok sordinói (55 = 34 + 21),
   - a fúgaexpozíció **21 ütem** után zárul (34 = 21 + 13),
   - a sordinok visszatétele a 69. ütemben (34 = 13 + 21), az utolsó 21 ütem 13 + 8 arányban bomlik.
3. **III. tétel**: a nyitó **xilofon-szóló ritmusa** kifejezetten Fibonacci-minta: **1, 1, 2, 3, 5, 8, 5, 3, 2, 1, 1** — crescendo–decrescendo, retrográd szimmetriával (Roberts; Mongoven).
4. **További művek**: Szonáta két zongorára és ütőkre (a I. tétel 443 üteme; a repríz a 274. ütemnél, 443·0,618 ≈ 274 — Lowman), Concerto, Divertimento; Mikrokozmosz VI. kötet (4.3 pont).
5. Lendvai emellett a **tengelyrendszert** (axis system) is kidolgozta: a tonális funkciók a kvintkör harmadolásán (nagyterc-tengely: C–E–Asz) járnak; az Allegro barbaro Fisz-moll ↔ C-dúr poláris-párja ennek része.

### 5.2. A kritika — Howat és a pontos számok (őszinteség, AGENTS §17–18)

1. **Roy Howat** újramérése (Roberts előadásában összefoglalva):
   - a kotta **88 ütem** (Lendvai egy egész-ütemes szünetet toldott hozzá a Bülow–Beethoven-analógiák mintájára),
   - a dinamikai csúcspont (fff) valóban az **55. ütem végén** van, de a **tonális csúcspont a 44. ütem** (a téma Esz-en, tritónusznyira A-tól; 88/2 = 44 — szimmetria!),
   - a sordinóleszedések **33/34/35. ütemek** között oszlanak meg (nem egyetlen 34-nél),
   - az expozíció a **20. ütemben** zárul (nem 21),
   - a **cseleszta a 77. után** lép be (Lendvai nem említi; 77 − 55 = 22, nem Fibonacci).
2. **Nyolcadokban mérve**: az I. tétel 705 nyolcadot tartalmaz; a φ-pont a 436. nyolcadnál (54. ütem közepe) esik — kb. két ütemmel a mért csúcspont előtt (Howat).
3. **Mongoven** (2010) független mérése viszont **időtartam alapján** (ajánlott temposzámok átlagával) a csúcspontot **~1/1000 pontossággal** az aranyarányra illeszkedőnek találta.
4. **Tanulság (a projekt szemszögéből)**: az arányok attól függenek, **mit mérünk** (ütem? nyolcad? másodperc?) és **mit nevezünk csúcspontnak** (dinamikai? tonális?). Ez a mérési hiba-kötelezettség (AGENTS §17) tükre: a Δ/σ jelentés nélkül „σ-számok" értelmezhetetlenek — itt is a mérték (ütem vs. nyolcad vs. idő) explicit megadása nélkül a „φ-bizonyítás" üres. Roberts végkonklúzója: a szimmetria (Esz-közeppont, inverzió, Lucas-számok) a movement ereje, a szigorú Fibonacci-olvaszat pedig túlfeszített.
5. **Bartók hallgatása**: kézirataiban nincs írásos nyom a φ-használatról; kortársai tanúsága szerint titkolta módszereit — ezért minden φ-állítás ** posteriori mérés**, nem dokumentumokkal igazolt szándék (Roberts; Mongoven).

### 5.3. A projekt φ-jelenségeivel való kapcsolat — ŐSZINTÉN jelölve

1. **BIZONYÍTOTT (fizika, mérés)**: Coldea és munkatársai (Science 327, 177–180, 2010. január 8., DOI: 10.1126/science.1180085) a CoNb2O6 izing-lánc kvantumkritikus pontja közelében **két meredek gerjesztést** (m1, m2) mértek neutronszórással; az **m2/m1 arány a kritikus mező (5,5 T) közelében az aranyarányhoz (φ = (1+√5)/2 ≈ 1,618) közeledik** — Zamolodcsikov 1989-es E8-előrejelzésének kísérleti igazolása. A teljes E8-spektrum nyolc részecskét jósol; az első kettő aránya φ. Forrás: https://www.science.org/doi/10.1126/science.1180085 és https://physicsworld.com/a/e8-symmetry-spotted-in-ultracold-magnet/
2. **ANALÓGIA (zenei szerkezet, nem fizika)**: Bartók arány-szerkezetei (5.1) formai/mérési jelenségek — a φ ott **kompozíciós arány**, itt **gerjesztési tömegspektrum arány**. A kettő között **nincs bizonyított közös mechanizmus**; a párhuzam az, hogy φ és a Fibonacci-számok **mindkét területen dokumentáltan** megjelennek. A projekt E8-affin tömegspektrumának φ-hatvány-szerkezete (saját kutatásunk) fizikai tartalmú; a Bartók-φ zenei-történeti tartalmú.
3. **MI A KÖZÖS MÓDSZERTAN (valódi átvihető tanulság)**: mindkét esetben a **mérés pontosságának és a mérték egységének explicit megadása** dönt (Howat/Mongoven vitája ↔ AGENTS §17 Δ/σ-kötelezettség); és mindkét esetben **kevés generátor** hoz létre gazdag, önhasonló struktúrát (E8 affin algebra ↔ Bartók generátor-skálái, tengelyrendszer). A Szima-projektben a φ-megjelenéseket továbbra is **kettős fedéssel** kell bizonyítani (AGENTS §18.4: Idris-bizonyítás + numerika + irodalom) — a zenei példa emlékeztet, hogy a szép arány még nem bizonyítás.

---

## 6. Zárszó — mit ad a Szima nyelvi magának / 结语 / Schluss / סיכום

1. **Ritmus-lánc a Mondat-réteghez**: a magyar agglutináció (tő + toldalékok) időben kibomló, hierarchikus lánc; a bolgár ritmus (4+2+3) azt mutatja, hogy a **toldalékhossz nem egyenletes, hanem információt hordoz**. A Mondat-réteg tervezett ritmus-lánca: a szótag/toldalék hosszát a [[7,1,3]] kód idő-bitjéhez kötni — a mérő (4+2+3) modellje lehet a mondathangsúly-hullám kvantálása.
2. **Órajel és redundancia** (La campanella haranga; Allegro barbaro osztinátója): minden koherens rendszer **referencia-periodicitást** tart fenn, amely fölött az információ változik — a projektben ez a szívverés (szivdobbanas-skill) és a fázisbit.
3. **Generátor-gazdagság** (h-moll szonáta 3 motívuma; Mandarin generátor-skálája; E8 gyökrendszer): kevés generátor → magas önhasonlóság → j javíthatóság. A zene szerint a leggazdagabb forma a **legkevesebb anyagból** épül (MSPC: egyetlen fúgatéma, nulla epizód).
4. **Tükrözés és ívforma** (szonáta 3–2–1 zárása; Concerto A–B–C–B–A íve; MSPC inverziós fúgája): a CPT tükrözés (AGENTS §9) zenei megfelelője — az időbeli forma is hordozhat paritás-szimmetriát.
5. **A mérés fegyelme** (Lendvai–Howat–Mongoven): minden arány-állításhoz mérőszám, egység és hibahatár kell — ez a projekt §17-es szabályának a zenében is megtanult igazolása.

---

## 7. Négy nyelvű összefoglaló / 四种语言总结 / Vier sprachige Zusammenfassung / תקציר רב-לשוני

**Magyar:** A dokumentum tizenegy művet elemez forrásmegadással (5 Liszt + 6 Bartók): fő motívumok kottából dokumentált hangjai (pl. Liebestraum: C–C–Desz–C; MSPC fúgatéma: A3-ról, A–B–Desz nyitás, kromatikus A–E tartomány; Mandarin: G-dúr skála bővített oktávval), ritmusképletek (lassan–friska; bolgár 4+2+3; Fibonacci-xilofon 1,1,2,3,5,8,5,3,2,1,1), hangnemek és formák, Hz-táblával (A4=440, Idris-számítás). A Lendvai-féle aranyarány-elemzést a Howat-féle kritikával és Mongoven időtartam-mérésével együtt, őszintén mutatjuk be; a Coldea 2010 E8/φ-mérés **bizonyított fizika**, a Bartók-φ **zenei analógia** — közös mechanizmus nincs bizonyítva, közös módszertan (mérési fegyelem, generátor-elv) viszont igen.

**中文：** 本文以逐条注明出处的方式分析了十一部作品（李斯特五部、巴托克六部）：乐谱中记载的主导动机音列、节奏型（慢—快段落；保加利亚 4+2+3 节奏；斐波那契木琴节奏）、调性与曲式，并附频率表（A4=440，用 Idris 计算）。我们诚实地并列了伦德魏的黄金分割分析、豪厄特的批评与蒙戈芬的时长测量：Coldea 2010 的 E8/φ 实验是已被证实的物理，而巴托克的 φ 只是音乐类比——并无已证的共同机制，但共同的方法论（测量纪律、生成元原则）确实存在。

**Deutsch:** Elf Werke (fünf von Liszt, sechs von Bartók) werden quellenbasiert analysiert: dokumentierte Motivtöne aus den Partituren, Rhythmusmodelle (Lassan–Friska; bulgarischer Rhythmus 4+2+3; Fibonacci-Xylophonmuster), Tonarten und Formen, mit Frequenztabelle (A4 = 440 Hz, in Idris berechnet). Lendvais Goldener-Schnitt-Analyse wird ehrlich neben Howats Kritik und Mongovens Dauermessung gestellt: Coldeas E8/φ-Experiment (2010) ist bewiesene Physik, Bartóks φ ist eine musikalische Analogie — ein gemeinsamer Mechanismus ist nicht bewiesen, eine gemeinsame Methodik (Messdisziplin, Generatorprinzip) jedoch schon.

**עברית:** אחת-עשרה יצירות (חמש של ליסט, שש של בארטוק) נותחו עם מקורות: צלילי מוטיבים מתועדים מן הפרטיטורות, תבניות קצב (לסאן–פריסקה; קצב בולגרי 4+2+3; תבנית פיבונאצ'י לקסילופון), סולמות וצורות, עם טבלת תדירויות (A4=440, חישוב ב-Idris). ניתוח יחס הזהב של לנדוואי מוצג ביושר לצד ביקורת האואט ומדידת הזמן של מונגובן: ניסוי E8/φ של Coldea (2010) הוא פיזיקה מוכחת; ה-φ של בארטוק הוא אנלוגיה מוזיקלית — מנגנון משותף לא הוכח, אך מתודולוגיה משותפת (משמעת מדידה, עקרון גנרטור) אכן קיימת.

---

## 8. Forrásjegyzék (teljes URL-lista)

**IMSLP (kották):**
- https://imslp.org/wiki/Hungarian_Rhapsody_No.2,_S.244/2_(Liszt,_Franz)
- https://imslp.org/wiki/Grandes_%C3%A9tudes_de_Paganini,_S.141_(Liszt,_Franz)
- https://imslp.org/wiki/Liebestr%C3%A4ume,_S.541_(Liszt,_Franz)
- https://imslp.org/wiki/Piano_Sonata_in_B_minor,_S.178_(Liszt,_Franz)
- https://imslp.org/wiki/Piano_Concerto_No.1,_S.124_(Liszt,_Franz)
- https://imslp.org/wiki/Allegro_barbaro%2C_Sz.49_(Bart%C3%B3k,_B%C3%A9la)
- https://imslp.org/wiki/Romanian_Folk_Dances,_Sz.56_(Bart%C3%B3k,_B%C3%A9la)
- https://imslp.org/wiki/Romanian_Folk_Dances_(orchestra)%2C_Sz.68_(Bart%C3%B3k,_B%C3%A9la)
- https://imslp.org/wiki/Mikrokosmos,_Sz.107_(Bart%C3%B3k,_B%C3%A9la)
- https://imslp.org/wiki/Music_for_Strings,_Percussion_and_Celesta,_Sz.106_(Bart%C3%B3k,_B%C3%A9la)
- https://imslp.org/wiki/Concerto_for_Orchestra,_Sz.116_(Bart%C3%B3k,_B%C3%A9la)
- https://imslp.org/wiki/A_csod%C3%A1latos_mandarin_(Bart%C3%B3k,_B%C3%A9la)

**Elemzések, lexikonok:** en.wikipedia (Hungarian Rhapsody No. 2; La campanella; Piano Sonata in B minor; Piano Concerto No. 1; Allegro barbaro; Romanian Folk Dances; Concerto for Orchestra) · romarchive.eu · pianotv.net · andantemoderato.com · PTNA enc.piano.or.jp (971, 982, 23749, 561, 898) · so04.tci-thaijo.org (La campanella tanulmány) · allmusic.com · opensiuc.lib.siu.edu (Aldach) · dominantninthchord.blogspot.com · classicalmusic-notes.com (Liszt-szonáta 1–2. rész) · houstonsymphony.org · sfsymphony.org · bso.org · universaledition.com (Bartók levele, 1937. 04. 10.) · jordanrsmith.com · edisciplinas.usp.br (Solomon 2002) · symmetry-us.com (Lendvai: Axis System; Quadrophonic Stage) · gianmariagriglio.com · scholarsarchive.byu.edu · dissertations.umi.com (Lin) · mural.maynoothuniversity.ie (Byrne) · minnesotaorchestra.org · indianapolissymphony.org · njsymphony.org · sin80.com · orchestrasounds.com · berliner-philharmoniker.de · akjournals.com · blog.henle.de · etd.ohiolink.edu (Mandarin disszertáció)

**Aranyarány / Fibonacci / E8:** meetings.ams.org/math/jmm2021/mediafile/Handout/Paper3109/Bartok_JMM2021_Roberts.pdf (Roberts) · mathcs.holycross.edu/~groberts (Bartók and the Golden Section; The Bartók Controversy) · blogs.ams.org (Hershberger: Did Bartók use Fibonacci numbers?) · scholarworks.calstate.edu / hdl.handle.net/10211.3/137778 (Jones) · mat.ucsb.edu/Publications/mongoven_CongressusNumerantium2010.pdf (Mongoven) · fq.math.ca/Scanned/9-5/lowman-a.pdf (Lowman) · science.org/doi/10.1126/science.1180085 (Coldea et al. 2010) · physicsworld.com/a/e8-symmetry-spotted-in-ultracold-magnet/

**Saját számítás:** `/var/folders/cw/4jhpxnwn47d7y4jyg2zgvpx80000gn/T/opencode/Hangfrekvencia.idr` (Idris 2, egyenletes hangolás, A4 = 440 Hz) — kimenete a 2. szakasz táblázata.
