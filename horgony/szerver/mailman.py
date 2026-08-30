#!/usr/bin/env python3
"""
MailMan — file-based sub-agent communication protocol.
Master (Claude) writes commands to outbox/<id>.json
MailMan executes them and writes results to inbox/<id>.json
Protocol: one JSON file per message, idempotent, append-only log.
"""
import json, os, subprocess, sys, time, signal
from datetime import datetime
from pathlib import Path

MAILBOX = os.path.expanduser("~/scripts/mailbox")
OUTBOX = os.path.join(MAILBOX, "outbox")
INBOX = os.path.join(MAILBOX, "inbox")
LOG = os.path.join(MAILBOX, "mailman.log")
POLL = 2  # seconds between scans

os.makedirs(OUTBOX, exist_ok=True)
os.makedirs(INBOX, exist_ok=True)

def log(msg):
    ts = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    line = f"[{ts}] {msg}"
    with open(LOG, "a") as f:
        f.write(line + "\n")
    print(line, flush=True)

def execute(msg):
    msg_id = msg["id"]
    cmd = msg["command"]
    cwd = msg.get("cwd", os.path.expanduser("~"))
    timeout = min(msg.get("timeout", 120), 600)
    log(f"EXEC [{msg_id}] $ {cmd}")

    try:
        result = subprocess.run(cmd, shell=True, cwd=cwd,
                                capture_output=True, text=True, timeout=timeout)
        response = {
            "id": msg_id, "status": "done",
            "exit_code": result.returncode,
            "stdout": result.stdout[-50000:],  # trim to last 50KB
            "stderr": result.stderr[-10000:],
            "completed_at": datetime.now().isoformat()
        }
        log(f"DONE  [{msg_id}] exit={result.returncode} out={len(result.stdout)} err={len(result.stderr)}")
    except subprocess.TimeoutExpired:
        response = {"id": msg_id, "status": "timeout", "error": f"Timeout after {timeout}s"}
        log(f"TIMEOUT [{msg_id}]")
    except Exception as e:
        response = {"id": msg_id, "status": "error", "error": str(e)}
        log(f"ERROR [{msg_id}] {e}")

    inbox_file = os.path.join(INBOX, f"{msg_id}.json")
    with open(inbox_file, "w") as f:
        json.dump(response, f, indent=2)

    # remove processed outbox message
    outbox_file = os.path.join(OUTBOX, f"{msg_id}.json")
    os.rename(outbox_file, outbox_file + ".done")

def scan():
    files = sorted(Path(OUTBOX).glob("*.json"))
    for f in files:
        try:
            msg = json.loads(f.read_text())
            if "id" in msg and "command" in msg:
                execute(msg)
        except Exception as e:
            log(f"PARSE-ERROR {f.name}: {e}")

def main():
    log("MailMan STARTED — polling outbox/ every 2s")
    while True:
        try:
            scan()
        except Exception as e:
            log(f"SCAN-ERROR: {e}")
        time.sleep(POLL)

if __name__ == "__main__":
    main()
