#!/usr/bin/env bash
# copiar-a-proyecto.sh — copia las skills a otro proyecto.
set -euo pipefail

if [ $# -lt 1 ]; then
  cat <<'USO'
Uso: copiar-a-proyecto.sh <ruta-del-proyecto>

Copia .claude/skills, .claude/agents y .claude/egm al proyecto indicado.
Los subagentes y la carpeta egm los necesitan las skills egm-*.

Ejemplo:
  ./scripts/copiar-a-proyecto.sh ~/mis-proyectos/mi-app
USO
  exit 1
fi

ORIGEN="$(cd "$(dirname "$0")/.." && pwd)"
DESTINO="$1"

[ -d "$DESTINO" ] || { echo "Error: no existe $DESTINO" >&2; exit 1; }

mkdir -p "$DESTINO/.claude"
for carpeta in skills agents egm; do
  if [ -d "$ORIGEN/.claude/$carpeta" ]; then
    cp -r "$ORIGEN/.claude/$carpeta" "$DESTINO/.claude/"
  fi
done

echo "Listo. Copiado a $DESTINO/.claude: skills, agents, egm"
ls "$DESTINO/.claude/skills" | wc -l | xargs echo "Total de skills:"
echo "Haz commit de la carpeta .claude en ese proyecto."
