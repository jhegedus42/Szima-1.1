---
name: konyv-keszito
description: >
  PDF könyv készítés kategóriaelmélethez. Magyar-bal / angol-jobb oldal,
  középen elválasztva. LaTeX + TikZ diagramok minden struktúrához.
  A 49 kategóriaelméleti struktúra (Awodey 39 + Mac Lane 10) vizuális
  reprerezentációja. Idris kód + bizonyítások + Wikipedia linkek.
---

# Könyv Készítő — Kategóriaelméleti PDF

## Használat

```
skill konyv-keszito
```

## Architektúra

```
Idris kód (.idr) ──→ LaTeX (.tex) ──→ PDF
     │                   │              │
  Refl bizonyítások   TikZ diagramok  GitHub link
  Wikipedia linkek    magyar/angol    nyitható
```

## Formátum

Minden oldalon:
- **Bal oldal (magyar)**: magyar név, magyar leírás, magyar kommentek
- **Jobb oldal (angol)**: english name, english description, mathematical notation
- **Középen**: TikZ diagram (commutative diagram)
- **Alul**: Idris kód, bizonyítás kimenete, Wikipedia link

LaTeX struktúra:
```latex
\usepackage[twocolumn]{geometry}  % bal/jobboldal
\usepackage{tikz-cd}               % commutative diagrams
\usepackage{amsmath,amssymb}       % math
\usepackage{hyperref}              % links
```

## TikZ Diagramok

Minden struktúrához commutative diagram:

### Kategória (1.)
```latex
\begin{tikzcd}
A \arrow[r, "f"] \arrow[dr, "g \circ f"'] & B \arrow[d, "g"] \\
& C
\end{tikzcd}
```

### Funktor (2.)
```latex
\begin{tikzcd}
A \arrow[r, "f"] \arrow[d, "F"'] & B \arrow[d, "F"] \\
F(A) \arrow[r, "F(f)"'] & F(B)
\end{tikzcd}
```

### Természetes transzformáció (3.)
```latex
\begin{tikzcd}
F(A) \arrow[r, "F(f)"] \arrow[d, "\alpha_A"'] & F(B) \arrow[d, "\alpha_B"] \\
G(A) \arrow[r, "G(f)"'] & G(B)
\end{tikzcd}
```

### Adjunkció (23.)
```latex
\begin{tikzcd}
\mathcal{C} \arrow[rr, bend left=40, "F"] & & \mathcal{D} \\
& \perp & \\
\mathcal{C} & & \mathcal{D} \arrow[ll, bend left=40, "G"']
\end{tikzcd}
```

### Szorzat (11.)
```latex
\begin{tikzcd}
& Z \arrow[dl, "f"'] \arrow[d, "\langle f,g \rangle"] \arrow[dr, "g"] & \\
A & A \times B \arrow[l, "p_1"] \arrow[r, "p_2"'] & B
\end{tikzcd}
```

### Limesz (17.)
```latex
\begin{tikzcd}
\lim D \arrow[r, "p_j"] \arrow[dr, "p_i"'] & D_j \\
D_i \arrow[ur, "D(\alpha)"'] &
\end{tikzcd}
```

### Monoidális kategória (40.)
```latex
\begin{tikzcd}
(A \otimes B) \otimes C \arrow[r, "\alpha"] \arrow[dr, "\rho \otimes 1"'] & A \otimes (B \otimes C) \arrow[d, "1 \otimes \lambda"] \\
& A \otimes (B \otimes C)
\end{tikzcd}
```

### Yoneda (33.)
```latex
\begin{tikzcd}
\text{Hom}(-, A) \arrow[r, "\text{Nat}"] \arrow[dr, "\text{eval}_A"'] & F \\
& F(A)
\end{tikzcd}
```

### Monád (24.)
```latex
\begin{tikzcd}
T^2 A \arrow[r, "\mu_A"] \arrow[d, "T\eta"'] & TA \\
TA \arrow[ur, "\text{id}"'] &
\end{tikzcd}
```

### Steane [[7,1,3]]
```latex
\begin{tikzcd}
|0\rangle \arrow[r, "\text{kodol}"] & |0000000\rangle \arrow[r, "\text{hiba}"] & |0001000\rangle \arrow[r, "\text{javitas}"] & |0000000\rangle \arrow[r, "\text{dekodol}"] & |0\rangle
\end{tikzcd}
```

### 7+7+1 = [[15,1,3]]
```latex
\begin{tikzcd}
\text{Emberi (7)} \arrow[r, "\text{Legendre}"] & \text{Perem (1)} \arrow[r, "\text{Legendre}'] & \text{Sz\'am\'it\'asi (7)}
\end{tikzcd}
```

## Fordítás

```bash
pdflatex -interaction=nonstopmode konyv.tex
pdflatex -interaction=nonstopmode konyv.tex  # 2x for TOC
```

## GitHub Publikálás

```bash
git add konyv.pdf konyv.tex
git commit -m "konyv: ..."
git push
# Link: https://github.com/jhegedus42/Szima/raw/master/konyv.pdf
```

## Tartalomjegyzék

1. Kvantum Hibajavító Kódok ([[7,1,3]], [[15,1,3]])
2. Kategóriaelmélet (49 struktúra, Awodey + Mac Lane)
3. Funktorok és Természetes Transzformációk
4. Limitek és Kolimitek
5. Adjunkció, Monád, Komonád
6. Monoidális Kategóriák
7. 2-Kategóriák
8. Toposz és Yoneda
9. Fizikai Egyenletek
10. Fizikai Állandók
11. A 15 Dimenzió
12. Élet Domainek (Clifford fokozatok)
13. Magyar Nyelv = Kategóriaelmélet
14. Hipotézisek

## Fájlok

| Fájl | Tartalom |
|------|----------|
| `konyv.tex` | LaTeX forrás |
| `konyv.pdf` | PDF kimenet |
| `bizonyitasok.tex` | Régi bizonyítás PDF (megmarad) |
| `bizonyitasok.pdf` | Régi PDF (megmarad) |