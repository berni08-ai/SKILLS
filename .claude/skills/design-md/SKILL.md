---
name: design-md
description: Write, read, or validate a DESIGN.md (the Google Stitch format that describes a visual identity to coding agents with YAML tokens plus prose), or start one from a library of 74 brand-inspired examples (Stripe, Linear, Vercel, Apple, Notion, Airbnb, Spotify...). Use when the user asks for a DESIGN.md, a design system file for an agent, "make it look like <brand>", or wants consistent UI tokens across a project.
---

# DESIGN.md

Material de dos repos:

- `references/spec.md`: la especificación oficial del formato (google-labs-code/design.md, Apache-2.0).
- `library/<marca>.md`: 74 DESIGN.md inspirados en sitios reales (VoltAgent/awesome-design-md, MIT).

## Crear un DESIGN.md

1. Lee `references/spec.md` antes de escribir. Respeta el orden de secciones y los nombres de tokens que define.
2. Si el usuario nombra una marca o un estilo, lista `library/` y lee solo los archivos que encajen. No cargues la carpeta entera.
3. Usa el ejemplo como punto de partida. Cambia nombre, colores y tipografías por los del proyecto. No copies logos ni marcas registradas.
4. Guarda el resultado como `DESIGN.md` en la raíz del proyecto.
5. Si hay Node disponible, valídalo: `npx @google/design.md lint DESIGN.md`. Corrige `broken-ref` y `contrast-ratio` antes de terminar.

## Usar un DESIGN.md existente

Lee el `DESIGN.md` del proyecto antes de tocar UI. Los tokens del front matter mandan sobre cualquier valor por defecto.

## Marcas disponibles

Lista los archivos de `library/` para ver los nombres exactos.
