#!/bin/bash
yum update -y
yum install -y python3 python3-pip git

# Clonar el repo
git clone https://github.com/cmolina12/manejador-reportes-arquisoft.git /app
cd /app/django

# Instalar dependencias
pip3 install -r requirements.txt
pip3 install django-redis

# Crear archivo de variables de entorno
cat > /home/ec2-user/.env << ENVEOF
DB_HOST=${db_host}
DB_NAME=${db_name}
DB_USER=${db_user}
DB_PASSWORD=${db_password}
REDIS_HOST=${redis_host}
APP_PORT=${app_port}
DJANGO_SETTINGS_MODULE=config.settings
ENVEOF

# Cargar variables y arrancar el servidor
set -a && source /home/ec2-user/.env && set +a
cd /app/django
python3 manage.py makemigrations reportes
python3 manage.py migrate
nohup python3 manage.py runserver 0.0.0.0:${app_port} &
