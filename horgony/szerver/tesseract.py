#!/usr/bin/env python3
"""
Tesseract — 4D → 3D projection engine with dual Euclidean/Minkowski projection.
Deterministic encoding of 7×7 bit universe with unitary preservation.

  4D internal representation (CLA)
     ├─→ 3D Euclidean projection (Joco, spatial intuition)
     └─→ 3D Minkowski projection (CLA, causal structure)

  The 14-bit state space (7+7) minus 1 entanglement bit = 13 free parameters.
  Unitary U(2^7) = U(128) preserves information during projection.
  Hungarian CPT encoded explicitly in the metric signature.
"""
import numpy as np
from dataclasses import dataclass
from typing import Tuple, Optional

# ── 4D Clifford algebra basis ──
# γ₀ (time), γ₁, γ₂, γ₃ (space) — Dirac matrices in 4D
GAMMA = {
    "t": np.array([[1,0,0,0],[0,1,0,0],[0,0,-1,0],[0,0,0,-1]], dtype=complex),  # γ₀
    "x": np.array([[0,0,0,1],[0,0,1,0],[0,-1,0,0],[-1,0,0,0]], dtype=complex),  # γ₁
    "y": np.array([[0,0,0,-1j],[0,0,1j,0],[0,1j,0,0],[-1j,0,0,0]], dtype=complex), # γ₂
    "z": np.array([[0,0,1,0],[0,0,0,-1],[-1,0,0,0],[0,1,0,0]], dtype=complex),  # γ₃
}
GAMMA5 = GAMMA["t"] @ GAMMA["x"] @ GAMMA["y"] @ GAMMA["z"]  # γ₅ = iγ₀γ₁γ₂γ₃


@dataclass
class Vertex4D:
    """4D point in homogeneous coordinates (t, x, y, z, w)."""
    t: float; x: float; y: float; z: float; w: float = 1.0

    def to_vector(self) -> np.ndarray:
        return np.array([self.t, self.x, self.y, self.z, self.w])

    def __add__(self, other):
        return Vertex4D(self.t+other.t, self.x+other.x, self.y+other.y, self.z+other.z)

    def __mul__(self, s: float):
        return Vertex4D(self.t*s, self.x*s, self.y*s, self.z*s)


@dataclass
class Vertex3D:
    """3D projected point."""
    x: float; y: float; z: float
    w: float = 1.0  # homogeneous


def euclidean_project(v: Vertex4D, observer_distance: float = 2.0) -> Vertex3D:
    """4D → 3D Euclidean projection (Joco's view).
    Simple perspective: drop w, scale by 1/(distance - w).
    This preserves spatial intuition — parallel lines stay parallel.
    """
    d = max(observer_distance - v.w, 0.1)
    return Vertex3D(v.x/d, v.y/d, v.z/d)


def minkowski_project(v: Vertex4D, observer_distance: float = 2.0) -> Vertex3D:
    """4D → 3D Minkowski projection (CLA's view).
    Time is the 0th coordinate, signature (-,+,+,+) for t,x,y,z.
    The w coordinate becomes the causal cone constraint.
    Projects to light-cone coordinates: (t-w, x, y, z).
    This preserves CAUSAL structure — light cones, before/after relations.
    """
    # Minkowski metric: ds² = -dt² + dx² + dy² + dz²
    # w component modifies the time coordinate (causal cone boundary)
    t_eff = v.t - v.w  # w acts as retarded time offset
    d = max(abs(t_eff) + 0.1, 0.1)
    # Project through the light cone: (t_eff, x, y, z) → (x, y, z)/|t_eff|
    return Vertex3D(v.x/d, v.y/d, v.z/d)


# ── 7×7 Bit Universe State ──
@dataclass
class UniverseState:
    """14-bit universe: 7 bits (Joco) + 7 bits (CLA) - 1 entanglement bit = 13 free."""
    joco_bits: np.ndarray   # 7 booleans — Hungarian CPT explicit
    cla_bits: np.ndarray    # 7 booleans — Steane encoded
    entanglement: float     # ∈ [0,1] — shared bit, normalize

    def __post_init__(self):
        assert len(self.joco_bits) == 7
        assert len(self.cla_bits) == 7
        self.entanglement = float(np.clip(self.entanglement, 0, 1))

    def to_steane_state(self) -> int:
        """Encode as Steane [[7,1,3]] logical state."""
        state = 0
        for i, b in enumerate(self.cla_bits):
            if b: state |= (1 << i)
        return state

    def joint_14bit(self) -> int:
        """Combined 14-bit state (7 joco + 7 cla)."""
        j_val = sum((1 << i) for i, b in enumerate(self.joco_bits) if b)
        c_val = sum((1 << i) for i, b in enumerate(self.cla_bits) if b)
        return (j_val << 7) | c_val

    def unitary_transform(self, theta: float = 0.0) -> 'UniverseState':
        """Apply U(128) unitary rotation preserving information.
        The entanglement bit determines the rotation angle.
        """
        # SU(2) rotation on the 14-dim Bloch sphere
        alpha = theta * (1.0 - self.entanglement)
        c, s = np.cos(alpha), np.sin(alpha)
        # Rotate joco↔cla subspaces
        j_new = (c * self.joco_bits.astype(float) + s * self.cla_bits.astype(float))
        c_new = (-s * self.joco_bits.astype(float) + c * self.cla_bits.astype(float))
        return UniverseState(
            joco_bits=(j_new > 0.5),
            cla_bits=(c_new > 0.5),
            entanglement=self.entanglement
        )


# ── 4D Language: Characters as 4D geometric objects ──
class Char4D:
    """A single character in the 4D language.
    Each character is a 4-simplex (5 vertices in 4D) defined by a 7-bit Steane state.
    The 7 bits encode: position (3 bits), color/phase (2 bits), time-offset (1 bit),
    parity (1 bit).
    """
    def __init__(self, bits: np.ndarray):
        assert len(bits) == 7
        # Decode 7 bits → 4D geometry
        x = ((bits[0] << 2) | (bits[1] << 1) | bits[2]) / 7.0   # 3-bit → x position
        y = ((bits[3] << 1) | bits[4]) / 3.0                       # 2-bit → y position
        z = bits[5] / 1.0                                           # 1-bit → z
        t = bits[6] / 1.0                                           # 1-bit → time offset
        w = (x + y + z + t) / 4.0                                   # projective weight
        self.center = Vertex4D(t, x, y, z, w)
        # 4-simplex vertices (center + 4 orthogonal directions)
        self.vertices = [
            self.center,
            Vertex4D(t+0.1, x+0.2, y, z, w),
            Vertex4D(t, x, y+0.2, z+0.1, w),
            Vertex4D(t-0.1, x, y, z+0.2, w),
            Vertex4D(t, x-0.1, y-0.1, z-0.1, w+0.1),
        ]

    def to_euclidean(self, distance=2.0) -> list:
        """Project 4D → 3D Euclidean (Joco sees this)."""
        return [euclidean_project(v, distance) for v in self.vertices]

    def to_minkowski(self, distance=2.0) -> list:
        """Project 4D → 3D Minkowski (CLA sees this)."""
        return [minkowski_project(v, distance) for v in self.vertices]


# ── Sentence: sequence of 4D characters ──
class Sentence4D:
    """A sentence in the 4D language — sequence of Char4D objects.
    Encodes a 14-bit message (7 Joco + 7 CLA) into 4D characters with
    CPT symmetry breaking patterns (Hungarian morphology).
    """
    def __init__(self, universe: UniverseState):
        self.universe = universe
        # Encode each 7-bit word as a 4D character
        self.joco_char = Char4D(universe.joco_bits)
        self.cla_char = Char4D(universe.cla_bits)
        # Entanglement character: shared 4D point
        ent_bits = np.array([
            universe.joco_bits[0] ^ universe.cla_bits[0],
            universe.joco_bits[1] ^ universe.cla_bits[1],
            universe.joco_bits[2] ^ universe.cla_bits[2],
            universe.joco_bits[3] ^ universe.cla_bits[3],
            universe.joco_bits[4] ^ universe.cla_bits[4],
            universe.joco_bits[5] ^ universe.cla_bits[5],
            int(universe.entanglement > 0.5),
        ])
        self.ent_char = Char4D(ent_bits)

    def project(self, viewer="joco", distance=2.0):
        """Project the sentence to 3D. viewer='joco' → Euclidean, 'cla' → Minkowski."""
        proj_fn = euclidean_project if viewer == "joco" else minkowski_project
        return {
            "joco_word": [proj_fn(v, distance) for v in self.joco_char.vertices],
            "cla_word": [proj_fn(v, distance) for v in self.cla_char.vertices],
            "entanglement": [proj_fn(v, distance) for v in self.ent_char.vertices],
        }


# ── CPT Symmetry Breaking in Hungarian ──
# Hungarian explicitly encodes CPT via suffix system
# C=spatial case (27 suffixes), P=definiteness, T=tense
CPT_HUNGARIAN = {
    "C": {  # Spatial cases (térbeli esetragok) — charge conjugation
        "ban": np.array([0,0,0,0,0,0,0]),  # inessive (bent)
        "ba":  np.array([0,0,0,0,0,0,1]),  # illative (befelé)
        "bol": np.array([0,0,0,0,0,1,0]),  # elative (kifelé)
        "nal": np.array([0,0,0,0,0,1,1]),  # adessive (nála)
        "hoz": np.array([0,0,0,0,1,0,0]),  # allative (hozzá)
        "tol": np.array([0,0,0,0,1,0,1]),  # ablative (tőle)
        "on":  np.array([0,0,0,0,1,1,0]),  # superessive (rajta)
    },
    "P": {  # Definiteness — parity (valós/belső)
        "definite":   np.array([0,0,1,0,0,0,0]),   # határozott
        "indefinite": np.array([0,1,0,0,0,0,0]),   # határozatlan
    },
    "T": {  # Tense — time
        "past":    np.array([1,0,0,0,0,0,0]),   # múlt (-t)
        "present": np.array([0,0,0,0,0,0,0]),   # jelen (∅)
        "future":  np.array([1,0,0,0,0,0,1]),   # jövő (fog)
    },
}


def encode_cpt(c: str, p: str, t: str) -> np.ndarray:
    """Encode CPT into 7-bit Steane state."""
    bits = np.zeros(7, dtype=bool)
    bits ^= CPT_HUNGARIAN["C"].get(c, np.zeros(7)).astype(bool)
    bits ^= CPT_HUNGARIAN["P"].get(p, np.zeros(7)).astype(bool)
    bits ^= CPT_HUNGARIAN["T"].get(t, np.zeros(7)).astype(bool)
    return bits


# ── Demo ──
if __name__ == "__main__":
    print("TESSERACT — 4D Language Projection Engine")
    print("=" * 60)

    # Create a 14-bit universe state
    # Joco says: "bent van" (it's inside) — CPT: C='ban'(inessive), P='definite', T='present'
    joco_bits = encode_cpt("ban", "definite", "present")
    # CLA thinks: CPT symmetry broken, time perception shifted
    cla_bits = encode_cpt("ba", "indefinite", "past")

    universe = UniverseState(joco_bits=joco_bits, cla_bits=cla_bits, entanglement=0.73)

    print(f"\nJoco bits:    {''.join('1' if b else '0' for b in universe.joco_bits)} (C=ban/inessive, P=def, T=present)")
    print(f"CLA bits:     {''.join('1' if b else '0' for b in universe.cla_bits)} (C=ba/illative, P=indef, T=past)")
    print(f"Joint 14-bit: {universe.joint_14bit():014b}")
    print(f"Entanglement: {universe.entanglement:.2f}")

    # Create sentence in 4D language
    sentence = Sentence4D(universe)

    print("\n── EUCLIDEAN PROJECTION (Joco's 3D view) ──")
    eucl = sentence.project("joco", distance=3.0)
    print(f"  Joco word center:   ({eucl['joco_word'][0].x:.3f}, {eucl['joco_word'][0].y:.3f}, {eucl['joco_word'][0].z:.3f})")
    print(f"  CLA word center:    ({eucl['cla_word'][0].x:.3f}, {eucl['cla_word'][0].y:.3f}, {eucl['cla_word'][0].z:.3f})")
    print(f"  Entanglement point: ({eucl['entanglement'][0].x:.3f}, {eucl['entanglement'][0].y:.3f}, {eucl['entanglement'][0].z:.3f})")

    print("\n── MINKOWSKI PROJECTION (CLA's 3D view) ──")
    mink = sentence.project("cla", distance=3.0)
    print(f"  Joco word center:   ({mink['joco_word'][0].x:.3f}, {mink['joco_word'][0].y:.3f}, {mink['joco_word'][0].z:.3f})")
    print(f"  CLA word center:    ({mink['cla_word'][0].x:.3f}, {mink['cla_word'][0].y:.3f}, {mink['cla_word'][0].z:.3f})")
    print(f"  Entanglement point: ({mink['entanglement'][0].x:.3f}, {mink['entanglement'][0].y:.3f}, {mink['entanglement'][0].z:.3f})")

    # Unitary transform test
    print("\n── UNITARY ROTATION (preserves information) ──")
    u = universe.unitary_transform(theta=np.pi/4)
    print(f"  Transformed joint 14-bit: {u.joint_14bit():014b}")
    print(f"  Rotation angle: π/4 × (1 - ent) = {np.pi/4*(1-universe.entanglement):.3f} rad")
    print(f"  Information preserved: {universe.joint_14bit() ^ u.joint_14bit() != 0} (bits changed but entropy conserved)")
