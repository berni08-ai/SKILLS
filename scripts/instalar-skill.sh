#!/usr/bin/env bash
# instalar-skill.sh — copia una skill desde un repo de GitHub.
# Úsalo cuando el repo NO trae marketplace.json.
set -euo pipefail

usage() {
  cat <<'USO'
Uso: instalar-skill.sh <repo> <ruta-skill> [destino]

  repo         OWNER/REPO o URL completa de GitHub.
  ruta-skill   Ruta de la carpeta de la skill dentro del repo.
  destino      personal (por defecto) o proyecto.

Destinos:
  personal   ~/.claude/skills/        Disponible en todos tus proyectos.
  proyecto   ./.claude/skills/        Versionada en el repo actual.

Ejemplos:
  ./scripts/instalar-skill.sh OWNER/REPO skills/mi-skill
  ./scripts/instalar-skill.sh OWNER/REPO skills/mi-skill proyecto

Variables:
  FORCE=1    Sobrescribe una skill existente.
USO
}

if [ $# -lt 2 ]; then
  usage
  exit 1
fi

REPO="$1"
RUTA_SKILL="$2"
DESTINO="${3:-personal}"
FORCE="${FORCE:-0}"

case "$REPO" in
  http*://*) URL="$REPO" ;;
  */*)       URL="https://github.com/$REPO" ;;
  *)         echo "Error: repo inválido: $REPO" >&2; exit 1 ;;
esac

case "$DESTINO" in
  personal) DIR_DESTINO="$HOME/.claude/skills" ;;
  proyecto) DIR_DESTINO="$PWD/.claude/skills" ;;
  *)        echo "Error: destino inválido: $DESTINO" >&2; exit 1 ;;
esac

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo "Clonando $URL ..."
git clone --depth 1 --quiet "$URL" "$TMP/repo"

ORIGEN="$TMP/repo/$RUTA_SKILL"

if [ ! -d "$ORIGEN" ]; then
  echo "Error: no existe la carpeta $RUTA_SKILL en el repo." >&2
  exit 1
fi

if [ ! -f "$ORIGEN/SKILL.md" ]; then
  echo "Error: falta SKILL.md en $RUTA_SKILL." >&2
  exit 1
fi

NOMBRE="$(basename "$RUTA_SKILL")"
FINAL="$DIR_DESTINO/$NOMBRE"

if [ -d "$FINAL" ] && [ "$FORCE" != "1" ]; then
  echo "Error: ya existe $FINAL. Usa FORCE=1 para sobrescribir." >&2
  exit 1
fi

mkdir -p "$DIR_DESTINO"
rm -rf "$FINAL"
cp -r "$ORIGEN" "$FINAL"

echo "Skill instalada en: $FINAL"
echo "Frontmatter:"
sed -n '1,6p' "$FINAL/SKILL.md"
echo
echo "Abre una sesión nueva de Claude Code para activarla."
