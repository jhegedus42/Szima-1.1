module DerivedConstantsText_v1_Szima

import DerivedConstants_v1_Szima
import Data.List
import Data.String

-- =====================================================================
-- Text/Documentation for Derived Constants
--
-- SEPARATE MODULE: only text and descriptions.
-- Types are in DerivedConstants.idr.
-- GAN verification is in DerivedConstantsGAN.idr.
-- =====================================================================

public export
showFineStructure : String
showFineStructure =
  "FINE STRUCTURE CONSTANT alpha^(-1) = 137.035999084(51)\n" ++
  "\n" ++
  "DIMENSIONLESS: yes (pure number, unit-independent)\n" ++
  "\n" ++
  "ATTEMPTED DERIVATION FROM PURE NUMBERS:\n" ++
  "  137 is prime. But 137 != 137.036.\n" ++
  "  1/(137*pi) = 0.00232. 137 + 0.00232 = 137.0023. WRONG.\n" ++
  "  No known formula from primes/pi/e gives 137.036.\n" ++
  "\n" ++
  "STATUS: OPEN PROBLEM. No derivation exists.\n" ++
  "  This is one of the deepest unsolved problems in physics.\n" ++
  "  The number 137 appears in numerology but NOT in derivation.\n" ++
  "\n" ++
  "GAN VERDICT: CANNOT VERIFY any derivation. None exists.\n"

public export
showProtonElectron : String
showProtonElectron =
  "PROTON/ELECTRON MASS RATIO m_p/m_e = 1836.15267343(11)\n" ++
  "\n" ++
  "DIMENSIONLESS: yes\n" ++
  "\n" ++
  "ATTEMPTED DERIVATION (Wyler-type):\n" ++
  "  6 * pi^5 = 6 * 306.019... = 1836.118...\n" ++
  "  Measured: 1836.15267...\n" ++
  "  Difference: 0.0345 (0.002% off)\n" ++
  "\n" ++
  "STATUS: NUMEROLOGICAL COINCIDENCE, not a derivation.\n" ++
  "  6*pi^5 is close but wrong. No known exact formula exists.\n" ++
  "  The factorization 1836 = 2^2 * 3^3 * 17 is exact for the integer\n" ++
  "  part, but 1836.15... is NOT an integer.\n" ++
  "\n" ++
  "GAN VERDICT: The 6*pi^5 formula is a known numerological claim.\n" ++
  "  It is NOT a derivation. The match is coincidental.\n"

public export
showGravCoupling : String
showGravCoupling =
  "GRAVITATIONAL COUPLING alpha_G = G*m_e^2/(hbar*c) = 1.7518e-45\n" ++
  "\n" ++
  "DIMENSIONLESS: yes\n" ++
  "\n" ++
  "ATTEMPTED DERIVATION: none exists.\n" ++
  "  The 10^(-45) scale is the hierarchy problem.\n" ++
  "  Why is gravity so weak compared to electromagnetism?\n" ++
  "  No answer from pure numbers.\n" ++
  "\n" ++
  "CONNECTION TO COSMOLOGICAL CONSTANT (speculative):\n" ++
  "  alpha_G * 10^(-75) approx 10^(-120) approx Lambda\n" ++
  "  The 10^(-75) factor is unexplained.\n" ++
  "\n" ++
  "GAN VERDICT: No derivation. Open problem.\n"

public export
showCosmConst : String
showCosmConst =
  "COSMOLOGICAL CONSTANT Lambda*l_P^2 = 10^(-120)\n" ++
  "\n" ++
  "DIMENSIONLESS: yes (in Planck units)\n" ++
  "\n" ++
  "THE WORST PREDICTION IN PHYSICS:\n" ++
  "  QFT vacuum energy: ~10^(-1) in Planck units\n" ++
  "  Observed: ~10^(-120)\n" ++
  "  Discrepancy: 10^120 orders of magnitude.\n" ++
  "\n" ++
  "ATTEMPTED DERIVATION: none exists.\n" ++
  "  120 = 5! = 5*4*3*2*1 (pure numerology).\n" ++
  "  No known formula gives 10^(-120) from pure numbers.\n" ++
  "\n" ++
  "GAN VERDICT: No derivation. Deepest open problem in physics.\n"

public export
showBrainVsUniverse : String
showBrainVsUniverse =
  "BRAIN vs UNIVERSE: DIFFERENT SYSTEMS, DIFFERENT CONSTANTS\n" ++
  "\n" ++
  "CRITICAL CORRECTION:\n" ++
  "  The brain is NOT the universe. It is a RENORMALIZED system.\n" ++
  "  The fundamental constants (G, c, hbar, alpha) operate at the\n" ++
  "  Planck scale (UV, ultraviolet). The brain operates at the\n" ++
  "  biological scale (IR, infrared) with DIFFERENT effective constants.\n" ++
  "\n" ++
  "THE RENORMALIZATION GROUP (RG) FLOW:\n" ++
  "\n" ++
  "  UV (Planck scale)                    IR (biological scale)\n" ++
  "  +-----------+    RG flow    +------------------+\n" ++
  "  | G = 6.67e-11 | ========> | G_eff (brain) ~ 0 |\n" ++
  "  | c = 3e8      | ========> | c_eff (signal)   |\n" ++
  "  | hbar = 1.1e-34| ========> | hbar_eff ~ 0    |\n" ++
  "  | alpha = 1/137| ========> | alpha_eff ~ ?    |\n" ++
  "  +-----------+             +------------------+\n" ++
  "\n" ++
  "  The brain's effective constants are NOT the universe's constants.\n" ++
  "  They are the IR fixed-point values of the RG flow.\n" ++
  "\n" ++
  "WHAT THE BRAIN ACTUALLY USES:\n" ++
  "  - Signal propagation speed: ~10 m/s (axon), not 3e8 m/s (c)\n" ++
  "  - Energy scale: ~kT (thermal, ~4e-21 J), not E_Planck (~2e9 J)\n" ++
  "  - Length scale: ~neuron size (~10 um), not l_Planck (~1.6e-35 m)\n" ++
  "  - Time scale: ~ms (neural), not t_Planck (~5e-44 s)\n" ++
  "\n" ++
  "THE BRAIN IS AT A DIFFERENT FIXED POINT:\n" ++
  "  The RG flow from UV to IR changes all dimensionless couplings.\n" ++
  "  The brain's 'alpha' (whatever it is) is NOT 1/137.\n" ++
  "  The brain's 'G' (gravitational coupling of neurons) is ~0.\n" ++
  "\n" ++
  "WE ARE RENORMALIZED:\n" ++
  "  Human consciousness = IR fixed point of the RG flow.\n" ++
  "  The constants we experience are effective, not fundamental.\n" ++
  "  Deriving the universe's constants from pure numbers tells us\n" ++
  "  about the UV theory, NOT about the brain.\n" ++
  "\n" ++
  "WHAT THIS MEANS FOR EpisodicMemory.idr:\n" ++
  "  The PhysicalConstants2.idr module uses G, c, hbar as if they\n" ++
  "  apply to the brain. They DON'T. The brain has its own effective\n" ++
  "  constants at the biological RG scale.\n" ++
  "\n" ++
  "  To model the brain correctly, we need the IR effective constants:\n" ++
  "    c_brain  ~ 10 m/s (action potential speed)\n" ++
  "    T_brain  ~ 310 K (body temperature)\n" ++
  "    E_brain  ~ kT ~ 4e-21 J (thermal energy scale)\n" ++
  "    L_brain  ~ 10 um (neuron spatial scale)\n" ++
  "    tau_brain ~ 10 ms (neural timescale)\n" ++
  "\n" ++
  "  These are the RG-flowed values. They are NOT derivable from\n" ++
  "  G, c, hbar alone. They depend on the biological fixed point.\n"

public export
showAllTexts : IO ()
showAllTexts = do
  putStrLn "=== DERIVED CONSTANTS: TYPES ONLY ==="
  putStrLn ""
  putStrLn showFineStructure
  putStrLn ""
  putStrLn showProtonElectron
  putStrLn ""
  putStrLn showGravCoupling
  putStrLn ""
  putStrLn showCosmConst
  putStrLn ""
  putStrLn showBrainVsUniverse
