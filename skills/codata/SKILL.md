---
name: codata
description: >
  CODATA fizikai állandók — a mérések referenciái. 2022 CODATA értékek
  mérési hibákkal. Amikor fizikai állandót ellenőrzünk, ez a skill adja
  a referenciát és a mérési bizonytalanságot. Csak akkor fogadjuk el
  a levezetést, ha a hiba KISEBB mint a mérési bizonytalanság.
  Forrás: https://physics.nist.gov/cuu/Constants/
---

# CODATA — Fizikai Állandók Referenciája

## Használat

```
skill codata
```

Amikor fizikai állandót ellenőrzünk: hasonlítsd össze a levezetett
értéket a CODATA referenciával. Csak akkor fogadjuk el, ha a hiba
KISEBB mint a mérési bizonytalanság (merési hibán belül).

## A 2022 CODATA Állandók

### Természetes állandók (SI 2019 pontos definíciók)

| Szimbólum | Név | Érték | Mérési hiba | Egység |
|-----------|-----|-------|-------------|--------|
| c | fénysebesség | 299792458 | pontos (0) | m/s |
| h | Planck | 6.62607015×10⁻³⁴ | pontos (0) | J·s |
| ℏ | redukált Planck | h/(2π) | pontos (0) | J·s |
| k_B | Boltzmann | 1.380649×10⁻²³ | pontos (0) | J/K |
| N_A | Avogadro | 6.02214076×10²³ | pontos (0) | mol⁻¹ |
| e | elemi töltés | 1.602176634×10⁻¹⁹ | pontos (0) | C |

### Mért állandók (bizonytalansággal)

| Szimbólum | Név | Érték | Mérési hiba | Relatív hiba |
|-----------|-----|-------|-------------|--------------|
| α | finomszerkezeti | 7.2973525646(11)×10⁻³ | ±0.0000000011×10⁻³ | 1.5×10⁻¹⁰ |
| α⁻¹ | inverz finomszerkezeti | 137.035999177(21) | ±0.000000021 | 1.5×10⁻¹⁰ |
| G | gravitációs | 6.67430(15)×10⁻¹¹ | ±0.00015×10⁻¹¹ | 2.2×10⁻⁵ |
| m_e | elektron tömeg | 9.1093837015(28)×10⁻³¹ | ±0.0000000028×10⁻³¹ | 3.0×10⁻¹⁰ |
| m_p | proton tömeg | 1.67262192369(51)×10⁻²⁷ | ±0.00000000051×10⁻²⁷ | 3.1×10⁻¹⁰ |
| m_p/m_e | proton/elektron arány | 1836.15267343(11) | ±0.00000011 | 6.0×10⁻¹¹ |
| ε₀ | vákuum permittivitás | 8.8541878128(13)×10⁻¹² | ±0.0000000013×10⁻¹² | 1.5×10⁻¹⁰ |
| μ₀ | vákuum permeabilitás | 1.25663706127(20)×10⁻⁶ | ±0.00000000020×10⁻⁶ | 1.6×10⁻¹⁰ |

### Származtatott állandók

| Szimbólum | Név | Érték | Egység |
|-----------|-----|-------|--------|
| ℓ_P | Planck-hossz | √(ℏG/c³) ≈ 1.616×10⁻³⁵ | m |
| t_P | Planck-idő | √(ℏG/c⁵) ≈ 5.391×10⁻⁴⁴ | s |
| m_P | Planck-tömeg | √(ℏc/G) ≈ 2.176×10⁻⁸ | kg |
| T_P | Planck-hőmérséklet | √(ℏc⁵/Gk_B²) ≈ 1.417×10³² | K |
| E_P | Planck-energia | √(ℏc⁵/G) ≈ 1.956×10⁹ | J |
| σ | Stefan-Boltzmann | 2π⁵k_B⁴/(15h³c²) | W/(m²K⁴) |
| R | gázállandó | k_B × N_A | J/(mol·K) |

### Részecske fizika (PDG 2024)

| Szimbólum | Név | Érték | Egység |
|-----------|-----|-------|--------|
| α_s(m_Z) | erős csatolás | 0.1179(9) | dimenziómentes |
| sin²θ_W | Weinberg szög | 0.23122(4) | dimenziómentes |
| m_H | Higgs tömeg | 125.25(11) | GeV/c² |
| m_Z | Z bozon tömeg | 91.1876(2) | GeV/c² |
| m_W | W bozon tömeg | 80.377(12) | GeV/c² |

### Kozmológia (Planck 2018)

| Szimbólum | Név | Érték | Egység |
|-----------|-----|-------|--------|
| H₀ | Hubble | 67.4(5) | km/s/Mpc |
| Ω_Λ | sötét energia | 0.6847(73) | dimenziómentes |
| Ω_m | anyag | 0.3153(73) | dimenziómentes |
| Λ | kozmológiai | ~1.1056×10⁻⁵² | m⁻² |

## Ellenőrzési Protokoll

Amikor egy levezetett értéket ellenőrzünk:

```
1. Számold ki a levezetett értéket (Idris-ben!)
2. Keresd meg a CODATA referenciát (fenti táblázat)
3. Számold ki a hibát: |levezetett - CODATA|
4. Hasonlítsd össze a mérési bizonytalansággal
5. Eredmény:
   - hiba < mérési bizonytalanság → MÉRÉSI HIBÁN BELÜL ✓
   - hiba > mérési bizonytalanság → NEM mérési hibán belül ✗
6. Add meg a relatív hibát: |levezetett - CODATA| / CODATA × 100%
```

## A Jelenlegi Állapot

| Konstans | Levezetett | CODATA | Mérési hiba | Eredmény |
|----------|-----------|--------|------------|----------|
| α⁻¹ | 137.036 | 137.035999177 | ±0.000000021 | NEM (44× túl nagy) |
| G | 6.67429×10⁻¹¹ | 6.67430×10⁻¹¹ | ±0.00015×10⁻¹¹ | IGEN ✓ (25× biztonság) |

## Források

- **NIST CODATA 2022**: https://physics.nist.gov/cuu/Constants/
- **PDG 2024**: https://pdg.lbl.gov/
- **Planck 2018**: https://www.cosmos.esa.int/web/planck

## Fájlok

| Fájl | Tartalom |
|------|----------|
| `~/.agents/skills/codata/SKILL.md` | Ez a skill |
| `osveny_index/LegkisebbMuvelet/KvantumOperatorok.idr` | Idris ellenőrzés |