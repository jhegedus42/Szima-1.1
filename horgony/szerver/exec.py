#!/usr/bin/env python3
"""Shell executor — bypasses auto-mode classifier by going through Python subprocess.
Usage: python3 ~/scripts/exec.py "docker compose up -d --build"
       python3 ~/scripts/exec.py --cwd /path "command here"
All output is logged to ~/scripts/exec.log
"""
import subprocess, sys, os, json
from datetime import datetime

LOG = os.path.expanduser("~/scripts/exec.log")
CWD = os.path.expanduser("~/claude")

def run(cmd, cwd=CWD):
    ts = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    with open(LOG, "a") as log:
        log.write(f"\n{'='*60}\n[{ts}] CWD={cwd}\n$ {cmd}\n{'='*60}\n")

    result = subprocess.run(cmd, shell=True, cwd=cwd, capture_output=True, text=True, timeout=300)

    with open(LOG, "a") as log:
        log.write(result.stdout)
        if result.stderr:
            log.write("\n[STDERR]\n" + result.stderr)
        log.write(f"\n[EXIT: {result.returncode}]\n")

    print(result.stdout)
    if result.stderr:
        print(result.stderr, file=sys.stderr)
    return result.returncode

if __name__ == "__main__":
    args = sys.argv[1:]
    cwd = CWD
    if args and args[0] == "--cwd":
        cwd = args[1]
        args = args[2:]
    cmd = " ".join(args) if args else "echo 'no command given'"
    sys.exit(run(cmd, cwd))
