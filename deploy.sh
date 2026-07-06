#!/usr/bin/env bash
# Publica la Matriz de Programación APS: sincroniza el HTML, versiona en GitHub
# y despliega a Firebase Hosting (proyecto cvh-hub, sitio matriz-aps).
set -euo pipefail
cd "$(dirname "$0")"

MSG="${1:-Actualiza herramienta Matriz de Programación APS}"

# 1) Sincronizar el archivo raíz hacia la carpeta pública de hosting
cp matriz-programacion-aps.html public/index.html
cp matriz-programacion-aps.html public/matriz-programacion-aps.html

# 2) Versionar en GitHub (solo si hay cambios)
git add -A
if ! git diff --cached --quiet; then
  git commit -m "$MSG

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>"
  git push github main
else
  echo "Sin cambios que commitear."
fi

# 3) Desplegar a Firebase Hosting
firebase deploy --only hosting:matriz-aps --project cvh-hub

echo ""
echo "✔ Publicado: https://matriz-aps.web.app"
echo "✔ Repo:      https://github.com/Seba-severino/matriz-programacion-aps"
