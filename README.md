# SKILLS

Skills propias para Claude Code.

## Uso inmediato

Abre este repo con Claude Code. Las skills de `.claude/skills/` se cargan al iniciar.

No hay comandos que ejecutar. No hay plugins que instalar.

## Skills incluidas

| Origen | Skills | Para qué |
|---|---|---|
| propia | `ejemplo-skill` | Plantilla para crear skills propias. |
| [Leonxlnx/taste-skill](https://github.com/Leonxlnx/taste-skill) | `design-taste-frontend`, `design-taste-frontend-v1`, `gpt-taste`, `high-end-visual-design`, `minimalist-ui`, `industrial-brutalist-ui`, `redesign-existing-projects`, `stitch-design-taste`, `image-to-code`, `imagegen-frontend-web`, `imagegen-frontend-mobile`, `brandkit`, `full-output-enforcement` | Diseño frontend que no parezca plantilla. |
| [VoltAgent/awesome-design-md](https://github.com/VoltAgent/awesome-design-md) + [google-labs-code/design.md](https://github.com/google-labs-code/design.md) | `design-md` | Spec de DESIGN.md + 74 ejemplos de marcas. Ninguno de los dos repos trae skill: la armé yo con su contenido. |
| [nateherkai/scroll-craft](https://github.com/nateherkai/scroll-craft) | `scroll-craft` | Landings con scroll cinematográfico. Verifica con Playwright. |
| [blader/humanizer](https://github.com/blader/humanizer) | `humanizer` | Quita marcas de texto escrito por IA. |
| [ognjengt/founder-skills](https://github.com/ognjengt/founder-skills) | `brand-copywriter`, `competitor-intel`, `cro-optimization`, `go-to-market-plan`, `lead-magnet-generator`, `linkedin-writer`, `marketing-ideas`, `outreach-specialist`, `prd-generator`, `pricing-strategist`, `product-hunt-launch-plan`, `sop-creator`, `strategic-planning`, `viral-hook-creator`, `x-writer` | Marketing, ventas y estrategia. Leen `FOUNDER_CONTEXT.md` de la raíz del proyecto. |
| [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills) | `vercel-react-best-practices`, `vercel-composition-patterns`, `vercel-react-native-skills`, `vercel-react-view-transitions`, `web-design-guidelines`, `writing-guidelines`, `deploy-to-vercel`, `vercel-cli-with-tokens`, `vercel-optimize` | React/Next y deploy en Vercel. |
| [affaan-m/ECC](https://github.com/affaan-m/ECC) | `seo` | SEO técnico. Solo esta skill del repo. |

### Avisos

- **founder-skills**: copia `plantillas/FOUNDER_CONTEXT.md` a la raíz de tu proyecto y complétalo.
- **scroll-craft + Playwright**: en el build corre `npm i playwright-core`. Si no hay Chrome instalado, apunta `SCROLLCRAFT_CHROME` a un binario. Chromium no decodifica h264, así que los videos `.mp4` no se pintan con él: para la verificación final usa Chrome.
- **scroll-craft + kie.ai**: generar imágenes o video manda tus imágenes y tu `KIE_AI_API_KEY` a `api.kie.ai` y a `kieai.redpandaai.co`. Es opcional. Sin key, usa tus propias fotos.
- **web-design-guidelines** y **writing-guidelines**: bajan sus reglas de `raw.githubusercontent.com/vercel-labs/...` en cada uso. Si ese repo cambia, cambia lo que hace la skill.
- **deploy-to-vercel**: sube el proyecto (sin `node_modules`, `.git` ni `.env*`) a un endpoint de Vercel para crear un deploy reclamable.
- **humanizer**: Claude ya trae `anthropic-skills:humanizer`. Son distintas; invoca la que quieras por nombre.
- Cada skill copiada lleva su licencia original en `LICENSE.upstream` (vercel-labs/agent-skills no publica archivo de licencia).

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
plantillas/
  FOUNDER_CONTEXT.md   Contexto de negocio para founder-skills.
scripts/
  copiar-a-proyecto.sh Copia .claude/skills a otro proyecto.
  instalar-skill.sh    Copia una skill suelta desde otro repo.
```
