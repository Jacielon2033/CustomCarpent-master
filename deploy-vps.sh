#!/bin/bash

# Script para desplegar en VPS directamente
echo "🚀 Desplegando CustomCarpent en VPS..."

# Actualizar sistema
sudo apt update && sudo apt upgrade -y

# Instalar Docker y Docker Compose
sudo apt install -y docker.io docker-compose
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER

# Crear directorio del proyecto
mkdir -p ~/customcarpent
cd ~/customcarpent

# Clonar repositorio
git clone https://github.com/Jacielon2033/CustomCarpent-master.git .

# Dar permisos
sudo chown -R $USER:$USER ~/customcarpent

# Iniciar servicios
docker-compose up -d --build

echo "✅ ¡Desplegado! Accede a:"
echo "🌐 Frontend: http://$(curl -s ifconfig.me):8080"
echo "🔧 Backend: http://$(curl -s ifconfig.me):5001"
echo "📊 Base de datos: $(curl -s ifconfig.me):3307"
