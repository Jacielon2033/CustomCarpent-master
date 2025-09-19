# 🚀 Instrucciones de Despliegue - CustomCarpent

## 📋 Checklist Pre-Despliegue

### ✅ Preparación del Proyecto
- [x] Dockerfiles creados para frontend y backend
- [x] docker-compose.yml configurado
- [x] dokploy.yml para producción
- [x] Volúmenes configurados para persistencia de imágenes
- [x] Health checks implementados
- [x] Configuración centralizada de API
- [x] CORS configurado para producción

### 🔧 Configuración Requerida

#### 1. Variables de Entorno
Crea un archivo `.env` en la raíz del proyecto:

```env
# Base de Datos (ya configurada)
DB_HOST=tu_host_de_bd
DB_USER=tu_usuario_de_bd
DB_PASS=tu_password_de_bd
DB_NAME=tu_nombre_de_bd
DB_PORT=3306

# JWT Secret (genera uno seguro)
JWT_SECRET=tu_jwt_secret_muy_seguro_de_al_menos_32_caracteres

# Email (opcional)
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USER=tu_email@gmail.com
EMAIL_PASS=tu_password_de_email
```

#### 2. Dominios Configurados
- **Frontend**: `rtakabinetssolutions.com`
- **Backend**: `api.rtakabinetssolutions.com`

## 🐳 Despliegue en Dokploy

### Paso 1: Crear Proyecto
1. Accede a tu panel de Dokploy
2. Crea un nuevo proyecto llamado `customcarpent`
3. Selecciona "Docker Compose" como tipo de proyecto

### Paso 2: Configurar Repositorio
1. Conecta tu repositorio Git o sube los archivos
2. Usa el archivo `dokploy.yml` como configuración principal

### Paso 3: Configurar Variables de Entorno
En el panel de Dokploy, agrega las siguientes variables:

```
NODE_ENV=production
DB_HOST=tu_host_de_bd
DB_USER=tu_usuario_de_bd
DB_PASS=tu_password_de_bd
DB_NAME=tu_nombre_de_bd
DB_PORT=3306
JWT_SECRET=tu_jwt_secret_muy_seguro
```

### Paso 4: Configurar Dominios
1. **Frontend**:
   - Dominio: `rtakabinetssolutions.com`
   - Puerto: `80`
   - SSL: Habilitado (automático)

2. **Backend**:
   - Dominio: `api.rtakabinetssolutions.com`
   - Puerto: `5000`
   - SSL: Habilitado (automático)

### Paso 5: Configurar Volúmenes
- **Nombre**: `uploads_data`
- **Ruta en contenedor**: `/app/api/uploads`
- **Tipo**: Local

### Paso 6: Desplegar
1. Haz clic en "Deploy"
2. Monitorea los logs durante el despliegue
3. Verifica que ambos servicios estén "Healthy"

## 🔍 Verificación Post-Despliegue

### Health Checks
- Frontend: `https://rtakabinetssolutions.com`
- Backend: `https://api.rtakabinetssolutions.com/api/health`

### Funcionalidades a Probar
1. **Frontend**:
   - [ ] Carga correctamente
   - [ ] Navegación funciona
   - [ ] Formularios de contacto funcionan

2. **Backend**:
   - [ ] API responde correctamente
   - [ ] Autenticación funciona
   - [ ] Subida de imágenes funciona
   - [ ] Imágenes se sirven correctamente

3. **Base de Datos**:
   - [ ] Conexión establecida
   - [ ] Datos se guardan correctamente
   - [ ] Consultas funcionan

## 🛠️ Comandos Útiles

### Desarrollo Local
```bash
# Construir y ejecutar
docker-compose up --build

# Solo backend
docker-compose up backend

# Ver logs
docker-compose logs -f
```

### Producción
```bash
# Usar configuración de Dokploy
docker-compose -f dokploy.yml up --build -d

# Ver logs
docker-compose -f dokploy.yml logs -f
```

## 🚨 Troubleshooting

### Problemas Comunes

#### 1. Error de Conexión a Base de Datos
**Síntomas**: Backend no puede conectar a MySQL
**Solución**:
- Verificar variables de entorno
- Confirmar que la BD es accesible desde Dokploy
- Revisar firewall y configuración de red

#### 2. Imágenes No Se Cargan
**Síntomas**: Imágenes no aparecen en el frontend
**Solución**:
- Verificar que el volumen `uploads_data` esté montado
- Revisar permisos del directorio `/app/api/uploads`
- Confirmar que las rutas de imágenes son correctas

#### 3. Frontend No Conecta con Backend
**Síntomas**: Errores de CORS o conexión
**Solución**:
- Verificar que `VITE_API_URL` esté configurado
- Confirmar que el backend esté funcionando
- Revisar configuración de CORS

#### 4. SSL No Funciona
**Síntomas**: Certificados no se generan
**Solución**:
- Verificar que los dominios estén configurados correctamente
- Confirmar que los DNS apunten a Dokploy
- Revisar configuración de SSL en Dokploy

### Logs Importantes
```bash
# Logs del backend
docker-compose logs backend

# Logs del frontend
docker-compose logs frontend

# Logs de todos los servicios
docker-compose logs
```

## 📞 Soporte

Si encuentras problemas:

1. **Revisa los logs** en el panel de Dokploy
2. **Verifica los health checks** de ambos servicios
3. **Confirma las variables de entorno**
4. **Prueba la conectividad** entre servicios

### Información Útil para Soporte
- Versión de Dokploy
- Logs de error específicos
- Configuración de variables de entorno (sin passwords)
- Estado de los health checks

## 🎉 ¡Despliegue Completado!

Una vez que todo esté funcionando:

1. **Prueba todas las funcionalidades**
2. **Configura backups** de la base de datos
3. **Monitorea el rendimiento**
4. **Configura alertas** si es necesario

¡Tu aplicación CustomCarpent estará lista para producción! 🚀
