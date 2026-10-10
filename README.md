# SKILLS

Skills propias para Claude Code.

## Uso inmediato

Abre este repo con Claude Code. Las skills de `.claude/skills/` se cargan al iniciar.

No hay comandos que ejecutar. No hay plugins que instalar.

## Skills incluidas

| Skill | Para qué |
|---|---|
| `ejemplo-skill` | Plantilla para crear skills propias. |

## Llevarlas a otro proyecto

```bash
./scripts/copiar-a-proyecto.sh /ruta/de/tu/proyecto
```

El script copia `.claude/skills` al proyecto. Después haz commit de la carpeta `.claude` allí.

## Cómo invocarlas

**Automático.** Claude activa la skill según su `description`.

**Manual.** Escribe el nombre con una barra: `/ejemplo-skill`.

## Qué NO funciona

Declarar plugins en `.claude/settings.json` **no los instala solos**.
Por eso las skills van en `.claude/skills/`, no como plugin.

## Método alternativo: plugin de marketplace

Sirve en tu máquina local, no en sesiones web.

```
/plugin marketplace add berni08-ai/SKILLS
/plugin install mis-skills@berni-skills
```

## Agregar una skill nueva

1. Crea `.claude/skills/mi-skill/SKILL.md`.
2. Agrega la ruta a `skills` en `.claude-plugin/marketplace.json`.
3. Sube la versión en los dos archivos de `.claude-plugin/`.
4. Valida: `claude plugin validate .`
5. Haz commit y push.

Para copiar una skill desde otro repo de GitHub:

```bash
./scripts/instalar-skill.sh OWNER/REPO ruta/mi-skill proyecto
```

## Estructura

```
.claude/
  skills/              Claude Code las lee al iniciar.
.claude-plugin/
  plugin.json          Manifiesto del plugin.
  marketplace.json     Manifiesto del marketplace.
scripts/
  copiar-a-proyecto.sh Copia .claude/skills a otro proyecto.
  instalar-skill.sh    Copia una skill suelta desde otro repo.
```
