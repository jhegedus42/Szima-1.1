#!/usr/bin/env python3
"""Send follow-up email to 20 recipients with Python source code attachments.
SMTP: smtp.gmail.com:587, user: jhegedus42@gmail.com
2-second delay between emails, logs results.
"""

import smtplib
import ssl
import time
import sys
import os
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders
from datetime import datetime

# ── SMTP config ──
SMTP_HOST = "smtp.gmail.com"
SMTP_PORT = 587
FROM_ADDR = "jhegedus42@gmail.com"
FROM_PASS = "dtcc nwkw mhmg hica"

# ── Subject ──
SUBJECT = "Re: The 710 Code — Python Source Code + Contact (v2, 2026-07-21)"

# ── Body ──
BODY = """Dear Colleague,

Thank you for your attention to the preprint 'The 710 Code' sent earlier today. I forgot to attach the Python source code that implements the full derivation. Please find it attached below.

Also, here is my phone number if you wish to discuss the theory: +36307465157

The attached Python files:
- gut_final.py — Main program with Y(f) fixpoint + free categories + constants + 710 code
- all_constants_exact.py — Complete verification against CODATA 2022
- gut_free_category.py — Free category + symmetry breaking + dimensional analysis

Key formulas reproduced:
alpha^-1 = (2^7+2^3+2^0) + 3^2/(5^3*2) = 137 + 9/250 = 137.036
G = (7*11)/(2^3*5^2) * sqrt(3) * (1+9/250)^(1/40) * 10^-10 = 6.67429e-11
Input parameters: 0 (zero). Only primes {2,3,5,7,11} and d=4.
K(Universe) <= 85 bytes.

Best regards,
Hegedűs József (joco)
Budapest, Hungary
+36307465157
jhegedus42@gmail.com"""

# ── Attachments: full paths ──
ATTACHMENTS = [
    "/home/joco/scripts/gut_final.py",
    "/home/joco/scripts/all_constants_exact.py",
    "/home/joco/scripts/gut_free_category.py",
]

# ── 20 Recipients ──
RECIPIENTS = [
    "roger.penrose@maths.ox.ac.uk",
    "hinton@cs.toronto.edu",
    "wilczek@mit.edu",
    "witten@ias.edu",
    "yann@cs.nyu.edu",
    "bengioy@iro.umontreal.ca",
    "susskind@stanford.edu",
    "j.maldacena@ias.edu",
    "carlo.rovelli@cpt.univ-mrs.fr",
    "lee.smolin@perimeterinstitute.ca",
    "max.tegmark@gmail.com",
    "s.wolfram@gmail.com",
    "president@royalsociety.org",
    "info@mpg.de",
    "kugler@phy.bme.hu",
    "levay.peter@ttk.bme.hu",
    "levaipeter@wigner.hu",
    "rouse@maths.ox.ac.uk",
    "simonviktoria@yahoo.com",
    "jhegedus42@gmail.com",
]

DELAY_SEC = 2  # 2 seconds between emails


def build_message(recipient: str) -> MIMEMultipart:
    """Build a MIME message with body and 3 file attachments."""
    msg = MIMEMultipart()
    msg["From"] = FROM_ADDR
    msg["To"] = recipient
    msg["Subject"] = SUBJECT
    msg["Date"] = datetime.now().strftime("%a, %d %b %Y %H:%M:%S +0200")

    # Plain-text body
    msg.attach(MIMEText(BODY, "plain", "utf-8"))

    # Attach files
    for fpath in ATTACHMENTS:
        if not os.path.isfile(fpath):
            print(f"  ⚠ WARNING: attachment not found: {fpath}", file=sys.stderr)
            continue
        with open(fpath, "rb") as fh:
            part = MIMEBase("application", "octet-stream")
            part.set_payload(fh.read())
        encoders.encode_base64(part)
        fname = os.path.basename(fpath)
        part.add_header("Content-Disposition", f"attachment; filename=\"{fname}\"")
        msg.attach(part)

    return msg


def send_one(recipient: str, msg: MIMEMultipart) -> tuple[str, bool]:
    """Send one email. Returns (recipient, success)."""
    try:
        ctx = ssl.create_default_context()
        with smtplib.SMTP(SMTP_HOST, SMTP_PORT, timeout=30) as server:
            server.ehlo()
            server.starttls(context=ctx)
            server.ehlo()
            server.login(FROM_ADDR, FROM_PASS)
            server.sendmail(FROM_ADDR, recipient, msg.as_string())
        return (recipient, True)
    except Exception as exc:
        return (recipient, False, str(exc))


def main():
    print(f"=== FOLLOW-UP EMAIL SENDER ===")
    print(f"From:      {FROM_ADDR}")
    print(f"Subject:   {SUBJECT}")
    print(f"Recipients: {len(RECIPIENTS)}")
    print(f"Delay:      {DELAY_SEC}s between sends")
    print(f"Attachments: {[os.path.basename(a) for a in ATTACHMENTS]}")
    print(f"Start:      {datetime.now().strftime('%H:%M:%S')}")
    print(f"{'─'*60}")

    success_count = 0
    fail_count = 0
    failures = []

    for i, recipient in enumerate(RECIPIENTS, 1):
        ts = datetime.now().strftime("%H:%M:%S")
        print(f"[{ts}] [{i:02d}/20] Sending to: {recipient} ... ", end="", flush=True)

        msg = build_message(recipient)
        result = send_one(recipient, msg)

        if isinstance(result, tuple) and len(result) == 2:
            # old format without error
            _, ok = result
            err_msg = ""
        elif isinstance(result, tuple) and len(result) == 3:
            _, ok, err_msg = result
        else:
            ok = False
            err_msg = str(result)

        if ok:
            print("✓ SENT")
            success_count += 1
        else:
            print(f"✗ FAILED: {err_msg}")
            fail_count += 1
            failures.append((recipient, err_msg))

        # Delay between sends (no delay after last)
        if i < len(RECIPIENTS):
            time.sleep(DELAY_SEC)

    print(f"{'─'*60}")
    print(f"End:    {datetime.now().strftime('%H:%M:%S')}")
    print(f"Result: {success_count} sent, {fail_count} failed")

    if failures:
        print(f"\nFAILURES:")
        for addr, err in failures:
            print(f"  ✗ {addr}: {err}")

    print(f"\nLOG written to: /home/joco/scripts/followup_email_log.txt")

    # Write log file
    log_path = "/home/joco/scripts/followup_email_log.txt"
    with open(log_path, "w") as lf:
        lf.write(f"FOLLOW-UP EMAIL LOG — {datetime.now()}\n")
        lf.write(f"Subject: {SUBJECT}\n")
        lf.write(f"From: {FROM_ADDR}\n")
        lf.write(f"Count: {len(RECIPIENTS)}\n")
        lf.write(f"Sent: {success_count}, Failed: {fail_count}\n")
        lf.write(f"{'─'*60}\n")
        for i, recipient in enumerate(RECIPIENTS, 1):
            status = "✓ SENT" if recipient not in [f[0] for f in failures] else "✗ FAILED"
            lf.write(f"[{i:02d}] {recipient}: {status}\n")
        if failures:
            lf.write(f"\nFAILURE DETAILS:\n")
            for addr, err in failures:
                lf.write(f"  {addr}: {err}\n")


if __name__ == "__main__":
    main()
