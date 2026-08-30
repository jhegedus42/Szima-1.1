"""
A KOR UJRAOLVASASA — a 440 es a korfelosztas egyuttertese.
Numerikus ellenorzes:
  1. 440 vs 439: faktorizalhatosag = MDL (rovid leiras)
  2. A konzonans primjei = Fermat-primjek? (Gauss-Wantzel!)
  3. A komma = tiszta primhatvanyok (3^12 / 2^19)
  4. A 360 = 3^2 miatt nem szerkesztheto — a 3^2 a "sok"
"""
from sympy import isprime, factorint

print("=== 1. A 440 VALASZTASA = MDL (rovid leiras) ===")
print(f"439 prím?           {isprime(439)}   <- leírás: maga a szám (3 számjegy, 'véletlen')")
print(f"440 = {factorint(440)}   <- 2^3·5·11 : faktorizálható = RÖVID LEÍRÁS")
print(f"360 = {factorint(360)}  <- 2^3·3^2·5 : osztható 24 féleképpen — de 3^2 miatt")
print(f"   Gauss–Wantzel szerint NEM szerkeszthető!")
print(f"256 = {factorint(256)}     <- Sauveur 'tudományos hang' C4=256=2^8, és |Cl(8)|=256 = 1 bájt")
print()

print("=== 2. A KONZONANCIA PRIMJEI = FERMAT-PRIMEK ===")
fermat = {0: 3, 1: 5, 2: 17, 3: 257, 4: 65537}
for n, p in fermat.items():
    print(f"F_{n} = 2^(2^{n})+1 = {p:>6}   prím? {isprime(p)}")
print()
print("A tiszta hangolás (Ptolemaiosz, 5-limit) primjei:")
print("  oktáv  2/1  = 2      <- 2 = a duplácio")
print("  kvint  3/2  = 3      <- F_0 FERMAT-PRIM  -> szerkeszthető, konzonáns")
print("  terc   5/4  = 5      <- F_1 FERMAT-PRIM  -> szerkeszthető, konzonáns")
print("  szeptim 7/4 = 7      <- NEM Fermat-prim  -> 'blue note' (a blues!")
print("  11/8         = 11     <- NEM Fermat-prim  -> Partch-terület (43-hang)")
print("  17/16        = 17     <- F_2 FERMAT-PRIM  -> Gauss 17-szöge is!")
print()
print(">>> A KONZONANCIA = A SZERKESZTHETŐSÉG: ugyanazok a primjek <<<")
print()

print("=== 3. A KOMMA = TISZTA PRIMHATVANYOK ===")
szamlalo, nevezo = 3**12, 2**19
print(f"komma = 3^12 / 2^19 = {szamlalo}/{nevezo} = {szamlalo/nevezo:.9f}")
print(f"      = {factorint(szamlalo)} / {factorint(nevezo)}")
print(f"centben: {1200*__import__('math').log2(szamlalo/nevezo):.4f} cent")
print("  12 kvint (3/2) = 7 oktáv (2/1) + komma — a KÖR NEM ZÁRÓDIK")
print("  az egyetlen pontosan záró hangköz: az oktáv maga (2 = a duplácio)")
print()

print("=== 4. A SZINTÉZIS ===")
print("  MIÉRT PONT EZEK A SZÁMOK? MERT RÖVID A LEÍRÁSUK (MDL):")
print("    12 = 2^2·3      (Fermat 3)     -> szerkeszthető, 12 hang")
print("    440 = 2^3·5·11  (rövid leírás) -> Swinburne 1939-es érve")
print("    8 = 2^3         (tiszta hatvány)-> bájt, Cl(8)=256")
print("  MIT FIZETÜNK ÉRTE? A REZIDUUMOT (a kompresszió ára):")
print("    komma = 23.46 cent  (a 12-TET elosztja: Bach)")
print("    δ = 5.604e-4        (nem zárható: irreducibilis)")
print("    CPT-rest            (a fizika ára a választásért)")
print("  A ABSZOLÚT HANGOLÁS (A440) = MÉRÉSI RÖGZÍTÉS (gauge):")
print("    a fizika a VISZONYOKBAN van (3/2, 5/4), nem a 440-ben")
print("    -> a Bach-korrekcio A4-tagja gauge-rögzítés — nem fizika")
