from django.db import models
import os
import uuid
from django.contrib.auth.models import User


def drawing_image_path(instance, filename):
    # 处理标签中的空格和非法字符
    tag_folder = instance.DrawingTag.replace(' ', '_').replace('　', '_')
    # 使用 UUID 避免文件名冲突
    filename = f"{uuid.uuid4().hex}_{filename}"
    # 返回完整路径
    return os.path.join('all_picture', tag_folder, filename)

class DrawingWarehouse(models.Model):
    DrawingID = models.AutoField(primary_key=True)
    DrawingName = models.CharField(max_length=100, null=True, verbose_name='画作名字')
    DrawingSize = models.CharField(max_length=30, null=True, verbose_name='画作大小')
    DrawingYear = models.CharField(max_length=20, null=True, verbose_name='画作年份')
    DrawingPicture = models.ImageField(upload_to=drawing_image_path, verbose_name='画作图片')
    DrawTagChoice=[
        ('中国画', '中国画'),
        ('油画', '油画'),
        ('版画', '版画'),
        ('雕塑', '雕塑'),
        ('素描 速写', '素描 速写'),
        ('摄影', '摄影'),
        ('水彩 水粉 色粉', '水彩 水粉 色粉'),
        ('漫画', '漫画'),
        ('连环画', '连环画'),
        ('漆画', '漆画'),
        ('书法 篆刻', '书法 篆刻'),
        ('新年画', '新年画'),
        ('插图', '插图'),
        ('现代装置', '现代装置'),
        ('综合艺术', '综合艺术'),
    ]
    DrawingTag = models.CharField(choices=DrawTagChoice, max_length=20, verbose_name='画作标签')
    feekback = models.CharField(null=True, verbose_name='画作评价', max_length=100)
    likes = models.PositiveIntegerField(default=0, verbose_name='点赞数')
    views = models.PositiveIntegerField(default=0, verbose_name='浏览量')
    clicks = models.PositiveIntegerField(default=0, verbose_name='点击数')
    favorites = models.PositiveIntegerField(default=0, verbose_name='收藏数')

    class Meta:
        verbose_name = '画作信息'
        verbose_name_plural = '画作信息'

    def __str__(self):
        return self.DrawingName or "未命名画作"


class MyLike(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='likes')
    drawing = models.ForeignKey(DrawingWarehouse, on_delete=models.CASCADE, related_name='liked_by')
    liked_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('user', 'drawing')  # 防止用户重复收藏同一幅画作

    def __str__(self):
        return f"{self.user.username} 喜欢 {self.drawing.DrawingName}"