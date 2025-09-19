# 🚀 CustomCarpent - Configuración Final para Dokploy

## ✅ **Configuración Completa Lista**

### **Archivos Principales:**
- `dokploy-final.yml` - Docker Compose con valores hardcodeados
- `backend/database/init.sql` - Script de inicialización de BD
- `backend/Dockerfile` - Optimizado para producción
- `frontend/Dockerfile` - Con Nginx

### **Persistencia de Datos:**
- ✅ **Base de Datos**: Volumen `mysql_data` para persistir datos
- ✅ **Imágenes**: Volumen `uploads_data` para persistir imágenes
- ✅ **Esquema completo**: Inicialización automática con tu estructura

## 🔧 **Configuración en Dokploy**

### **1. Compose Path:**
```
./dokploy-final.yml
```

### **2. Variables de Entorno:**
**NO NECESARIAS** - Todo está hardcodeado en el compose

### **3. Dominios:**
- Frontend: `rtakabinetssolutions.com`
- Backend: `api.rtakabinetssolutions.com`

## 🚀 **Despliegue**

1. **Importar proyecto** desde GitHub
2. **Configurar Compose Path** a `dokploy-final.yml`
3. **Desplegar** - Todo se configurará automáticamente

## 📊 **Servicios que se Desplegarán:**

### **1. Database (MySQL 8.0)**
- **Contenedor**: `customcarpent-database`
- **Puerto**: 3306 (interno)
- **Volumen**: `mysql_data` (persistente)
- **Inicialización**: Automática con tu esquema

### **2. Backend (Node.js API)**
- **Contenedor**: `customcarpent-backend`
- **Puerto**: 5000
- **Volumen**: `uploads_data` (imágenes persistentes)
- **Health Check**: `/api/health`

### **3. Frontend (React + Nginx)**
- **Contenedor**: `customcarpent-frontend`
- **Puerto**: 80
- **Health Check**: `/`

## 🔍 **Verificación Post-Despliegue**

### **URLs de Acceso:**
- **Frontend**: `https://rtakabinetssolutions.com`
- **Backend**: `https://api.rtakabinetssolutions.com`
- **Health Check**: `https://api.rtakabinetssolutions.com/api/health`

### **Funcionalidades a Probar:**
1. ✅ **Frontend carga correctamente**
2. ✅ **Login de administrador** (admin@admin.com / admin123)
3. ✅ **Subida de imágenes** funciona
4. ✅ **Base de datos** tiene datos iniciales
5. ✅ **Imágenes persisten** entre reinicios

## 🎯 **Características Implementadas:**

- ✅ **Dockerización completa**
- ✅ **Persistencia de datos** (BD + imágenes)
- ✅ **Health checks** para todos los servicios
- ✅ **SSL automático** con Let's Encrypt
- ✅ **Configuración optimizada** para producción
- ✅ **Esquema de BD real** con datos iniciales

## 🚨 **Troubleshooting**

### **Si MySQL no inicia:**
- Verificar que el volumen `mysql_data` esté disponible
- Revisar logs del contenedor `database`

### **Si Backend no conecta:**
- Verificar que `DB_HOST=database` (no localhost)
- Confirmar que MySQL esté "healthy"

### **Si Frontend no carga:**
- Verificar que el backend esté "healthy"
- Confirmar que `VITE_API_URL` esté configurado

## 📞 **Soporte**

Si encuentras problemas:
1. **Revisar logs** en Dokploy
2. **Verificar health checks** de los servicios
3. **Confirmar volúmenes** estén montados
4. **Probar conectividad** entre servicios

¡Tu aplicación estará lista para producción! 🎉
