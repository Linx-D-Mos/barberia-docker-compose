#!/bin/bash

echo "=========================================="
echo "🚀 INICIANDO CONFIGURACION AUTOMATICA (Mac/Linux) 🚀"
echo "=========================================="
echo ""

echo "1. Instalando dependencias de PHP (Composer)..."
docker-compose exec app composer install --no-interaction

echo ""
echo "2. Configurando archivo de entorno (.env)..."
# Copia solo si no existe para no sobrescribir cambios previos
docker-compose exec app cp -n .env.example .env

echo ""
echo "3. Generando llave de la aplicacion..."
docker-compose exec app php artisan key:generate

echo ""
echo "4. Asignando permisos a carpetas de almacenamiento..."
docker-compose exec app chmod -R 777 storage bootstrap/cache

echo ""
echo "5. Esperando a que la Base de Datos arranque..."
# En Linux/Mac se usa 'sleep' en lugar de 'timeout'
sleep 10

echo ""
echo "6. Corriendo migraciones y seeders..."
docker-compose exec app php artisan migrate --seed

echo ""
echo "7. Limpiando caches..."
docker-compose exec app php artisan config:clear
docker-compose exec app php artisan route:clear

echo ""
echo "=========================================="
echo "✅ ¡TODO LISTO! YA PUEDES USAR LA APP ✅"
echo "=========================================="
echo "Backend: http://localhost:9000"
echo "Frontend: http://localhost:8080"
echo ""