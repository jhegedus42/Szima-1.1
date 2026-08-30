module TartalomPróba2

-- 1. KÖRÜLÍRÓ definíció: a tartalom a DEFINÍCIÓBAN van (112+128
--    = két különböző számítási út), a Reflnek munkája van:
public export
E8Szerkesztve : Nat
E8Szerkesztve = (4 * 28) + 126 + 1

-- 2. KÖRKÖRÖS definíció: barom egyszerűen beírom a 240-et.
--    Ugyanolyan jól "bizonyítható" — és NULLA információt hordoz:
public export
E8Beirva : Nat
E8Beirva = 240

-- Mindkettő "bizonyítható":
BizSzerkesztve : E8Szerkesztve = 240
BizSzerkesztve = Refl

BizBeirva : E8Beirva = 240
BizBeirva = Refl
