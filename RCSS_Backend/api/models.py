from django.db import models

class AppSettings(models.Model):
    id = models.AutoField(auto_created=True, primary_key=True)
    setting_name = models.CharField(max_length=255)
    setting_value = models.TextField()
    setting_type = models.CharField(max_length=50)
    description = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    is_active = models.BooleanField()
    options = models.TextField()
    priority = models.IntegerField()

class NetworkBasesSettings(models.Model):
    id = models.AutoField(auto_created=True, primary_key=True)
    api_base_url = models.CharField(max_length=255)
    api_key = models.CharField(max_length=255)
    service_port = models.IntegerField()
    retry_policy = models.CharField(max_length=50)
    max_connections = models.IntegerField()
    security_config = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class NetworkServiceSettings(models.Model):
    id = models.AutoField(auto_created=True, primary_key=True)
    setting_name = models.CharField(max_length=255)
    setting_value = models.TextField()
    setting_type = models.CharField(max_length=50)
    description = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    is_active = models.BooleanField()
    priority = models.IntegerField()
    access_control = models.CharField(max_length=255)

class ContentManagement(models.Model):
    id = models.AutoField(auto_created=True, primary_key=True)
    content = models.TextField()

class ReportingAnalysis(models.Model):
    id = models.AutoField(auto_created=True, primary_key=True)
    reports_type = models.CharField(max_length=255)
    reports_settings = models.JSONField()

class NotificationLog(models.Model):
    id = models.AutoField(auto_created=True, primary_key=True)
    notifications = models.TextField()
    logs = models.TextField()

class FileManagement(models.Model):
    id = models.AutoField(auto_created=True, primary_key=True)
    files = models.TextField()

class AuditLog(models.Model):
    id = models.AutoField(auto_created=True, primary_key=True)
    audit_logs = models.TextField()