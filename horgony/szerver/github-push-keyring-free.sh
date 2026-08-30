#!/usr/bin/env bash
# github-push-keyring-free.sh — Alternatív push módszer keyring nélkül
# Ez a script megkerüli a gh CLI keyring problémáját

set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
SECRETS_FILE="/home/joco/.secrets/secrets.env"

echo "═══════════════════════════════════════════════════════════════"
echo "  GOD REPO → GITHUB PUSH (KEYRING-FREE)"
echo "═══════════════════════════════════════════════════════════════"
echo ""

# 1. LÉPÉS: PAT a secrets.env-ből vagy környezetből
if [ -n "${GITHUB_TOKEN:-}" ]; then
  echo "  → GITHUB_TOKEN környezeti változóból"
elif [ -f "$SECRETS_FILE" ] && grep -q "^GITHUB_TOKEN=" "$SECRETS_FILE" 2>/dev/null; then
  GITHUB_TOKEN=$(grep "^GITHUB_TOKEN=" "$SECRETS_FILE" | cut -d'=' -f2- | tr -d '\n\r' | tr -d "'\"")
  echo "  → PAT a secrets.env-ből"
else
  echo "  ✗ Nincs GITHUB_TOKEN!"
  echo "  Generálj egyet: https://github.com/settings/tokens/new"
  echo "  Majd add hozzá a secrets.env-hez:"
  echo "    echo 'GITHUB_TOKEN=ghp_xxxxx' >> $SECRETS_FILE"
  echo "  Vagy exportáld:"
  echo "    export GITHUB_TOKEN=ghp_xxxxx"
  exit 1
fi

if [ -z "${GITHUB_USER:-}" ]; then
  if [ -f "$SECRETS_FILE" ] && grep -q "^GITHUB_USER=" "$SECRETS_FILE" 2>/dev/null; then
    GITHUB_USER=$(grep "^GITHUB_USER=" "$SECRETS_FILE" | cut -d'=' -f2- | tr -d '\n\r' | tr -d "'\"")
  else
    GITHUB_USER="jhegedus42"
  fi
fi

REPO=${GITHUB_REPO:-home-joco-god-repo}
DESC=${GITHUB_DESC:-"/home/joco teljes AI kutatólabor — god repo"}

echo "  User: $GITHUB_USER"
echo "  Repo: $REPO"
echo ""

# 2. LÉPÉS: Repo ellenőrzése/létrehozása API-n keresztül
echo "▸ Repo ellenőrzése..."
EXISTING=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  "https://api.github.com/repos/$GITHUB_USER/$REPO")

if echo "$EXISTING" | grep -q '"id"'; then
  echo "  ✓ Repo létezik"
else
  echo "  → Repo létrehozása..."
  CREATE=$(curl -s -X POST \
    -H "Authorization: token $GITHUB_TOKEN" \
    -H "Accept: application/vnd.github.v3+json" \
    -d "{\"name\":\"$REPO\",\"description\":\"$DESC\",\"private\":true,\"auto_init\":false}" \
    "https://api.github.com/user/repos")

  if echo "$CREATE" | grep -q '"id"'; then
    echo "  ✓ Repo létrehozva"
  else
    echo "  ✗ Hiba:"
    echo "$CREATE" | head -5
    exit 1
  fi
fi
echo ""

# 3. LÉPÉS: Remote beállítása
echo "▸ Remote beállítása..."
cd "$DIR"
git remote remove origin 2>/dev/null || true
HTTPS_URL="https://${GITHUB_TOKEN}@github.com/${GITHUB_USER}/${REPO}.git"
git remote add origin "$HTTPS_URL"
echo "  ✓ Remote: https://github.com/${GITHUB_USER}/${REPO}.git"
echo ""

# 4. LÉPÉS: Push
echo "▸ Push..."
git push -u origin main 2>&1 | tail -10
echo ""

echo "═══════════════════════════════════════════════════════════════"
echo "  ✓ KÉSZ: https://github.com/${GITHUB_USER}/${REPO}"
echo "═══════════════════════════════════════════════════════════════"
