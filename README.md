# SKILLS

Colección personal de skills para Claude Code.

## Qué es una skill

Una skill es una carpeta con un archivo `SKILL.md`.

El `SKILL.md` empieza con frontmatter YAML:

```markdown
---
name: mi-skill
description: Qué hace la skill y cuándo debe activarse.
---

# Mi skill

Instrucciones que Claude sigue al activar la skill.
```

Claude lee la `description` y activa la skill sola.
También puedes invocarla escribiendo `/mi-skill`.

## Dónde van las skills

| Ruta | Alcance | Se versiona en git |
|---|---|---|
| `~/.claude/skills/<skill>/` | Todos tus proyectos | No |
| `<proyecto>/.claude/skills/<skill>/` | Un proyecto | Sí |
| Plugin de marketplace | Según instalación | Sí, en el repo del plugin |

## Primero: identifica el tipo de repo

Revisa si el repo trae el archivo `.claude-plugin/marketplace.json`.

```bash
git clone --depth 1 https://github.com/OWNER/REPO /tmp/repo
ls /tmp/repo/.claude-plugin/
```

- Existe `marketplace.json` → usa el Método A (marketplace).
- No existe → usa el Método B (copiar carpeta).

## Método A: marketplace de plugins

Dentro de Claude Code:

```
/plugin marketplace add OWNER/REPO
/plugin install NOMBRE@MARKETPLACE
```

Desde la terminal:

```bash
claude plugin marketplace add OWNER/REPO
claude plugin install NOMBRE@MARKETPLACE
```

Actualiza después con `claude plugin marketplace update`.

## Método B: copiar la carpeta

Sirve para cualquier repo de GitHub.

```bash
git clone --depth 1 https://github.com/OWNER/REPO /tmp/repo
cp -r /tmp/repo/RUTA/mi-skill ~/.claude/skills/
```

Atajo con el script de este repo:

```bash
./scripts/instalar-skill.sh OWNER/REPO ruta/mi-skill
./scripts/instalar-skill.sh OWNER/REPO ruta/mi-skill proyecto
```

Abre una sesión nueva de Claude Code después de copiar.

## Método C: probar sin instalar

```bash
claude --plugin-dir /ruta/al/plugin
```

La skill vive solo durante esa sesión.

## Caso verificado: superpowers

Repo: https://github.com/obra/superpowers

Es un plugin de marketplace con 14 skills.
Usa el Método A.

Opción 1, marketplace oficial de Anthropic:

```
/plugin install superpowers@claude-plugins-official
```

Opción 2, marketplace del autor:

```
/plugin marketplace add obra/superpowers-marketplace
/plugin install superpowers@superpowers-marketplace
```

Skills que instala:

`brainstorming`, `dispatching-parallel-agents`, `executing-plans`,
`finishing-a-development-branch`, `receiving-code-review`,
`requesting-code-review`, `subagent-driven-development`,
`systematic-debugging`, `test-driven-development`, `using-git-worktrees`,
`using-superpowers`, `verification-before-completion`, `writing-plans`,
`writing-skills`.

Costo de contexto medido: unos 688 tokens fijos por sesión.
Cada skill consume más tokens solo al activarse.

Instala una sola skill de superpowers así:

```bash
./scripts/instalar-skill.sh obra/superpowers skills/brainstorming
```

## Verificar la instalación

```bash
claude plugin list
claude plugin details NOMBRE
ls ~/.claude/skills/
ls .claude/skills/
```

Dentro de Claude Code, escribe `/` y busca el nombre de la skill.

## Desinstalar

```bash
claude plugin uninstall NOMBRE@MARKETPLACE
claude plugin marketplace remove MARKETPLACE
rm -rf ~/.claude/skills/mi-skill
```

## Avisos

Lee el `SKILL.md` antes de instalar.
El archivo contiene instrucciones que Claude ejecuta.

Instala solo skills de repos que reconozcas.

Las sesiones remotas usan contenedores temporales.
Guarda tus skills en este repo para conservarlas.

## Estructura de este repo

```
skills/
  ejemplo-skill/
    SKILL.md
scripts/
  instalar-skill.sh
```
