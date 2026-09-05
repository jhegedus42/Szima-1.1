module KategoriaStruktura.OsztásBisect_v1

-- ╔══════════════════════════════════════════════════════════════════╗
-- ║ OSZTÁS-BISECT · v1 — FORDÍTÁSI IDEJŰ redukciós hiba lokalizálása  ║
-- ║ 除法二分 · v1 — 定位编译期归约错误                                 ║
-- ║ DIVISION BISECT · v1 — locating the COMPILE-TIME reduction bug    ║
-- ║ DIVISIONS-BISEKTION · v1 —lokalisierung des Compile-Time-Fehlers  ║
-- ╚══════════════════════════════════════════════════════════════════╝
--
-- A futásidő MINDEN értéket helyesen ad (OsztásProbe_v1, 2026-09-04);
-- a kernel (fordítási idő) mégis False-t számolt. Ez a probe APRÓ
-- fordítási idejű állításokkal bisectel: melyik szint Douglas el?
-- 运行时全对而内核编译期算错；本探针用小断言逐级定位。
-- Runtime is fully correct yet the kernel computes False; this probe
-- bisects with tiny compile-time claims.

%default partial

osztás : (n, d : Nat) -> (Nat, Nat)
osztás Z _ = (Z, Z)
osztás (S k) d =
  let (hányados, maradék) = osztás k d in
  if S maradék == d then (S hányados, Z) else (hányados, S maradék)

maradékNullaE : (Nat, Nat) -> Bool
maradékNullaE (_, Z) = True
maradékNullaE _      = False

osztóE : (d, n : Nat) -> Bool
osztóE d n = maradékNullaE (osztás n d)

egyetlenOsztóSem : (n, határ : Nat) -> Bool
egyetlenOsztóSem _ Z     = True
egyetlenOsztóSem n (S k) = not (osztóE (S k) n) && egyetlenOsztóSem n k

-- ─── 1. szint: egy lépéses osztás ───
elsoLepes : osztás 1 2 = (0, 1)
elsoLepes = Refl

-- ─── 2. szint: kicsi, teljes ───
kettoHárom : osztás 3 2 = (1, 1)
kettoHárom = Refl

-- ─── 3. szint: egy csomagolás (wrap) ───
wrapNegy : osztás 4 2 = (2, 0)
wrapNegy = Refl

-- ─── 4. szint: nagyobb, sok wrap ───
sokWrap : osztás 47 2 = (23, 1)
sokWrap = Refl

-- ─── 5. szint: nagy osztó ───
nagyOsztó : osztás 47 46 = (1, 1)
nagyOsztó = Refl

-- ─── 6. szint: osztóE egyedileg ───
osztóEketto : osztóE 2 47 = False
osztóEketto = Refl

osztóEnagy : osztóE 46 47 = False
osztóEnagy = Refl

-- ─── 7. szint: a keresés kicsin ───
keresésHárom : egyetlenOsztóSem 3 2 = True
keresésHárom = Refl

-- ─── 8. szint: a keresés hétes ───
keresésHét : egyetlenOsztóSem 7 6 = True
keresésHét = Refl

-- ─── 9. szint: az összetett-ellenőrzés ───
keresésTíz : egyetlenOsztóSem 10 9 = False
keresésTíz = Refl
