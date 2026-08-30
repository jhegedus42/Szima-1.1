#!/usr/bin/env python3
"""
S713 Bayesian Truth Detector — Stan model wrapper.
Null hypothesis (H0): az állítás HALU.
Alternatív hipotézis (H1): az állítás VALÓS.

A Stan hierarchikus Bayes-i modell a CPT jellemzők alapján becsli
P(valós | X, Z, Hamming, location, agent, reality) értékét.

Használat:
  python3 s713_stan.py --train frames.jsonl   # tanítás
  python3 s713_stan.py --predict event.json   # predikció egy eseményre
  python3 s713_stan.py --serve                # API szerver

Követelmény: pip install cmdstanpy
"""
import json, os, sys
from datetime import datetime

# Stan modell — Bayes-i hierarchikus CPT igazság detektor
STAN_MODEL = """
data {
  int<lower=0> N;                          // események száma
  array[N] int<lower=0,upper=1> y;         // 1=valós, 0=HALU (ami tudjuk)
  array[N] int<lower=0,upper=1> x_err;     // X hiba jelen van?
  array[N] int<lower=0,upper=1> z_err;     // Z hiba jelen van?
  array[N] int<lower=0,upper=7> hamming;   // Hamming distance (0-7)
  array[N] int<lower=0,upper=1> speaker_cla;// 1=CLA mondta, 0=joco
  array[N] int<lower=0,upper=1> internal;   // 1=belső gondolat, 0=külső esemény
  array[N] int<lower=0,upper=1> grounded;  // 1=groundolt (fájl/parancs/mérés), 0=nincs
  array[N] real timestamp;                  // időbélyeg (normalizálva)
}
parameters {
  real alpha;                              // intercept
  real beta_x;                             // X hiba hatása
  real beta_z;                             // Z hiba hatása
  real beta_hamming;                       // Hamming hatása
  real beta_speaker;                       // speaker hatása
  real beta_internal;                      // belső gondolat hatása
  real beta_grounded;                      // grounding hatása
  real beta_time;                          // idő trend
}
model {
  // Gyenge prior-ok — nem tudunk semmit, adatból tanulunk
  alpha ~ normal(0, 2);
  beta_x ~ normal(-1, 1);      // X hiba → valószínűleg HALU (negatív hatás)
  beta_z ~ normal(-0.5, 1);    // Z hiba → enyhébb negatív hatás
  beta_hamming ~ normal(-0.5, 0.5); // nagyobb Hamming → nagyobb HALU esély
  beta_speaker ~ normal(0, 0.5);
  beta_internal ~ normal(-0.5, 1); // belső gondolat → nagyobb HALU esély
  beta_grounded ~ normal(1, 0.5);  // grounding → VALÓS indikátor (pozitív)
  beta_time ~ normal(0, 0.1);

  // Likelihood
  y ~ bernoulli_logit(
    alpha
    + beta_x * to_vector(x_err)
    + beta_z * to_vector(z_err)
    + beta_hamming * to_vector(hamming)
    + beta_speaker * to_vector(speaker_cla)
    + beta_internal * to_vector(internal)
    + beta_grounded * to_vector(grounded)
    + beta_time * to_vector(timestamp)
  );
}
generated quantities {
  array[N] real y_rep;                    // posterior prediktív ellenőrzés
  array[N] real log_lik;                  // loo-hoz
  for (n in 1:N) {
    real eta = alpha
      + beta_x * x_err[n]
      + beta_z * z_err[n]
      + beta_hamming * hamming[n]
      + beta_speaker * speaker_cla[n]
      + beta_internal * internal[n]
      + beta_grounded * grounded[n]
      + beta_time * timestamp[n];
    y_rep[n] = bernoulli_logit_rng(eta);
    log_lik[n] = bernoulli_logit_lpmf(y[n] | eta);
  }
}
"""


class S713TruthDetector:
    """Stan-alapú Bayes-i igazság detektor CPT jellemzőkből."""

    def __init__(self):
        self.fitted = False
        self.fit_result = None

    def features_from_frame(self, frame: dict) -> dict:
        """S713 frame → Stan feature vektor."""
        cpt = frame.get("cpt", {})
        ev = frame.get("event", {})
        text = frame.get("text", "")

        return {
            "x_err": 1 if cpt.get("X") else 0,
            "z_err": 1 if cpt.get("Z") else 0,
            "hamming": frame.get("hamming_from_prev", 0),
            "speaker_cla": 1 if frame.get("speaker") == "cla" else 0,
            "internal": 0 if ev.get("real", True) else 1,
            "grounded": 1 if any(w in text.lower() for w in
                ["mérve", "tesztelve", "fájl:", "docker", "curl",
                 "parancs", "log", "json", "http", "port"]) else 0,
            "timestamp": frame.get("timestamp", 0),
        }

    def train(self, frames: list):
        """Betanítja a Stan modellt címkézett frame-ekből."""
        try:
            import cmdstanpy
        except ImportError:
            return {"error": "cmdstanpy nincs telepítve. pip install cmdstanpy"}

        N = len(frames)
        data = {
            "N": N,
            "y": [],
            "x_err": [], "z_err": [], "hamming": [],
            "speaker_cla": [], "internal": [], "grounded": [],
            "timestamp": [],
        }

        for f in frames:
            feats = self.features_from_frame(f)
            for k in ["x_err", "z_err", "hamming", "speaker_cla", "internal", "grounded"]:
                data[k].append(feats[k])
            data["timestamp"].append(feats["timestamp"])
            # Címke: HALU ha Y-hiba van VAGY Hamming > 1 és nincs grounding
            is_halu = f.get("cpt", {}).get("Y", False)
            if feats["hamming"] > 1 and not feats["grounded"]:
                is_halu = True
            data["y"].append(0 if is_halu else 1)

        # Normalizálás
        t0 = min(data["timestamp"])
        data["timestamp"] = [t - t0 for t in data["timestamp"]]
        max_t = max(data["timestamp"]) or 1
        data["timestamp"] = [t / max_t for t in data["timestamp"]]

        # Stan modell fordítása és futtatása
        model = cmdstanpy.CmdStanModel(stan_code=STAN_MODEL)
        self.fit_result = model.sample(data=data, iter_sampling=1000, iter_warmup=500,
                                       chains=2, show_progress=False)
        self.fitted = True
        return self._summary()

    def predict(self, frame: dict) -> dict:
        """Predikció egy frame-re: P(valós | CPT jellemzők)."""
        feats = self.features_from_frame(frame)

        if not self.fitted:
            # Heurisztikus predikció betanított modell nélkül
            p_halu = 0.0
            if feats["x_err"] and feats["z_err"]:  # Y hiba
                p_halu += 0.6
            if feats["hamming"] > 1:
                p_halu += 0.2
            if feats["internal"]:  # belső gondolat
                p_halu += 0.1
            if feats["grounded"]:  # van grounding
                p_halu -= 0.4
            if feats["speaker_cla"]:  # CLA mondja
                p_halu += 0.05
            p_halu = max(0.01, min(0.99, p_halu))
            p_real = 1.0 - p_halu

            return {
                "p_real": round(p_real, 4),
                "p_halu": round(p_halu, 4),
                "verdict": "VALÓS" if p_real > 0.5 else "HALU",
                "confidence": "magas" if abs(p_real - 0.5) > 0.3 else "alacsony",
                "method": "heuristic",
                "features": feats,
            }

        # TODO: implement Stan posterior predikció a fitted model-ből
        return {"error": "Stan predikció implementálás alatt", "method": "stan"}

    def _summary(self) -> dict:
        if not self.fit_result:
            return {}
        s = self.fit_result.summary()
        return {k: {"mean": float(s.loc[k, "Mean"]), "sd": float(s.loc[k, "Std"])}
                for k in ["alpha", "beta_x", "beta_z", "beta_hamming",
                          "beta_speaker", "beta_internal", "beta_grounded", "beta_time"]
                if k in s.index}


# ── API ──
if __name__ == "__main__":
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument("--train", help="JSONL fájl a tanításhoz")
    ap.add_argument("--predict", help="JSON fájl egy esemény predikciójához")
    ap.add_argument("--serve", action="store_true", help="API szerver indítása :8778")
    args = ap.parse_args()

    det = S713TruthDetector()

    if args.train:
        with open(args.train) as f:
            frames = [json.loads(l) for l in f if l.strip()]
        result = det.train(frames)
        print(json.dumps(result, indent=2, default=str))

    if args.predict:
        with open(args.predict) as f:
            frame = json.load(f)
        result = det.predict(frame)
        print(json.dumps(result, indent=2))

    if args.serve:
        print("S713 Truth Detector API :8778", flush=True)
        from http.server import HTTPServer, BaseHTTPRequestHandler
        class H(BaseHTTPRequestHandler):
            def do_POST(self):
                length = int(self.headers.get('Content-Length', 0))
                body = json.loads(self.rfile.read(length)) if length else {}
                if self.path == "/predict":
                    result = det.predict(body)
                elif self.path == "/train":
                    result = det.train(body.get("frames", []))
                else:
                    result = {"error": "not found"}
                self.send_response(200)
                self.send_header('Content-Type', 'application/json')
                self.end_headers()
                self.wfile.write(json.dumps(result, default=str).encode())
            def do_GET(self):
                self.send_response(200); self.send_header('Content-Type', 'application/json')
                self.end_headers()
                self.wfile.write(json.dumps({"status":"ok","fitted":det.fitted}).encode())
            def log_message(self, *args): pass
        HTTPServer(("0.0.0.0", 8778), H).serve_forever()
