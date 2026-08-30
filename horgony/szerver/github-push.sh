#!/usr/bin/env bash
# github-push.sh — A /home/joco god repo privát GitHub repo-ba pusholása
# Használat: ./github-push.sh
# PAT forrása (prioritás sorrendben):
#   1. GITHUB_TOKEN környezeti változó
#   2. ~/.secrets/secrets.env fájl (GITHUB_TOKEN=...)
#   3. Interaktív prompt (read -s, soha nem jelenik meg)

set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
SECRETS_FILE="/home/joco/.secrets/secrets.env"

echo "═══════════════════════════════════════════════════════════════"
echo "  GOD REPO → PRIVÁT GITHUB REPO PUSH"
echo "═══════════════════════════════════════════════════════════════"
echo ""

# ─── 1. LÉPÉS: GitHub felhasználónév ───
echo "▸ 1. LÉPÉS: GitHub felhasználónév"
echo "─────────────────────────────────────"

if [ -n "${GITHUB_USER:-}" ]; then
  echo "  → GITHUB_USER környezeti változóból: $GITHUB_USER"
else
  read -p "GitHub felhasználónév [jhegedus42]: " GITHUB_USER
  GITHUB_USER=${GITHUB_USER:-jhegedus42}
fi
echo ""

# ─── 2. LÉPÉS: PAT lekérése ───
echo "▸ 2. LÉPÉS: Personal Access Token (PAT)"
echo "─────────────────────────────────────"

# Prioritás 1: környezeti változó
if [ -n "${GITHUB_TOKEN:-}" ]; then
  echo "  → GITHUB_TOKEN környezeti változóból"
# Prioritás 2: secrets.env
elif [ -f "$SECRETS_FILE" ] && grep -q "^GITHUB_TOKEN=" "$SECRETS_FILE" 2>/dev/null; then
  GITHUB_TOKEN=$(grep "^GITHUB_TOKEN=" "$SECRETS_FILE" | cut -d'=' -f2- | tr -d '\n\r')
  echo "  → PAT a secrets.env-ből: $SECRETS_FILE"
# Prioritás 3: interaktív prompt
else
  echo "  PAT szükséges (repo scope). Generáld itt:"
  echo "    https://github.com/settings/tokens/new"
  echo "  Scope: 'repo' (teljes hozzáférés a privát repo-khoz)"
  echo ""
  echo -n "  PAT (nem jelenik meg): "
  read -s GITHUB_TOKEN
  echo ""

  if [ -z "$GITHUB_TOKEN" ]; then
    echo "  ✗ PAT kötelező"
    exit 1
  fi

  # PAT mentése a secrets.env-be
  echo ""
  echo "▸ PAT mentése a secrets.env-be"
  if [ ! -d "/home/joco/.secrets" ]; then
    mkdir -p /home/joco/.secrets
    chmod 700 /home/joco/.secrets
  fi
  if [ ! -f "$SECRETS_FILE" ]; then
    touch "$SECRETS_FILE"
    chmod 600 "$SECRETS_FILE"
  fi
  # Töröljük a régit
  sed -i '/^GITHUB_TOKEN=/d' "$SECRETS_FILE" 2>/dev/null || true
  sed -i '/^GITHUB_USER=/d' "$SECRETS_FILE" 2>/dev/null || true
  # Hozzáfűzzük az újat
  cat >> "$SECRETS_FILE" << EOF

# GitHub Personal Access Token (gondnok god repo push, $(date -I))
GITHUB_USER=$GITHUB_USER
GITHUB_TOKEN=$GITHUB_TOKEN
EOF
  chmod 600 "$SECRETS_FILE"
  echo "  ✓ PAT elmentve: $SECRETS_FILE (chmod 600)"
fi
echo ""

# ─── 3. LÉPÉS: GitHub API hitelesítés teszt ───
echo "▸ 3. LÉPÉS: GitHub API hitelesítés"
echo "─────────────────────────────────────"
USER_INFO=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/user 2>&1)

if echo "$USER_INFO" | grep -q '"login"'; then
  LOGIN=$(echo "$USER_INFO" | grep -o '"login": *"[^"]*"' | head -1 | cut -d'"' -f4)
  echo "  ✓ Hitelesítve: $LOGIN"
else
  echo "  ✗ Hitelesítés sikertelen:"
  echo "$USER_INFO" | head -5
  exit 1
fi
echo ""

# ─── 4. LÉPÉS: Repo név és leírás ───
echo "▸ 4. LÉPÉS: Repo konfiguráció"
echo "─────────────────────────────────────"

# Repo név
if [ -n "${GITHUB_REPO:-}" ]; then
  echo "  → Repo név környezeti változóból: $GITHUB_REPO"
else
  read -p "Repo név [home-joco-god-repo]: " GITHUB_REPO
  GITHUB_REPO=${GITHUB_REPO:-home-joco-god-repo}
fi

# Repo leírás
if [ -n "${GITHUB_DESC:-}" ]; then
  echo "  → Leírás környezeti változóból: $GITHUB_DESC"
else
  read -p "Leírás [/home/joco teljes AI kutatólabor — god repo]: " GITHUB_DESC
  GITHUB_DESC=${GITHUB_DESC:-"/home/joco teljes AI kutatólabor — god repo"}
fi

echo "  → User:  $GITHUB_USER"
echo "  → Repo:  $GITHUB_REPO"
echo "  → Desc:  $GITHUB_DESC"
echo ""

# ─── 5. LÉPÉS: Privát repo létrehozása ───
echo "▸ 5. LÉPÉS: Privát repo létrehozása"
echo "─────────────────────────────────────"

# Ellenőrizzük, hogy létezik-e már
EXISTING=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/$GITHUB_USER/$GITHUB_REPO 2>&1)

if echo "$EXISTING" | grep -q '"id"'; then
  echo "  → A repo már létezik: $GITHUB_USER/$GITHUB_REPO"
  IS_PRIVATE=$(echo "$EXISTING" | grep -o '"private": *[a-z]*' | head -1 | grep -o '[a-z]*$')
  echo "  → Private: $IS_PRIVATE"
else
  echo "  → Repo létrehozása..."
  CREATE_RESULT=$(curl -s -X POST \
    -H "Authorization: token $GITHUB_TOKEN" \
    -H "Accept: application/vnd.github.v3+json" \
    -d "{\"name\":\"$GITHUB_REPO\",\"description\":\"$GITHUB_DESC\",\"private\":true}" \
    https://api.github.com/user/repos 2>&1)

  if echo "$CREATE_RESULT" | grep -q '"id"'; then
    REPO_URL=$(echo "$CREATE_RESULT" | grep -o '"html_url": *"[^"]*"' | head -1 | cut -d'"' -f4)
    echo "  ✓ Repo létrehozva: $REPO_URL"
  else
    echo "  ✗ Repo létrehozás sikertelen:"
    echo "$CREATE_RESULT" | head -10
    exit 1
  fi
fi
echo ""

# ─── 6. LÉPÉS: Remote beállítása ───
echo "▸ 6. LÉPÉS: Remote beállítása"
echo "─────────────────────────────────────"
cd "$DIR"

# Távolítsuk el a régi origin-t, ha read-only SSH
if git remote get-url origin 2>/dev/null | grep -q "git@github.com"; then
  # Ellenőrizzük, hogy a meglévő remote read-only-e
  # Ha igen, HTTPS-re váltunk a PAT-tel
  git remote remove origin 2>/dev/null || true
  echo "  → Régi SSH remote eltávolítva"
fi

# HTTPS remote a PAT-tel (a PAT a Git credential helper-ben tárolódik)
HTTPS_URL="https://$GITHUB_TOKEN@github.com/$GITHUB_USER/$GITHUB_REPO.git"
git remote add origin "$HTTPS_URL"
echo "  ✓ Remote beállítva: origin → https://github.com/$GITHUB_USER/$GITHUB_REPO.git"
echo "  (A PAT a remote URL-ben van, nem jelenik meg a git config-ban)"
echo ""

# ─── 7. LÉPÉS: Push ───
echo "▸ 7. LÉPÉS: Push a GitHub-ra"
echo "─────────────────────────────────────"
git push -u origin main 2>&1 | tail -15
echo ""

# ─── 8. LÉPÉS: Eredmény ───
echo "═══════════════════════════════════════════════════════════════"
echo "  ✓ KÉSZ"
echo "═══════════════════════════════════════════════════════════════"
echo "  Repo URL:    https://github.com/$GITHUB_USER/$GITHUB_REPO"
echo "  PAT tárolva: $SECRETS_FILE (chmod 600)"
echo "  Remote:      origin (HTTPS, PAT-tel)"
echo ""
echo "  Következő push-ok:"
echo "    cd /home/joco && git push"
echo "    (A remote URL tartalmazza a PAT-et, nem kell újra megadni)"
echo ""
echo "  Ha a jövőben le szeretnéd cserélni a PAT-et:"
echo "    1. Generálj újat: https://github.com/settings/tokens/new"
echo "    2. Futtasd újra: ./github-push.sh"
echo "═══════════════════════════════════════════════════════════════"
