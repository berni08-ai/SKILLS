# SKILLS

Skills propias para Claude Code.

## Uso inmediato

Abre este repo con Claude Code. Las skills de `.claude/skills/` se cargan al iniciar.

No hay comandos que ejecutar. No hay plugins que instalar.

## Skills incluidas

57 skills en total.

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
Selección de 47 de 818, enfocada en WEBINT, sitio web, APIs, bases de datos y gestión.

> **Proyecto comunitario.** No está afiliado a Anthropic pese al nombre.
> Incluye técnicas ofensivas. Úsalas solo contra sistemas propios o con autorización.

**WEBINT y OSINT**

| Skill | Para qué |
|---|---|
| `collecting-open-source-intelligence` | Recolectar OSINT sobre infraestructura y actores. |
| `conducting-external-reconnaissance-with-osint` | Mapear la superficie externa sin tocar el objetivo. |
| `performing-osint-with-spiderfoot` | Automatizar OSINT con SpiderFoot. |
| `performing-ai-driven-osint-correlation` | Unir hallazgos de varias fuentes en un perfil. |
| `performing-subdomain-enumeration-with-subfinder` | Enumerar subdominios. |
| `performing-dns-enumeration-and-zone-transfer` | Enumerar DNS y probar transferencias de zona. |
| `auditing-tls-certificate-transparency-logs` | Descubrir subdominios y certificados en logs CT. |
| `analyzing-typosquatting-domains-with-dnstwist` | Detectar dominios parecidos al tuyo. |
| `performing-brand-monitoring-for-impersonation` | Vigilar suplantación de marca. |
| `implementing-attack-surface-management` | Gestionar la superficie de ataque externa. |
| `tracking-threat-actor-infrastructure` | Pivotar sobre DNS, certificados y WHOIS. |
| `monitoring-darkweb-sources` | Vigilar foros, pastes y sitios de filtraciones. |
| `performing-ip-reputation-analysis-with-shodan` | Analizar IPs con Shodan. |

**Sitio web**

| Skill | Para qué |
|---|---|
| `performing-web-application-penetration-test` | Pentest web según OWASP WSTG. |
| `performing-security-headers-audit` | Auditar CSP, HSTS y cookies. |
| `performing-ssl-tls-security-assessment` | Evaluar la configuración TLS. |
| `testing-for-xss-vulnerabilities` | Probar XSS. |
| `performing-csrf-attack-simulation` | Probar CSRF. |
| `testing-for-broken-access-control` | Probar control de acceso y multi-tenant. |
| `testing-cors-misconfiguration` | Probar CORS. |
| `exploiting-server-side-request-forgery` | Probar SSRF. |
| `testing-for-business-logic-vulnerabilities` | Probar fallos de lógica de negocio. |
| `analyzing-web-server-logs-for-intrusion` | Detectar ataques en logs de Apache y Nginx. |
| `implementing-cloud-waf-rules` | Configurar un WAF en la nube. |
| `hunting-for-dns-based-persistence` | Detectar secuestro de DNS y subdominios huérfanos. |

**APIs y autenticación**

| Skill | Para qué |
|---|---|
| `testing-api-security-with-owasp-top-10` | Evaluar APIs contra OWASP API Top 10. |
| `testing-api-for-broken-object-level-authorization` | Probar BOLA e IDOR. |
| `testing-api-authentication-weaknesses` | Probar la autenticación de APIs. |
| `testing-jwt-token-security` | Probar JWT. |
| `testing-oauth2-implementation-flaws` | Probar OAuth 2.0 y OIDC. |
| `implementing-api-rate-limiting-and-throttling` | Limitar peticiones por usuario e IP. |
| `hunting-credential-stuffing-attacks` | Detectar relleno de credenciales. |

**Bases de datos**

| Skill | Para qué |
|---|---|
| `exploiting-sql-injection-vulnerabilities` | Probar inyección SQL. |
| `exploiting-nosql-injection-vulnerabilities` | Probar inyección NoSQL. |
| `implementing-pam-for-database-access` | Controlar el acceso privilegiado a la base. |
| `implementing-aes-encryption-for-data-at-rest` | Cifrar datos en reposo. |
| `implementing-hashicorp-vault-dynamic-secrets` | Credenciales de base temporales con Vault. |
| `validating-backup-integrity-for-recovery` | Verificar que los backups se restauran. |

**Sistemas de gestión y cumplimiento**

| Skill | Para qué |
|---|---|
| `implementing-iso-27001-information-security-management` | Implantar un SGSI ISO 27001. |
| `implementing-gdpr-data-protection-controls` | Controles RGPD. |
| `performing-privacy-impact-assessment` | Evaluación de impacto de privacidad. |
| `conducting-cyber-risk-assessment-with-nist-800-30` | Evaluación de riesgos y registro de riesgos. |
| `performing-threat-modeling-with-owasp-threat-dragon` | Modelado de amenazas. |

**Código y despliegue**

| Skill | Para qué |
|---|---|
| `implementing-secret-scanning-with-gitleaks` | Detectar secretos en git. |
| `implementing-devsecops-security-scanning` | SAST, DAST y SCA en CI/CD. |
| `detecting-malicious-npm-packages` | Revisar dependencias npm. |
| `securing-github-actions-workflows` | Endurecer GitHub Actions. |

Los scripts de `scripts/` de cada skill no se ejecutan solos.
Necesitan herramientas externas (subfinder, dnstwist, gitleaks...) y a veces claves API.

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
