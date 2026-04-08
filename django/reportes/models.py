from django.db import models

class Reporte(models.Model):
    nombre = models.CharField(max_length=100)
    periodo = models.CharField(max_length=20)
    datos = models.JSONField(default=dict)
    creado_en = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.nombre} - {self.periodo}"
