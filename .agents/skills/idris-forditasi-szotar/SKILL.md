---
name: idris-forditasi-szotar
description: >
  IDRIS FORDÍTÁSI SZÓTÁR / Idris 编译错误词典 / Idris Compiler-Error Dictionary —
  Idris 2 0.8.0 (macOS arm64, /opt/homebrew/bin/idris2) fordító- és futtatási
  hibaüzeneteinek empirikus szótára: üzenet → ok → megoldás táblázatok,
  minimál példákkal. A Szima projekt 27 csapdájának és a 2026-09-05-i
  NégynyelvűEllenőrző_v1 javítási ciklusának lepárolt tudása. Hibaüzenet
  láttán ELŐSZÖR itt keresel, utána próbálsz — a vak próbálkozás tilalma
  (AGENTS §1/2) alól ez a szótár nem mentesít: a gyógyír után a gyökeret is
  megérted.
---

# IDRIS FORDÍTÁSI SZÓTÁR · Idris 编译错误词典 · Idris Compiler-Error Dictionary

**Használat / 用法 / Usage:** a fordító üzenetének KULCSSZAVÁT keresd (Ctrl-F),
a sor megadja az okot és a megoldást; ahol minimál példa van, azt másold
mintának. Minden bejegyzés empirikusan bizonyított a gépen (GAUGE: a kimenetet
mindig olvastuk — az exit 0 néha hazudik!).

**Lásd még / 另见 / See also:** `idrisz-agens` (protokoll), `idris-nyelv`
(encyclopédia), `idris-stilus` (stílus), `osveny_index/tanulsagok/OLVASD.md`
(csapda-archívum).

---

## A. ELABORÁCIÓS HIBÁK / 精化错误 / ELABORATION ERRORS

| Üzenet (kulcsszó félkövérrel) | Ok | Megoldás |
|---|---|---|
| **Undefined name** X, ahol X ékezetes LAMBDA-paraméter (`\ítélet => …`) | ékezetes csupasz lambda-paraméter import mellett (csapda #27 lambdán) | pontstílus: `filter (not . rendbenVan) …`; ``filter (`elem` szavak)``; VAGY felső szintű nevesített függvény |
| **Undefined name** X, ahol X ékezetes mintaváltozó a klauzula bal oldalán, és a fv IO-do-s | #27 finomítás (2026-09-05): tiszta fv-nél a csupasz ékezetes mehet, IO-do-s fnél NEM | @-minta: `próbaFuttatás útvonal@_ = do …` — bizonyítva; vagy konstruktorba ágyazás: `f (elsőÉl :: többiÉl) = …` |
| **Undefined name getArgs** | System.Environment ebben az installban nem elérhető | `import System.File` + `readFile` rögzített útvonallal (Kereso.idr minta) |
| **Can't find an implementation for Integral Nat** (pl. `pozíció \`mod\` 4`) | a Prelude `mod` az Integral osztály metódusa; Nat nincs benne | `import Data.Nat` VAGY stilus-közelebb: strukturális rekurzió — `ciklusHely (S (S (S (S tovább)))) = ciklusHely tovább` |
| **Mismatch between: List1 String and List String** | `Data.String.split : (Char -> Bool) -> String -> List1 String` | `import Data.List1` + `forget (split határoló szöveg)` |
| **Mismatch between: X and X** (ugyanaz a rövid név!) | nominális típusok: két azonos ALAKÚ `data Kubit = Nulla \| Egy` KÜLÖNBÖZŐ típus | kanonikus egy defníció + `import public`; VAGY minősítés `Steane713.Kubit` |
| **Ambiguous: A.X vs B.X** | két import ugyanazt a nevet hozza | `%hide A.X` — az IMPORT-LISTA VÉGÉRE (ha közé ékelődik: «Imports must go…» hamis hiba!) |
| **Can't solve: X vs X** cong-nál, azonos tagokkal | cong GLOBÁLIS fv-fejnél beragad; `id` a típusban implicit kötés lesz | `Prelude.id` minősítés; véges világnál futásidejű kimerítés tanúja (§18b) |
| **implicitly bind lowercase names** figyelmeztetés + Refl nem zár | csupasz kisbetűs KONSTANS a proof TÍPUSÁBAN (fv-alkalmazás OK!) | nagybetűs alias: `public export KezdetiÁllapot : Állapot; KezdetiÁllapot = kezdetiÁllapot` |
| **There are 2 uses of linear name x** | lineáris (1) kvantitású név kétszer | használd egyszer, VAGY függvényargumentum-átadással duplikálj |

## B. PARSE-HIBÁK / 语法错误 / PARSE ERRORS

| Üzenet | Ok | Megoldás |
|---|---|---|
| **Couldn't parse declaration** (doc-komment után) | `||` elütés `|||` helyett a folytató sorban | minden dokumentációs sor `|||` |
| **Expected '=>'** lambdánál | többparaméteres `\x y =>` alak | `\x => \y => …` (egyenként) |
| **Bracket is not properly closed** stringben | tipográfiai idézőjel „" a Stringben | »« jelölés VAGY sima `"` — „" SOHA |
| **Expected end of input** record-deklarációnál | magyar `konstruktor` kulcsszó | angol `constructor` |
| **Not the end of a block entry, check indentation** (valójában zárójel-hiba) | hiányzó nyitó zárójel a szem elől elbújik (13/14!) | `grep -o '(' fájlnév \| wc -l` vs `grep -o ')' fájlnév \| wc -l` — a gép a bíra, nem a szem |

## C. TOTALITY-HIBÁK / 完全性错误 / TOTALITY ERRORS

| Üzenet | Ok | Megoldás |
|---|---|---|
| **X is not total, possibly not terminating due to function Data.Fuel.forever being reachable via … readFile** | %default total + readFile perem | `covering` jelölés a readFile-es PEREM-fv-re és a main-ra; a tiszta mag marad total |
| **X is not covering** | hiányzó klauzula | `:am` REPL-ben; VAGY a perem-döntés `_` ága (a perem case-e megengedett — karakterláncbólTő-minta) |
| **X is possibly not total** rekurziónál | a zsugorodás nem látványos | `assert_smaller (x :: xs) kifejezés`; strukturális rekurzió átírása |

## D. MODUL/IMPORT-HIBÁK / 模块错误 / MODULE ERRORS

| Üzenet | Ok | Megoldás |
|---|---|---|
| **Imports must go before any declarations or directives** | `import … hiding` NEM LÉTEZIK Idris2-ben (parser-visszaugrás!) VAGY %hide rossz helyen | NINCS hiding; `%hide Modul.Név` az importok UTÁN, de minden deklaráció ELŐTT |
| **Module name does not match file name** | név/útvonal eltérés; kisbetűs szegmens az útvonalban | modulnév = fájlnév; NAGYBETŰS szegmensek (a `tanulsagok/` almappa ezért nem modul-útvonal!) |
| **Module Data.Char not found** (vagy más) | nem létező modul ebben az installban | `ord`/`isAlpha` Prelude; fájl: System.File; List1: Data.List1; Nat-mod: Data.Nat |
| **Source file … is not in the source directory** (-o-nál) | a -o cél másik könyvtár, mint a forrás | a fordítást a FORRÁS könyvtárából futtasd, -o relatív |
| **Interpreting … will perform havoc / %language** ismeretlen pragma | verzióeltérés | 0.8.0-n a kumulativitás NINCS implementálva; ElabReflection van |

## E. FUTTATÁS/LINDELÉS / 运行错误 / RUNTIME ERRORS

| Üzenet | Ok | Megoldás |
|---|---|---|
| **Exception in read: invalid string character \36 at line 1 … of …/compileChez** | ÉKEZETES futtatható-név a -o-ban: a generátor decimális kódpont-escape-t ír (\369 = ű), a Chez read OKTÁLISAN olvassa — a 9-es/8-as jegy olvasási hiba | a futtatható neve LEGYEN ASCII: `-o negynyelvu_ellenorzo` (a modul- és fájl-név maradhat ékezetes) |
| futtatáskor **No such file or directory … /útvonal//útvonal/….so** (duplán fűzve) | `-o` ABSZOLÚT útvonallal: a burkoló szkript a saját könyvtárához fűzi | `-o` RELATÍV névvel; a futtatható a `build/exec/`-be kerül → `./build/exec/név` |
| **idris2 --check** exit 0, de hibaüzenet a kimeneten | a --check néha hazudik (Próba C!) | GAUGE: a kimenetet OLVASNI; gyanús láncot TISZTA fájlban újrafuttatni |

### Futtatási recept (bevált, 2026-09-05):
```sh
cd /Users/joco/opencode/osveny_index          # a FORRÁS könyvtárába!
idris2 --check Modul.idr                       # 1. ellenőrzés (kimenetet OLVASD)
idris2 Modul.idr -o futurhato                  # 2. ASCII név, relatívan
./build/exec/futurhato                         # 3. futtatás onnan
```

## F. A HÁROM ARANYSZABÁLY / 三条金律 / THREE GOLDEN RULES

1. **Három egyforma hiba → KERESÉS** (szótár → projekt-grep → net → kérdezz),
   nem próbálkozás (AGENTS §1/2).
2. **GAUGE: a kimenetet OLVASD** — az exit 0 nem tanúság; a «0 hiba» lehet
   elgépelt lánc műterméke (AGENTS §18/§GAUGE).
3. **Bisect, nem vak javítás**: vissza az utolsó jó állapothoz, egyesével
   vissza a változtatásokat, minden lépésben mérve (AGENTS: a let-lánc
   csapda így került elő).

## 中文 · EN

中文：本词典按「错误信息 → 原因 → 解法」排列，全部条目皆在本机实证
（Idris 2 0.8.0）。最常见的陷阱：带变音符的裸 lambda 参数或 IO-do 函数
裸模式变量报 «Undefined name»（改用无 lambda 点风格或 @-模式）；ékezetes
可执行文件名让 Chez 读取崩溃（可执行名用 ASCII）；readFile 触及 forever
故须标 covering；split 返回 List1 须 forget；exit 0 可能撒谎——务必读输出。

EN: Every entry is message → cause → fix, all verified on this machine
(Idris 2 0.8.0). Top pitfalls: accented bare lambda parameters and bare
pattern variables of IO-do functions yield «Undefined name» (use point-free
style or an @-pattern); an accented executable name crashes the Chez reader
(keep the -o name ASCII); readFile reaches Data.Fuel.forever so mark the
boundary `covering`; `Data.String.split` returns List1 (use `forget`);
exit 0 can lie — always read the output.
