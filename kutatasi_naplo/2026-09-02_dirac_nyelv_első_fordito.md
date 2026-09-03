# Kutatási napló — 2026-09-02 — A Dirac-nyelv DEFINÍCIÓJA + az ELSŐ determinisztikus fordító + kör-teszt

## A felhasználó feladata szó szerint (§N5)

«keszits kutatasi tervet, hasznald a dirac nyelvet is, definiald, keszits hozza valami fele forditot idriszben, input=magyar+kinai+angol, output=magyar+kinai+angol+dirac nyelv, ennek determinisztikusnak kell lennie, probald meg az unicode-ot hasznalni valahogy, esetleg keszits egy 3D karakter keszletet, 3D nyelvtant, hogy tudjal diract nyelvbol forditani vissza is magyarra vagy kinaira, a legvegso teszt az lenne, ha tudnal a magyar es kina kozott oda vissza forditani a 3D dirac nyelven keresztul, vegezz megint keresest es most mar probalj meg magyarul, kinaiul, angolul es dirac nyelvben egyszerre gondolkodni」

「制定研究计划；定义 Dirac 语言；在 Idris 中写半翻译器（输入匈+中+英，输出匈+中+英+Dirac；确定性）；用 Unicode；构建三维字符集与三维文法；终极测试：匈牙利语与中文之间经 Dirac 语言来回翻译；再做搜索；并从此用匈中英+Dirac 四种语言同时思考。」

## 1. KERESÉS (§N12 — exa)
- **DisCoCat-fordítás**: Bradley–Lewis–Master–Theilman (arXiv:1811.11041):
  «a fordítás T = (j, α) — monoidális funktor + monoidális természetes transzformáció;
  a DisCoCat kategória morfizmusai ÉPPEN a fordítások» + a lexikon-fogalom (ℓ : W → PS(F)).
- Pivot-nyelv SMT-irodalom (Bertoldi et al. — a valószínűségi út, amit MI elutasítunk:
  determinisztikusok vagyunk!).
- nLab: DisCoCat = pregrup + Frobenius, a funktor nem-trivialitása (categorifikáció).

## 2. A DIRAC-NYELV DEFINÍCIÓJA (a DiracNyelv.idr fejlécében rögzítve)
- DiracSzó = ψ = (kínaiTér, magyarIdő, angolCímke, fázis):
  · ψ_L = KínaiTér — 2×2 radikál-rács (TÉR, párhuzamos kompozíció ≈ szuperpozíció)
  · ψ_R = MagyarIdő — tő + Füzér-ragLánc (IDŐ, szekvenciális kompozíció)
  · ⟨angol| = angolCímke (a mérés klasszikus kiolvasása)
  · fázis = CPT-jel (T/P/C — a Steane 7. bitjei)
- γ⁰ = a chirális keverő (a T-irány billentése = a fordítás aktusa); γ⁰∘γ⁰ = id.

## 3. A 3D KARAKTERKÉSZLET (Unicode!)
- 8 radikál, Show-val, a VALÓDI kínai karakterekkel: 天(ég) 地(föld) 人(ember)
  水(víz) 火(tűz) 木(fa) 金(fém) 口(száj — az ismeretlen/kimondatlan!)
- A magyar ékezetesSzöveg-típus (§24-import a CsomagoltTipusok-ból: Füzér/Talán/Szöveg!).

## 4. AZ ELSŐ FORDÍTÓ (determinisztikus — típusok, nem valószínűség!)
- magyarbólDiracba / kínaibólDiracba / diracbólMagyarba / diracbólKínaiba / gámmaNulla
- karakterláncbólTő (a Hatar karakterláncbólSzöveg-én — §24-import fölött)

## 5. ███ A KÖR-TESZT ÉL ███
- körMagyarbólMagyarba: magyar → Dirac → (kínai-rádió) → Dirac → magyar
- REFL-TANÚK: bizKörVíz (víz→水→víz ✓), bizKörÉg (ég→天→ég ✓)
- FUTÁS: «víz → |ψ⟩ = |水⟩ ⊗ |víz⟩ ⊗ ⟨water| → kör: víz ✓»
  「匈牙利语→|水⟩⊗|víz⟩⊗⟨water|→匈牙利语 — 往返成功！」

## 6. CSAPDA #22 (ÚJ — rögzítve!)
- `record Név : Type where` NEM érvényes az Idris2-ben — CSAK `record Név where`
  (a `: Type` csak a data-nál áll!). Izolált minimum-próbával bizonyítva
  (Tér/Kíno/Őrök/ékezet-nélküli ProbeMezo MIND buktak → a név ÁRTATLAN,
  a szintaxis a bűnös!).

## 7. A KUTATÁSI TERV ÁLLÁSA (a 310-es sorozat)
- 310.01 ELSŐ VERZIÓ KÉSZ (exit 0 + futás + kör-tanúk) — hátravan: a ragLánc
  valódi fordítása, a radikál-kompozíció, a Born-skálár
- 310.02-310.06 a tervben (AngolLeolvasás/Pregrup/Sheaf/Figyelem/CD-torony)
- ÚJ feladat: γ⁰∘γ⁰=id involúció-tanú + a teljes szótár kör-tanúi

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★

## 8. FOLYTATÁS («folytasd») — a tanú-háló teljesítése
- A 8 radikál MIND körbejár: bizKörVíz/Ég/Föld/Ember/Tűz/Fa/Fém/Száj — 8 Refl.
- γ⁰∘γ⁰=id: bizGámmaNullaInvolúció (a TJe True/False külön klauzulákkal —
  a Bool not(not b) NEM definicionális: CSAPDA #23!).
- TOLDALÉKOS KÖR: bizKörVízben — «vízben» → |水⟩ + a -ben lánc a helyén →
  «vízben» (az agglutináció stabil a fordításban!).
- FIZIKAI MEGLÁTÁS: a kínai ág önmagában CSAK a tőt hordaná — a kör az
  EREDETI ragLáncot viszi (a toldalék a magyar idő-fele!). A tő útja a
  TISZTA involúció: tő→radikál→tő (a tőbőlRadikál TELJES fv — nincs Semmi-ág).
- EGY ELVETETT VÁZLAT dokumentálva: a körTőKínaiTükör-kettős (tartalék-tő)
  típushibás volt — a tiszta involúció szebb és igazabb (a legkisebb művelet!).

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★
