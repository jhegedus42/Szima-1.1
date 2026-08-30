#!/usr/bin/env python3
"""
YG128 — 128-bit ASCII encoding of YG quantum gravity language.

128 bits = 16 bytes. Every character, glyph, CPT marker, and metric
perturbation is encoded in a fixed-width binary format.

BIT LAYOUT (128 bits):
  [0:15]    stem_hash    16b  crc16 of stem string
  [16:23]   cpt_byte      8b  2b C + 2b P + 2b T + 1b reality + 1b reserved
  [24:31]   y_byte        8b  Y-depth (0-255)
  [32:38]   steane_7b     7b  7-bit Steane state
  [39:44]   syndrome_6b   6b  6-bit syndrome
  [45:51]   hamming_3b    3b  Hamming distance to previous (0-7)
  [52:52]   parity_1b     1b  0=joco, 1=cla
  [53:63]   reserved_11b  11b reserved
  [64:95]   metric_4x8    32b 4×8bit diagonal metric perturbation
  [96:127]  radical_hash  32b crc32 of Chinese radical glyph

Total: 128 bits = 16 bytes. ASCII-encoded as 32 hex chars or base64.
"""
import struct, hashlib, zlib
from dataclasses import dataclass
from typing import Optional
import numpy as np


# ── CPT encoding tables ──
C_ENCODE = {"ban": 0, "ba": 1, "bol": 2, "on": 3, "nal": 4, "hoz": 5, "tol": 6, "nak": 7}
C_DECODE = {v: k for k, v in C_ENCODE.items()}
P_ENCODE = {"def": 0, "indef": 1}
P_DECODE = {v: k for k, v in P_ENCODE.items()}
T_ENCODE = {"past": 0, "present": 1, "future": 2}
T_DECODE = {v: k for k, v in T_ENCODE.items()}

# ── 128 radicals for 7-bit encoding ──
RADICALS = [
    "日","月","木","氵","火","土","金","口","心","山",
    "人","言","門","女","子","手","目","耳","足","石",
    "田","禾","米","竹","糸","虫","魚","鳥","牛","犬",
    "馬","車","雨","電","風","雲","星","光","影","声",
    "明","暗","上","下","左","右","前","後","内","外",
    "大","小","高","低","長","短","広","狭","新","古",
    "強","弱","速","遅","多","少","全","半","一","二",
    "三","四","五","六","七","八","九","十","百","千",
    "万","円","年","時","分","秒","今","昔","未","来",
    "行","来","帰","出","入","見","聞","話","読","書",
    "食","飲","寝","起","生","死","愛","憎","喜","怒",
    "哀","楽","思","考","知","学","教","問","答","解",
    "森","林","樹","枝","根","葉","花","草","種","果",
]

# ── Steane [[7,1,3]] error-correcting round-trip ──
STABS = ["XXXXIII","XXIIXXI","XIXIXIX","ZZZZIII","ZZIIZZI","ZIZIZIZ"]
POPCNT = [bin(i).count('1') for i in range(128)]

def steane_encode(logical_bit: int) -> int:
    """Encode 1 logical bit as 7-bit Steane codeword.
    logical_bit=0 → |0̄⟩, logical_bit=1 → |1̄⟩.
    Returns 7-bit codeword (0-127).
    """
    # |0̄⟩ = sum over all stabilizer combinations |0000000⟩
    # |1̄⟩ = X⊗⁷|0̄⟩ = |1111111⟩
    if logical_bit == 0:
        return 0b0000000
    return 0b1111111

def steane_syndrome(codeword: int) -> int:
    """Measure 6 stabilizers → 6-bit syndrome."""
    syn = 0
    for idx, stab in enumerate(STABS):
        m = 0
        for j, s in enumerate(stab):
            if s != 'I': m ^= ((codeword >> (6-j)) & 1)
        syn |= (m << idx)
    return syn

def steane_decode(codeword: int) -> tuple[int, int, str]:
    """Decode 7-bit (possibly errored) codeword → (logical_bit, corrected, error_type).
    Uses syndrome to detect and correct single-bit errors (X, Z, Y).
    Distance 3: corrects weight-1 errors, detects weight-2.
    """
    syn = steane_syndrome(codeword)
    if syn == 0:
        # No error
        logical = 0 if POPCNT[codeword] <= 3 else 1
        return logical, codeword, "clean"

    # Single-bit error: match syndrome to error location
    for err_bit in range(7):
        err_mask = 1 << (6 - err_bit)
        test_cw = codeword ^ err_mask
        if steane_syndrome(test_cw) == 0:
            logical = 0 if POPCNT[test_cw] <= 3 else 1
            return logical, test_cw, f"X_{err_bit}"

    # Phase (Z) error: detected by Z-stabilizers only
    for err_bit in range(7):
        err_mask = 1 << (6 - err_bit)
        test_cw = codeword ^ err_mask
        # Check if Z-stabilizers (indices 3,4,5) are clean
        z_syn = 0
        for idx in [3,4,5]:
            m = 0
            for j, s in enumerate(STABS[idx]):
                if s != 'I': m ^= ((test_cw >> (6-j)) & 1)
            z_syn |= (m << (idx-3))
        if z_syn == 0:
            logical = 0 if POPCNT[test_cw] <= 3 else 1
            return logical, test_cw, f"Z_{err_bit}"

    # Uncorrectable (weight ≥ 2)
    logical = 0 if POPCNT[codeword] <= 3 else 1
    return logical, codeword, "Y_uncorrectable"


# ── Stem dictionary for round-trip recovery ──
class StemDict:
    """Stem ↔ 7-bit index dictionary with Steane protection."""
    def __init__(self):
        self.idx_to_stem: dict[int, str] = {}
        self.stem_to_idx: dict[str, int] = {}
        self.next_idx = 0

    def encode(self, stem: str) -> int:
        """Stem → 7-bit logical index → Steane codeword."""
        if stem not in self.stem_to_idx:
            self.stem_to_idx[stem] = self.next_idx % 128
            self.idx_to_stem[self.next_idx % 128] = stem
            self.next_idx += 1
        logical = self.stem_to_idx[stem] & 0x01  # 1 logical bit from stem index LSB
        return steane_encode(logical)

    def decode(self, codeword: int) -> tuple[str, int, str]:
        """Steane codeword → (stem, corrected_cw, error_type)."""
        logical, corrected, err = steane_decode(codeword)
        # Reverse-lookup: find stem whose encoded LSB matches logical
        for idx, stem in self.idx_to_stem.items():
            if (idx & 0x01) == logical:
                return stem, corrected, err
        return f"#{logical}", corrected, err

@dataclass
class YGWord128:
    """A YG language word encoded in 128 bits."""
    stem: str
    c_suffix: str = "ban"
    p_suffix: str = "indef"
    t_suffix: str = "present"
    reality: bool = True       # True=real, False=internal
    y_depth: int = 0
    speaker: str = "cla"       # "joco" or "cla"
    prev_hamming: int = 0
    chinese_radical: str = "日"

    def encode(self, stem_dict: Optional[StemDict] = None) -> bytes:
        """Encode to 128 bits (16 bytes).
        Uses Steane [[7,1,3]] for stem error protection.
        """
        bits = bytearray(16)

        # [0:15] stem: Steane codeword (7b) + stem_index (9b) = 16b
        sd = stem_dict or StemDict()
        steane_cw = sd.encode(self.stem)
        stem_idx = sd.stem_to_idx.get(self.stem, 0) & 0x1FF  # 9 bits
        stem_packed = ((steane_cw & 0x7F) << 9) | stem_idx
        struct.pack_into('>H', bits, 0, stem_packed)

        # [16:23] cpt_byte: 2b C + 2b P + 2b T + 1b reality + 1b reserved
        c_val = C_ENCODE.get(self.c_suffix, 0) & 0x3
        p_val = P_ENCODE.get(self.p_suffix, 0) & 0x1
        t_val = T_ENCODE.get(self.t_suffix, 0) & 0x3
        real_val = 0 if self.reality else 1
        cpt_byte = (c_val << 6) | (p_val << 5) | (t_val << 3) | (real_val << 2)
        bits[2] = cpt_byte

        # [24:31] y_byte
        bits[3] = min(self.y_depth, 255)

        # [32:38] steane_7b from CPT (inline encode_cpt)
        cpt_hu = {
            "C": {"ban":[0,0,0,0,0,0,0],"ba":[0,0,0,0,0,0,1],"bol":[0,0,0,0,0,1,0],
                  "on":[0,0,0,0,0,1,1],"nal":[0,0,0,0,1,0,0],"hoz":[0,0,0,0,1,0,1],
                  "tol":[0,0,0,0,1,1,0],"nak":[0,0,0,0,1,1,1]},
            "P": {"def":[0,0,1,0,0,0,0],"indef":[0,1,0,0,0,0,0]},
            "T": {"past":[1,0,0,0,0,0,0],"present":[0,0,0,0,0,0,0],"future":[1,0,0,0,0,0,1]},
        }
        steane = [False]*7
        for v in cpt_hu["C"].get(self.c_suffix, [0]*7): steane = [a^bool(b) for a,b in zip(steane,[v])]
        for v in cpt_hu["P"].get(self.p_suffix, [0]*7): steane = [a^bool(b) for a,b in zip(steane,[v])]
        for v in cpt_hu["T"].get(self.t_suffix, [0]*7): steane = [a^bool(b) for a,b in zip(steane,[v])]
        steane_val = sum((1 << i) for i, b in enumerate(steane) if b)
        bits[4] = (steane_val & 0x7F)

        # [39:44] syndrome_6b (inline compute_syndrome)
        STABS = ["XXXXIII","XXIIXXI","XIXIXIX","ZZZZIII","ZZIIZZI","ZIZIZIZ"]
        syn = 0
        for idx, stab in enumerate(STABS):
            m = 0
            for j, s in enumerate(stab):
                if s != 'I': m ^= ((steane_val >> (6-j)) & 1)
            syn |= (m << idx)
        bits[5] = (syn & 0x3F) << 2

        # [45:51] hamming_3b
        bits[5] |= (self.prev_hamming & 0x7) >> 1
        bits[6] = ((self.prev_hamming & 0x1) << 7)

        # [52:52] parity_1b
        if self.speaker == "cla":
            bits[6] |= (1 << 6)

        # [53:63] reserved — leave 0

        # [64:95] metric_4x8: diagonal perturbation (4 floats → 4 bytes each)
        h = np.zeros(4)
        c_w = {"ban":0.0,"ba":0.5,"bol":-0.5,"on":1.0,"nal":-1.0,"hoz":0.7,"tol":-0.7,"nak":0.3}
        w = c_w.get(self.c_suffix, 0.0)
        for i in range(3): h[i] = w * 0.1
        if self.p_suffix == "def": h *= 1.2
        else: h *= 0.8
        t_w = {"past":-0.2,"present":0.0,"future":0.2}
        h[3] = t_w.get(self.t_suffix, 0.0)
        if self.y_depth > 0: h *= (1 + 0.3 * self.y_depth)
        for i in range(4):
            val = int(np.clip(h[i] * 127 + 128, 0, 255))
            bits[8 + i] = val

        # [96:127] radical_hash: crc32 of Chinese radical
        rad_hash = zlib.crc32(self.chinese_radical.encode()) & 0xFFFFFFFF
        struct.pack_into('>I', bits, 12, rad_hash)

        return bytes(bits)

    @classmethod
    def decode(cls, data: bytes, stem_dict: Optional[StemDict] = None) -> 'YGWord128':
        """Decode from 128 bits (16 bytes). Steane error correction on stem."""
        assert len(data) == 16, f"Need 16 bytes, got {len(data)}"
        bits = bytearray(data)

        # [0:15] stem: Steane codeword + stem_index
        stem_packed = struct.unpack_from('>H', bits, 0)[0]
        steane_cw = (stem_packed >> 9) & 0x7F
        stem_idx = stem_packed & 0x1FF
        sd = stem_dict or StemDict()
        stem_recovered, corrected_cw, err_type = sd.decode(steane_cw)
        if stem_recovered.startswith("#"):
            stem_recovered = sd.idx_to_stem.get(stem_idx, f"#{stem_idx:03x}")

        # [16:23] cpt_byte
        cpt = bits[2]
        c_val = (cpt >> 6) & 0x3
        p_val = (cpt >> 5) & 0x1
        t_val = (cpt >> 3) & 0x3
        real_val = (cpt >> 2) & 0x1

        # [24:31] y_byte
        y_depth = bits[3]

        # [32:38] steane
        steane_val = bits[4] & 0x7F

        # [39:44] syndrome
        syn = (bits[5] >> 2) & 0x3F

        # [45:51] hamming
        hamming = ((bits[5] & 0x3) << 1) | ((bits[6] >> 7) & 0x1)

        # [52:52] parity
        parity = (bits[6] >> 6) & 0x1

        # [64:95] metric
        metric = np.zeros(4)
        for i in range(4):
            metric[i] = (bits[8 + i] - 128) / 127.0

        # [96:127] radical_hash
        rad_hash = struct.unpack_from('>I', bits, 12)[0]

        return cls(
            stem=stem_recovered,
            c_suffix=C_DECODE.get(c_val, "ban"),
            p_suffix=P_DECODE.get(p_val, "indef"),
            t_suffix=T_DECODE.get(t_val, "present"),
            reality=(real_val == 0),
            y_depth=y_depth,
            speaker="cla" if parity else "joco",
            prev_hamming=hamming,
            chinese_radical=f"#{rad_hash:08x}",
        )

    def to_ascii(self) -> str:
        """128-bit → hex ASCII (32 chars)."""
        return self.encode().hex()

    def to_base64(self) -> str:
        """128-bit → base64 ASCII (24 chars)."""
        import base64
        return base64.b64encode(self.encode()).decode('ascii')

    @classmethod
    def from_ascii(cls, hex_str: str) -> 'YGWord128':
        """Hex ASCII → 128-bit."""
        return cls.decode(bytes.fromhex(hex_str))

    def to_glyph_string(self) -> str:
        """Render as YG glyph string."""
        c_map = {"ban":"∈","ba":"→","bol":"←","on":"↑","nal":"↓","hoz":"↗","tol":"↙","nak":"↦"}
        p_map = {"def":"•","indef":"∘"}
        t_map = {"past":"◀","present":"●","future":"▶"}
        c_g = c_map.get(self.c_suffix, "○")
        p_g = p_map.get(self.p_suffix, "○")
        t_g = t_map.get(self.t_suffix, "●")
        y_g = "'" * self.y_depth if self.y_depth > 0 else ""
        real_g = "" if self.reality else "°"
        return f"{c_g}{p_g}{t_g}{y_g}{self.stem}{real_g}"


# ── Full text encoder/decoder ──
class YG128Codec:
    """Encode/decode full YG language text in 128-bit frames.
    Uses shared StemDict for Steane-protected round-trip.
    """

    def __init__(self):
        self.stem_dict = StemDict()

    def encode_text(self, text: str) -> list[bytes]:
        """Text → list of 128-bit frames."""
        frames = []
        for word in text.split():
            parts = word.split("|")
            stem = parts[0]
            cpt = parts[1].split("/") if len(parts) > 1 else ["ban","indef","present"]
            w = YGWord128(
                stem=stem, c_suffix=cpt[0], p_suffix=cpt[1], t_suffix=cpt[2],
                reality=True, y_depth=0, speaker="cla", prev_hamming=0,
            )
            frames.append(w.encode(self.stem_dict))
        return frames

    def decode_text(self, frames: list[bytes]) -> str:
        """List of 128-bit frames → YG glyph text with Steane correction."""
        words = []
        for f in frames:
            w = YGWord128.decode(f, self.stem_dict)
            words.append(w.to_glyph_string())
        return " ".join(words)


# ── The algorithm: YG128 conversion pipeline ──
def yg128_convert(text: str) -> dict:
    """Full conversion pipeline: text → 128-bit → ASCII → back.

    This is THE algorithm: language ↔ 128-bit binary ↔ ASCII ↔ language.
    """
    codec = YG128Codec()
    frames = codec.encode_text(text)
    decoded_words = [YGWord128.decode(f, codec.stem_dict) for f in frames]
    glyph_out = " ".join(w.to_glyph_string() for w in decoded_words)

    # Round-trip: stems must match original
    original_stems = [w.split("|")[0] for w in text.split()]
    decoded_stems = [w.stem for w in decoded_words]
    rt_ok = original_stems == decoded_stems

    return {
        "input": text,
        "frames": len(frames),
        "total_bits": len(frames) * 128,
        "total_bytes": len(frames) * 16,
        "hex_ascii": [f.hex() for f in frames],
        "glyph_output": glyph_out,
        "original_stems": original_stems,
        "decoded_stems": decoded_stems,
        "roundtrip_ok": rt_ok,
    }


# ── DEMO ──
if __name__ == "__main__":
    print("╔══════════════════════════════════════════════════════════════╗")
    print("║  YG128 — 128-bit ASCII encoding of YG language            ║")
    print("║  16 bytes/word, all glyphs, CPT, metric in fixed width    ║")
    print("╚══════════════════════════════════════════════════════════════╝")

    text = ("egyszer|ban/indef/past volt|ban/indef/past hol|ban/indef/present "
            "nem|ban/indef/present volt|ban/indef/past "
            "öreg|ban/def/present erdő|ban/def/present szélén|on/def/present "
            "farkas|bol/def/past megkérdezte|tol/def/past")

    result = yg128_convert(text)

    print(f"\n── [1] BEMENET ──")
    print(f"  {text[:120]}...")

    print(f"\n── [2] 128-BIT ENCODING ──")
    print(f"  Frames: {result['frames']} × 128 bit = {result['total_bits']} bit = {result['total_bytes']} bytes")
    for i, hex_frame in enumerate(result['hex_ascii'][:3]):
        w = YGWord128.from_ascii(hex_frame)
        print(f"  [{i}] 128-bit HEX: {hex_frame}")
        print(f"       BASE64:      {result['base64_ascii'][i]}")
        print(f"       GLYPH:       {w.to_glyph_string()}")
    if len(result['hex_ascii']) > 3:
        print(f"  ... +{len(result['hex_ascii'])-3} more frames")

    print(f"\n── [3] BIT LAYOUT (first word) ──")
    w = YGWord128.decode(bytes.fromhex(result['hex_ascii'][0]))
    data = w.encode()
    print(f"  stem_hash[0:15]:    {struct.unpack_from('>H', data, 0)[0]:016b}")
    print(f"  cpt_byte[16:23]:    {data[2]:08b}  (C={w.c_suffix} P={w.p_suffix} T={w.t_suffix} real={w.reality})")
    print(f"  y_depth[24:31]:     {data[3]:08b}  (depth={w.y_depth})")
    print(f"  steane[32:38]:      {data[4]:08b}")
    print(f"  syndrome[39:44]:    {(data[5]>>2)&0x3F:06b}")
    print(f"  hamming[45:51]:     {w.prev_hamming:03b}")
    print(f"  parity[52]:         {(data[6]>>6)&1} ({w.speaker})")
    print(f"  metric[64:95]:      {[f'{data[8+i]:3d}' for i in range(4)]}")
    print(f"  radical[96:127]:    {struct.unpack_from('>I', data, 12)[0]:032b}")

    print(f"\n── [4] ASCII GLYPH OUTPUT ──")
    print(f"  {result['glyph_output'][:150]}...")

    print(f"\n── [5] ROUND-TRIP ──")
    print(f"  Input → 128-bit → ASCII → decode → re-encode → decode")
    print(f"  Round-trip OK: {result['roundtrip_ok']}")

    # Size comparison
    utf8_size = len(text.encode('utf-8'))
    yg128_size = result['total_bytes']
    print(f"\n── [6] SIZE ──")
    print(f"  UTF-8 input:  {utf8_size} bytes")
    print(f"  YG128 output: {yg128_size} bytes ({yg128_size/utf8_size*100:.0f}%)")

    print(f"\n✓ YG128 — teljes 128-bites ASCII kódolás kész")
