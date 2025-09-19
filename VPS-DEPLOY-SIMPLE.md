# 🚀 Despliegue Súper Simple en VPS

## 📋 Requisitos
- VPS con Ubuntu/Debian
- Acceso SSH
- 2GB RAM mínimo

## ⚡ Pasos (5 minutos)

### 1. Conectar al VPS
```bash
ssh usuario@tu-vps-ip
```

### 2. Instalar Docker
```bash
sudo apt update
sudo apt install -y docker.io docker-compose
sudo systemctl start docker
sudo usermod -aG docker $USER
```

### 3. Descargar proyecto
```bash
git clone https://github.com/Jacielon2033/CustomCarpent-master.git
cd CustomCarpent-master
```

### 4. Iniciar aplicación
```bash
docker-compose up -d --build
```

### 5. ¡Listo! 🎉
- **Frontend**: `http://tu-vps-ip:8080`
- **Backend**: `http://tu-vps-ip:5001`

## 🔧 Comandos útiles

```bash
# Ver logs
docker-compose logs -f

# Parar aplicación
docker-compose down

# Reiniciar
docker-compose restart

# Ver contenedores
docker ps
```

## 🌐 Configurar dominio (opcional)

Si tienes un dominio, puedes usar Nginx como proxy:

```bash
sudo apt install nginx
sudo nano /etc/nginx/sites-available/customcarpent
```

Contenido:
```nginx
server {
    listen 80;
    server_name tu-dominio.com;
    
    location / {
        proxy_pass http://localhost:8080;
    }
}
```

```bash
sudo ln -s /etc/nginx/sites-available/customcarpent /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```
