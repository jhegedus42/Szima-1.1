# SZABALY0-IDRISBEN-LEHETETLEN(átmeneti) — 2026-08-18: a 240 gyök generálása
# ÁTÍRANDÓ Idrisbe (E8Pont = 8 Kubit pontosan tudja!); ez a fáxl legacy-ként marad.
# Az algebra (112+128=240 stb.) az E8Gyokrendszer.idr-ben Refl-lel bizonyítva.
import numpy as np
import math

gyokok = []
# 112 D8-gyok: (±1,±1,0,...,0) — 4 elojel x C(8,2)=28
for i in range(8):
    for j in range(i + 1, 8):
        for elojel_i in (1.0, -1.0):
            for elojel_j in (1.0, -1.0):
                v = np.zeros(8)
                v[i] = elojel_i
                v[j] = elojel_j
                gyokok.append(v)
d8_db = len(gyokok)

# 128 felegesz gyok: (±1/2)^8 paros minuszjellel — 2^8/2 = 2^7
for bits in range(256):
    elojelek = [1.0 if (bits >> k) & 1 else -1.0 for k in range(8)]
    if elojelek.count(-1.0) % 2 == 0:
        gyokok.append(0.5 * np.array(elojelek))
felegesz_db = len(gyokok) - d8_db
gyokok = np.array(gyokok)

# --- az elso 3 D8-gyok tenyleges vektora: ---
for k in range(3):
    v = gyokok[k]
    print('  D8-gyok', k + 1, ':', np.array2string(v, precision=1, suppress_small=True), '| norma^2 =', v @ v)
print('D8-gyokok:', d8_db, '== 4*28 =', 4 * 28, '==', d8_db == 112)
# --- az elso 4 felegesz gyok: a hozza tartozo BAJT (elojelek) is ---
felegesz_vektorok = gyokok[d8_db:]
for k in [0, 1, 2, 3, 127]:
    v = felegesz_vektorok[k]
    bajt = ''.join('1' if x > 0 else '0' for x in v * 2)
    paritas = bajt.count('1')
    print('  felegesz', k + 1, ':', np.array2string(v, precision=1), '| bajt =', bajt, '| 1-esek:', paritas, '(paros!)', '| norma^2 =', v @ v)
mind_paros = all(''.join('1' if x > 0 else '0' for x in v * 2).count('1') % 2 == 0 for v in felegesz_vektorok)
print('MIND a 128 felegesz gyok paros paritasu bajt:', mind_paros)
print('felegesz gyokok:', felegesz_db, '== 2^7 =', 2 ** 7, '==', felegesz_db == 128)
print('E8 osszesen:', len(gyokok), '== 240:', len(gyokok) == 240)
print('dim E8 = 240 + 8 =', len(gyokok) + 8, '== 248:', len(gyokok) + 8 == 248)

normak = np.sum(gyokok ** 2, axis=1)
print('minden gyok norma^2 == 2:', bool(np.allclose(normak, 2.0)))

skalar = gyokok @ gyokok.T
kivono = ~np.eye(len(gyokok), dtype=bool)
ertekek = sorted(set(np.round(skalar[kivono], 6)))
print('kulonbozo gyokok skalarszorzatai:', ertekek, '(simply-laced: {-2,-1,0,1})')

print('Cayley-Dickson: Hurwitz 8+16 =', 8 + 16, '== 24:', 8 + 16 == 24)
print('Oktonion 16+224 =', 16 + 224, '== E8 gyokok:', 16 + 224 == len(gyokok))

print('137 = 11^2 + 4^2 (Gauss-norma):', 11 ** 2 + 4 ** 2 == 137)
print('6*pi^5 vs m_p/m_e hiba%:', abs(6 * math.pi ** 5 - 1836.15267343) / 1836.15267343 * 100)
hbar = 1.054571817e-34
feny = 299792458.0
gravitacio = 6.6743e-11
protontomeg = 1.67262192369e-27
print('log2(alpha_G^-1):', math.log2(hbar * feny / (gravitacio * protontomeg ** 2)), '(~127)')
print('Horgony: 137 + 9/250 =', 137 + 9 / 250, '(a 250 != 240 — kulon szam!)')
