from django.db import router
from django.urls import path
from rest_framework.routers import DefaultRouter
from .views import MessageViewSet

urlpattenrs = [
    path('chat', MessageViewSet.as_view()),
]