from django.urls import path
from .views import *

urlpatterns = [
    path('app-settings', AppSettingsView.as_view()),
    path('network-bases-settings', NetworkBasesSettingsView.as_view()),
    path('network-service.settings', NetworkServiceSettingsView.as_view()),
    path('content-management', ContentManagementView.as_view()),
    path('content-management/<int:pk>', ContentManagementIdView.as_view()),
    path('reporting-analysis/settings/', ReportingAnalysisView.as_view()),
    path('reporting-analysis/<str:type>', ReportingAnalysisTypeView.as_view()),
    path('notifications/', NotificationLogView.as_view()),
    path('log/<int:pk>', NotificationLogIdView.as_view()),
    path('files/', FileManagementView.as_view()),
    path('files/<int:pk>', FileManagementIdView.as_view()),
    path('audit-log/', AuditLogView.as_view()),
    path('audit-log/<int:pk>', AuditLogIdView.as_view()),
]