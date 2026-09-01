# Kutatási napló — 2026-09-01 — az adjunkció + az összes bizonyítható kategóriaelméleti fogalom

## A felhasználó kérdése (szó szerint, §N5)

„adjunkciot vegyuk hozza, illetve az osszes letezo kategoria elmeleti fogalmat amit tudunk bizonyitani"

## 1. A §N11 (olvass-előbb) eredménye

A `osveny_index/KategoriaElmelet.idr` (1337 sor) MÁR TARTALMAZZA 16 kategóriaelméleti fogalmat:
1. Kategoria (record) 2. KategoriaT (interface + törvények) 3. MonoidalisKategoria 4. DualisKategoria 5. Funktor 6. TermeszetesTranszformacio 7. Bifunktor 8. Span 9. Cospan 10. SzimmetrikusMonoidalisKategoria 11. SzorzatKategoria 12. EllenMorf (C^op) 13. **Adjunkcio** (a 117. sortól!) 14. KettoKategoria (2-kategória) 15. **YonedaBeagyazas** (a 143. sortól — a yonedaLemma-mel!) 16. Csoport (Group typeclass)

**Az adjunkció MÁR BENNE VAN** (a 117–124. sorban): `record Adjunkcio` — balFunktor + jobbFunktor + balEgyseg + jobbEgyseg.

## 2. A §N12 (keress a neten) eredménye

A „Proof-relevant Category Theory in Agda" (Hu & Carette, 2020, arXiv:2005.07059) szerint a dependent type theory-ben bizonyítható: Category, Functor, NaturalTransformation, Kan, Monad, Yoneda, Adjoint — MIND.

## 3. A hiányzó 34 kategóriaelméleti fogalom (a KategoriaElmelet.idr-hez kiegészítendő)

### A. Limit/Kolimit család (10 fogalom)
Végződés (terminal), Kezdet (initial), Szorzat (product), Koprodukt (coproduct), Pullback, Pushout, Egyenlőség (equalizer), Koegyenlőség (coequalizer), Limit (általános), Kolimit (általános)

### B. Monad/Comonad család (5 fogalom)
Monad, Comonad, Kleisli-kategória, Eilenberg-Moore-kategória, Szabad monad

### C. Morfizmus-típusok (4 fogalom)
Monomorfizmus, Epimorfizmus, Izomorfizmus, Retrakció

### D. Funktor-típusok (4 fogalom)
Teljes funktor, Hűséges funktor, Ekvivalencia, Felejtő funktor

### E. Magasabb kategóriák (3 fogalom)
Bikategória, Profunctor, Kan kiterjesztés

### F. Kvantum/fizika (4 fogalom)
Dagger kategória (CPT!), Kompakt zárt kategória (E8×E8×E8!), Szalagos kategória (Fano!), Nyom (trace)

### G. Toposz/zárt (4 fogalom)
Toposz, Részobjektum-osztályozó, Exponenciális, Grothendieck-konstrukció

## 4. A morfizmusok a fogalmak között (a gráf élei)

- Adjunkció → Monad; Adjunkció → Comonad
- Monad → Kleisli; Monad → Eilenberg-Moore
- Szabad ⊣ Felejtő (az adjunkció)
- Yoneda → Kan-kiterjesztés
- Limit → Egyenlőség; Kolimit → Koegyenlőség
- Szorzat → Pullback; Koprodukt → Pushout
- Végződés → Szorzat; Kezdet → Koprodukt
- Dagger → CPT-buborék; Kompakt zárt → E8×E8×E8
- Szalagos → Fano; Nyom → kvantum-mérés
- Toposz → „gondolkodási tér"

## 5. A teendő

A `KategoriaElmelet.idr` kiegészítése a 34 hiányzó fogalommal. A GrafKeretrendszerTerv kiegészítése a „XIII. A kategóriaelméleti fogalmak teljes katalógusa" fejezettel.

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★