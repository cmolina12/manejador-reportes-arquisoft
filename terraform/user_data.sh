#!/bin/bash
yum update -y
yum install -y python3 python3-pip git

# Variables de entorno
export DB_HOST="${db_host}"
export DB_NAME="${db_name}"
export DB_USER="${db_user}"
export DB_PASSWORD="${db_password}"
export REDIS_HOST="${redis_host}"
export APP_PORT="${app_port}"

# Guardarlas permanentemente
cat >> /etc/environment << ENVEOF
DB_HOST=${db_host}
DB_NAME=${db_name}
DB_USER=${db_user}
DB_PASSWORD=${db_password}
REDIS_HOST=${redis_host}
APP_PORT=${app_port}
ENVEOF

# Instalar dependencias Django
pip3 install django djangorestframework psycopg2-binary redis gunicorn

# Crear directorio de la app
mkdir -p /app
cd /app

# Crear el proyecto Django
django-admin startproject config .
python3 manage.py startapp reportes

# Arrancar el servidor
gunicorn config.wsgi:application --bind 0.0.0.0:${app_port} --daemon
