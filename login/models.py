from django.db import models
from django.contrib.auth.models import User

# Create your models here.
class Profile(models.Model):
    USER_TYPE_CHOICES = [
        ('teacher', '教师'),
        ('student', '学生'),
        ('parent', '家长'),
    ]

    user_type = models.CharField(
        max_length=20,
        choices=USER_TYPE_CHOICES,
        default='student',  # 可以设置默认值，例如默认是学生
    )

    # 其他字段定义
    user = models.OneToOneField('auth.User', on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.user.username}"

    def re_id(self):
        return self.user.id


