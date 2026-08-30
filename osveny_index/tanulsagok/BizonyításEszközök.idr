module BizonyításEszközök

-- 1. ESZKÖZ: Refl — ha a két oldal kiszámolva egyezik (a mi 240-ünk):
aKetUt : (2 * 8 + 224) = (4 * 28 + 128)
aKetUt = Refl

-- 2. ESZKÖZ: cong — ha egy belső részen már van bizonyításunk,
--    a külső függvény "átemeli" (a hivatalos tutorial példája):
plusNullaBalra : (n : Nat) -> 0 + n = n
plusNullaBalra n = Refl

plusNullaJobbra : (n : Nat) -> n + 0 = n
plusNullaJobbra Z     = Refl          -- 0 + 0 = 0: számolással kész
plusNullaJobbra (S k) = cong S (plusNullaJobbra k)   -- S k + 0 = S (k + 0)

-- 3. ESZKÖZ: trans — két bizonyítás LÁNCA: (a = b) -> (b = c) -> (a = c)
ketszerPluszNulla : (n : Nat) -> (n + 0) + 0 = n
ketszerPluszNulla n = trans (plusNullaJobbra (n + 0)) (plusNullaJobbra n)
--   1. láncszem: (n+0)+0 = n+0      [plusNullaJobbra, n+0-ra alkalmazva]
--   2. láncszem: n+0    = n          [plusNullaJobbra n maga]
