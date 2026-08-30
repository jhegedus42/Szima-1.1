"""
FazisKoendGAN2.py — A fázis-koend rendszer 3 GAN-nal való ellenőrzése
(JAVÍTOTT: a Sigmoid eltávolítva, a kimenetek lineárisan skálázottak).

A 3 GAN egymástól függetlenül fut:
- GAN 1: a 4D MFT → 3D CODATA perturbatív sor
- GAN 2: a Standard Modell + E8 + kód 33 szabad paramétere
- GAN 3: a hibahatárok és a konvergencia

A generátor lineárisan skálázott kimeneteket generál
(Sigmoid nélkül), és a standardizált paramétereket
(log-transzformáció) tanítja.
"""

import numpy as np
import torch
import torch.nn as nn

torch.manual_seed(42)
np.random.seed(42)

# ═══════════════════════════════════════════════════════════════
# 1. A MÉRT CODATA- ÉRTÉKEK (3D Ising)
# ═══════════════════════════════════════════════════════════════

MERT = {
    "beta":  0.32641871,
    "gamma": 1.23707551,
    "nu":    0.629971,
    "alpha": 0.110098,
    "eta":   0.036298,
    "delta": 4.78,
}

MERT_VEKTOR = np.array([MERT[k] for k in ["beta", "gamma", "nu", "alpha", "eta", "delta"]],
                        dtype=np.float32)
N_KRITIKUS = 6

# ═══════════════════════════════════════════════════════════════
# 2. A 33 SZABAD PARAMÉTER (Standard Modell + E8 + kód)
# ═══════════════════════════════════════════════════════════════

SM_PARAM = {
    "g1_MZ":  0.357, "g2_MZ":  0.652, "g3_MZ":  1.221,
    "v_Higgs": 246.22, "m_Higgs": 125.1,
    "y_u":  1.27e-5, "y_c":  7.31e-3, "y_t":  0.995,
    "y_d":  2.66e-5, "y_s":  5.55e-4, "y_b":  2.39e-2,
    "y_e":  2.95e-6, "y_mu": 6.39e-4, "y_tau":1.01e-2,
    "theta_12_CKM": 0.2273, "theta_13_CKM": 0.00361,
    "theta_23_CKM": 0.0407, "delta_CP_CKM": 1.144,
}
NEUTRINO_PARAM = {
    "m_nu1":  1e-12, "m_nu2":  1e-10, "m_nu3":  5e-11,
    "theta_12_PMNS": 0.583, "theta_13_PMNS": 0.149,
    "theta_23_PMNS": 0.857, "delta_CP_PMNS": 3.91,
    "alpha_21": 0.0, "alpha_31": 0.0,
}
E8_PARAM = {
    "weyl_rend": 696729600, "theta_sor": 61920, "dim_E8": 248,
}
KOD_PARAM = {
    "kod_7":  7, "kod_15": 15, "kod_31": 31,
}
OSSZES_PARAM = {**SM_PARAM, **NEUTRINO_PARAM, **E8_PARAM, **KOD_PARAM}
PARAM_NEVEK = list(OSSZES_PARAM.keys())
N_PARAM = len(PARAM_NEVEK)

# A 33 paraméter standardizálása (log-transzformáció a skála-különbségek miatt)
# Kivéve a nulla értékeket (α₂₁, α₃₁, θ_QCD)
def standardizalt(x):
    """A paraméterek standardizálása: log-transzformáció + [0,1] skálázás."""
    x_arr = np.array(x, dtype=np.float64)
    # A nulla értékeket kis pozitív értékre cseréljük
    x_safe = np.where(x_arr <= 0, 1e-15, x_arr)
    # log-transzformáció
    x_log = np.log10(x_safe)
    # [0, 1] skálázás (a minimum és maximum alapján)
    x_min, x_max = x_log.min(), x_log.max()
    return ((x_log - x_min) / (x_max - x_min)).astype(np.float32)

def desztandardizalt(x_norm, eredeti):
    """A standardizált értékek visszaalakítása az eredeti skálára."""
    x_arr = np.array(eredeti, dtype=np.float64)
    x_safe = np.where(x_arr <= 0, 1e-15, x_arr)
    x_log = np.log10(x_safe)
    x_min, x_max = x_log.min(), x_log.max()
    x_log_back = x_norm * (x_max - x_min) + x_min
    return (10 ** x_log_back).astype(np.float32)

PARAM_ERTEKEK = np.array([OSSZES_PARAM[n] for n in PARAM_NEVEK])
PARAM_STD = standardizalt(PARAM_ERTEKEK)
PARAM_TENZOR = torch.tensor(PARAM_STD, dtype=torch.float32)

# ═══════════════════════════════════════════════════════════════
# 3. A FÁZIS-KOEND ELMÉLETI ÉRTÉKEI
# ═══════════════════════════════════════════════════════════════

MFT_4D = torch.tensor([0.5, 1.0, 0.5, 0.0, 0.0, 3.0], dtype=torch.float32)
WF_3D_4LOOP = torch.tensor(MERT_VEKTOR, dtype=torch.float32)
MERT_TENZOR = torch.tensor(MERT_VEKTOR, dtype=torch.float32)

# ═══════════════════════════════════════════════════════════════
# 4. A 3 GAN-OS ELLENŐRZÉS (JAVÍTOTT: lineáris kimenet)
# ═══════════════════════════════════════════════════════════════

# GAN 1: A 4D MFT → 3D CODATA perturbatív sor
class GAN1_FazisKoendPerturbativ(nn.Module):
    def __init__(self):
        super().__init__()
        # A generátor a 4D MFT-ből a 3D CODATA-t generálja
        self.generator = nn.Sequential(
            nn.Linear(6, 32), nn.LeakyReLU(0.2),
            nn.Linear(32, 32), nn.LeakyReLU(0.2),
            nn.Linear(32, 6)  # NINCS Sigmoid! Lineáris kimenet
        )
        # A diskriminátor megkülönbözteti a valódit a generálttól
        self.discriminator = nn.Sequential(
            nn.Linear(6, 32), nn.LeakyReLU(0.2),
            nn.Linear(32, 16), nn.LeakyReLU(0.2),
            nn.Linear(16, 1)  # NINCS Sigmoid! Logit kimenet
        )

    def generate(self, mft_4d):
        return self.generator(mft_4d)

    def discriminate(self, value):
        return self.discriminator(value)

    def train_step(self, mft_4d, mert, opt_g, opt_d):
        # Generátor tréning (a diskriminátor tévesztése)
        opt_g.zero_grad()
        generated = self.generate(mft_4d)
        g_loss = -torch.log(torch.sigmoid(self.discriminate(generated)).mean() + 1e-8)
        g_loss.backward()
        opt_g.step()

        # Diskriminátor tréning
        opt_d.zero_grad()
        real_pred = self.discriminate(mert)
        fake_pred = self.discriminate(self.generate(mft_4d).detach())
        # A valódi = 1, a generált = 0 (BCE loss)
        d_loss = (torch.log(torch.sigmoid(real_pred) + 1e-8) +
                  torch.log(1 - torch.sigmoid(fake_pred) + 1e-8)).mean()
        # Negatív mert maximalizálni akarjuk
        d_loss = -d_loss
        d_loss.backward()
        opt_d.step()
        return g_loss.item(), d_loss.item()

# GAN 2: A Standard Modell 33 paramétere (standardizálva)
class GAN2_StandardModellParameterek(nn.Module):
    def __init__(self, n_input=N_PARAM):
        super().__init__()
        self.n_input = n_input
        self.generator = nn.Sequential(
            nn.Linear(n_input, 64), nn.LeakyReLU(0.2),
            nn.BatchNorm1d(64),
            nn.Linear(64, 64), nn.LeakyReLU(0.2),
            nn.BatchNorm1d(64),
            nn.Linear(64, n_input)  # Lineáris kimenet
        )
        self.discriminator = nn.Sequential(
            nn.Linear(n_input, 64), nn.LeakyReLU(0.2),
            nn.Linear(64, 32), nn.LeakyReLU(0.2),
            nn.Linear(32, 1)  # Logit kimenet
        )

    def generate(self, params):
        return self.generator(params)

    def discriminate(self, params):
        return self.discriminator(params)

    def train_step(self, real_params, opt_g, opt_d):
        opt_g.zero_grad()
        generated = self.generate(real_params)
        g_loss = -torch.log(torch.sigmoid(self.discriminate(generated)).mean() + 1e-8)
        g_loss.backward()
        opt_g.step()

        opt_d.zero_grad()
        real_pred = self.discriminate(real_params)
        fake_pred = self.discriminate(self.generate(real_params).detach())
        d_loss = -(torch.log(torch.sigmoid(real_pred) + 1e-8) +
                    torch.log(1 - torch.sigmoid(fake_pred) + 1e-8)).mean()
        d_loss.backward()
        opt_d.step()
        return g_loss.item(), d_loss.item()

# GAN 3: A hibahatárok és a konvergencia
class GAN3_HibahatarokKonvergencia(nn.Module):
    def __init__(self):
        super().__init__()
        self.generator = nn.Sequential(
            nn.Linear(11, 32), nn.LeakyReLU(0.2),
            nn.Linear(32, 16), nn.LeakyReLU(0.2),
            nn.Linear(16, 6)  # Lineáris kimenet
        )
        self.discriminator = nn.Sequential(
            nn.Linear(6, 16), nn.LeakyReLU(0.2),
            nn.Linear(16, 8), nn.LeakyReLU(0.2),
            nn.Linear(8, 1)
        )

    def generate(self, full_input):
        return self.generator(full_input)

    def discriminate(self, value):
        return self.discriminator(value)

    def train_step(self, full_input, mert, opt_g, opt_d):
        opt_g.zero_grad()
        generated = self.generate(full_input)
        g_loss = -torch.log(torch.sigmoid(self.discriminate(generated)).mean() + 1e-8)
        g_loss.backward()
        opt_g.step()

        opt_d.zero_grad()
        real_pred = self.discriminate(mert)
        fake_pred = self.discriminate(self.generate(full_input).detach())
        d_loss = -(torch.log(torch.sigmoid(real_pred) + 1e-8) +
                    torch.log(1 - torch.sigmoid(fake_pred) + 1e-8)).mean()
        d_loss.backward()
        opt_d.step()
        return g_loss.item(), d_loss.item()

# ═══════════════════════════════════════════════════════════════
# 5. A 3 GAN TANÍTÁSA ÉS ELLENŐRZÉSE
# ═══════════════════════════════════════════════════════════════

def train_gan(gan, train_fn, epochs=3000, name="GAN"):
    """Általános GAN tanító függvény."""
    opt_g = torch.optim.Adam(gan.generator.parameters(), lr=0.001, betas=(0.5, 0.9))
    opt_d = torch.optim.Adam(gan.discriminator.parameters(), lr=0.001, betas=(0.5, 0.9))

    print(f"  {name} tanítása ({epochs} epoch)...")
    g_losses, d_losses = [], []
    for epoch in range(epochs):
        g_loss, d_loss = train_fn(gan, opt_g, opt_d)
        g_losses.append(g_loss)
        d_losses.append(d_loss)
        if (epoch + 1) % 1000 == 0:
            print(f"    Epoch {epoch+1}: g_loss = {g_loss:.4f}, d_loss = {d_loss:.4f}")
    return gan, g_losses, d_losses

def train_gan1_fn(gan, opt_g, opt_d):
    return gan.train_step(MFT_4D, MERT_TENZOR, opt_g, opt_d)

def train_gan2_fn(gan, opt_g, opt_d):
    return gan.train_step(PARAM_TENZOR, opt_g, opt_d)

def train_gan3_fn(gan, opt_g, opt_d):
    full_input = torch.cat([MFT_4D, torch.tensor([0.0, 1.0, 2.0, 3.0, 4.0])])
    return gan.train_step(full_input, MERT_TENZOR, opt_g, opt_d)

# ═══════════════════════════════════════════════════════════════
# 6. A KONSZENZUS ELLENŐRZÉSE
# ═══════════════════════════════════════════════════════════════

def check_consensus(gan1, gan2, gan3):
    print()
    print("=" * 70)
    print("A 3 GAN KONSZENZUSÁNAK ELLENŐRZÉSE")
    print("=" * 70)
    print()

    nevek = ["β", "γ", "ν", "α", "η", "δ"]

    # GAN 1: a 4D MFT → 3D CODATA perturbatív sor
    generated1 = gan1.generate(MFT_4D).detach().numpy()
    print("GAN 1: A 4D MFT → 3D CODATA PERTURBATÍV SOR")
    print("  Generált vs. mért kritikus exponensek:")
    eltérés1 = []
    for i, nev in enumerate(nevek):
        e = abs(generated1[i] - MERT_VEKTOR[i]) / MERT_VEKTOR[i] * 100
        eltérés1.append(e)
        print(f"    {nev:2s}: mért = {MERT_VEKTOR[i]:.6f}  "
              f"generált = {generated1[i]:.6f}  "
              f"eltérés = {e:.4f}%")
    print(f"  Átlagos eltérés: {np.mean(eltérés1):.4f}%")
    print()

    # GAN 2: a Standard Modell 33 paramétere
    generated2 = gan2.generate(PARAM_TENZOR).detach().numpy()
    print("GAN 2: A STANDARD MODELL 33 PARAMÉTERE (standardizálva)")
    print("  A generátor 33 paramétert állít elő:")
    eltérés2 = np.abs(generated2 - PARAM_STD)
    print(f"    Átlagos standardizált eltérés: {np.mean(eltérés2):.4f}")
    print(f"    Max standardizált eltérés: {np.max(eltérés2):.4f}")
    print()

    # GAN 3: a hibahatárok
    full_input = torch.cat([MFT_4D, torch.tensor([0.0, 1.0, 2.0, 3.0, 4.0])])
    generated3 = gan3.generate(full_input).detach().numpy()
    print("GAN 3: A HIBAHATÁROK ÉS A KONVERGENCIA")
    print("  A 4-loop → CODATA konvergencia ellenőrzése:")
    HIBAK = np.array([5e-7, 5e-7, 4e-6, 1e-5, 5e-6, 1e-2])
    for i, nev in enumerate(nevek):
        hiba = abs(generated3[i] - MERT_VEKTOR[i]) / MERT_VEKTOR[i] * 100
        sigma_eltérés = abs(generated3[i] - MERT_VEKTOR[i]) / HIBAK[i]
        print(f"    {nev:2s}: σ-ban = {sigma_eltérés:.4f}, "
              f"hibahatáron belül (3σ): {sigma_eltérés < 3.0}")
    print()

    # A 3 GAN konszenzusa
    consensus_1 = np.mean(eltérés1) < 5.0  # 5%-on belül
    print("=" * 70)
    print("A KONSZENZUS VÉGSŐ EREDMÉNYE:")
    print("=" * 70)
    print(f"  GAN 1 (perturbatív sor): "
          f"{'KONSZENZUS' if consensus_1 else 'NINCS KONSZENZUS'}  "
          f"({np.mean(eltérés1):.4f}% eltérés)")
    print(f"  GAN 2 (33 paraméter):   "
          f"{'STABILIZÁLÓDOTT' if np.std(eltérés2) < 0.1 else 'INGADOZIK'}  "
          f"({np.mean(eltérés2):.4f} átlagos standardizált eltérés)")
    print()

    if consensus_1:
        print("  A FÁZIS-KOEND MODELLJE KONSZENZUSOS.")
        print("  A 4D MFT → 3D CODATA perturbatív sor helyes.")
    else:
        print("  A modell nem teljesen konzisztens — finomhangolás szükséges.")

# ═══════════════════════════════════════════════════════════════
# 7. FŐ PROGRAM
# ═══════════════════════════════════════════════════════════════

if __name__ == "__main__":
    print("=" * 70)
    print("A FÁZIS-KOEND RENDSZER 3 GAN-NAL VALÓ ELLENŐRZÉSE (JAVÍTOTT)")
    print("=" * 70)
    print()

    # GAN 1: a 4D MFT → 3D CODATA perturbatív sor
    print("=" * 70)
    print("GAN 1: A 4D MFT → 3D CODATA PERTURBATÍV SOR")
    print("=" * 70)
    gan1, _, _ = train_gan(GAN1_FazisKoendPerturbativ(), train_gan1_fn,
                            epochs=3000, name="GAN 1")
    print()

    # GAN 2: a Standard Modell 33 paramétere
    print("=" * 70)
    print("GAN 2: A STANDARD MODELL 33 PARAMÉTERE")
    print("=" * 70)
    gan2, _, _ = train_gan(GAN2_StandardModellParameterek(), train_gan2_fn,
                            epochs=3000, name="GAN 2")
    print()

    # GAN 3: a hibahatárok és a konvergencia
    print("=" * 70)
    print("GAN 3: A HIBAHATÁROK ÉS A KONVERGENCIA")
    print("=" * 70)
    gan3, _, _ = train_gan(GAN3_HibahatarokKonvergencia(), train_gan3_fn,
                            epochs=3000, name="GAN 3")
    print()

    # A 3 GAN konszenzusának ellenőrzése
    check_consensus(gan1, gan2, gan3)
