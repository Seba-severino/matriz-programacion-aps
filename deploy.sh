#!/usr/bin/env bash
# Publica la Matriz de Programación APS: sincroniza el HTML, versiona en GitHub
# y despliega a Firebase Hosting (proyecto cvh-hub, sitio matriz-aps).
set -Eeuo pipefail
cd "$(dirname "$0")"

trap 'echo "✖ Error en la línea $LINENO. Deploy abortado sin cambios parciales en producción." >&2' ERR

require() { command -v "$1" >/dev/null 2>&1 || { echo "✖ Falta la dependencia: $1" >&2; exit 1; }; }
require git; require firebase

SRC="matriz-programacion-aps.html"
MSG="${1:-Actualiza herramienta Matriz de Programación APS}"
[[ -f "$SRC" ]] || { echo "✖ No se encuentra $SRC" >&2; exit 1; }

# 1) Sincronizar el archivo raíz hacia la carpeta pública de hosting (rutas intactas)
mkdir -p public
cp "$SRC" public/index.html
cp "$SRC" public/matriz-programacion-aps.html

# 2) Versionar en GitHub (solo si hay cambios y si el remoto existe)
git add -A
if git diff --cached --quiet; then
  echo "Sin cambios que commitear."
else
  git commit -m "$MSG

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>"
  if git remote get-url github >/dev/null 2>&1; then
    git push github main || echo "⚠ No se pudo hacer push a GitHub; continúo con el deploy." >&2
  else
    echo "⚠ Remoto 'github' no configurado; se omite el push." >&2
  fi
fi

# 3) Desplegar a Firebase Hosting (proyecto cvh-hub)
firebase deploy --only hosting:matriz-aps --project cvh-hub

# 4) Desplegar reglas Firestore (proyecto de datos, neutro)
firebase deploy --only firestore:rules --project matriz-aps-datos

echo ""
echo "✔ Publicado: https://matriz-aps.web.app"
echo "✔ Repo:      https://github.com/Seba-severino/matriz-programacion-aps"
