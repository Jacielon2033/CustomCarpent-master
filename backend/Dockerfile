# Backend Dockerfile
FROM node:18-alpine

# Instalar wget para health checks
RUN apk add --no-cache wget

# Crear directorio de trabajo
WORKDIR /app

# Copiar package.json y package-lock.json
COPY package*.json ./

# Instalar dependencias
RUN npm ci --only=production

# Copiar código fuente
COPY . .

# Crear directorio para uploads si no existe
RUN mkdir -p api/uploads

# Configurar permisos
RUN chown -R node:node /app
USER node

# Exponer puerto
EXPOSE 5000

# Comando para iniciar la aplicación
CMD ["npm", "start"]
