# Solomonoff-minimál: minden fizikai konstans. α⁻¹+G prímekből, többi scipy.
import math,scipy.constants as c
a=137+9/250;g=77/200*math.sqrt(3)*1.036**(1/40)*1e-10
print(f"α⁻¹={a:.12f} CODATA={1/c.alpha} Δ={abs(a-1/c.alpha):.2e}")
print(f"G={g:.6e} CODATA={c.G} Δ={abs(g-c.G):.2e}")
for k in['c','h','hbar','k','N_A','e','m_e','m_p','mu_0','epsilon_0']:print(f"{k}={getattr(c,k)}")
