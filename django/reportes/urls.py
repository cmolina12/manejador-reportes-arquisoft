from django.urls import path
from . import views

urlpatterns = [
    path('health/', views.health),
    path('reporte/<int:reporte_id>/', views.obtener_reporte),
]
