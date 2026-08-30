#!/usr/bin/env python3
"""
WIKI MINER — Wikipedia → Dirac Dictionary folyamatos bővítő.

1. Letölti a magyar és kínai Wikipedia top cikkeket
2. Kivonja a szavakat, CPT osztályozza őket
3. 4D Tesseract térben elhelyezi
4. Folyamatosan menti a szótárt
5. Időzíthető: cron, tmux, vagy manual

Első kör: top 1000 magyar + top 1000 kínai cikk → ~50K szó/szótár.
"""
import sys, os, json, time, hashlib, re, gzip, urllib.request
from collections import Counter
from pathlib import Path
from dirac_dict import TesseractDict, Word4D

DATA_DIR = os.path.expanduser("~/scripts/s713data/wiki")
os.makedirs(DATA_DIR, exist_ok=True)

# Wikipedia API — nyelvi dump letöltése (top cikkek)
WIKI_API = "https://{lang}.wikipedia.org/w/api.php"


def fetch_articles(lang: str, limit: int = 500) -> list[str]:
    """Letölti a top cikkek címét és tartalmát."""
    titles = _fetch_titles(lang, limit)
    articles = []
    for i, title in enumerate(titles):
        text = _fetch_article(lang, title)
        if text:
            articles.append(text)
        if i % 50 == 0:
            print(f"  [{lang}] {i}/{len(titles)} cikk letöltve...", flush=True)
        time.sleep(0.1)  # rate limit
    return articles


def _fetch_titles(lang: str, limit: int) -> list:
    """Random cikkek — jobb lefedettség mint az allpages."""
    titles = set()
    batch = min(limit, 20)
    for _ in range((limit // batch) + 1):
        params = urllib.parse.urlencode({
            "action": "query", "format": "json",
            "list": "random", "rnlimit": batch,
            "rnnamespace": "0",  # csak fő névtér (cikkek)
        })
        url = f"{WIKI_API.format(lang=lang)}?{params}"
        req = urllib.request.Request(url, headers={"User-Agent": "DiracDict/1.0 (research; contact@ex44)"})
        try:
            with urllib.request.urlopen(req, timeout=30) as r:
                data = json.loads(r.read())
                for page in data.get("query", {}).get("random", []):
                    titles.add(page["title"])
        except Exception as e:
            print(f"  [{lang}] random fetch error: {e}")
        time.sleep(0.2)
    return list(titles)[:limit]


def _fetch_article(lang: str, title: str) -> str | None:
    """Egy cikk letöltése — extract csak a tiszta szöveget."""
    params = urllib.parse.urlencode({
        "action": "query", "format": "json",
        "titles": title, "prop": "extracts",
        "exintro": "1", "explaintext": "1",
    })
    url = f"{WIKI_API.format(lang=lang)}?{params}"
    req = urllib.request.Request(url, headers={"User-Agent": "DiracDict/1.0 (research; contact@ex44)"})
    try:
        with urllib.request.urlopen(req, timeout=30) as r:
            data = json.loads(r.read())
            pages = data.get("query", {}).get("pages", {})
            for pid, page in pages.items():
                return page.get("extract", "")
    except Exception:
        pass
    return None


def tokenize(text: str, lang: str) -> list[str]:
    """Szöveg → szavak listája, nyelvenkénti tisztítással."""
    if lang == "hu":
        # Magyar: betűk + ékezetek
        words = re.findall(r'[a-záéíóöőúüűA-ZÁÉÍÓÖŐÚÜŰ]{2,}', text)
    else:
        # Kínai: karakterek + latin szavak
        cn_chars = re.findall(r'[一-鿿]+', text)
        words = []
        for chunk in cn_chars:
            for i in range(0, len(chunk), 2):
                if i + 2 <= len(chunk):
                    words.append(chunk[i:i+2])
                elif i == 0:
                    words.append(chunk[i])
        # Latin szavak is
        words += re.findall(r'[a-zA-Z]{2,}', text)
    return [w.lower() for w in words]


def mine_wikipedia(hu_limit: int = 500, cn_limit: int = 500) -> TesseractDict:
    """Wikipedia bányászat — magyar + kínai cikkek → TesseractDict."""
    print(f"╔══════════════════════════════════════════╗")
    print(f"║  WIKI MINER — {hu_limit} HU + {cn_limit} CN cikk  ║")
    print(f"╚══════════════════════════════════════════╝")

    td = TesseractDict()
    hu_counter = Counter()
    cn_counter = Counter()

    # Magyar cikkek
    print(f"\n── MAGYAR WIKIPEDIA ({hu_limit} cikk) ──")
    hu_articles = fetch_articles("hu", hu_limit)
    for text in hu_articles:
        words = tokenize(text, "hu")
        hu_counter.update(words)

    # Top szavak hozzáadása a szótárhoz
    print(f"\n  Top magyar szavak:")
    for word, count in hu_counter.most_common(1000):
        if count >= 3 and word not in {w.word for w in td.hu_words}:
            td.add(word, "hu")
    print(f"  {len(td.hu_words)} magyar szó a szótárban")

    # Kínai cikkek
    print(f"\n── KÍNAI WIKIPEDIA ({cn_limit} cikk) ──")
    cn_articles = fetch_articles("zh", cn_limit)
    for text in cn_articles:
        words = tokenize(text, "cn")
        cn_counter.update(words)

    print(f"\n  Top kínai szavak:")
    for word, count in cn_counter.most_common(1000):
        if count >= 3 and word not in {w.word for w in td.cn_words}:
            td.add(word, "cn")
    print(f"  {len(td.cn_words)} kínai szó a szótárban")

    _save(td)
    return td


def _save(td: TesseractDict):
    """Szótár mentése JSON-be + statisztika."""
    data = {
        "hu_words": [(w.word, w.c_type, w.p_type, w.t_type) for w in td.hu_words],
        "cn_words": [(w.word, w.c_type, w.p_type, w.t_type) for w in td.cn_words],
        "updated": time.time(),
    }
    with open(f"{DATA_DIR}/dict.json", "w") as f:
        json.dump(data, f, ensure_ascii=False)
    print(f"\n  Szótár mentve: {DATA_DIR}/dict.json")
    print(f"  {len(td.hu_words)} HU + {len(td.cn_words)} CN = {len(td.hu_words)+len(td.cn_words)} szó")


def load_cached() -> TesseractDict | None:
    """Korábban mentett szótár betöltése."""
    cache = Path(f"{DATA_DIR}/dict.json")
    if not cache.exists():
        return None
    with open(cache) as f:
        data = json.load(f)
    td = TesseractDict()
    for w, c, p, t in data.get("hu_words", []):
        td.add(w, "hu", c, p, t)
    for w, c, p, t in data.get("cn_words", []):
        td.add(w, "cn", c, p, t)
    return td


if __name__ == "__main__":
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument("--hu", type=int, default=500, help="Magyar cikkek száma")
    ap.add_argument("--cn", type=int, default=500, help="Kínai cikkek száma")
    ap.add_argument("--quick", type=int, default=50, help="Gyors teszt (kevés cikk)")
    ap.add_argument("--load", action="store_true", help="Csak betölti a cache-elt szótárt")
    ap.add_argument("--stats", action="store_true", help="Szótár statisztika")
    args = ap.parse_args()

    if args.load:
        td = load_cached()
        if td:
            print(f"Betöltve: {len(td.hu_words)} HU + {len(td.cn_words)} CN")
        else:
            print("Nincs cache-elt szótár. Futtasd: python3 wiki_miner.py --quick 30")
    elif args.stats:
        td = load_cached()
        if td:
            s = td.stats()
            for k, v in s.items():
                print(f"  {k}: {v}")
    else:
        hu_n = args.quick or args.hu
        cn_n = args.quick or args.cn
        td = mine_wikipedia(hu_n, cn_n)
