#!/usr/bin/env bash
# Vercel build: branch/commit meta + optional banner a statikus oldalakhoz.
# Env (Vercel): VERCEL_GIT_COMMIT_REF, VERCEL_GIT_COMMIT_SHA, VERCEL_ENV
# Env (GitHub Actions): GITHUB_REF_NAME, GITHUB_SHA

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOCS_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

BRANCH="${VERCEL_GIT_COMMIT_REF:-${GITHUB_REF_NAME:-local}}"
COMMIT="${VERCEL_GIT_COMMIT_SHA:-${GITHUB_SHA:-unknown}}"
COMMIT_SHORT="${COMMIT:0:7}"
ENV_NAME="${VERCEL_ENV:-preview}"
BUILD_TIME="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

META_JSON="$DOCS_DIR/adatok/preview_meta.json"
mkdir -p "$(dirname "$META_JSON")"

cat > "$META_JSON" <<EOF
{
  "ag": "${BRANCH}",
  "commit": "${COMMIT}",
  "commit_rovid": "${COMMIT_SHORT}",
  "kornyezet": "${ENV_NAME}",
  "epitve": "${BUILD_TIME}",
  "repo": "jhegedus42/Szima"
}
EOF

BANNER_CSS='/* preview banner — vercel-build.sh */
#preview-ag-banner{position:fixed;bottom:0;left:0;right:0;z-index:9999;background:#1f6feb;color:#fff;font:12px/1.4 system-ui,sans-serif;padding:6px 12px;display:flex;gap:12px;flex-wrap:wrap;align-items:center;box-shadow:0 -2px 8px #0006}
#preview-ag-banner a{color:#c9d1d9}
#preview-ag-banner .tag{background:#0d1117;border-radius:4px;padding:2px 8px;font-family:ui-monospace,monospace}
#preview-ag-banner.production{background:#238636}
body.has-preview-banner{padding-bottom:2.5rem}'

BANNER_JS="$(cat <<'JSEND'
(function(){
  var m = null;
  fetch('/adatok/preview_meta.json').then(function(r){ return r.json(); }).then(function(j){
    m = j;
    var b = document.createElement('div');
    b.id = 'preview-ag-banner';
    if (j.kornyezet === 'production') b.className = 'production';
    b.innerHTML = '<span><strong>Docs preview</strong></span>'
      + '<span class="tag">ág: ' + j.ag + '</span>'
      + '<span class="tag">' + j.commit_rovid + '</span>'
      + '<span>' + j.kornyezet + '</span>'
      + '<a href="https://github.com/jhegedus42/Szima/tree/' + encodeURIComponent(j.ag) + '/docs" target="_blank" rel="noopener">GitHub docs/</a>'
      + '<a href="literatura.html">Térkép</a>';
    document.body.classList.add('has-preview-banner');
    document.body.appendChild(b);
  }).catch(function(){});
})();
JSEND
)"

BANNER_DIR="$DOCS_DIR/_preview"
mkdir -p "$BANNER_DIR"
printf '%s\n' "$BANNER_CSS" > "$BANNER_DIR/banner.css"
printf '%s\n' "$BANNER_JS" > "$BANNER_DIR/banner.js"

# Inject into HTML files that lack the banner yet
for html in "$DOCS_DIR"/*.html; do
  [[ -f "$html" ]] || continue
  if grep -q 'preview_meta.json' "$html" 2>/dev/null; then
    continue
  fi
  # Insert before </head>
  sed -i.bak 's|</head>|  <link rel="stylesheet" href="_preview/banner.css">\n  <script src="_preview/banner.js" defer></script>\n</head>|' "$html"
  rm -f "${html}.bak"
done

echo "vercel-build: ag=${BRANCH} env=${ENV_NAME} commit=${COMMIT_SHORT}"
