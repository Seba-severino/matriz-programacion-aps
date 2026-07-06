# Matriz de Programación APS — Herramienta transversal

Herramienta web **single-file** (HTML autónomo, sin backend ni login) para construir la
Matriz de Programación de Atención Primaria de Salud de **cualquier CESFAM** de Chile,
alineada a la matriz oficial del Servicio de Salud (SSMSO 2026).

## Qué hace

Guía la programación en 5 pasos —Configuración, Población, Dotación, Actividades y Revisión—
con el motor de cálculo oficial embebido y una biblioteca de 1.743 actividades normadas.
Cada centro solo aporta sus datos por formularios validados; la herramienta calcula
beneficiarios, metas, actividades a programar, horas y jornadas requeridas, y compara la
brecha contra la dotación efectiva.

- **Persistencia local** (localStorage) + export/import JSON para seguimiento anual.
- **Exportación a la plantilla oficial nativa** (`.xlsx` SSMSO): carga tus datos sobre el
  archivo oficial preservando fórmulas, formato, tablas y validaciones, y sus fórmulas
  recalculan toda la matriz.
- Modo claro/oscuro, diseño alineado al Panel Metas & IAAPS.

## Uso

Abre `matriz-programacion-aps.html` en cualquier navegador, o visita el sitio publicado.
No requiere instalación ni conexión (funciona 100% offline).

## Publicación

Sitio estático en Firebase Hosting (proyecto `cvh-hub`, sitio `matriz-aps`).

```bash
firebase deploy --only hosting:matriz-aps
```
