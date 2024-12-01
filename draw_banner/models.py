from django.db import models
from django.contrib.auth.models import User
# Create your models here.
class Artwork(models.Model):
    CATEGORY_CHOICES=[
        ('original','原创'),
        ('inspiration', '灵感'),
        ('copy', '临摹'),
    ]

    title=models.CharField(max_length=100)
    author=models.CharField(max_length=50)
    image=models.ImageField(upload_to=r'image_draw')
    category=models.CharField(max_length=20,choices=CATEGORY_CHOICES)
    likes=models.PositiveIntegerField(default=0)
    views=models.PositiveIntegerField(default=0)

    def __str__(self):
        return self.title

# python manage.py makemigrations
# python manage.py migrate

class Drawing(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="drawings")
    name = models.CharField(max_length=100, blank=True, null=True, verbose_name="作品名称")
    image = models.ImageField(upload_to='saved_drawings/', verbose_name="绘画作品文件")
    feedback = models.TextField(blank=True, null=True, verbose_name="留言")
    created_at = models.DateTimeField(auto_now_add=True, verbose_name="创建时间")

    class Meta:
        verbose_name = "绘画作品"
        verbose_name_plural = "绘画作品集"

    def __str__(self):
        return f"{self.user.username} 的作品 - {self.name or '未命名'}"


class ChatMessage(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    message_type = models.CharField(max_length=10, choices=[('text', 'Text'), ('image', 'Image')])
    content = models.TextField()  # 对于文本消息，存储文字；对于图片消息，存储图片路径
    ai_response = models.TextField(null=True, blank=True)  # AI返回的回复
    timestamp = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.user.username} - {self.message_type} - {self.timestamp}"


