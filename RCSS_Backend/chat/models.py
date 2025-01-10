from django.db import models

# Create your models here.
class Message(models.Model):
    sender = models.CharField(max_length=100)
    text = models.TextField()
    timestamp = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f'{self.sender}: {self.text}'