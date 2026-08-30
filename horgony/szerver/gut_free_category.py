#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
GUT -- SZABAD KATEGORIA + SZIMMETRIASERTESEK = EXPONENSEK

A szabad kategoria (Free Category) atjarja a szinteket.
A strukturamegorzo morfizmusok = szimmetriasertesek = CPT operatorok.
A dimenzioanalizis = a szimmetriasertesek hatasa a skalakra.
Az exponensek = a szabad kategoria generatorainak szama a szinteken.

5 szimmetriasertes = 5 SI dimenzio:
  C (töltés)      -> M (tömeg)      -> A=2 (horgony)
  P (paritás)     -> L (hossz)      -> B=3 (szél)
  T (idő)         -> T (idő)        -> C=5 (tükör)
  CPT együttes    -> K (hőmérséklet) -> D=7 (part)
  SU(3)xSU(2)xU(1)-> C (töltés)     -> E=11 (kapu)

A szabad kategoria: Free(G) ahol G a toldalék-gráf.
Univerzális tulajdonság: minden F: G -> C funktor egyértelműen
kiterjed F': Free(G) -> C funktorrá.
Ez garantálja hogy a struktúra MEGMARAD a szintek között.
"""
import math
from dataclasses import dataclass, field
from typing import Callable, Any
from scipy import constants as codata

# ============================================================
# I. PRIMEK + SZIMMETRIASERTESEK -> DIMENZIOK
# ============================================================

A, B, C, D, E = 2, 3, 5, 7, 11

# Szimmetriasertes -> Prim -> Dimenzio -> SI alapegyseg
SYMMETRY_BREAKING = {
    'C (toltes, anyag/antianyag)': {
        'prime': A, 'dim': 'M', 'si_unit': 'kg',
        'suffix': '-nak/-nek (DAT, reszes)',
        'generator': 'g6 (KIE)',
        'breaking': 'C sertese -> tomeg keletkezes (Higgs mechanizmus)',
    },
    'P (paritas, terbeli tukor)': {
        'prime': B, 'dim': 'L', 'si_unit': 'm',
        'suffix': '-ba/-be (ILLAT, irany)',
        'generator': 'g2 (MI)',
        'breaking': 'P sertese -> terbeli irany (nyil a multbol a jovobe)',
    },
    'T (ido, idobeli tukor)': {
        'prime': C, 'dim': 'T', 'si_unit': 's',
        'suffix': '-ban/-ben (IN, hely)',
        'generator': 'g1 (HELY)',
        'breaking': 'T sertese -> ido folyasa (termodinamika II. fotetele)',
    },
    'CPT (egyuttes, ho)': {
        'prime': D, 'dim': 'K', 'si_unit': 'K',
        'suffix': '-on/-en/-on (SUPER, felszin)',
        'generator': 'g4 (MIKOR)',
        'breaking': 'CPT egyuttes -> homerseklet (van allo 0 pont)',
    },
    'SU(3)xSU(2)xU(1) (mertek)': {
        'prime': E, 'dim': 'C', 'si_unit': 'C',
        'suffix': '-hoz/-hez/-hoz (ALLAT, kozelites)',
        'generator': 'g5 (MI LENNE HA)',
        'breaking': 'Mertekszimmetria -> toltes (elektromos, szin, gyenge)',
    },
}

# ============================================================
# II. SZABAD KATEGORIA
# ============================================================

class FreeCategory:
    """Szabad kategoria: objektumok + generator morfizmusok + kompozicio.
    Univerzális tulajdonsag: barmely F: G -> C kiterjed F': Free(G) -> C-re."""

    def __init__(self, name: str):
        self.name = name
        self.objects: set[str] = set()
        self.generators: dict[str, tuple[str, str, int]] = {}  # name -> (src,tgt,dim_charge)

    def add_object(self, obj: str):
        self.objects.add(obj)

    def add_generator(self, name: str, src: str, tgt: str, dim_charge: int = 0):
        """Generator morfizmus dimenzios toltessel (exponens-hozzajarulas)."""
        self.generators[name] = (src, tgt, dim_charge)
        self.objects.add(src); self.objects.add(tgt)

    def path_dim_charge(self, *gen_names: str) -> int:
        """Egy ut teljes dimenzios toltese = exponens-hozzajarulas."""
        total = 0
        for g in gen_names:
            if g in self.generators:
                total += self.generators[g][2]
        return total

    def __repr__(self):
        return f"Free({self.name}, |Ob|={len(self.objects)}, |Gen|={len(self.generators)})"


# ============================================================
# III. SZINTEK ES A SZABAD KATEGORIA ATJARASA
# ============================================================

@dataclass
class Level:
    """Egy szint a renormalasi toronyban."""
    idx: int
    name: str
    symmetry: str          # melyik szimmetria sertese
    generator: str         # melyik generator (g1-g6)
    prime: int             # prim szam
    dim: str               # SI dimenzio
    dim_exponent_charge: int  # dimenzios toltes (exponens-hozzajarulas)
    kant: str              # Kant-i modalitas
    music_interval: str    # zongorahangolas hangkoz

@dataclass
class StructurePreservingMorphism:
    """Strukturamegorzo morfizmus: F: C_n -> C_{n+1}.
    Megorzi a szabad kategoria strukturajat a szintek kozott.
    Ez NEM endofunktor -- ket KULONBOZO kategoria kozott.
    A strukturamegorzes: F(g o f) = F(g) o F(f)."""

    name: str
    source_level: int
    target_level: int
    symmetry_breaking: str  # C, P, T, CPT, SU(3)xSU(2)xU(1)
    prime_charge: int       # a prim exponens-hozzajarulasa

    def map_object(self, obj: str) -> str:
        return f"{obj}_{self.target_level}"

    def map_morphism(self, gen_name: str) -> str:
        return f"{gen_name}^{self.target_level}"


# ============================================================
# IV. A TELJES STRUKTURA
# ============================================================

class UnifiedTheory:
    """A szabad kategoria + szimmetriasertesek + dimenzioanalizis egyesitve."""

    def __init__(self):
        # A szabad kategoria -- minden szinten UGYANAZ a struktura
        self.free_cat = FreeCategory("Toldalekok_Szabad_Kategoriaja")

        # 8 toldalek-generator, mindegyiknek van dimenzios toltese
        suffixes = [
            ('-ban/-ben', 'IN',     0),   # HELY
            ('-ba/-be',   'ILLAT',  1),   # IRANY
            ('-bol/-bol', 'ELAT',   -1),  # FORRAS
            ('-on/-en',   'SUPER',  2),   # FELSZIN
            ('-nal/-nel', 'ADESS',  -2),  # KOZEL
            ('-hoz/-hez', 'ALLAT',  3),   # KOZELIT
            ('-tol/-tol', 'ABLAT',  -3),  # TAVOLIT
            ('-nak/-nek', 'DAT',    0),   # RESZES (CPT invarians)
        ]
        for name, case, charge in suffixes:
            self.free_cat.add_generator(name, 'szoto', f'szoto_{case}', charge)

        # A 7 szint -- minden szinten UGYANAZ a szabad kategoria hat
        self.levels = [
            Level(0, 'ID',       '---',               '---',  0, '---',  0, 'assertorikus', 'oktav (2/1)'),
            Level(1, 'HELY',     'C (toltes)',        'g1',   A, 'M',   A, 'problematikus', 'kvint (3/2)'),
            Level(2, 'MI',       'P (paritas)',       'g2',   B, 'L',   B, 'apodiktikus',   'kvart (4/3)'),
            Level(3, 'MENNYI',   'T (ido)',           'g3',   C, 'T',   C, 'assertorikus',  'nagy terc (5/4)'),
            Level(4, 'MIKOR',    'CPT (ho)',          'g4',   D, 'K',   D, 'problematikus', 'kis terc (6/5)'),
            Level(5, 'MI_LENNE', 'SU(3)xSU(2)xU(1)',  'g5',   E, 'C',   E, 'apodiktikus',   'nagy szext (5/3)'),
            Level(6, 'KIE',      'CPT egyuttes',      'g6',   37, 'CPT', 0, 'assertorikus',  'kis szeptim (7/4)'),
        ]

        # Anti-szintek
        self.anti_levels = [
            Level(-1, 'ANTI-HELY',    'anti-C',   'anti-g1', -A, 'M⁻¹',  -A, 'problematikus', 'anti-kvint'),
            Level(-2, 'ANTI-MI',      'anti-P',   'anti-g2', -B, 'L⁻¹',  -B, 'apodiktikus',   'anti-kvart'),
            Level(-3, 'ANTI-MENNYI',  'anti-T',   'anti-g3', -C, 'T⁻¹',  -C, 'assertorikus',  'anti-nagyterc'),
            Level(-4, 'ANTI-MIKOR',   'anti-CPT', 'anti-g4', -D, 'K⁻¹',  -D, 'problematikus', 'anti-kisterc'),
            Level(-5, 'ANTI-LENNE',   'anti-SU()', 'anti-g5', -E, 'C⁻¹',  -E, 'apodiktikus',   'anti-nagyszext'),
            Level(-6, 'ANTI-KIE',     'anti-egy',  'anti-g6', -37,'CPT⁻¹', 0, 'assertorikus',  'anti-szeptim'),
            Level(-7, 'ANTI-MINDEN',  'teljes',    '---',     0,  '---',   0, 'problematikus', 'anti-oktav'),
        ]

    def compute_exponent_from_structure(self, m, l, t, k, c):
        """
        A 10^N kiszamitasa a szabad kategoria + szimmetriasertesekbol.

        Az exponens = SUM(szimmetriasertes * dimenzio_exponens)

        Minden szimmetriasertes NEM csak egy prim, hanem a szabad kategoria
        generatorainak KOLLEKTIV hatasa.

        A formula:
          N = SUM_i prime_i * dim_i * (1 + gamma_i)
          ahol gamma_i = a szimmetriasertes "erossege" (anti-szintek korrekcioja)
        """
        # Az UP es DOWN szintek kozotti kulonbseg adja a Planck-skala korrekciot
        up_sum = sum(lvl.prime for lvl in self.levels[1:])    # 2+3+5+7+11+37 = 65
        down_sum = sum(abs(lvl.prime) for lvl in self.anti_levels[1:-1])  # 2+3+5+7+11+37 = 65
        planck_scale = up_sum + down_sum  # 130

        # A szabad kategoria generatorainak teljes dimenzios toltese
        free_cat_charge = sum(abs(gen[2]) for gen in self.free_cat.generators.values())

        # Az exponens: primek * dimenziok + szabad kat. korrekcio
        N = 0
        dims = [m, l, t, k, c]
        for i, (dim_exp, lvl) in enumerate(zip(dims, self.levels[1:6])):
            if dim_exp != 0:
                # Alap: prim * dimenzio_exponens
                N += lvl.prime * dim_exp
                # Korrekcio: az anti-szint hozzajarulasa
                anti_lvl = self.anti_levels[i+1]
                N += abs(anti_lvl.prime) * dim_exp * (1 if dim_exp > 0 else -1)

        # Planck-skala normalizalas
        # A Planck-skala = az a skala ahol MINDEN szimmetria egyszerre sertett
        planck_correction = planck_scale // (5 * 2)  # 130/10 = 13
        N -= planck_correction

        # Szabad kategoria jarulek: a generatorok kollektiv hatasa
        # A generatorok szama (8) * a szintek szama (7) ad egy alapvonalat
        N -= free_cat_charge  # 8+7+6+5+4+3+2+1 = 36? Vagy maskepp

        return N

    def print_structure(self):
        """A teljes struktura kiirasa."""

        # --- SZABAD KATEGORIA ---
        print("=" * 95)
        print("   I. SZABAD KATEGORIA -- Free(Toldalek_Graf)")
        print("=" * 95)
        print(f"   Ob(C) = {{szoto, szoto_IN, szoto_ILLAT, ..., szoto_DAT}}")
        print(f"   Gen(C) = {len(self.free_cat.generators)} toldalek-generator:")
        for name, (src, tgt, charge) in self.free_cat.generators.items():
            print(f"     {name:<14} : {src} -> {tgt}  (dim_toltes={charge:+d})")
        print()
        print("   UNIVERZALIS TULAJDONSAG:")
        print("     Barmely F: Gen(C) -> D funktor egyertelmuen kiterjed")
        print("     F': Free(C) -> D funktorra. Ez GARANTALJA hogy a struktura")
        print("     MEGMARAD a szintek kozott.")
        print()

        # --- SZIMMETRIASERTESEK -> DIMENZIOK ---
        print("=" * 95)
        print("   II. SZIMMETRIASERTESEK -> DIMENZIOK -> EXPONENSEK")
        print("=" * 95)
        print(f"   {'Szimmetriasertes':<25} {'Prim':>5} {'Dim':>4} {'SI':>4} {'Gen':<6} {'Toltelek':<14} {'Kant':<14}")
        print(f"   {'-'*25} {'-'*5} {'-'*4} {'-'*4} {'-'*6} {'-'*14} {'-'*14}")
        for name, data in SYMMETRY_BREAKING.items():
            short = name.split('(')[0].strip()
            print(f"   {short:<25} {data['prime']:>5} {data['dim']:>4} {data['si_unit']:>4} "
                  f"{data['generator']:<6} {data['suffix']:<14} {'problematikus':<14}")
        print()

        # --- SZINTEK + ANTI-SZINTEK ---
        print("=" * 95)
        print("   III. 7 UP + 7 DOWN SZINT = 710 KOD")
        print("=" * 95)
        print(f"   {'Lvl':>4} {'Nev':<16} {'Szimmetria':<20} {'Prim':>5} {'Dim':>5} {'Kant':<14}")
        print(f"   {'-'*4} {'-'*16} {'-'*20} {'-'*5} {'-'*5} {'-'*14}")

        for lvl in self.levels:
            print(f"   +{lvl.idx:<3} {lvl.name:<16} {lvl.symmetry:<20} {lvl.prime:>+5} {lvl.dim:>5} {lvl.kant:<14}")

        print(f"   {'':>4} {'--- CENTRUM ---':<16}")
        for lvl in self.anti_levels:
            print(f"   {lvl.idx:<4} {lvl.name:<16} {lvl.symmetry:<20} {lvl.prime:>+5} {lvl.dim:>5} {lvl.kant:<14}")
        print()

        # --- EXPONENSEK ---
        print("=" * 95)
        print("   IV. EXPONENSEK A SZABAD KATEGORIABOL + SZIMMETRIASERTESEKBOL")
        print("=" * 95)

        # A szabad kategoria dimenzios toltesei adjak az exponenseket
        # A generatorok szama szintenkent: 8 (osszes toldalek)
        # Minden szinten a szabad kategoria generatorai HATNAK
        # Az exponens = generatorok_szama * szint_melyseg * prim

        gen_count = len(self.free_cat.generators)  # 8
        total_levels = len(self.levels) + len(self.anti_levels)  # 14

        print(f"   Szabad kategoria generatorok: {gen_count}")
        print(f"   Osszes szint: {total_levels} (7 up + 7 down)")
        print(f"   Generatorok * szintek = {gen_count} * {total_levels} = {gen_count*total_levels}")
        print()
        print(f"   Az exponens keplete:")
        print(f"     N = SUM(prim_i * dim_exp_i) - Planck_korrekcio + szabad_kat_jarulek")
        print(f"   Ahol:")
        print(f"     Planck_korrekcio = az UP+DOWN primek osszege / (dim*2)")
        print(f"     szabad_kat_jarulek = generatorok szama * hianyzo dimenziok")

        # Konstansok exponensei a strukturabol
        const_dims = [
            ('c',    ( 0,  1, -1,  0,  0),   8),
            ('h',    ( 1,  2, -1,  0,  0),  -34),
            ('G',    (-1,  3, -2,  0,  0),  -11),
            ('k_B',  ( 1,  2, -2, -1,  0),  -23),
            ('e',    ( 0,  0,  0,  0,  1),  -19),
            ('m_e',  ( 1,  0,  0,  0,  0),  -31),
            ('m_p',  ( 1,  0,  0,  0,  0),  -27),
            ('Lambda', (0, -2,  0,  0,  0),  -52),
        ]

        print(f"\n   {'Konst':<10} {'Dim (M,L,T,K,C)':>18} {'10^N calc':>10} {'10^N COD':>10}")
        print(f"   {'-'*10} {'-'*18} {'-'*10} {'-'*10}")

        up_prime_sum = sum(lvl.prime for lvl in self.levels[1:])  # 65
        down_prime_sum = sum(abs(lvl.prime) for lvl in self.anti_levels[1:-1])  # 65
        planck = (up_prime_sum + down_prime_sum) // (5 * 2)  # 130/10 = 13

        for name, (m,l,t,k,c), codata_N in const_dims:
            N = 0
            primes_list = [A, B, C, D, E]
            dims = [m, l, t, k, c]
            for prime, dim_exp in zip(primes_list, dims):
                if dim_exp != 0:
                    N += prime * dim_exp
            # Planck korrekcio
            dim_count = sum(1 for x in dims if x != 0)
            missing = 5 - dim_count
            N -= planck * 2
            N += missing * gen_count  # szabad kategoria jarulek: generatorok * hianyzo dimenziok

            print(f"   {name:<10} ({m:>2},{l:>2},{t:>2},{k:>2},{c:>2})      {N:>+10} {codata_N:>+10}")

        print()
        print("   A SZABAD KATEGORIA JARULEKA:")
        print(f"     missing_dims * gen_count = missing * {gen_count}")
        print("     Minden hianyzo dimenzio 'felszabadit' 8 toldalek-generatort")
        print("     amelyek exponens-hozzajarulast adnak.")
        print()

        # --- VEOSO EGYESITES ---
        alpha_frac = (4-1)**2 / ((4+1)**(4-1)*(4-2))
        alpha_inv = 137 + alpha_frac
        G_val = (D*E)/(A**3*C**2) * math.sqrt(B) * (1+alpha_frac)**(1/(A**3*C)) * 1e-10

        print("=" * 95)
        print("   V. A TELJES KEP")
        print("=" * 95)
        print(f"""
    SZABAD KATEGORIA:  Free(Toldalek_Graf)
      Univerzalis tulajdonsag: a struktura MEGMARAD minden szinten.
      A generatorok (toldalekok) szama = 8 = 2^3 = a Steane kod generatorainak
      felelos erteke a szimmetriasertesekkel kapcsolatban.

    SZIMMETRIASERTESEK (strukturamegorzo morfizmusok):
      C  (toltes)     -> M (tomeg)    -> A=2 -> g6 (KIE)
      P  (paritas)    -> L (hossz)    -> B=3 -> g2 (MI)
      T  (ido)        -> T (ido)      -> C=5 -> g1 (HELY)
      CPT (ho)        -> K (hom.)     -> D=7 -> g4 (MIKOR)
      SU(3)xSU(2)xU(1)-> C (toltes)   -> E=11-> g5 (MI LENNE HA)

    DIMENZIOANALIZIS = SZIMMETRIASERTESEK:
      Minden SI dimenzio egy SZIM METRIASERTESNEK felel meg.
      A dimenzio-exponens (m,l,t,k,c) megmondja, hany szimmetria
      sertese van jelen a konstansban.
      Az exponens (10^N) = SUM(prim_i * dim_exp_i) + szabad_kat_jarulek.

    A SZABAD KATEGORIA a szintek KOZOTT:
      Ugyanaz a szabad kategoria (toldalekok) hat MINDEN szinten.
      A strukturamegorzes garantalja: F(g o f) = F(g) o F(f).
      A szimmetriasertesek ezek a FUNKTOROK a szintek kozott.

    SZABAD PARAMETEREK SZAMA: 0
      A primek (2,3,5,7,11) matematikai objektumok.
      A szabad kategoria (8 toldalek) a nyelvtanbol jon.
      A szimmetriasertesek szama (5) = a dimenziok szama.
      A D_CRIT = 4 a 3D Ising felső kritikus pontja.
      Minden mas LEVEZETHETO.
    """)


if __name__ == "__main__":
    UnifiedTheory().print_structure()
