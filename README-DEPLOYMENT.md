# Guía de Despliegue - CustomCarpent

## Configuración para Dokploy

Este proyecto está configurado para ser desplegado en Dokploy con 3 servicios principales:

### 🏗️ Arquitectura

- **Frontend**: React + Vite (puerto 80)
- **Backend**: Node.js + Express (puerto 5000)
- **Base de Datos**: MySQL (externa, ya configurada)
- **Volúmenes**: Persistencia de imágenes en `/uploads`

### 📋 Pasos para el Despliegue

#### 1. Preparar Variables de Entorno

Crea un archivo `.env` en la raíz del proyecto con las siguientes variables:

```env
# Database Configuration
DB_HOST=tu_host_de_bd
DB_USER=tu_usuario_de_bd
DB_PASS=tu_password_de_bd
DB_NAME=tu_nombre_de_bd
DB_PORT=3306

# JWT Secret (genera una cadena segura)
JWT_SECRET=tu_jwt_secret_muy_seguro

# Email Configuration (opcional)
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USER=tu_email@gmail.com
EMAIL_PASS=tu_password_de_email
```

#### 2. Configuración en Dokploy

1. **Crear Proyecto en Dokploy**:
   - Nombre: `customcarpent`
   - Tipo: Docker Compose

2. **Configurar Dominios**:
   - Frontend: `rtakabinetssolutions.com`
   - Backend: `api.rtakabinetssolutions.com`

3. **Subir Código**:
   - Conecta tu repositorio Git o sube los archivos
   - Usa el archivo `dokploy.yml` como configuración

#### 3. Configuración de Servicios

##### Frontend (rtakabinetssolutions.com)
- **Puerto**: 80
- **Build Context**: `./frontend`
- **Variables de Entorno**:
  - `VITE_API_URL=https://api.rtakabinetssolutions.com`

##### Backend (api.rtakabinetssolutions.com)
- **Puerto**: 5000
- **Build Context**: `./backend`
- **Variables de Entorno**: Todas las variables del archivo `.env`
- **Volúmenes**: 
  - `uploads_data:/app/api/uploads` (para persistencia de imágenes)

#### 4. Configuración de SSL

Dokploy manejará automáticamente los certificados SSL para ambos dominios.

#### 5. Health Checks

Ambos servicios incluyen health checks:
- Frontend: `http://localhost:80`
- Backend: `http://localhost:5000/api/health`

### 🔧 Comandos Útiles

#### Desarrollo Local
```bash
# Construir y ejecutar
docker-compose up --build

# Solo backend
docker-compose up backend

# Solo frontend
docker-compose up frontend
```

#### Producción
```bash
# Usar dokploy.yml
docker-compose -f dokploy.yml up --build -d
```

### 📁 Estructura de Archivos

```
├── backend/
│   ├── Dockerfile
│   ├── package.json
│   ├── server.js
│   └── api/
│       ├── uploads/          # Imágenes (volumen persistente)
│       └── routes/
├── frontend/
│   ├── Dockerfile
│   ├── nginx.conf
│   ├── package.json
│   └── src/
│       └── config/
│           └── api.js        # Configuración centralizada de API
├── docker-compose.yml        # Para desarrollo
├── dokploy.yml              # Para producción
└── env.example              # Plantilla de variables de entorno
```

### 🚀 Características Implementadas

- ✅ Dockerización completa
- ✅ Configuración de volúmenes para persistencia
- ✅ Health checks
- ✅ Configuración centralizada de API
- ✅ Nginx para frontend
- ✅ Variables de entorno para producción
- ✅ CORS configurado
- ✅ Optimización de imágenes

### 🔍 Troubleshooting

#### Problemas Comunes

1. **Error de conexión a BD**:
   - Verificar variables de entorno
   - Confirmar que la BD es accesible desde Dokploy

2. **Imágenes no se cargan**:
   - Verificar que el volumen `uploads_data` esté montado
   - Revisar permisos del directorio `/app/api/uploads`

3. **Frontend no conecta con Backend**:
   - Verificar que `VITE_API_URL` esté configurado correctamente
   - Confirmar que el backend esté funcionando

#### Logs
```bash
# Ver logs del backend
docker-compose logs backend

# Ver logs del frontend
docker-compose logs frontend

# Seguir logs en tiempo real
docker-compose logs -f
```

### 📞 Soporte

Si encuentras problemas durante el despliegue, revisa:
1. Los logs de Dokploy
2. Los health checks de los servicios
3. La configuración de variables de entorno
4. La conectividad de red entre servicios
