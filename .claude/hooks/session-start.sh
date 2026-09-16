#!/usr/bin/env bash
# Hook SessionStart. Inyecta la skill using-superpowers al iniciar la sesion.
# Portado del plugin superpowers (MIT, Jesse Vincent). Ver LICENSES/.
set -euo pipefail

DIR_HOOK="$(cd "$(dirname "$0")" && pwd)"
SKILL="${DIR_HOOK}/../skills/using-superpowers/SKILL.md"

[ -f "$SKILL" ] || exit 0

python3 - "$SKILL" <<'PY'
import json, sys

with open(sys.argv[1], encoding="utf-8") as f:
    contenido = f.read()

texto = (
    "<EXTREMELY_IMPORTANT>\n"
    "You have superpowers.\n\n"
    "**Below is the full content of your 'using-superpowers' skill - your "
    "introduction to using skills. For all other skills, use the 'Skill' tool:**\n\n"
    + contenido +
    "\n</EXTREMELY_IMPORTANT>"
)

print(json.dumps({
    "hookSpecificOutput": {
        "hookEventName": "SessionStart",
        "additionalContext": texto,
    }
}))
PY
