import os

SECRET_KEY = 'clave-secreta-temporal'
DEBUG = True
ALLOWED_HOSTS = ['*']

INSTALLED_APPS = [
    'django.contrib.contenttypes',
    'django.contrib.auth',
    'rest_framework',
    'reportes',
]

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': os.environ.get('DB_NAME', 'reportes_db'),
        'USER': os.environ.get('DB_USER', 'admin'),
        'PASSWORD': os.environ.get('DB_PASSWORD', 'Admin1234!'),
        'HOST': os.environ.get('DB_HOST', 'localhost'),
        'PORT': '5432',
    }
}

CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.redis.RedisCache',
        'LOCATION': f"redis://{os.environ.get('REDIS_HOST', 'localhost')}:6379",
    }
}

ROOT_URLCONF = 'config.urls'
