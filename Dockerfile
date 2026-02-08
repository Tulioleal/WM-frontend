# ============================================================================
# Dockerfile - Frontend Waste Detection
# Nginx para servir archivos estáticos
# ============================================================================

FROM nginx:alpine

LABEL maintainer="tuliolealdev@gmail.com"
LABEL version="1.0.0"
LABEL description="Frontend para sistema de detección de desechos"

# Copiar archivos del frontend
COPY index.html /usr/share/nginx/html/

# Copiar configuración de Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Puerto
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost/ || exit 1

# Comando de inicio
CMD ["nginx", "-g", "daemon off;"]
