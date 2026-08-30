# Tanulságok — a 2026-08-17-es közös felfedezések futtatható archívuma

Ezek a fájlok a /tmp-ből lettek ide mentve (a /tmp újraindításnál törlődik).
Mindegyik egy-egy **élő kísérlet**, amelyből az AGENTS.md „Tanulság" szekciója
született. Újrafuttathatók: `idris2 -c <fájl>` (a /tmp-ből másolt séma miatt
egyesek nem fordulnak le — ÉPP EZ A TANULSÁG BENNÜK).

## A kisbetűs-név csapda felderítése (AGENTS.md: Idris 2 csapda)

| Fájl | Mi | Eredmény |
|---|---|---|
| `PróbaÉkezet.idr` | működnek-e az ékezetes azonosítók? | IGEN (a fájlnevet is egyezni kell) |
| `proba_ekezet.idr` | ugyanez kisbetűs fájlnévvel | modulnév-egyezés hiba (tanulság) |
| `PróbaLegkisebb.idr` | `bizKetto : kettoLeg = 2` | ELBUKIK — a csapda minimalisztikusan |
| `PróbaNévvel.idr` | nagybetűs `KettoLegNev` vs `the Nat` | nagybetűs ÁTMEGY, a `the`-s nem |
| `PróbaKicsi2/3.idr`, `PróbaVégső.idr` | a csapda izolálása lépésről lépésre | a `Delay`/unifikáció működése látszik |
| `RosszPélda.idr` / `HelyesPélda.idr` (2026-08-22-ig: Mutatvány/MutatványJó) | a csapda és a megoldás, egymás mellett | rossz: Mismatch; jó: exit 0 |
| `KisBetűsProjekcióCsapda.idr` (2026-08-19) | a csapda KISBETŰS konstansszal függvény-argumentumként (KisAI.idr esete) | rossz: `kezdoKisAI .tudastarProbe` nem redukál; jó: nagybetűs alias ÁTMEGY — a gyógyítás: nagybetűs alias, a kisbetűs marad a futásidejű kódnak |

## A Refl-tanulság felderítése (AGENTS.md: Tanulság: mit bizonyít a Refl)

| Fájl | Mi | Eredmény |
|---|---|---|
| `Cáfolat.idr` | SZÁNDÉKOSAN hamis Refl (8 = 9) | ELUTASÍTVA — a kernel számol, nem hisz |
| `TartalomPróba.idr` | köröző vs strukturált definíció, egyszerre | mindkettő "átmegy" — a köröző üres |
| `TartalomPróba2/3.idr` | a shell-lánc-elgépelés nyomai | a "0 hiba" műtermék esete (l. AGENTS.md 6. pont) |
| `TisztaA/B.idr` | a tiszta újrafuttatás: köröző és strukturált elgépelve | MINDKETTŐ elutasítva — helyreállt a rend |
| `KétÚt.idr` | **A HÍD**: két független konstrukció (16+224 vs 112+128) ugyanarra a 240-re | Refl ✓ |
| `KétÚtElrontva/Elrontva2.idr` (2026-08-22-ig: KetUtTorott/Torott2) | a híd egyik oldalát SZÁNDÉKOSAN elrontva (2·8→2·9, ill. 2⁷→2⁶) | a bizonyítás magától eltörik — a Refl elutasítva |
| `BizonyításEszközök.idr` | Refl + cong + trans (és a rewrite irány-csapdája) | eszköztár, 0 hibával |
| `MiértJó.idr` | a típusok összekeverése (KerdoszoT ≠ Esetrag) | fordítási időben elutasítva |

## Az E8 szimpleptikus cáfolat (2026-08-18) — a "semmi halu" elv működésben

| Fájl | Mi | Eredmény |
|---|---|---|
| `osveny_index/Dirac3D/E8Szimplektikus.idr` | 1. sejtés: MᵀΩM = Ω (E8 ∈ Sp(8,Z)) | ELUTASÍTVA (kernel: -3 ≠ -1) — a Refl nem azt bizonyítja, amit szeretnénk |
| ugyanott | a mért igazság: K = MᵀΩM egész, antiszimmetrikus | GKP-érvényes rács, Refl páronként ✓ |
| ugyanott | `E8BinarisSzimpleptikus`: K ≡ Ω (mod 2), teljes mátrix | Refl ✓ — az E8 mod 2 = qubit-áramkör (Chakraborty–Albert Fig. 5) |
| ugyanott | `sp8TagsagHamis`: M ∉ Sp(8,Z) rögzítve | a cáfolat mint állandó tulajdonság |
| `docs/E8_szimpleptikus_felfedezes.md` | a teljes felfedezés dokumentációja (lánc, Refl-jegyzék, hivatkozások) | a 7-modulos bizonyított lánc |

## Egyéb

| Fájl | Mi |
|---|---|
| `test_kérdőszó.idr`, `HibakeresésFonetika.idr` | korábbi sessionök hibakereső maradványai (megtartva, semmit nem törlünk) |


## A rövidítés-előtag csapda (2026-08-21) — "Dcs nincsen a magyarban"

| Fájl | Mi | Eredmény |
|---|---|---|
| `RövidítésElőtagCsapda.md` | a Dcs/Va (Digraf-/Magánhangzó-rövidítés) konstruktor-család két generáción át élte túl a refaktorálást; a v3 szintaxis-javítása ÁLDÁST ADOTT a hibás nevekre | a felhasználó leleplezte; v4: valódi betűk (Cs..Dzs, A..Ű), 0 hiba |

## A cong globális-fej csapda (2026-08-22) — a KetoldaliKategoria_v3 gyógyításából

| Fájl | Mi | Eredmény |
|---|---|---|
| `CongBeragadtGlobálisFejCsapda.md` (+ a T/opencode Próba*-lánc) | a cong VÁLTOZÓ függvényfejű szakasznál megy, GLOBÁLISnál beragad ("Can't solve: X vs X" azonos tagokkal!); `id` a típusban → `Prelude.id` minősítendő (automatikus implicit!); import NEM tranzitív (Kubit → KomplexByte közvetlenül); konstruktor↔típusálnév ütközés | gyógyír: §18(b) futásidejű kimerítés véges világnál (természetesTranszformációKimerítő = True ✓) |

**A szabály:** konstruktor-név = a valóság neve (`Cs` ≠ `Dcs`); rövidítés-
előtag TILOS (§0+§25); átörökítés (_v2→_v3) előtt NÉV-AUDIT kötelező —
a javítás nem ad felmentést a hibás neveknek.

## A magyar helyesírás (2026-08-21) — "ha szétcsúszik a magyar nyelv, te is szétcsúszol"

| Fájl | Mi | Eredmény |
|---|---|---|
| `MagyarHelyesirasTanulsag.md` | az AkH.12 (helyesiras.mta.hu) gyakorlati kivonata: 4 alapelv + igekötő egybeírás + -val/-vel teljes hasonulás (kóddal, szabállyal) + j/ly + hosszú magánhangzók + vessző a "hogy" előtt + az őrszem szólistájának hibajavítása | a horog-injektor 9. pontja + plugin §N9 |

**A szabály:** "ez tart egyben" — a helyesírás nem esztétika: a toldalékolás
ugyanaz a szóelemző kompozíció, mint a típusokban.

## A magyar matematikai szókincs (2026-08-22) — a projekt hivatalos nyelvezete

| Fájl | Mi | Eredmény |
|---|---|---|
| `MagyarMatematikaiSzókincs.md` | a Gyökrendszer-szócikk (hu.wiki) + Bolyai-fogalomtár + AkH.12 alapján: tétel/lemma/állítás/megjegyzés szókészlet; tükrözés-hipersík-krisztalografikus szakszavak; KÉT javítás a saját szavainkra: reflexió→tükrözés, kristallográfiai→krisztalografikus (következő _v2-hullámban) | a kommentek, napló, bizonyítások innentől e szókincs szerint |
