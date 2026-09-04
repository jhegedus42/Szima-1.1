# FÁJLRENDSZER-RENDTERV — javaslatok, SEMMIT NEM MOZGATUNK JÓVÁHAGYÁS NÉLKÜL
# 整理方案——建议而已，未经批准不移动任何文件 · v1 (2026-09-04)

**Forrás:** `docs/FajlrendszerFelmérés_v1.md` (a felmérés adatai).
**Szabály:** AGENTS §13 (soha nem írunk felül), §20 (soha nem törlünk),
HOROG szívdobbanás („Csak HOZZÁADJ, soha ne törölj vagy módosíts").
Minden javaslat VÁRAKOZIK a felhasználó döntésére — `git mv` is csak
engedéllyel. A javaslatok a konzervatív…tól a bátor…ig sorrendben.
**所有建议均待用户批准；连 git mv 也须允许。建议由保守到大胆排列。**

---

## JAVASLAT 1 (konzervatív) — jegyzék, nem érintés
Semmit nem mozgatunk. A felmérés (`FajlrendszerFelmérés_v1.md`) + a
TudásGráf `Könyvtár-Hely` csomópontjai már rögzítik a rendetlenségek
helyét és szerepét. **Előnye:** nulla kockázat. **Hátránya:** a gyökér
zsúfoltsága megmarad.

## JAVASLAT 2 (perem-rendezés) — session-exportok begyűjtése
Az üres `session_export/` mappa valószínű célja a ~18 gyökérbeli
`session-*.md` + `session_export*.md` begyűjtése. Javaslat:
`git mv session-*.md session_export/` (megjegyzés: a `.gitignore`
`session-*.md` mintát zár ki — a mozgatás UTÁN a mappán belül is
ignoráltak maradnak, a git-történet nem változik; a LOKÁLIS rendet
viszont rendbe teszi).
**Kockázat:** kizárólag elnevezés; a fájlok tartalma érintetlen.

## JAVASLAT 3 (napló-egyesítés) — a három napló egy irányba
- `kutatasi_naplo2/*.log` → `kutatasi_naplo/plugin_naplok/` almappa
  (a kanonikus naplóban már élnek `plugin_naplo_*.log` fájlok — ide
  valók, dátum-megtartással).
- `kutatasi_naplo3/kutatasi_naplo/*` (14 fájl, 2026-08-29…30) → a
  kanonikus `kutatasi_naplo/`-ba, dátum-megtartással (névütközés nincs:
  a kanonikusban ezek a dátumok hiányoznak).
- `kutatasi_naplo2/datjumok/` → maradhat jelöléskéént, vagy tartalma
  (`download.txt`) átkerül `kutatasi_naplo/mellékletek/`-be.
**Kockázat:** a plugin (horog-injektor) a `kutatasi_naplo2`-be írt
2026-09-04-én is (`plugin_naplo_2026-09-04.log`) — ha a plugint NEM
frissítjük, újra létrehozza a mappát. Döntés kell: plugin-konfig
frissítése a mozgatással együtt (külön lépés, `~/.config/opencode/`).

## JAVASLAT 4 (az elásott .idr-k sorsa) — `kutatasi_naplo3` gyökere
A `KonstansHitelesites.idr` és `MindenKonstans.idr` (2026-08-29)
ellenőrzendők: fordulnak-e (`idris2 --check`), és mit tudnak, amit a
kanonikus konstans-modulok nem. Három kimenet:
- (a) ha a tartalmuk beolvadt a kánonba → jelölve maradnak
  `kutatasi_naplo3/`-ban, a TudásGráf „elavult-változat" élet jelöli;
- (b) ha egyediek → `osveny_index/`-be KÚJ fájlnévvel másolandók
  (`KonstansHitelesites_v2.idr` séma — §13 szerint új fájl, nem mozgatás!),
  az eredetiek maradnak;
- (c) ha nem fordulnak → tanulság-csapdaként dokumentálva (OLVASD.md
  sémája: „egyesek épp nem fordulnak le — ez a tanulság bennük").
**Első lépés mindenképpen:** `idris2 --check` mindkettőre — ezt az
irányító sorba tudja tenni, jóváhagyás nem kell hozzá (olvasás).

## JAVASLAT 5 (melléktermékek) — gyökér-tisztaság
- LaTeX `.aux/.log/.out/.toc` (9 db) → `build/latex/` almappába,
  VAGY `.gitignore`-ba a mintáik (a `build/` már ignorált? — nem, a
  `build/` commitolva van; döntés kell).
- A ~14 vizualizációs `.py` maradhat a gyökérben (eszközök, §3
  kivétel), DE a Rajz-kimenetek (PNG/GIF, ~11 db) → `docs/abra/`
  almappába, ahol a `vizualizaciok.html` család már él.
**Kockázat:** a dashboardok/PDF-ek ELÉRÉSI ÚTJAIBAN szerepelhetnek a
PNG-nevek — mozgatás előtt grep a docs/-ban (a Rendterv végrehajtási
lépése lesz, jóváhagyás után).

## JAVASLAT 6 (nagy dobás — CSAK jelzés szintjén) — `source/` archiválás
A `source/` 7 GB külső nyersanyag (többé-kevésbé duplikált OKComputer ×5).
Javaslat szintjén: `git mv source NYERSANYAG_source/` átnevezés, vagy
git-LFS/külső archívum — DE: (a) 7 GB mozgatás lassú, (b) a
gondnok-laptop katalógus útvonalai bele vannak drótozva a docs-okba,
(c) a felhasználó explicit döntése kell. **A felmérés rögzíti; nem cselekszünk.**

---

## MIÉRT EZ A SORREND (Yoneda-rész)
A javaslatok a MOZGATÁS ZAVARÓHATÁSA szerint nőnek: (1) nulla él-mozgás →
(2) izolált levelek → (3) perem-naplók (1 él: a plugin) → (4) egyedi
csomópontok (döntést igényel) → (5) melléktermék-élek (dashboard-hivatkozások)
→ (6) nagy részgráf. Minél több él mozdul, annál több GAN-ellenőrzés kell
utána — a 7-1-3 elv a RENDESRE is vonatkozik: minden mozgatás után a
git-lánc + a felmérés + a TudásGráf három kópiáját frissíteni kell.
**顺序理由：按扰动递增排列——边动得越多，越需要 GAN 检验与三副本同步。**

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★
