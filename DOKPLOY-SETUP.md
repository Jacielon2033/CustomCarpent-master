# 🚀 Configuración para Dokploy - CustomCarpent

## 📋 Variables de Entorno para Dokploy

**Copia estas variables en la sección "Environment Variables" de Dokploy:**

```
DB_ROOT_PASSWORD=Pa12724110$
DB_NAME=customcarpent
DB_USER=root
DB_PASS=Pa12724110$
JWT_SECRET=1234abcd5678efgh
EMAIL_USER=alexholguinmartinez22@gmail.com
EMAIL_PASS=ehyxjvvhlpmqjctg
EMAIL_RECEIVER=Carpentry.ido@gmail.com
```

## 🔧 Pasos para Configurar en Dokploy

### 1. **Compose Path**
- Cambiar a: `./dokploy-complete.yml`

### 2. **Variables de Entorno**
- Agregar las variables de arriba en la sección "Environment Variables"
- **Importante**: Usar exactamente los valores mostrados

### 3. **Dominios**
- Frontend: `rtakabinetssolutions.com`
- Backend: `api.rtakabinetssolutions.com`

### 4. **Desplegar**
- Hacer clic en "Deploy"
- Monitorear los logs

## ✅ Verificación Post-Despliegue

### Health Checks:
- Frontend: `https://rtakabinetssolutions.com`
- Backend: `https://api.rtakabinetssolutions.com/api/health`

### Funcionalidades a Probar:
1. **Frontend carga correctamente**
2. **Login de administrador funciona**
3. **Subida de imágenes funciona**
4. **Base de datos tiene datos iniciales**

## 🚨 Si Algo Falla

### Error de MySQL:
- Verificar que `DB_ROOT_PASSWORD` esté configurado
- Confirmar que las variables estén en mayúsculas

### Error de Conexión:
- Verificar que `DB_HOST=database` (no localhost)
- Confirmar que el backend espere a que la BD esté lista

### Imágenes No Se Cargan:
- Verificar que el volumen `uploads_data` esté montado
- Confirmar permisos del directorio `/app/api/uploads`
