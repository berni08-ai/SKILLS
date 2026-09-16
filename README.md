# SKILLS

Skills para Claude Code, listas para usar sin instalar nada.

## Uso inmediato

Abre este repo con Claude Code. Las 16 skills ya están activas.

No hay comandos que ejecutar. No hay plugins que instalar.

Las skills viven en `.claude/skills/`. Claude Code lee esa carpeta al iniciar.

## Llevarlas a otro proyecto

```bash
./scripts/copiar-a-proyecto.sh /ruta/de/tu/proyecto
```

El script copia `.claude/skills` y `.claude/hooks` al proyecto.

Después haz commit de la carpeta `.claude` en ese proyecto.

Verificado: un proyecto vacío con esa carpeta activa las skills al instante.

## Skills incluidas

### De superpowers (14)

**Pruebas**

| Skill | Para qué |
|---|---|
| `test-driven-development` | Aplica el ciclo rojo-verde-refactor antes de escribir código. |

**Depuración**

| Skill | Para qué |
|---|---|
| `systematic-debugging` | Busca la causa raíz de un bug en cuatro fases. |
| `verification-before-completion` | Exige evidencia antes de declarar algo terminado. |

**Colaboración y flujo de trabajo**

| Skill | Para qué |
|---|---|
| `brainstorming` | Explora qué quieres construir antes de programar. |
| `writing-plans` | Escribe un plan de implementación detallado. |
| `executing-plans` | Ejecuta un plan por lotes, con puntos de revisión. |
| `subagent-driven-development` | Divide el plan entre subagentes, con doble revisión. |
| `dispatching-parallel-agents` | Lanza agentes en paralelo para tareas independientes. |
| `requesting-code-review` | Revisa tu código antes de pedir revisión ajena. |
| `receiving-code-review` | Responde a comentarios de revisión con rigor técnico. |
| `using-git-worktrees` | Crea un espacio de trabajo aislado por rama. |
| `finishing-a-development-branch` | Decide cómo integrar la rama terminada. |

**Meta**

| Skill | Para qué |
|---|---|
| `writing-skills` | Crea y prueba skills nuevas. |
| `using-superpowers` | Explica el sistema. El hook la inyecta al iniciar. |

### Otras (2)

| Skill | Para qué |
|---|---|
| `frontend-design` | Da criterio de diseño visual al construir interfaces. |
| `ejemplo-skill` | Plantilla para crear skills propias. |

## Cómo invocarlas

**Automático.** No escribes nada.

El hook `.claude/hooks/session-start.sh` inyecta `using-superpowers` al iniciar.
Claude activa la skill que corresponda según lo que le pidas.

Ejemplo: dices "quiero agregar login" y se activa `brainstorming`.

**Manual.** Escribe el nombre con una barra:

```
/brainstorming
/systematic-debugging
/test-driven-development
```

## Flujo típico

1. `brainstorming` define qué construir.
2. `writing-plans` escribe el plan.
3. `subagent-driven-development` ejecuta el plan.
4. `requesting-code-review` revisa el resultado.
5. `finishing-a-development-branch` integra la rama.

## Qué NO funciona

Declarar plugins en `.claude/settings.json` **no los instala solos**.

Prueba realizada: borré los plugins del entorno. Dejé el archivo con
`extraKnownMarketplaces` y `enabledPlugins`. Abrí una sesión en el repo.
Resultado: cero skills, cero plugins instalados.

Por eso las skills van en `.claude/skills/`, no como plugin.

## Método alternativo: plugin de marketplace

Sirve en tu máquina local, no en sesiones web.

Este repo también es un marketplace. Instálalo así:

```
/plugin marketplace add berni08-ai/SKILLS
/plugin install mis-skills@berni-skills
```

Para superpowers, con su hook original:

```
/plugin marketplace add obra/superpowers-marketplace
/plugin install superpowers@superpowers-marketplace
```

Con el plugin, los nombres llevan prefijo: `/superpowers:brainstorming`.

Actualiza con `claude plugin marketplace update` y `claude plugin update`.

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

## Licencias

| Origen | Licencia | Archivo |
|---|---|---|
| [obra/superpowers](https://github.com/obra/superpowers) | MIT | `LICENSES/superpowers-MIT.txt` |
| [anthropics/skills](https://github.com/anthropics/skills) | Apache 2.0 | `.claude/skills/frontend-design/LICENSE.txt` |

Las skills se copiaron sin modificaciones.

El hook `session-start.sh` es una adaptación del hook de superpowers.

## Estructura

```
.claude/
  skills/              16 skills. Claude Code las lee al iniciar.
  hooks/
    session-start.sh   Inyecta using-superpowers al arrancar.
  settings.json        Registra el hook.
.claude-plugin/
  plugin.json          Manifiesto del plugin.
  marketplace.json     Manifiesto del marketplace.
scripts/
  copiar-a-proyecto.sh Copia .claude a otro proyecto.
  instalar-skill.sh    Copia una skill suelta desde otro repo.
LICENSES/
  superpowers-MIT.txt
```
