#!/usr/bin/env python3
"""Send 3 emails to Pekka Orponen and his research group members."""

import smtplib
import time
from email.mime.multipart import MIMEMultipart
from email.mime.base import MIMEBase
from email.mime.text import MIMEText
from email import encoders
import os

# ── SMTP config ──────────────────────────────────────────────
SMTP_SERVER = "smtp.gmail.com"
SMTP_PORT = 587
USERNAME = "jhegedus42@gmail.com"
PASSWORD = "dtcc nwkw mhmg hica"

# ── Recipients ───────────────────────────────────────────────
# Pekka Orponen + current research group members (Natural Computation, Aalto Univ.)
RECIPIENTS = [
    "pekka.orponen@aalto.fi",       # Prof. Pekka Orponen — group leader
    "antti.elonen@aalto.fi",        # Antti Elonen — M.Sc., current member
    "kaisla.nyblom@aalto.fi",       # Kaisla Nyblom — B.Sc., current member
    "robin.runne@aalto.fi",         # Robin Runne — Mr., current member
]

# ── Email body texts ─────────────────────────────────────────
BODY_1 = """Dear Colleague,

I am sending you a preprint of my work "The 710 Code" (v2, 2026-07-21).

The theory derives all fundamental physical constants from 5 primes {2,3,5,7,11}.

Key results:
- alpha^-1 = 137 + 9/250 = 137.036 (matches CODATA 137.035999084)
- G = (7*11)/(2^3*5^2)*sqrt(3)*(1+9/250)^(1/40)*10^-10
- K(Universe) <= 85 bytes (Kolmogorov complexity bound)
- SM gauge group from 710 = 2*5*71 decomposition
- 12 = 6X + 6Z stabilizers from CPT-137 structure

The derivation is purely mathematical — no free parameters beyond the 5 primes.

I would be grateful for any feedback or comments.

Best regards,
Hegedűs József (joco)
+36307465157
"""

BODY_2 = """Dear Colleague,

Following up on my previous email, I am attaching the Python source code for the 710 Code calculations.

Three files attached:
1. gut_final.py — Main derivation: alpha, G, all constants from 5 primes
2. all_constants_exact.py — Exact symbolic computation of all SM constants
3. gut_free_category.py — Free category formulation of the derivation

The code is pure Python 3 with no dependencies beyond the standard library.
All calculations are exact (fractions, not floating point).

Best regards,
Hegedűs József (joco)
+36307465157
"""

BODY_3 = """Dear Colleague,

I am also attaching two PDFs that explain the 710 Code at a high-school level:

1. GUT_Complete_Explanation_EN.pdf — English version
2. GUT_Teljes_Magyarazat.pdf — Hungarian version (the theory is formulated in the Dirac language: Chinese + Hungarian simultaneously)

The English PDF walks through every step from the 5 primes to all physical constants, requiring only high-school algebra.

I hope this makes the theory accessible to a wider audience.

Best regards,
Hegedűs József (joco)
+36307465157
"""

# ── Email definitions ────────────────────────────────────────
EMAILS = [
    {
        "subject": "The 710 Code -- Complete Derivation of All Physical Constants from 5 Primes (v2, 2026-07-21)",
        "body": BODY_1,
        "attachments": ["/home/joco/claude/gut_paper.pdf"],
    },
    {
        "subject": "Re: The 710 Code -- Python Source Code + Contact",
        "body": BODY_2,
        "attachments": [
            "/home/joco/scripts/gut_final.py",
            "/home/joco/scripts/all_constants_exact.py",
            "/home/joco/scripts/gut_free_category.py",
        ],
    },
    {
        "subject": "Re: The 710 Code -- High-School Level Explanation (EN + HU PDFs)",
        "body": BODY_3,
        "attachments": [
            "/home/joco/claude/GUT_Complete_Explanation_EN.pdf",
            "/home/joco/claude/GUT_Teljes_Magyarazat.pdf",
        ],
    },
]


def connect_smtp():
    """Create a fresh SMTP connection."""
    smtp = smtplib.SMTP(SMTP_SERVER, SMTP_PORT, timeout=30)
    smtp.ehlo()
    smtp.starttls()
    smtp.ehlo()
    smtp.login(USERNAME, PASSWORD)
    return smtp


def send_email(smtp_conn, to_addr, subject, body, attachments):
    """Send one email to a single recipient. Returns True on success."""
    msg = MIMEMultipart()
    msg["From"] = USERNAME
    msg["To"] = to_addr
    msg["Subject"] = subject
    msg.attach(MIMEText(body, "plain", "utf-8"))

    for filepath in attachments:
        if not os.path.exists(filepath):
            print(f"    ⚠ MISSING: {filepath}")
            continue
        filename = os.path.basename(filepath)
        with open(filepath, "rb") as f:
            part = MIMEBase("application", "octet-stream")
            part.set_payload(f.read())
        encoders.encode_base64(part)
        part.add_header("Content-Disposition", f'attachment; filename="{filename}"')
        msg.attach(part)
        print(f"    ✓ Attached: {filename}")

    smtp_conn.sendmail(USERNAME, to_addr, msg.as_string())
    return True


def main():
    print("=" * 72)
    print("SENDING EMAILS TO PEKKA ORPONEN + RESEARCH GROUP")
    print("=" * 72)
    print(f"\nRecipients ({len(RECIPIENTS)}):")
    for r in RECIPIENTS:
        print(f"  • {r}")
    print()

    total_sent = 0
    total_failed = 0
    all_results = []

    for i, email_def in enumerate(EMAILS, 1):
        print(f"══ Email {i}/3 ══")
        print(f"   Subject: {email_def['subject']}")
        print(f"   Attachments: {len(email_def['attachments'])}")

        # Fresh connection per email to avoid timeout issues
        try:
            print("   Connecting to SMTP...")
            smtp = connect_smtp()
            print("   ✓ Authenticated")
        except Exception as e:
            print(f"   ✗ SMTP connection failed: {e}")
            all_results.append((i, "FAILED", f"SMTP: {e}", []))
            time.sleep(2)
            continue

        # Send to each recipient individually
        sent_to = []
        failed_to = []
        for recipient in RECIPIENTS:
            print(f"   → {recipient} ... ", end="", flush=True)
            try:
                send_email(
                    smtp,
                    recipient,
                    email_def["subject"],
                    email_def["body"],
                    email_def["attachments"],
                )
                print("✓")
                sent_to.append(recipient)
                total_sent += 1
            except Exception as e:
                print(f"✗ ({e})")
                failed_to.append((recipient, str(e)))
                total_failed += 1

        try:
            smtp.quit()
        except Exception:
            pass

        all_results.append((i, sent_to, failed_to))

        if i < len(EMAILS):
            wait = 2
            print(f"\n   Waiting {wait}s before next email...\n")
            time.sleep(wait)

    # Summary
    print("\n" + "=" * 72)
    print("RESULTS SUMMARY")
    print("=" * 72)
    for num, sent_to, failed_to in all_results:
        if isinstance(sent_to, list):
            ok_count = len(sent_to)
            fail_count = len(failed_to)
            print(f"\n  Email {num}: ✓ {ok_count} sent, ✗ {fail_count} failed")
            for r in sent_to:
                print(f"    ✓ {r}")
            for r, err in failed_to:
                print(f"    ✗ {r}: {err}")
        else:
            print(f"\n  Email {num}: ✗ FAILED — {failed_to}")

    print(f"\n{'─' * 72}")
    print(f"Total individual sends: {total_sent} OK, {total_failed} FAILED")
    print(f"Recipients: {len(RECIPIENTS)}")
    print(f"Timestamp: {time.strftime('%Y-%m-%d %H:%M:%S %Z')}")
    print("=" * 72)


if __name__ == "__main__":
    main()
