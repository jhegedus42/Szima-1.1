# Kutatási napló — 2026-09-02 — 100.01b KÉSZ: a HaromKubit ékezetes átnevezése

## A felhasználó utasítása szó szerint (§N5)

«folytassuk akkor»

## Amit végeztem

### 1. A modul belső átnevezései (HaromKubit.idr — exit 0)
- VilagKonstruktor → **VilágKonstruktor**
- mezők: sajat/masik/fazis → **saját/másik/fázis**
- azonosFazis → **azonosFázis**; Irany → **Irány**;
  SajatMasik/MasikSaját/NincsIrany → **SajátMásik/MásikSaját/NincsIrány**
- irany → **irány**; idoKubit/forrasKubit → **időKubit/forrásKubit**;
  idoFazisba → **időFázisba**
- A MODUL- és TÍPUSNÉV (HaromKubit) **ASCII maradt** — az ékezetes
  fájlnév az NFC/NFD-csapda (#6) lenne; a Steane713-béli konstruktorok
  (IgeIdo, Forras, Mult, Jovo…) a Steane-lépésig (400.03) ékezetlenek.

### 2. Terjedés a 6 importálóba (mind exit 0)
- **FazisAlgebra**: azonosFázis ×3; `toltesParitasIdoIrany : … -> Irány`
  (KÖRNYEZETES csere — a szóHatáron belüli `toltesParitasIdoIrany`
  SAJÁT név megmaradt!) + `irány tpi.…` hívás.
- **Rendszer** (előző törött): VilágKonstruktor ×6 — a nevek a jövőnek.
- **MagyarNyelv**: VilágKonstruktor ×1.
- **KategoriaElmelet**: VilágKonstruktor ×2 + a VALÓDI
  HaromKubit-mező-hozzáférések (v.saját v.másik v.fázis — 875. sor).
- **Kant/Index**: VilágKonstruktor ×3 + mező-hozzáférések.
- **HaromKubitGepeiTeszt**: minden név + a minősített HaromKubit.irány.
- Futás: «igaz»/«hamis» változatlanul helyes ✓.

### 3. CSAPDA #17 — a mező-átnevezés terjedésének túllövése

A `.fazis` → `.fázis` replaceAll a KategoriaElmelet SAJÁT mezőit is
eltalálta (más rekordok azonos nevű mezői!):
- `szo.fázisKubit` → vissza `szo.fazisKubit` (RagozottSzo saját mező);
- `vf.fázis.bizalom/hivatkozasok` → vissza `vf.fazis.…`
  (VilagFa saját mezője — a deklaráció változatlan);
- `vf.saját/vf.másik` → vissza `vf.sajat/vf.masik` (VilagFa mezők —
  a «VilagFa vs HaromKubit» unifikációs hiba árulta el).
**Szabály**: mező-hozzáférés átnevezése ELŐTT nézd meg, melyik
REKORD tagja a hozzáférés (a változó típusa dönt — vf : VilagFa,
v : HaromKubit) — a pont-tövű minta önmagában NEM elég!

### 4. Állapot
- Mind a 7 ép modul exit 0 (Rendszer előző meglévő töréssel, saját
  lépésében újraírandó); a teszt fut.
- A vonal: 74+2 lépés, **7 kész** (000.00–000.04, 100.01, 100.01b);
  következő: **100.02 — Torusz átírása (2 meztelen)**.

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★