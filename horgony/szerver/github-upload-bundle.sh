#!/usr/bin/env bash
# github-upload-bundle.sh — A god repo feltöltése git bundle segítségével
# Használat:
#   1. Generálj PAT-et: https://github.com/settings/tokens/new (scope: repo)
#   2. export GITHUB_TOKEN=ghp_xxxxx
#   3. ./github-upload-bundle.sh

set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
BUNDLE="/tmp/god-repo.bundle"
SECRETS_FILE="/home/joco/.secrets/secrets.env"

echo "═══════════════════════════════════════════════════════════════"
echo "  GOD REPO → GITHUB (BUNDLE UPLOAD)"
echo "═══════════════════════════════════════════════════════════════"
echo ""

# 1. LÉPÉS: Bundle ellenőrzése
if [ ! -f "$BUNDLE" ]; then
  echo "  ✗ Bundle nem található: $BUNDLE"
  echo "  Generálás: cd $DIR && git bundle create $BUNDLE --all"
  exit 1
fi

BUNDLE_SIZE=$(du -h "$BUNDLE" | cut -f1)
echo "  ✓ Bundle: $BUNDLE ($BUNDLE_SIZE)"
git bundle verify "$BUNDLE" > /dev/null && echo "  ✓ Bundle érvényes"
echo ""

# 2. LÉPÉS: PAT lekérése
if [ -z "${GITHUB_TOKEN:-}" ]; then
  if [ -f "$SECRETS_FILE" ] && grep -q "^GITHUB_TOKEN=" "$SECRETS_FILE" 2>/dev/null; then
    GITHUB_TOKEN=$(grep "^GITHUB_TOKEN=" "$SECRETS_FILE" | cut -d'=' -f2- | tr -d '\n\r' | tr -d "'\"")
    echo "  → PAT a secrets.env-ből"
  else
    echo "  ✗ Nincs GITHUB_TOKEN!"
    echo "  Generálj egyet: https://github.com/settings/tokens/new"
    echo "  Majd: export GITHUB_TOKEN=ghp_xxxxx"
    exit 1
  fi
fi

GITHUB_USER=${GITHUB_USER:-jhegedus42}
REPO=${GITHUB_REPO:-home-joco-god-repo}
DESC=${GITHUB_DESC:-"/home/joco teljes AI kutatólabor — god repo"}

echo "  User: $GITHUB_USER"
echo "  Repo: $REPO"
echo ""

# 3. LÉPÉS: Repo létrehozása (ha nem létezik)
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

# 4. LÉPÉS: Bundle klónozása és push
echo "▸ Bundle klónozása és push..."
TMPDIR=$(mktemp -d)
cd "$TMPDIR"
git clone "$BUNDLE" repo 2>&1 | tail -3
cd repo
git remote add origin "https://${GITHUB_TOKEN}@github.com/${GITHUB_USER}/${REPO}.git"
git push -u origin main 2>&1 | tail -10
cd /
rm -rf "$TMPDIR"
echo ""

echo "═══════════════════════════════════════════════════════════════"
echo "  ✓ KÉSZ: https://github.com/${GITHUB_USER}/${REPO}"
echo "═══════════════════════════════════════════════════════════════"
