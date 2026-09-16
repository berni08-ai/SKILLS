#!/usr/bin/env bash
# copiar-a-proyecto.sh — copia las skills y el hook a otro proyecto.
set -euo pipefail

if [ $# -lt 1 ]; then
  cat <<'USO'
Uso: copiar-a-proyecto.sh <ruta-del-proyecto>

Copia .claude/skills y .claude/hooks al proyecto indicado.
Crea .claude/settings.json si no existe.

Ejemplo:
  ./scripts/copiar-a-proyecto.sh ~/mis-proyectos/mi-app
USO
  exit 1
fi

ORIGEN="$(cd "$(dirname "$0")/.." && pwd)"
DESTINO="$1"

[ -d "$DESTINO" ] || { echo "Error: no existe $DESTINO" >&2; exit 1; }

mkdir -p "$DESTINO/.claude"
cp -r "$ORIGEN/.claude/skills" "$DESTINO/.claude/"
cp -r "$ORIGEN/.claude/hooks" "$DESTINO/.claude/"

if [ -f "$DESTINO/.claude/settings.json" ]; then
  echo "Aviso: ya existe settings.json. No lo toco."
  echo "Agrega el hook a mano. Copia el bloque de $ORIGEN/.claude/settings.json"
else
  cp "$ORIGEN/.claude/settings.json" "$DESTINO/.claude/settings.json"
fi

echo "Listo. Skills copiadas a $DESTINO/.claude/skills"
ls "$DESTINO/.claude/skills" | wc -l | xargs echo "Total de skills:"
echo "Haz commit de la carpeta .claude en ese proyecto."
