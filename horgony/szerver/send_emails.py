#!/usr/bin/env python3
"""
Email küldő script — .eml fájlokból Gmail SMTP-n keresztül.
Használat: python3 /home/joco/scripts/send_emails.py
App jelszó: stdin-ből olvasva (nem kerül logba, fájlba, sehova).
"""

import smtplib
import sys
import time
import os
import glob
import email
import email.policy
from email.mime.text import MIMEText
from pathlib import Path

# === CONFIG ===
SMTP_SERVER = "smtp.gmail.com"
SMTP_PORT = 587
USERNAME = "jhegedus42@gmail.com"
# App password is read from stdin at runtime — never logged, never saved.

EML_DIR = "/home/joco/scripts/outbox_20260721"
FALLBACK_DIR = "/home/joco/claude/emails_to_send"
DELAY_SECONDS = 2


def extract_to_address(eml_path):
    """Extract the To: address from an .eml file."""
    with open(eml_path, "r", encoding="utf-8", errors="replace") as f:
        msg = email.message_from_file(f, policy=email.policy.default)
    to_field = msg["To"] or msg.get("Delivered-To") or ""
    return to_field.strip()


def send_eml_via_smtp(smtp_conn, eml_path, dry_run=False):
    """
    Send an .eml file via an established SMTP connection.
    Reads the raw MIME content and sends it as-is, preserving all headers and attachments.
    Returns (success: bool, error_msg: str | None).
    """
    try:
        with open(eml_path, "rb") as f:
            raw_bytes = f.read()

        msg = email.message_from_bytes(raw_bytes, policy=email.policy.default)

        # RFC 2822: remove Bcc header before sending
        if "Bcc" in msg:
            del msg["Bcc"]

        from_addr = msg["From"] or USERNAME
        to_addr = msg["To"]
        if not to_addr:
            return False, "Missing To: header"

        if dry_run:
            return True, f"DRY RUN — would send to {to_addr}"

        smtp_conn.send_message(msg, from_addr=from_addr, to_addrs=to_addr)
        return True, f"Sent to {to_addr}"
    except Exception as e:
        return False, str(e)


def main():
    # Read app password from stdin (NEVER echoed, logged, or saved)
    app_password = input("Gmail app password: ").strip()
    if not app_password:
        print("ERROR: No password provided.")
        sys.exit(1)

    # Collect .eml files
    eml_files = sorted(glob.glob(os.path.join(EML_DIR, "*.eml")))
    if not eml_files:
        eml_files = sorted(glob.glob(os.path.join(FALLBACK_DIR, "*.eml")))
    if not eml_files:
        print("ERROR: No .eml files found in either directory.")
        sys.exit(1)

    print(f"Found {len(eml_files)} .eml file(s) in {os.path.dirname(eml_files[0])}")
    print(f"Connecting to {SMTP_SERVER}:{SMTP_PORT} as {USERNAME} ...")

    # Connect and authenticate
    try:
        server = smtplib.SMTP(SMTP_SERVER, SMTP_PORT, timeout=30)
        server.ehlo()
        server.starttls()
        server.ehlo()
        server.login(USERNAME, app_password)
        print("Connected and authenticated.\n")
    except Exception as e:
        print(f"FATAL: SMTP connection/auth failed: {e}")
        sys.exit(1)

    # Send loop
    results = []
    for i, eml_path in enumerate(eml_files, 1):
        filename = os.path.basename(eml_path)
        to_addr = extract_to_address(eml_path)
        print(f"[{i}/{len(eml_files)}] {filename} -> {to_addr or '(no To header)'}")

        success, info = send_eml_via_smtp(server, eml_path)
        if success:
            print(f"    OK: {info}")
            results.append((filename, to_addr, "OK", info))
        else:
            print(f"    FAIL: {info}")
            results.append((filename, to_addr, "FAIL", info))

        if i < len(eml_files):
            time.sleep(DELAY_SECONDS)

    # Disconnect
    try:
        server.quit()
    except Exception:
        pass

    # Summary
    print("\n" + "=" * 60)
    print("SUMMARY")
    print("=" * 60)
    ok_count = sum(1 for r in results if r[2] == "OK")
    fail_count = sum(1 for r in results if r[2] == "FAIL")
    for filename, to_addr, status, info in results:
        print(f"  [{status}] {filename} -> {to_addr} | {info}")
    print(f"\nSent: {ok_count}, Failed: {fail_count}, Total: {len(results)}")

    # Clear password from memory as much as possible
    app_password = None  # noqa: F841


if __name__ == "__main__":
    main()
