from .models import *
from rest_framework import serializers

class AppSettingsSerializer(serializers.ModelSerializer):
    class Meta:
        model = AppSettings
        fields = '__all__'

class NetworkBasesSettingsSerializer(serializers.ModelSerializer):
    class Meta:
        model = NetworkBasesSettings
        fields = '__all__'

class NetworkServiceSettingsSerializer(serializers.ModelSerializer):
    class Meta:
        model = NetworkServiceSettings
        fields = '__all__'

class ContentManagementSerializer(serializers.ModelSerializer):
    class Meta:
        model = ContentManagement
        fields = '__all__'

class ReportingAnalysisSerializer(serializers.ModelSerializer):
    class Meta:
        model = ReportingAnalysis
        fields = '__all__'

class NotificationLogSerializer(serializers.ModelSerializer):
    class Meta:
        model = NotificationLog
        fields = '__all__'

class FileManagementSerializer(serializers.ModelSerializer):
    class Meta:
        model = FileManagement
        fields = '__all__'

class AuditLogSerializer(serializers.ModelSerializer):
    class Meta:
        model = AuditLog
        fields = '__all__'
