import time
import json
from django.core.cache import cache
from django.http import JsonResponse
from .models import Reporte

def health(request):
    return JsonResponse({"status": "ok"})

def obtener_reporte(request, reporte_id):
    cache_key = f"reporte_{reporte_id}"

    # Intentar obtener desde cache
    resultado = cache.get(cache_key)
    if resultado:
        return JsonResponse({
            "fuente": "cache",
            "reporte_id": reporte_id,
            "datos": resultado
        })

    # Si no esta en cache, consultar BD
    try:
        reporte = Reporte.objects.get(id=reporte_id)
        datos = {
            "nombre": reporte.nombre,
            "periodo": reporte.periodo,
            "datos": reporte.datos,
        }
    except Reporte.DoesNotExist:
        # Simular generacion de reporte si no existe
        time.sleep(0.1)  # simula tiempo de procesamiento
        datos = {
            "nombre": f"Reporte {reporte_id}",
            "periodo": "2024-Q1",
            "datos": {
                "usuarios": 1500,
                "consumos": 320,
                "proyectos": 45,
                "recursos": 120,
                "costos": 98000
            }
        }

    # Guardar en cache con TTL de 60 segundos
    cache.set(cache_key, datos, timeout=60)

    return JsonResponse({
        "fuente": "base_de_datos",
        "reporte_id": reporte_id,
        "datos": datos
    })
