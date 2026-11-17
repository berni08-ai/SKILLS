# SKILLS

Skills propias para Claude Code.

## Uso inmediato

Abre este repo con Claude Code. Las skills de `.claude/skills/` se cargan al iniciar.

No hay comandos que ejecutar. No hay plugins que instalar.

## Skills incluidas

29 skills en total.

### Propias

| Skill | Para qué |
|---|---|
| `ejemplo-skill` | Plantilla para crear skills propias. |

### Google: desarrollo web

Fuente: [GoogleChrome/modern-web-guidance](https://github.com/GoogleChrome/modern-web-guidance), commit `64a6d70`.

| Skill | Para qué |
|---|---|
| `modern-web-guidance` | Buenas prácticas actuales de HTML, CSS y JS del lado del cliente. |
| `chrome-extensions` | Crear y publicar extensiones de Chrome con Manifest V3. |

`modern-web-guidance` consulta sus guías con `npx -y modern-web-guidance@latest`.
Necesita red. El paquete envía telemetría anónima a Google.
Para desactivarla, define `DISABLE_TELEMETRY=1` en tu entorno.

### Google: Elephant-Goldfish Model (EGM)

Fuente: [google/elephant-goldfish-model](https://github.com/google/elephant-goldfish-model), commit `72d06f5`.
Desarrolla ideas y revisa documentos de diseño con revisores independientes.

| Skill | Para qué |
|---|---|
| `egm-brainstorm` | Convierte una idea en un plan. |
| `egm-draft` | Redacta un documento de diseño. |
| `egm-review` | Revisa un documento con revisores sin contexto previo. |
| `egm-review-loop` | Repite revisión y corrección. |
| `egm-resolve` | Resuelve los hallazgos de una revisión. |
| `egm-bootstrap` | Documenta un código existente. |
| `egm-drift-report` | Compara el código con su diseño. |

Solo se invocan a mano: `/egm-brainstorm`, `/egm-draft`, `/egm-review`.
No aparecen en la activación automática. Es lo esperado.

EGM viene como plugin. Aquí está adaptado para funcionar sin plugin:

- Los 10 revisores están en `.claude/agents/egm-*.md`, como subagentes del proyecto.
- Sus personas, estándares y guía están en `.claude/egm/`.
- Las rutas `${CLAUDE_PLUGIN_ROOT}` apuntan a `.claude/egm`.

Requiere Claude Code 2.1.271 o posterior.

### Seguridad

Fuente: [mukul975/Anthropic-Cybersecurity-Skills](https://github.com/mukul975/Anthropic-Cybersecurity-Skills), commit `54a7988`.
Selección de 19 de 818, elegidas para lo que es webint: un sistema de gestión
web (Cloudflare Workers + base D1) con login, roles y varios negocios en el
mismo programa.

> **Proyecto comunitario.** No está afiliado a Anthropic pese al nombre.
> Incluye técnicas ofensivas. Úsalas solo contra webint o sistemas propios.

Lo más importante para webint es que un negocio no vea los datos de otro, y que
la `caja` no acceda a lo del `dueno`. Eso lo cubren `testing-for-broken-access-control`
y `testing-api-for-broken-object-level-authorization`.

**Sitio web**

| Skill | Para qué |
|---|---|
| `performing-web-application-penetration-test` | Pentest web según OWASP WSTG. |
| `testing-for-broken-access-control` | Control de acceso y aislamiento entre negocios. |
| `testing-for-xss-vulnerabilities` | Probar XSS. |
| `performing-csrf-attack-simulation` | Probar CSRF. |
| `testing-cors-misconfiguration` | Probar CORS. |
| `exploiting-server-side-request-forgery` | Probar SSRF. |
| `testing-for-business-logic-vulnerabilities` | Fallos de lógica (precios, stock). |
| `performing-security-headers-audit` | Auditar CSP, HSTS y cookies. |
| `implementing-cloud-waf-rules` | Reglas de WAF (incluye Cloudflare). |

**APIs y login**

| Skill | Para qué |
|---|---|
| `testing-api-for-broken-object-level-authorization` | Probar BOLA e IDOR entre negocios. |
| `testing-api-security-with-owasp-top-10` | Evaluar la API contra OWASP API Top 10. |
| `testing-api-authentication-weaknesses` | Probar la autenticación de la API. |
| `testing-jwt-token-security` | Probar los tokens de sesión (si usás JWT). |
| `implementing-api-rate-limiting-and-throttling` | Limitar peticiones (el bloqueo por 5 intentos). |
| `hunting-credential-stuffing-attacks` | Detectar ataques de robo de cuentas. |

**Base de datos**

| Skill | Para qué |
|---|---|
| `exploiting-sql-injection-vulnerabilities` | Probar inyección SQL (D1 es SQL). |

**Copias y código**

| Skill | Para qué |
|---|---|
| `validating-backup-integrity-for-recovery` | Verificar que las copias se restauran. |
| `implementing-secret-scanning-with-gitleaks` | Detectar secretos en git (tenés `claves-ejemplo.txt`). |
| `detecting-malicious-npm-packages` | Revisar dependencias de npm. |

Los scripts de `scripts/` de cada skill no se ejecutan solos.
Necesitan herramientas externas (sqlmap, gitleaks...) y a veces claves API.

## Llevarlas a otro proyecto

```bash
./scripts/copiar-a-proyecto.sh /ruta/de/tu/proyecto
```

El script copia `.claude/skills`, `.claude/agents` y `.claude/egm` al proyecto.
Después haz commit de la carpeta `.claude` allí.

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

El plugin no incluye las skills `egm-*`. Dependen de `.claude/agents` y `.claude/egm`.
Para EGM usa `copiar-a-proyecto.sh`.

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

Las skills de terceros usan Apache 2.0. Las licencias están en `LICENSES/`.

## Estructura

```
.claude/
  skills/              Claude Code las lee al iniciar.
  agents/              Subagentes revisores de EGM.
  egm/                 Personas, estándares y guía de EGM.
.claude-plugin/
  plugin.json          Manifiesto del plugin.
  marketplace.json     Manifiesto del marketplace.
LICENSES/              Licencias de las skills de terceros.
scripts/
  copiar-a-proyecto.sh Copia .claude a otro proyecto.
  instalar-skill.sh    Copia una skill suelta desde otro repo.
```
