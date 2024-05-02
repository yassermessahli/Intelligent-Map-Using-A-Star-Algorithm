from django.urls import path
from .views import calculate_path

urlpatterns = [
    path('calculate_path/', calculate_path, name='calculate_path'),
]