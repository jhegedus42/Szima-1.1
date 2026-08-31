# Kutatási napló — 2026-08-31 (cikk)

## A felhasználó kérése (szó szerint, §N5)
- „Olyan bizonyitas kell, amit meg lehet jeleniteni ugy, hogy egy ember azt megertse, konkret szamolasokbol, szimulaciokbol legyenek numerikusan is igazolva az allitasok. Lenyegeben egy cikket kell irni, ahogy minden el van magyarazva es be lehet kuldeni egy tudomanyos lapba."

## Mit csináltunk
1. **Terv készítése** — 7 bizonyítatlan állítás azonosítása a `Torusz.idr`-ben
2. **Netes keresés** (§N12): Cl(4) penge-szám, E8 gyökrendszer, Pauli kommutátor, GKP kód
3. **Vizualizáció** — 2 Mermaid diagram (tórusz↔Cl(4), Pauli kommutátor)
4. **Cikk írása** — `cikkek/torusz_cikk.md` (579 sor, 11 szakasz)

## A cikk szerkezete
1. Összefoglalás (abstract)
2. Bevezetés
3. A bináris tórusz definíciója (Z₂ × Z₈ = 16 pont)
4. A Cl(4) 16 pengéje (binomiális együtthatók: 1+4+6+4+1=16)
5. A Pauli-mátrixok és a tórusz (X = pozíció, Z = fázis)
6. A kommutátor [X,Z] = -2iY és a Heisenberg-felcserélhetetlenség
7. A GKP-kód és a tórusz (ön-duális rács)
8. Az E8 gyökrendszer (240 gyök) és a 256-os híd (240+16=256)
9. A magyar mondattípusok kódolása
10. Numerikus szimuláció (Idris2)
11. Eredmények + hivatkozások

## Numerikus igazolások
- Cl(4) = 16: Pascal háromszög n=4: 1+4+6+4+1=16 ✓
- [X,Z] = -2iY: konkrét mátrixszorzás (XZ=-iY, ZX=+iY, XZ-ZX=-2iY) ✓
- 240+16=256: aritmetikailag ✓
- Cl(8) = 256: 1+8+28+56+70+56+28+8+1=256 ✓
- Mondattípusok: Állítás=F0, Kérdés=F2, Feltevés=F4, Következtetés=F6 ✓

## Fontos javítás
- A [X,Z] kommutátor értéke **-2iY** (nem +2iY, mint a korábbi tervben állítottam)
- A Joan Orr forrás szerint: XZ = -iY, ZX = +iY, tehát [X,Z] = XZ - ZX = -2iY

## Push
- `73df72c` — cikk: A bináris tórusz és a magyar mondattípusok

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★