# Script de build para CustomCarpent (PowerShell)
Write-Host "🚀 Iniciando build de CustomCarpent..." -ForegroundColor Green

# Verificar que Docker esté instalado
if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Docker no está instalado. Por favor instala Docker Desktop primero." -ForegroundColor Red
    exit 1
}

# Verificar que Docker Compose esté instalado
if (-not (Get-Command docker-compose -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Docker Compose no está instalado. Por favor instala Docker Compose primero." -ForegroundColor Red
    exit 1
}

# Verificar que existe el archivo .env
if (-not (Test-Path ".env")) {
    Write-Host "⚠️  No se encontró el archivo .env" -ForegroundColor Yellow
    Write-Host "📋 Copiando env.example a .env..." -ForegroundColor Cyan
    Copy-Item "env.example" ".env"
    Write-Host "✅ Archivo .env creado. Por favor configura las variables de entorno antes de continuar." -ForegroundColor Green
    Write-Host "📝 Edita el archivo .env con tus credenciales de base de datos y otras configuraciones." -ForegroundColor Cyan
    exit 1
}

Write-Host "🔨 Construyendo imágenes Docker..." -ForegroundColor Yellow

# Construir imágenes
docker-compose build

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Build completado exitosamente!" -ForegroundColor Green
    Write-Host ""
    Write-Host "🚀 Para iniciar los servicios:" -ForegroundColor Cyan
    Write-Host "   docker-compose up -d" -ForegroundColor White
    Write-Host ""
    Write-Host "📊 Para ver los logs:" -ForegroundColor Cyan
    Write-Host "   docker-compose logs -f" -ForegroundColor White
    Write-Host ""
    Write-Host "🛑 Para detener los servicios:" -ForegroundColor Cyan
    Write-Host "   docker-compose down" -ForegroundColor White
    Write-Host ""
    Write-Host "🌐 URLs de acceso:" -ForegroundColor Cyan
    Write-Host "   Frontend: http://localhost" -ForegroundColor White
    Write-Host "   Backend: http://localhost:5000" -ForegroundColor White
    Write-Host "   Health Check: http://localhost:5000/api/health" -ForegroundColor White
} else {
    Write-Host "❌ Error durante el build. Revisa los logs arriba." -ForegroundColor Red
    exit 1
}
