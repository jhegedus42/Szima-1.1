# Kutatási napló — 2026-09-03 — GAN-ellenőrzés: idris-nyelv skill + IdrisNyelv.idr

## A felhasználó kérdése (szó szerint, §N5)

«GAN-ELLENŐRZÉS (hozzátesz, nem elvesz! — soha ne mondd, hogy «nem érdemes»): A cél a következő MESTER-munka TÖKÉLETESÍTÉSE. Kérlek, olvasd el ezeket a fájlokat:
1. /Users/joco/.agents/skills/idris-nyelv/SKILL.md (a hivatalos Idris2-tutorial 13 fejezetéből készült négynyelvű enciklopédia-skill: magyar+中文+EN+DIRAC bra-ket formák; forrás: https://idris2.readthedocs.io/en/latest/tutorial/index.html)
2. /Users/joco/opencode/osveny_index/IdrisNyelv.idr (a skill Idris-megtestesülése: IdrisFejezet 13 konstruktor, trigger-funktor, DiracSzabály rekord, Refl-tanúk, main — ez már FORDUL exit 0-zal és FUT)

A FELADATOD (GAN, hozzáadó mód):
A) PONTOSÍTÁS: találtál-e TÉNYBELI hibát a skillben az Idris2-hivatalos tutorial ismereteid alapján? (pl. rossz szintaxis, félrevezető állítás). Sorold fel konkrét javítással.
B) KIEGÉSZÍTÉS: melyik fejezet-törzs túl vékony? Milyen TÉNYI tartalmat (a tutorialból, a Brady-könyvből vagy az ECOOP-2021 QTT-iratból) kellene HOZZÁADNI? Adj 5-8 konkrét, hiányzó tételt mondat-nívón (magyarul, rövid kínai párkal együtt).
C) A DIRAC-bra-ket-formák (pl. ⟨törvény|instance⟩, ⟨használat|futásidő⟩₀, |Parity⟩-bázisra projekció) matematikailag/érthetően HELYES-e, javasolj 2-3 jobb formát ha van.
D) AZ IDRIS-FÁJLRA: a `trigger`-funktor és a 13 konstruktor jól van-e nevezve (AkH.12 magyar helyesírás); van-e a main-ben hiba; javasolj 1-2 új Refl-tanút, ami triviálisan zár.
Válaszold RÖVIDEN, pontokban (max ~40 sor), magyarul+kínaiul párban. Ne dicsérj; csak javíts és egészíts ki!»

## Elvégzett ellenőrzés (§N12: keresés a neten ELŐBB)

A hivatalos tutorial négy fejezét élőben lekértem és szó szerint egyeztettem (webfetch, 2026-09-03):
- https://idris2.readthedocs.io/en/latest/tutorial/index.html (13 fejezet listája)
- typesfuns.html (let/:=, operátorok, where, totality, DPair, rekordok)
- theorems.html (rewrite-irány, cong, replace/disjoint, totality-directívák)
- multiplicities.html ((1 _ :a), duplicate, Lin/Unr, vlen, %World, notId)
- miscellany.html (auto-implicit 4 lépéses sorrend, default implicit, .lidr, kumulativitás «NOT YET IN IDRIS 2»)

## A válasz (a GAN-eredmény)

### A) PONTOSÍTÁS — ténybeli javítandók
1. SKILL.md:55 «elsı» törött karakter (U+0131) → «első». / 中文：错字 elsı→első。
2. 12. fejezet: a kumulativitás a tutorialban «NOT YET IN IDRIS 2» minősítést visel — a skill elhagyta; hozzáadandó. / 中文：第 12 章须注明尚未实现。
3. 3i: `let`-nél `=` az alap; `:=` opció a kétértelműség ellen, ÉS lokális fv-definícióban tiltott (tutorial explicit). / 中文：:= 于局部函数定义中禁用。
4. 6: `(1 _ : a)` csak ha a név a típus további részében nem szerepel. / 中文：(1 _ :a) 有条件合法。
5. «! = egyszeri kötés» → «kötés és felhasználás a folytatásban (>>= desugár)». / 中文：「!」表述须改。
6. IdrisNyelv.idr:94-95 «allitas»/«bizonyitas» → «állítás»/«bizonyítás» (§N7). / 中文：须带变音符。

### B) KIEGÉSZÍTÉS — hiányzó tételek
1. 3: fenntartott operátorok (`% \ : = | ||| <- -> => ? ! & ** ..`) nem definiálhatók; engedélyezett készlet `:+-*\/=.?|&><!@$%^~#`.
2. 3: fv-név kezdődhet nagybetűvel; fv-/adat-/típuskonstruktorok közös névtérben.
3. 3: `forall a, n .` explicit implicit-kvantifikáció.
4. 6: `duplicate : (1 x : a) -> (a, a)` megvalósíthatatlan — kanonikus lineáris ellenpélda.
5. 6: `Lin`/`Unr` + getLin/getUnr (multiplicitás-öröklés mintán át); «0-s kvantitás után is beszélhetünk róla típusokban».
6. 6: kvantitásfélgyűrű {0,1,ω} (Atkey–McBride LICS 2018; ECOOP 2021): + = elágazás, · = egymásba ágyazás; nyitott kérdések (Granule, Linear Haskell arXiv:1710.09756).
7. 10: `disjoint`-bizonyítás `replace {p=…}`-rel (a skill csak `void`).
8. 10: `%default total` + `--total`/`--warnpartial` + «Not all of this is implemented yet» figyelmeztetés.

### C) DIRAC-formák
1. `⟨használat|futásidő⟩₀` → operátor a középen: `⟨használat|q₀|futásidő⟩ = 0`, lineárisan `⟨x|q₁|x⟩ = 1`.
2. `|Parity⟩ = α|Even⟩+β|Odd⟩` → determinisztikus δ: `with(k) = Σ_p ⟨p|k⟩ |p⟩⊗|többi(p)⟩`, ⟨p|k⟩∈{0,1}.
3. `⟨törvény|instance⟩ : Tanú` — az átfedés értéke TÍPUS; három szint: =1 (Refl-zár) / : Tanú (van lakó) / =0 (Void). `⟨mező|r⟩` ✓ marad.

### D) IDRIS-fájl
1. `RejtőSzésSzó` → `ElrejtésSzó` (AkH.12).
2. `IndulóSzó` → `ModulSzó` (pontosabb).
3. `kilencKulcsszóTáblázat`: 10 konstruktor / 9 sor — IOSzó sor hiányzik; → `tízKulcsszóTáblázat`.
4. `fejezet*Név` csupasz `String`-et ad → csomagolt `Szöveg` (karakterláncbólTő), mint a DiracSzabály.
5. main tanú-sorai kőrzött szövegek → `tanúÉl : (trigger X = Y) -> String; tanúÉl Refl = "Refl ✓"` fogyassza a tanút.
6. Új tanúk: `bizTriggerWithANézetekhez : trigger WithSzó = NézetekÉsWithSzabály` = Refl; `bizTízSor : length tízKulcsszóTáblázat = 10` = Refl.
7. «NÉGYNyelVŰ» → «NÉGYNYELVŰ» ( komment + SKILL.md leírás).

### Ellenőrzötten EGYEZIK a tutoriallal (nem elvett semmit)
rewrite-irány (prf : x = y ⟹ x→y csere — theorems.html szövegével), auto-implicit 4 lépéses sorrend, default-implicit forma, .lidr üressor-szabály, `2+2=4` Refl-példa, covering-alapértelmezés, PONTOSAN-egy-implementáció.

## Négy nyelv (§N1)
- **中文：** 事实修正六处；补八条；狄拉克三改；Idris 文件七处修正；四页官方教程逐字核对。
- **Deutsch:** Sechs Faktenkorrekturen, acht Ergänzungen, drei Dirac-Verbesserungen, sieben Datei-Korrekturen; vier Tutorial-Seiten wortwörtlich abgeglichen.
- **עברית:** שישה תיקוני עובדה, שמונה השלמות, שלוש צורות דיראק, שבעה תיקונים בקובץ.

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★
