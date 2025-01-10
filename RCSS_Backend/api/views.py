from django.db import transaction
from rest_framework import generics
from rest_framework.response import Response
from rest_framework import status
from drf_yasg.utils import swagger_auto_schema
from drf_yasg import openapi
from yaml import serialize
from .models import *
from .serializers import *

class AppSettingsView(generics.GenericAPIView):
    queryset = AppSettings.objects.all()
    serializer_class = AppSettingsSerializer

    def get(self, request):
        app_settings = self.get_queryset()
        serializer = self.serializer_class(app_settings, many=True)
        data = serializer.data

        return Response(data, status=status.HTTP_200_OK)

    def post(self, request):
        serializer = AppSettingsSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class NetworkBasesSettingsView(generics.GenericAPIView):
    queryset = NetworkBasesSettings.objects.all()
    serializer_class = NetworkBasesSettingsSerializer

    def get(self, request):
        network_bases_settings = self.get_queryset()
        serializer = self.serializer_class(network_bases_settings, many=True)
        data = serializer.data

        return Response(data, status=status.HTTP_200_OK)

    def post(self, request):
        serializer = NetworkBasesSettingsSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class NetworkServiceSettingsView(generics.GenericAPIView):
    queryset = NetworkServiceSettings.objects.all()
    serializer_class = NetworkServiceSettingsSerializer

    def get(self, request):
        network_service_settings = self.get_queryset()
        serializer = self.serializer_class(network_service_settings, many=True)
        data = serializer.data

        return Response(data, status=status.HTTP_200_OK)

    def post(self, request):
        serializer = NetworkServiceSettingsSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class ContentManagementView(generics.GenericAPIView):
    queryset = ContentManagement.objects.all()
    serializer_class = ContentManagementSerializer

    def get(self, request):
        content_management = self.get_queryset()
        serializer = self.serializer_class(content_management, many=True)
        data = serializer.data

        return Response(data, status=status.HTTP_200_OK)

    def post(self, request):
        serializer = ContentManagementSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class ContentManagementIdView(generics.GenericAPIView):
    queryset = ContentManagement.objects.all()
    serializer_class = ContentManagementSerializer

    def get(self, request, pk):
        try:
            content_management = ContentManagement.objects.get(pk=pk)
            data = content_management.data
        except Exception as e:
            data = {'error ': str(e)}
        return Response(data, status=status.HTTP_200_OK)

    def put(self, request, pk):
        try:
            content_management = ContentManagement.objects.get(pk=pk)
        except ContentManagement.DoesNotExist:
            return Response({'error': 'Content not found'}, status=status.HTTP_404_NOT_FOUND)

        serializer = ContentManagementSerializer(content_management, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, pk):
        try:
            content_management = ContentManagement.objects.get(pk=pk)
            content_management.delete()
            return Response(status=status.HTTP_204_NO_CONTENT)
        except ContentManagement.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)

class ReportingAnalysisView(generics.GenericAPIView):
    queryset = ReportingAnalysis.objects.all()
    serializer_class = ReportingAnalysisSerializer

    def post(self, request):
        serializer = ReportingAnalysisSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class ReportingAnalysisTypeView(generics.GenericAPIView):
    queryset = ReportingAnalysis.objects.all()
    serializer_class = ReportingAnalysisSerializer

    def get(self, request, pk):
        try:
            reporting_analysis = ReportingAnalysis.objects.get(type=type)
            data = reporting_analysis.data
        except Exception as e:
            data = {'error ': str(e)}
        return Response(data, status=status.HTTP_200_OK)

class NotificationLogView(generics.GenericAPIView):
    queryset = NotificationLog.objects.all()
    serializer_class = NotificationLogSerializer

    def get(self, request):
        notification_log = self.get_queryset()
        serializer = self.serializer_class(notification_log, many=True)
        data = serializer.data

        return Response(data, status=status.HTTP_200_OK)

    def post(self, request):
        def post(self, request):
            serializer = NotificationLogSerializer(data=request.data)
            if serializer.is_valid():
                serializer.save()
                return Response(status=status.HTTP_201_CREATED)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class NotificationLogIdView(generics.GenericAPIView):
    queryset = NotificationLog.objects.all()
    serializer_class = NotificationLogSerializer

    def get(self, request, pk):
        try:
            notification_log = NotificationLog.objects.get(type=type)
            data = notification_log.data
        except Exception as e:
            data = {'error ': str(e)}
        return Response(data, status=status.HTTP_200_OK)

class FileManagementView(generics.GenericAPIView):
    queryset = FileManagement.objects.all()
    serializer_class = FileManagementSerializer

    def get(self, request):
        file_management = self.get_queryset()
        serializer = self.serializer_class(file_management, many=True)
        data = serializer.data

        return Response(data, status=status.HTTP_200_OK)

    def post(self, request):
        def post(self, request):
            serializer = FileManagementSerializer(data=request.data)
            if serializer.is_valid():
                serializer.save()
                return Response(status=status.HTTP_201_CREATED)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class FileManagementIdView(generics.GenericAPIView):
    queryset = FileManagement.objects.all()
    serializer_class = FileManagementSerializer

    def get(self, request, pk):
        try:
            file_management = FileManagement.objects.get(pk=pk)
            data = file_management.data
        except Exception as e:
            data = {'error ': str(e)}
        return Response(data, status=status.HTTP_200_OK)

    def delete(self, request, pk):
        try:
            file_management = FileManagement.objects.get(pk=pk)
            file_management.delete()
            return Response(status=status.HTTP_204_NO_CONTENT)
        except FileManagement.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)

class AuditLogView(generics.GenericAPIView):
    queryset = AuditLog.objects.all()
    serializer_class = AuditLogSerializer

    def get(self, request):
        audit_log = self.get_queryset()
        serializer = self.serializer_class(audit_log, many=True)
        data = serializer.data

        return Response(data, status=status.HTTP_200_OK)

class AuditLogIdView(generics.GenericAPIView):
    queryset = AuditLog.objects.all()
    serializer_class = AuditLogSerializer

    def get(self, request, pk):
        try:
            audit_log = AuditLog.objects.get(pk=pk)
            data = audit_log.data
        except Exception as e:
            data = {'error ': str(e)}
        return Response(data, status=status.HTTP_200_OK)
