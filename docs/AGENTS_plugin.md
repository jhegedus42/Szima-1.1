# Perzisztens ügynök-szabályok — minden sessionbe betöltendő (a "plugin")

## A VÁLASZ NÉGYNYELVŰ — minden push előtt KÜLÖN KIEMELVE

**§N1. Minden válasz négynyelvű: magyar (elsődleges) + 中文 (KRITIKUS) +
Deutsch + עברית.** A válasz törzse magyarul; a lényeg rövid összefoglalóként
megjelenik 中文 / Deutsch / עבריס formában is. A kínai NEM opcionális.

**§N2. Minden git push előtt KÜLÖN KIEMELÉS:** az asszisztens a push
elött egy külön sorban kiemeli, hogy a válasz négy nyelvű volt, pl.:

   ★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★

   (és ugyanez szerepel a commit-üzenetben, ahol válasz is kerül a repóba)

**§N3. Kódkommentek:** a blokk-fejlécek és kulcs-tanulságok négynyelvűek;
a soronkénti kommentek magyar+kínai párosban.

**§N3a. A VÁLASZ PONTOS SABLONA (mindig ebben a sorrendben):**

```
[MAGYAR — a válasz TÖRZSE: a teljes válasz minden részlettel]

**中文：** [a lényeg tömör kínaiul — KRITIKUS, soha nem maradhat el]

**Deutsch:** [die Kernaussage kurz auf Deutsch]

**עברית:** [תמצית התשובה בעברית]
```

Push előtt külön sorban: `★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★`

**§N4. Kutatási napló:** minden kérdés–válasz pár időbélyeggel a projekt
`kutatasi_naplo/` könyvtárba, pusholva (a projekt AGENTS.md §21 szerint).

**§N5. SZÓRÓL SZÓRA, NINCS TÖMÖRÍTÉS (horog).** Mindent szó szerint írunk le:
- a felhasználó kérdése idézőjelben, SZÓRÓL SZÓRA (nyelvtörés, elírás együtt);
- a válasz NEM tömörített: inkább TÖBB, mint kevesebb;
- szépen pontokba szedve (listák, számozott szakaszok);
- semmi információ el nem dobható — a "tömörítés" = információvesztés (AGENTS §16).

Forrás: a felhasználó utasítása 2026-08-21-en — "fontos, hogy szorul szora
irjal le mindent, nincsen tomorites !!! inkabb legyen tobb, mint kvesebb es
legyen szepen pontokba szedve, ez menjen ez a szabaly is a pluginba mint horog".

Forrás: a felhasználó utasításai 2026-08-21-en — "a valasz 4 nyelvu!
ezt kulon emeld ki minden push-elott, ezeket tedd be a pluginba",
"kinai fontos, kritikus", "push our conversations... it's a research log".

**§N6. KÓD DUPLIKÁCIÓ TILOS (prioritás).** Meglévő függvényt IMPORTÁLJ,
soha ne írd újra. Új kód előtt: (a) grep a projektre (név + szignatúra),
(b) Prelude/Data.List (elem, take, nub...), (c) ha van: import.
A kanonikus helyek listája: KódDuplikációAudit. Forrás (2026-08-21):
"kod duplikacio kinyirja az egesz projektet ... kodot ujra kell
hasznallni !!! nem ujra irni !!!!!"

**§N8. PYTHON TILOS — MINDEN SZKRIPT IDRISBEN.** Soha ne használj
Pythont SEHOL, MÉG FÁJLJAVÍTÁSRA SEM (a `python3 - <<'PYEOF'`
szerkesztő-blokkok is tiltottak). Fájlszerkesztés: `edit` eszköz;
számítás/szkript: Idris (`idris2 --exec main`, l. E8Gyokok_v2 main-je,
Komplex.idr numerikái). Egyetlen kivétel: a felhasználó EXPLICIT kérésére
készült DB-eszköz (opencode_naplo_kirollo.py) — de az ügynök munkafolyamata
SOHA nem Python. Forrás (2026-08-21): "pythont tilos hasznalni, akar
javitasra is" / "minden szkript idriszben legyen".
| 一切脚本必须用 Idris！Python 连修文件也不许用！ |
| Alle Skripte in Idris! Python auch nicht zum Datei-Editieren! |

**§N9. MAGYAR HELYESÍRÁS — KRITIKUS. A nyelv tart egyben.** Minden magyar
szöveg (válasz, komment, napló, commit) a HELYESÍRÁS szerint: igekötős
igék EGYBE (szétcsúszik, felépít, lefuttat); a -val/-vel toldalék
TELJESEN hasonul (kóddal, szabállyal, programmal, szótárral); vessző a
"hogy/mert/hanem" előtt; hosszú magánhangzók a helyes alakban
(működik, szótár, gyökér, bizonyítás). Forrás: AkH.12 —
helyesiras.mta.hu; a gyakorlati kivonat: MagyarHelyesirasTanulsag.md.
Forrás (2026-08-21): "a magyar nyelvtant viszont hasznalnod kell, ugyelj
a helyesirasra... ha szetcsuszik a magyar nyelv, te is szetcsuszol /
ez tart egyben" / "a magyar helyesiras kritikus".
| 匈牙利语正字法——关键！语言把一切凝聚在一起。 |

**§N10. MAGYAR-MATEMATIKA — SZIGORÚ SKILL, MINDIG BETÖLTVE.** Nem
beszélhetünk értelmetlenségeket, mert eltévedünk — különösen nyelvi
modellek, akik a szavakra hagyatkoznak. A magyar nyelvtan és helyesírás
adja a megértést és jelentést. SZAKNYELV (MagyarMatematikaiSzókincs):
tükrözés (nem reflexió), krisztalografikus (nem kristallográfiai),
gyökrendszer (egy szó), tétel/lemma/állítás/megjegyzés/cáfolat,
belső szorzat, hipersík, generátorrendszer. METAFORA TILOS matematikai
szövegben (nincs „recept"/„mutatvány"). A teljes skill:
~/.agents/skills/magyar-matematika/SKILL.md. Forrás (2026-08-22): "a
matematikai fogalomtar az legyen egy standard skill ami mindig be van
toltve, szigoru skill... ez az egesz projektnek a lenyege, a magyar
nyelv specialis, ezt probaljuk matematikailag megragadni es direkt
beepiteni egy matematikailag tokeletes intelligenciaba". | 数学语言
为严格常驻技能——词的精确即理解。 |

**§N11. OLVASS MIELŐTT ÍRSZ — HARD RULE.** Minden átírás/szerkesztés előtt:
(a) OLVASD a fájlt teljes összefüggésben (Read + grep), (b) ÉRTELMEZD, mit
csinál a függvény (hol áll a hierarchiában, mit számol, ki hívja), (c) CSAK
UTÁN írj. A név jelentését a FUNKCIÓ adja, nem a szó hasonlósága ("Level az
Szint vagy Levél?" — a deltaSzint Levél = δ válaszol: a fa legkisebb egysége).
Forrás (2026-08-22): "olvass mielőtt irsz, ez hard rule, keress, olvas,
mielott irsz, ez legyen benne a pluginben". | 写之前必须先读！ |

**§N12. KERESS A NETEN MIELŐTT CSELEKEDSZ — HARD RULE.** Minden cselekvés
előtt keress releváns információra; a kereséseket ELŐRE TERVEZD meg; arra
is keress rá, HOGY KELL csinálni; ha valami hiba van → KERESS, ne találgass.
ESZKÖZÖK: MCP (brave-search, context7, exa, firecrawl, alphaxiv) ÉS
sub-agent (task), akinek a szükséges kontextust átadjuk. "Tanulni, tanulni,
tanulni!" (Lenen — a felhasználó idézi, 2026-08-22: "keress a neten mielott
cseleksz, minden cselekves elott keress... tervezd meg ezeket a kereseseket,
keress mindig mindent vegig... ha valami hiba van, keress, Tanulni Tanulni
Tanulni, már Lenin is megmondta; hassznalj ezekhez mcp-t").
| 行动之前先搜索——用 MCP 工具与子代理！学习，学习，再学习！ |

**§N7. ÉKEZETES MAGYAR — HARD RULE.** Minden magyar szó a kódban és a
válaszokban ÉKEZETES alakban (típusok, függvények, kommentek — az Idris2
teljes Unicode: SzóHáz, négyzet, magánhangzóMélyÉ mind futnak; ProbeUnikod
bizonyította). "Szotar" → "Szótár" — az ékezet információ, nem dísz.
Forrás (2026-08-21): "ekezettel, ez hard rule, ird be az osszes hook-ba".

**§N13. MINDEN FELFEDEZÉST PUSH-OLNI KELL — HARD RULE.** Minden
felfedezés (új eredmény, levezetés, bizonyítás, megértés, kutatási
átütés) azonnal commit + push a GitHubra. Nem várunk a „3. prompt
ritmusra", nem gyűjtjük felhalmozva — amint egy felfedezés megszületik,
azonnal rögzítjük a kutatási naplóba és pusholjuk. A kutatás nem
vész el: ha a laptop leáll, a szerver leáll, a context megtelik — a
felfedezés a GitHubon marad. Forrás (2026-08-30, a felhasználó):
„fontos szabaly, minden felfedezest push-olni kell !!!".
| 每个发现必须立即推送！ | Jede Entdeckung muss sofort gepusht werden! |
