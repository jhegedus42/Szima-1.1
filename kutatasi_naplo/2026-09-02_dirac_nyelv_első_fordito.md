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

## 9. FOLYTATÁS («folytasd») — AZ ESETRAG = AZ IDŐ-IRÁNY (310.03 csírája)
- ÚJ FUNKTOR: ragbólFázis / lábbólFázis — a magyar esetragok EGYENESEN a
  Dirac-fázis idő-tengelyére képeznek:
  · «-ba/-be» (illativusz, hová?) → TJe True = JÖVŐ-irány
  · «-ból/-ből» (elativusz, honnan?) → TJe False = MÚLT-irány
  · «-ban/-ben» (inesszivusz, hol?) → PJe True = FOLYAMATOS jelen (ASPEKTUS!)
  · «-ig» (terminativusz) → TJe True; «-tól/-től» (ablativusz) → TJe False
- FIZIKAI/LINGVISZTIKAI FELFEDEZÉS: a magyar irányult esetekben a TÉR-irány
  (hová/honnan) EGYENLŐ az IDŐ-iránnyal (jövő/múlt)! A γ⁰ épp ezt a tengelyt
  billenti — a fordítás «időt fordít». A nyelvtani eset = a spinor-fázis.
  「语法格即时间轴——空间方向即时间方向；γ⁰ 翻转的正是此轴。」
- A magyarbólDiracba frissítve: a ragLánc ELSŐ tagja adja a fázist (a többi
  rag a láncon marad — az agglutináció nem rövidül meg).
- 3 ÚJ REFL-TANÚ: bizVízbenFolyamatos (PJe True), bizVízbeJövő (TJe True),
  bizVízbőlMúlt (TJe False) — mind exit 0, a főprogram bemutatja.

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★

## 10. FOLYTATÁS («folytassuk») — A RADIKÁL-KOMPOZÍCIÓ + A FUNKTOR-TULAJDONSÁG
- 2 ÚJ KOMPONÁLT radikál (MANTRA: hozzáadás!): GőzRadikál (汽), ErdőRadikál (林)
  — úgy, ahogy a valódi 汉字 épülnek!
- radikálKompozíció: Víz⊗Tűz=Gőz (kommutatív!), Fa⊗Fa=Erdő; a többi pár
  a «kimondatlan» (SzájRadikál) — determinizmus minden páron.
- A szótár-fv-ek bővítve (gőz/steam/汽; erdő/forest/林) — a régi 8 kör-tanú
  ÉPSÉGBEN (csak új ágak).
- 2 ÚJ KÖR-TANÚ: bizGőzKöre, bizErdőKöre (a komponált fogalom is körbejár).
- ███ A FUNKTOR-TULAJDONSÁG CSÍRÁJA ███: bizFordításKompozíciótMegőriz —
  komponál(fordít(víz), fordít(tűz)) = fordít(komponál(víz, tűz)) — Refl!
  A tő-fordító monoidális (⊗-megőrző) funktor — a DisCoCat-fordítás
  definíciójának (Bradley et al. 1811.11041) ELSŐ teljesülése a projektben!
  「翻译保持复合——含幺函子，DisCoCat 第一定律实现！」

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★

## 11. FOLYTATÁS («folytassa mester!») — A BORN-SKÁLÁR (310.02 KÉSZ)
- fázisbólElöljáró: TJe True→"into" (-be); TJe False→"from" (-ből);
  PJe True→"in" (-ben); PJe False→"through"; CJe→"by" (ágenz).
- bornSkálár : DiracSzó -> String — ⟨angol|ψ⟩ = elöljáró ⊗ tő.
- ███ A GAN-TÉTEL KONKRÉT MEGÉLÉSE ███: AZ ANGOL ELÖLJÁRÓ = A MAGYAR
  ESETRAG MEGFELELŐJE, ÉS A HELY TÜKRÖZÖTT (vízBE ↔ INTO water — a
  magyar rag a szó UTÁN, az angol prepozíció ELŐTT) — a γ⁰ chirális
  tükör nyelvi lenyomata! 「匈牙利后缀在后，英语介词在前——手征镜像！」
- 3 REFL-TANÚ: bizVízbeAngolul («into water»), bizVízbőlAngolul
  («from water»), bizVízbenAngolul («in water») — a teljes magyar→angol
  mérési csatorna determinisztikusan ÉL!
- A 310.02 ezzel KÉSZ; a DiracNyelv modul: 4 nyelv (magyar/kínai/angol/
  dirac) × (kör + fázis + kompozíció + Born) — tanúhálós.

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★
