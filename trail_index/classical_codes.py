"""classical_codes.py — E8 × E8 convolutional codes (numerical computation only).
Hungarian case algebra as 5-bit sub-code within E8 lattice.
Convolutional encoder: not static, state evolves with each step.

Numerical computation — allowed per the no-python rule exception.
"""

import numpy as np
from dataclasses import dataclass, field
from typing import Optional

E8_PARITY = np.array([
    [1,0,0,0,1,0,1,1],
    [0,1,0,0,1,1,0,1],
    [0,0,1,0,1,1,1,0],
    [0,0,0,1,0,1,1,1],
    [0,0,0,0,1,0,0,0],
    [0,0,0,0,0,1,0,0],
    [0,0,0,0,0,0,1,0],
    [0,0,0,0,0,0,0,1],
], dtype=np.int8)

CASES = [
    "NOM","ACC","DAT","INS","COM","CAU","TRA","TER",
    "ILL","INE","ELA","ALL","ADE","ABL","SUP","DEL",
    "SUB","TEM","SOC","DIST","ESS","MOD","CAS","FOR",
]
CASE_CODES: dict[str, np.ndarray] = {
    c: np.array([(i>>b)&1 for b in range(5)]+[0,0,0], dtype=np.int8)
    for i,c in enumerate(CASES)
}
SYNDROME_TO_CASE: dict[tuple,str] = {}
for c,v in CASE_CODES.items():
    SYNDROME_TO_CASE[tuple(int(x) for x in (E8_PARITY@v)%2)] = c

@dataclass
class ConvState:
    prev_case: Optional[str] = None
    prev_vec: np.ndarray = field(default_factory=lambda: np.zeros(8,dtype=np.int8))
    step: int = 0
    def reset(self):
        self.prev_case=None; self.prev_vec=np.zeros(8,dtype=np.int8); self.step=0

def encode_case(case:str, st:ConvState) -> np.ndarray:
    v = CASE_CODES.get(case, np.zeros(8,dtype=np.int8))
    if st.prev_vec is not None: v = (v+st.prev_vec)%2
    for i in range(8):
        if np.any((E8_PARITY@v)%2):
            t=v.copy(); t[i]^=1
            if not np.any((E8_PARITY@t)%2): v=t; break
    r = (v+np.roll(v,1))%2
    st.prev_case=case; st.prev_vec=v; st.step+=1
    return np.concatenate([v,r])

def demo():
    c = ["NOM","ACC","CAU","TRA","DAT","SUB","INE","ELA"]
    st = ConvState()
    for case in c:
        code = encode_case(case, st)
        print(f"{case:6s} → 16D: {''.join(str(b) for b in code[:8])}|{''.join(str(b) for b in code[8:])}")

if __name__=="__main__": demo()
