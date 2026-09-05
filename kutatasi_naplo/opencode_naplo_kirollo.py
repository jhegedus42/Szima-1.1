#!/usr/bin/env python3
# SZABALY0-IDRISBEN-LEHETETLEN — a felhasználó által explicit kért SQLite-kiolló eszköz (AGENTS §3-kivétel, 2026-08-21)
# ═══════════════════════════════════════════════════════════════
# OPENCODE NAPLÓ-KIROLLÓ — a chat SQLite-ből a kutatási naplóba
# OPENCODE LOG EXTRACTOR — from the chat SQLite into the research log
# OpenCode 日志提取器 — 从聊天 SQLite 提取到研究日志
# OpenCode-Logbuch-Extraktor — aus der Chat-SQLite ins Forschungslogbuch
# חלץ יומן OpenCode — מ־SQLite של הצ'אט אל יומן המחקר
# ═══════════════════════════════════════════════════════════════
#
# MI EZ? / WHAT IS THIS? / 这是什么？
#   Az opencode minden chat-üzenetet SQLite-ban tárol:
#     ~/.local/share/opencode/opencode.db
#     - message tábla: (id, session_id, time_created [unix ms], data JSON
#       — benne role: "user"/"assistant")
#     - part tábla: (id, message_id, time_created, data JSON — a
#       {"type":"text","text":...} részek; a synthetic:true részek a
#       horog-plugin injekciói, NEM beszélgetés)
#   Ez a program a megadott session KÉRDÉS–VÁLASZ párjait időbélyeggel
#   (GÉPI időből, soha nem becslésből — l. napló 16. bejegyzés) markdown-
#   formában írja ki — a kutatási napló (AGENTS §21, §N5 SZÓRÓL SZÓRA)
#   automatizálására.
#
# MEGJEGYZÉS a "Python tiltott" szabályról (AGENTS §1/3): az a projekt
# SZÁMÍTÁSaira vonatkozik (azok Idrisben mennek). Ez az eszköz DB-olvasás —
# a felhasználó explicit kérésére készült (2026-08-21: "irjal ra python
# programot, szerintem valami opencode sql adatbazisban...").
#
# HASZNÁLAT / USAGE / 用法:
#   python3 opencode_naplo_kirollo.py                    # legutolsó session, képernyőre
#   python3 opencode_naplo_kirollo.py --out fragment.md  # fájlba
#   python3 opencode_naplo_kirollo.py --session msg_xxx  # adott session
#   python3 opencode_naplo_kirollo.py --since 2026-08-21T19:00:00
# ═══════════════════════════════════════════════════════════════

import argparse
import json
import sqlite3
import sys
import os
from datetime import datetime, timezone

DB_UTVONAL = os.path.expanduser("~/.local/share/opencode/opencode.db")


def unix_ms_iso(ms):
    # GÉPI idő → ISO 8601 (helyi idő, milliszekundum nélkül)
    return datetime.fromtimestamp(ms / 1000.0).astimezone().strftime("%Y-%m-%d %H:%M:%S")


def legutolso_session(conn):
    sor = conn.execute(
        "SELECT session_id FROM message ORDER BY time_created DESC LIMIT 1"
    ).fetchone()
    return sor[0] if sor else None


def parok_olvasasa(conn, session_id, since_ms=None):
    # Üzenetek: (id, time_created, role) — a role a data JSON-ben van
    uzenetek = {}
    felhasznalo_sorrend = []
    for mid, ts, data in conn.execute(
        "SELECT id, time_created, data FROM message WHERE session_id = ? ORDER BY time_created, id",
        (session_id,),
    ):
        try:
            role = json.loads(data).get("role", "?")
        except json.JSONDecodeError:
            role = "?"
        uzenetek[mid] = {"ts": ts, "role": role, "texts": []}
        felhasznalo_sorrend.append(mid)

    # Szövegrészek: csak type=="text" ÉS nem synthetic (a horog-injekciók synthetic-ok)
    for mid, data in conn.execute(
        "SELECT message_id, data FROM part WHERE session_id = ? ORDER BY time_created, id",
        (session_id,),
    ):
        if mid not in uzenetek:
            continue
        try:
            d = json.loads(data)
        except json.JSONDecodeError:
            continue
        if d.get("type") == "text" and not d.get("synthetic", False):
            szoveg = d.get("text", "")
            if szoveg.strip():
                uzenetek[mid]["texts"].append(szoveg)

    # Kérdés–válasz párok összeállítása idősorrendben
    eredmeny = []
    for mid in felhasznalo_sorrend:
        u = uzenetek[mid]
        if not u["texts"]:
            continue
        if since_ms is not None and u["ts"] < since_ms:
            continue
        eredmeny.append(
            {
                "role": u["role"],
                "ido": unix_ms_iso(u["ts"]),
                "szoveg": "\n\n".join(u["texts"]),
            }
        )
    return eredmeny


def markdown_ir(parok, session_id):
    sorok = [
        "<!-- AUTO-KIROLLÓ: opencode.db → kutatási napló; gépi időbélyegekkel -->",
        f"<!-- session: {session_id} -->",
        "",
    ]
    for p in parok:
        cimke = "KÉRDÉS (felhasználó)" if p["role"] == "user" else "VÁLASZ (asszisztens)"
        sorok.append(f"### {cimke} — {p['ido']} (gépi idő)")
        sorok.append("")
        if p["role"] == "user":
            sorok.append("> " + p["szoveg"].replace("\n", "\n> "))
        else:
            sorok.append(p["szoveg"])
        sorok.append("")
    return "\n".join(sorok)


def main():
    parser = argparse.ArgumentParser(description="opencode chat SQLite → kutatási napló markdown")
    parser.add_argument("--session", default=None, help="session id (alap: a legutolsó)")
    parser.add_argument("--since", default=None, help="ISO idő: ez utáni üzenetek (pl. 2026-08-21T19:00:00)")
    parser.add_argument("--out", default=None, help="kimeneti fájl (alap: stdout)")
    args = parser.parse_args()

    if not os.path.exists(DB_UTVONAL):
        sys.exit(f"Nincs meg az adatbázis: {DB_UTVONAL}")

    # READ-ONLY | WAL: a futó opencode-dal párhuzamosan is biztonságos
    conn = sqlite3.connect(f"file:{DB_UTVONAL}?mode=ro", uri=True)

    session_id = args.session or legutolso_session(conn)
    if not session_id:
        sys.exit("Nincs üzenet az adatbázisban.")

    since_ms = None
    if args.since:
        dt = datetime.fromisoformat(args.since).astimezone()
        since_ms = int(dt.timestamp() * 1000)

    parok = parok_olvasasa(conn, session_id, since_ms)
    conn.close()

    md = markdown_ir(parok, session_id)
    if args.out:
        with open(args.out, "w", encoding="utf-8") as f:
            f.write(md)
        print(f"{len(parok)} bejegyzés → {args.out}")
    else:
        print(md)


if __name__ == "__main__":
    main()
