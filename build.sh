#!/bin/bash

# Script de build para CustomCarpent
echo "🚀 Iniciando build de CustomCarpent..."

# Verificar que Docker esté instalado
if ! command -v docker &> /dev/null; then
    echo "❌ Docker no está instalado. Por favor instala Docker primero."
    exit 1
fi

# Verificar que Docker Compose esté instalado
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose no está instalado. Por favor instala Docker Compose primero."
    exit 1
fi

# Verificar que existe el archivo .env
if [ ! -f .env ]; then
    echo "⚠️  No se encontró el archivo .env"
    echo "📋 Copiando env.example a .env..."
    cp env.example .env
    echo "✅ Archivo .env creado. Por favor configura las variables de entorno antes de continuar."
    echo "📝 Edita el archivo .env con tus credenciales de base de datos y otras configuraciones."
    exit 1
fi

echo "🔨 Construyendo imágenes Docker..."

# Construir imágenes
docker-compose build

if [ $? -eq 0 ]; then
    echo "✅ Build completado exitosamente!"
    echo ""
    echo "🚀 Para iniciar los servicios:"
    echo "   docker-compose up -d"
    echo ""
    echo "📊 Para ver los logs:"
    echo "   docker-compose logs -f"
    echo ""
    echo "🛑 Para detener los servicios:"
    echo "   docker-compose down"
    echo ""
    echo "🌐 URLs de acceso:"
    echo "   Frontend: http://localhost"
    echo "   Backend: http://localhost:5000"
    echo "   Health Check: http://localhost:5000/api/health"
else
    echo "❌ Error durante el build. Revisa los logs arriba."
    exit 1
fi
