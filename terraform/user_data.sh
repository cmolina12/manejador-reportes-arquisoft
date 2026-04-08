#!/bin/bash
apt-get update -y
apt-get install -y python3 python3-pip git

git clone https://github.com/cmolina12/manejador-reportes-arquisoft.git /app

cat > /home/ubuntu/.env << ENVEOF
DB_HOST=${db_host}
DB_NAME=${db_name}
DB_USER=${db_user}
DB_PASSWORD=${db_password}
REDIS_HOST=${redis_host}
APP_PORT=${app_port}
DJANGO_SETTINGS_MODULE=config.settings
ENVEOF

cd /app/django
pip3 install -r requirements.txt --break-system-packages
pip3 install django-redis --break-system-packages

set -a && source /home/ubuntu/.env && set +a
python3 manage.py makemigrations reportes
python3 manage.py migrate
nohup python3 manage.py runserver 0.0.0.0:${app_port} &
