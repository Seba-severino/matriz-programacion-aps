# Matriz de Programación APS — Herramienta transversal

Herramienta web **single-file** (HTML autónomo, sin backend ni login) para construir la
Matriz de Programación de Atención Primaria de Salud de **cualquier CESFAM** de Chile,
alineada a la matriz oficial del Servicio de Salud.

## Qué hace

Guía la programación en 5 pasos —Configuración, Población, Dotación, Actividades y Revisión—
con el motor de cálculo oficial embebido y una biblioteca de 1.743 actividades normadas.
Cada centro solo aporta sus datos por formularios validados; la herramienta calcula
beneficiarios, metas, actividades a programar, horas y jornadas requeridas, y compara la
brecha contra la dotación efectiva.

- **Persistencia local** (localStorage) + export/import JSON para seguimiento anual.
- **Sincronización opcional en la nube por código** (sin cuentas): el código es la llave.
- **Exportación a la plantilla oficial nativa** (`.xlsx`): escribe tus datos sobre el archivo
  oficial preservando fórmulas, formato, tablas y validaciones.
- Modo claro/oscuro, diseño alineado al Panel Metas & IAAPS.

## Uso

Abre `matriz-programacion-aps.html` en cualquier navegador, o visita el sitio publicado.
No requiere instalación ni conexión (funciona 100% offline).

## Privacidad y datos

La herramienta **no almacena datos identificables de pacientes**: solo trabaja con conteos
agregados de población, dotación y metas. Los datos se guardan en el navegador del usuario
(localStorage) y, opcionalmente, en la nube bajo un **código privado** que actúa como llave.
Sin ese código no es posible leer ni enumerar los datos.

## Publicación

Un único script sincroniza el HTML, versiona en GitHub y despliega Hosting + reglas Firestore:

```bash
./deploy.sh "mensaje de commit"
# Hosting: proyecto cvh-hub, sitio matriz-aps  ->  https://matriz-aps.web.app
# Reglas Firestore: proyecto matriz-aps-datos
```
