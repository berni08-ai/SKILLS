---
name: ejemplo-skill
description: Plantilla base para crear skills nuevas. Copia esta carpeta y reemplaza el contenido. La description decide cuándo Claude activa la skill, así que descríbela con verbos y casos concretos.
---

# Ejemplo de skill

Reemplaza este contenido por las instrucciones de tu skill.

## Reglas del frontmatter

- `name`: usa minúsculas y guiones. Debe coincidir con el nombre de la carpeta.
- `description`: escribe qué hace la skill y cuándo se activa.

Claude compara tu petición contra la `description`.
Una `description` vaga impide la activación automática.

## Estructura recomendada

1. Explica el objetivo de la skill.
2. Lista los pasos en orden.
3. Agrega ejemplos de entrada y salida.
4. Define los casos que la skill no cubre.

## Archivos adicionales

Coloca scripts y plantillas dentro de la misma carpeta.
Referencia cada archivo por su ruta relativa.

```
mi-skill/
  SKILL.md
  scripts/procesar.py
  templates/salida.md
```

Claude carga el `SKILL.md` primero.
Lee los demás archivos solo cuando los necesita.
