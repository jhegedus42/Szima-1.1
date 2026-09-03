# Kutatási napló — 2026-09-03 — 100.06 KettőKategória + GAN + NR1 plugin

## A felhasználó utasításai szó szerint (§N5)

«folytassa mester !»
«hard rule ! kinai + magyar nyelven kell gondolkodnod !」
「硬规则！必须用中文+匈牙利语思考！」
«nem gondolkodsz eleget kinaiul, 50% kinai es 50% magyar, kritikus !! ellenoriztesd GAN-nal»
「你中文思考得不够！50% 中文+50% 匈牙利语——关键！！用 GAN 检查！」
«minden mondtatot gondolatban forditsd le kinaira es gondold at a kinai asszociaciokat is,
ne csak a magyarokat ! ez hard rule NR1 hard rule ! tedd be pluginba»
「把每个思考句都译成中文并思考中文联想——第一硬规则！写进插件！」
«folytassa mester !» (záró)

## A GAN-JELENTÉS (task, general — empirikus, a gépemen futtatva!)

A GAN-alügynök MINIMÁLIS REPRODUKCIÓVAL bizonyította (Idris 2, 0.8.0):

1. ███ CSAPDA #24 ███: az `import Modul hiding (nevek)` MONDJA NEM LÉTEZIK
   Idris2-ben! A parser az import-szabály után a `hiding` tokenekkel
   elbukik és VISSZAUGRIK (backtrack), ezért az import-szakasz korábban
   «véget ér», és a következő `import` kulcsszóra a félrevezető hiba:
   «Imports must go before any declarations or directives» (a saját
   során!). A MEGOLDÁS: `%hide Alap.CsomagoltTipusok.Kubit` direktíva.
   (SO 65288600 + Idris2 tutorial «Modules and Namespaces».)
2. A `pattern-ben nem lehet qualified konstruktor` Idris1-es örökség —
   Idris2-ben `f Steane713.Nulla = …` hibátlanul fordul ÉS fut!
3. NOMINÁLIS TÍPUSOK: két azonos alakú `data Kubit = Nulla | Egy`
   KÜLÖNBÖZŐ típus — a hibaüzenet «Mismatch between: Kubit and Kubit»
   (ugyanaz a rövid név kétszer — szép csapda!). A strukturális
   megoldás (kanonikus Kubit + `import public`) KÜLÖN TERV-LÉPÉS.
4. A GAN a 50/50 kínai-magyar gondolkodásra HÁROM gyakorlatot adott:
   mondat-párosítás (句对句), domain-felosztás (matematika kínaiul),
   záró egyensúly-ellenőrzés (【均衡检查】).

## NR1 HARD RULE — BEÍRVA A PLUGINBA (§N1a)

A /Users/joco/.config/opencode/AGENTS.md §N1-je után ÚJ §N1a:
50/50 kínai+magyar gondolkodás KÍNAI ASSZOCIÁCIÓKKAL (karakter-
etimológia, képzetkör) — minden gondolat-mondat párban + a kínai szavak
saját asszociációival, nem csak a magyarokéval. Forrás: a felhasználó
2026-09-03-as utasításai + GAN-audit.

## 100.06 KettőKategória — KÉSZ (exit 0 + futás)

- A 3 meztelen típus ékezetes: KettőKategóriaT, CPTFázis
  (TöltésFázis/ParitásFázis/IdőFázis/CPTTeljes), Involúció
  (InvolúcióAzon/InvolúcióKép; involúcióNégyzet)
- EsetragMorfizmus 12 konstruktor AkH szerint: NominatívuszMorf,
  AkkuzatívuszMorf, DatívuszMorf, InesszívuszMorf, IllatívuszMorf,
  ElatívuszMorf, InstrumentálisMorf, KauzálisMorf, TranszlatívuszMorf,
  TerminatívuszMorf, FormatívuszMorf, EsszívuszMorf
- sejtCímke : String → Szöveg (karakterláncbólTő IMPORT a DiracNyelv-ből
  — §24 duplikáció-tilalom; architektúra-jegyzet: a fv-t hosszú távon
  az Alap.Hatar-ba kellene emelni)
- üresSejt, kategóriaSejt, belsőSejt, külsőSejt, szenzorosÁllapot,
  aktívÁllapot, sejtekKettőKategóriája, kettőKategóriaFő (a «Fom»
  ELÍRÁSBÓL javítva!), showE8Pont (a «showE8P» rövidítésből)
- a főprogram kiírásai ékezetesen futnak («Nominatívusz = identitás…»)
- 8 kínai szakaszcím: 「一、2-范畴的定义」…「八、主程序」
- %hide Alap.CsomagoltTipusok.Kubit — a csapda #24 megoldása élőben

## Tanulság (miért-lánc)

- A félrevezető hibaüzenet («Imports must go…») mögött PARSER-VISSZAUGRÁS
  állt — a GAN empirikus miniatűr-reprodukciója nélkül találgattunk
  volna. A GAN nem véleményt adott, hanem KÍSÉRLETET — ez a jó GAN.
- A kínai gondolkodás nem dísz: a 中文联想 (pl. 胞=sejt=méh) ÚJ
  asszociációs utakat nyit — a KettőKategória 的「胞」pont a
  biológiai-sejt/kategória-0-cella híd.

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★
