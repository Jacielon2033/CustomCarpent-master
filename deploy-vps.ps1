# Script PowerShell para desplegar en VPS
Write-Host "🚀 Desplegando CustomCarpent en VPS..." -ForegroundColor Green

# Conectar por SSH y ejecutar comandos
$vps_ip = Read-Host "Ingresa la IP de tu VPS"
$username = Read-Host "Ingresa tu usuario SSH"

Write-Host "📡 Conectando a $vps_ip..." -ForegroundColor Yellow

# Comandos a ejecutar en el VPS
$commands = @"
# Actualizar sistema
sudo apt update && sudo apt upgrade -y

# Instalar Docker
sudo apt install -y docker.io docker-compose
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $username

# Crear directorio
mkdir -p ~/customcarpent
cd ~/customcarpent

# Clonar repositorio
git clone https://github.com/Jacielon2033/CustomCarpent-master.git .

# Iniciar servicios
docker-compose up -d --build

echo "✅ ¡Desplegado! Accede a:"
echo "🌐 Frontend: http://$(curl -s ifconfig.me):8080"
echo "🔧 Backend: http://$(curl -s ifconfig.me):5001"
"@

# Ejecutar comandos via SSH
ssh $username@$vps_ip $commands

Write-Host "✅ ¡Desplegado! Accede a http://$vps_ip:8080" -ForegroundColor Green
