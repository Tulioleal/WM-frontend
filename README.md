# 🖥️ Waste Detection Frontend

Interfaz web para el sistema de detección de desechos. Aplicación single-page en **React** servida con **Nginx**, que se comunica con la [Inference API](#) para analizar imágenes, verificar detecciones y monitorear el sistema.

## Funcionalidades

```
┌──────────────────────────────────────────────────────────┐
│                    Waste Detection AI                     │
│                                                          │
│  ┌─ Detectar ─┐  ┌─ Revisar ─┐  ┌ Métricas ┐  ┌ Estado ┐│
│  │            │  │           │  │          │  │        ││
│  │ Upload de  │  │ Panel de  │  │ Total    │  │ Health ││
│  │ imagen     │  │ verifica- │  │ inferen- │  │ check  ││
│  │ + bboxes   │  │ ción de   │  │ cias,    │  │ modelo,││
│  │ + feedback │  │ deteccio- │  │ tiempos, │  │ DB,    ││
│  │ + historial│  │ nes       │  │ uptime   │  │ GCS    ││
│  └────────────┘  └───────────┘  └──────────┘  └────────┘│
└──────────────────────────────────────────────────────────┘
```

### Detectar

Subida de imágenes (JPEG, PNG, WEBP) con visualización de bounding boxes sobre la imagen, confianza por detección, y feedback rápido (👍/👎) que alimenta el ciclo de verificación de la API.

### Revisar

Panel para verificar, corregir o descartar inferencias previas. Las detecciones verificadas/corregidas se usan después para reentrenar el modelo.

### Métricas

Dashboard con total de inferencias, tiempo promedio, requests de la última hora, uptime y catálogo visual de las 6 clases soportadas.

### Estado

Health check en tiempo real del sistema: API, modelo cargado, conexión a base de datos y Google Cloud Storage.

## Estructura del proyecto

```
├── index.html     # Aplicación React (single-file, Tailwind CSS)
├── nginx.conf     # Configuración de Nginx (gzip, cache, security headers)
└── Dockerfile     # Imagen nginx:alpine
```

## Stack

- **React 18** (CDN, JSX transpilado con Babel standalone)
- **Tailwind CSS** (CDN)
- **Nginx Alpine** — servidor estático con gzip, cache de assets y headers de seguridad

## Configuración

La URL de la API se define como placeholder `__API_URL__` en `index.html`. Se reemplaza en el pipeline de CI/CD o manualmente antes del build:

```bash
sed -i 's|__API_URL__|https://mi-api.example.com|g' index.html
```

## Docker

```bash
# Build
docker build -t frontend .

# Run
docker run -p 80:80 frontend
```

La imagen incluye health check en `/health` que retorna `200 OK`.

## Nginx

La configuración incluye compresión gzip para text/css/js, cache inmutable de 1 año para assets estáticos, SPA fallback (`try_files` a `index.html`), y headers de seguridad (`X-Frame-Options`, `X-Content-Type-Options`, `X-XSS-Protection`).