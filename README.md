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

Opción 1, marketplace del autor. **Verificada. Funciona siempre.**

```
/plugin marketplace add obra/superpowers-marketplace
/plugin install superpowers@superpowers-marketplace
```

Opción 2, marketplace oficial de Anthropic. La recomienda el README del autor.

```
/plugin install superpowers@claude-plugins-official
```

Aviso sobre la opción 2: falló en una sesión remota de Claude Code.
El marketplace `claude-plugins-official` no estaba registrado en el contenedor.
Error exacto: `Plugin "superpowers" not found in marketplace "claude-plugins-official"`.

Prueba la opción 2 en tu máquina local. Si falla, usa la opción 1.

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

## Usar estas skills en tus proyectos

Este repo es un **marketplace propio**. Instálalo como plugin.

### Instalación en cualquier proyecto

Dentro de Claude Code:

```
/plugin marketplace add berni08-ai/SKILLS
/plugin install mis-skills@berni-skills
```

Desde la terminal:

```bash
claude plugin marketplace add berni08-ai/SKILLS
claude plugin install mis-skills@berni-skills
```

Un comando por máquina. Las skills quedan disponibles en todos tus proyectos.

### Instalación fijada a un proyecto

Usa `--scope project` para que el proyecto instale las skills solo.

```bash
claude plugin marketplace add berni08-ai/SKILLS --scope project
claude plugin install mis-skills@berni-skills --scope project
git add .claude/settings.json
git commit -m "Habilita mis-skills en el proyecto"
git push
```

Cualquier persona que abra ese proyecto recibe las skills.

### Agregar una skill nueva

1. Crea la carpeta `skills/mi-skill/` con su `SKILL.md`.
2. Sube la versión en `.claude-plugin/plugin.json` y en `.claude-plugin/marketplace.json`.
3. Valida: `claude plugin validate .`
4. Haz commit y push.

### Actualizar las skills en tus proyectos

```bash
claude plugin marketplace update berni-skills
claude plugin update mis-skills
```

Reinicia Claude Code para aplicar los cambios.

### Comparación de métodos

| Método | Comandos por proyecto | Actualiza | Sirve en sesiones remotas |
|---|---|---|---|
| Marketplace propio | 2, una sola vez por máquina | Sí | Sí, con `--scope project` |
| Copiar a `~/.claude/skills/` | 1 por skill | No | No |
| Copiar a `.claude/skills/` | 1 por skill y por proyecto | No | Sí |

Usa el marketplace propio. Es el único método que se actualiza solo.

## Permanencia: qué se guarda y qué no

Claude Code escribe en dos lugares distintos.

| Qué | Dónde queda | ¿Sobrevive? |
|---|---|---|
| Archivos del repo | `/tu-repo/` → GitHub | Sí, para siempre |
| Config de proyecto | `/tu-repo/.claude/settings.json` | Sí, si haces commit |
| Plugin instalado | `~/.claude/plugins/` | No en sesiones remotas |
| Config de usuario | `~/.claude/settings.json` | No en sesiones remotas |

El repo vive en GitHub. `~/.claude/` vive en tu máquina o en el contenedor.

Las sesiones remotas (Claude Code web) usan un contenedor nuevo cada vez.
Ese contenedor borra `~/.claude/` al terminar.
Tu máquina local no tiene ese problema.

### Solución: instalar con alcance de proyecto

```bash
claude plugin marketplace add OWNER/REPO --scope project
claude plugin install NOMBRE@MARKETPLACE --scope project
```

Esos comandos escriben `.claude/settings.json` dentro del repo.

```bash
git add .claude/settings.json
git commit -m "Habilita el plugin en el proyecto"
git push
```

Claude Code lee ese archivo al abrir el proyecto.
Instala y habilita el plugin solo, en cualquier máquina o sesión.

Este repo ya tiene superpowers configurado así.

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
.claude-plugin/
  plugin.json          Manifiesto del plugin.
  marketplace.json     Manifiesto del marketplace.
.claude/
  settings.json        Plugins habilitados en este proyecto.
skills/
  ejemplo-skill/
    SKILL.md           Una carpeta por skill.
scripts/
  instalar-skill.sh    Copia una skill suelta desde otro repo.
```
