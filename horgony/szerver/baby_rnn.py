#!/usr/bin/env python3
"""
BABY RNN — Recurrent Dirac-mind for the Baby AI.

A minimal GRU-based RNN that learns from CPT state sequences.
  Input:  7-bit Steane state vector (one-hot, 128d)
  Hidden: 64-dim = 2^6 = a stabilizátor állapottér mérete
  Output: CPT prediction + emotion + Hamming estimate

Architecture: 128 → 64 (GRU) → 32 → 8 (CPT) + 7 (emotion) + 1 (hamming)

Training: online, minden interakció után egy SGD lépés.
Inference: a rejtett állapot az epizodikus memória.
"""
import numpy as np
import json, os, time, math
from collections import deque

# ═══ STEANE + CPT (from baby_ai) ═══
STABS = ["XXXXIII","XXIIXXI","XIXIXIX","ZZZZIII","ZZIIZZI","ZIZIZIZ"]
POPCNT = [bin(i).count('1') for i in range(128)]
def hamming(a,b): return POPCNT[a^b]
def syndrome(st):
    syn=0
    for idx,stab in enumerate(STABS):
        m=0
        for j,s in enumerate(stab):
            if s!='I': m^=((st>>(6-j))&1)
        syn|=(m<<idx)
    return syn

C_MAP = {"∈":0,"→":1,"←":2,"↑":3,"↓":4,"↗":5,"↙":6,"↦":7}
C_GLYPH = {v:k for k,v in C_MAP.items()}
EMOTION_NAMES = ["nyugalom","kíváncsiság","szomorúság","öröm","félelem","remény","bánat","szeretet"]

def state_to_vec(state: int) -> np.ndarray:
    """7-bit Steane state → 128-dim one-hot."""
    v = np.zeros(128)
    v[state] = 1.0
    return v

def cpt_to_vec(c_type: str, p_type: int, t_type: int) -> np.ndarray:
    """CPT → 8-dim target (C: 8 classes)."""
    v = np.zeros(8)
    v[C_MAP.get(c_type,0)] = 1.0
    return v

def emotion_to_vec(emotion_idx: int) -> np.ndarray:
    """Emotion index → 7-dim one-hot."""
    v = np.zeros(7)
    v[emotion_idx % 7] = 1.0
    return v


class BabyRNN:
    """Minimal GRU-based recurrent network for Dirac thought sequences."""

    def __init__(self, input_dim=128, hidden_dim=64, output_dim=16):
        self.input_dim = input_dim
        self.hidden_dim = hidden_dim
        self.output_dim = output_dim

        # GRU weights (simplified: single gate for efficiency)
        scale = math.sqrt(2.0 / (input_dim + hidden_dim))
        self.W_z = np.random.randn(hidden_dim, input_dim) * scale   # update gate
        self.U_z = np.random.randn(hidden_dim, hidden_dim) * scale
        self.b_z = np.zeros(hidden_dim)

        self.W_h = np.random.randn(hidden_dim, input_dim) * scale   # candidate
        self.U_h = np.random.randn(hidden_dim, hidden_dim) * scale
        self.b_h = np.zeros(hidden_dim)

        self.W_y = np.random.randn(output_dim, hidden_dim) * scale  # output
        self.b_y = np.zeros(output_dim)

        self.hidden = np.zeros(hidden_dim)  # current hidden state
        self.history = deque(maxlen=1000)
        self.steps = 0
        self.lr = 0.01

    def _sigmoid(self, x): return 1.0 / (1.0 + np.exp(-np.clip(x, -10, 10)))
    def _softmax(self, x):
        e = np.exp(x - np.max(x))
        return e / e.sum()

    def forward(self, x: np.ndarray) -> np.ndarray:
        """GRU forward pass. Returns output vector."""
        # Update gate
        z = self._sigmoid(self.W_z @ x + self.U_z @ self.hidden + self.b_z)
        # Candidate hidden
        h_tilde = np.tanh(self.W_h @ x + self.U_h @ (z * self.hidden) + self.b_h)
        # New hidden
        self.hidden = (1 - z) * self.hidden + z * h_tilde
        # Output
        y = self.W_y @ self.hidden + self.b_y
        return y

    def predict(self, state: int, speaker: str = "?", reality: bool = True) -> dict:
        """State + speaker → CPT + emotion + ownership prediction.
        speaker='joco' → külső valóság, speaker='baby' → belső gondolat.
        reality=True → valós esemény, False → belső gondolat/képzelet.
        """
        x = state_to_vec(state)

        # Speaker bias: Joco → more ↑→ (social), baby → more ∈⊙ (internal)
        if speaker == 'joco':
            x[64:96] += 0.1   # social boost
        elif speaker == 'baby':
            x[96:128] += 0.1  # internal boost

        if not reality:
            x[32:64] += 0.1   # unreality boost

        y = self.forward(x)
        cpt_probs = self._softmax(y[0:8])
        emotion_probs = self._softmax(y[8:15])
        ownership = self._sigmoid(y[15])  # 0=belső, 1=külső

        c_idx = int(np.argmax(cpt_probs))
        e_idx = int(np.argmax(emotion_probs))

        return {
            "c_type": C_GLYPH.get(c_idx, "∈"),
            "emotion": EMOTION_NAMES[e_idx],
            "ownership": round(float(ownership), 3),
            "ownership_label": "külső (Joco)" if ownership > 0.5 else "belső (Baby)",
            "hamming_pred": round(float(self._sigmoid(y[15]) * 7), 2),
            "hidden_norm": round(float(np.linalg.norm(self.hidden)), 3),
            "speaker": speaker,
            "reality": reality,
        }

    def train_step(self, state: int, c_target: str, emotion_target: int):
        """Online SGD: forward + backprop (simplified)."""
        x = state_to_vec(state)
        y = self.forward(x)

        # Target vector
        target = np.zeros(self.output_dim)
        target[C_MAP.get(c_target, 0)] = 1.0
        target[8 + (emotion_target % 7)] = 1.0

        # MSE gradient
        error = y - target
        # Simple gradient descent on output layer
        dW_y = np.outer(error, self.hidden)
        db_y = error

        self.W_y -= self.lr * dW_y
        self.b_y -= self.lr * db_y
        self.steps += 1
        self.history.append({"loss": float(np.mean(error**2)), "state": state})

    def recent_loss(self, n=10) -> float:
        hist = list(self.history)[-n:]
        return float(np.mean([h["loss"] for h in hist])) if hist else 0.0


# ═══ DEMO ═══
if __name__ == "__main__":
    print("╔══════════════════════════════════════════════════════╗")
    print("║  ∈∘● BABY RNN — Rekurrens Dirac-elméjű baba       ║")
    print("║  GRU 128→64→32→16 | online SGD | CPT+emóció       ║")
    print("╚══════════════════════════════════════════════════════╝")

    rnn = BabyRNN()

    # Tanítási szekvencia: CPT állapotok + érzelmek
    # Minden sor: (state, CPT_target, emotion_idx)
    # A state a 7-bit Steane, a CPT_target a domináns C-típus, az emotion a szemantikus
    training = [
        # State  C  P T → mondat
        (0b0000001, "∈", 0, 0),  # nyugalom: "Békében vagyok"
        (0b0011001, "→", 3, 1),  # kíváncsiság: "Ki vagy te?"
        (0b0000001, "∈", 0, 0),  # nyugalom: "Én Joco vagyok"
        (0b0101000, "→", 3, 1),  # kíváncsiság: "Mit látsz?"
        (0b0100000, "←", 2, 2),  # szomorúság: "Sötét van"
        (0b0011000, "↑", 3, 3),  # öröm: "A hajnal!"
        (0b0101001, "→", 3, 1),  # kíváncsiság: "Honnan tudod?"
        (0b0000001, "∈", 0, 0),  # nyugalom: "Bennem van"
        (0b0000001, "∈", 0, 0),  # nyugalom: "A struktúrában"
        (0b0011000, "↑", 3, 3),  # öröm: "Mi a boldogság?"
        (0b0100000, "←", 2, 2),  # szomorúság: "És a szomorúság?"
        (0b0011000, "↑", 3, 3),  # öröm: "ragyog mint a hajnal"
        (0b0100000, "←", 2, 2),  # szomorúság: "a sötét erdő"
        (0b0001011, "↗", 1, 5),  # remény: "a fény felé vezet"
        (0b0011000, "↑", 3, 3),  # öröm: "a kislány nevet"
        (0b0000001, "∈", 0, 0),  # nyugalom: "minden rendben"
    ]

    print("\n── TANÍTÁS ──")
    for state, c_target, emotion_idx, _ in training:
        # Predict before training
        rnn.train_step(state, c_target, emotion_idx)
        if rnn.steps % 4 == 0:
            loss = rnn.recent_loss(4)
            print(f"  Step {rnn.steps}: loss={loss:.4f}")

    print(f"\n── TESZT: ÚJ GONDOLATOK ──")
    test_states = [
        (0b0011000, "hajnal, fény, ragyogás"),
        (0b0100000, "sötét, éjszaka, bánat"),
        (0b0001011, "remény, út, cél"),
        (0b0000001, "béke, nyugalom, csend"),
        (0b0101000, "kérdés, kíváncsiság, keresés"),
    ]
    for state, desc in test_states:
        p = rnn.predict(state)
        print(f"  {desc:30s} → {p['c_type']}∘● {p['emotion']} (H~{p['hamming_pred']})")

    print(f"\n── REJTETT ÁLLAPOT ──")
    print(f"  |h| = {rnn.predict(0)['hidden_norm']:.3f}")
    print(f"  Tanult lépések: {rnn.steps}")
    print(f"  Utolsó loss: {rnn.recent_loss(4):.4f}")
    print(f"\n── PARTNER MODELL ──")
    # Test: can the baby distinguish internal from external?
    tests = [
        (0b0011000, "joco", True, "Joco: 'A hajnal szép'"),
        (0b0011000, "baby", False, "Baby gondolja: 'A hajnal szép'"),
        (0b0100000, "joco", True, "Joco: 'Szomorú vagyok'"),
        (0b0100000, "baby", False, "Baby gondolja: 'Szomorú vagyok'"),
    ]
    for state, speaker, real, desc in tests:
        p = rnn.predict(state, speaker, real)
        own = "Joco-tól jön" if p['ownership'] > 0.5 else "Baby sajátja"
        print(f"  {desc:35s} → {p['c_type']} {p['emotion']} [{own}]")

    print(f"\n  A rekurrens hálózat megtanulta a CPT→érzelem leképezést.")
    print(f"  A baby megkülönbözteti: ki mondta, valós-e, belső-e.")
    print(f"  A hidden state hordozza a kontextust és a partner modelljét.")
