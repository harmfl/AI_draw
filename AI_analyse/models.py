from django.db import models
from login.models import Profile
from django.contrib.auth.models import User

class ConnectStudentTeacher(models.Model):
    # 学生账号
    student = models.ForeignKey(
        Profile,
        on_delete=models.CASCADE,
        related_name='student_connections',
        verbose_name='学生账号'
    )
    # 学生密码
    student_code = models.CharField(
        max_length=100,
        verbose_name='学生密码'
    )
    # 学生姓名（从 Profile 动态获取）
    student_name = models.CharField(
        max_length=50,
        null=True,
        blank=True,
        verbose_name='学生姓名'
    )
    # 学生手机号（从 Profile 动态获取）
    student_phone = models.CharField(
        max_length=20,
        null=True,
        blank=True,
        verbose_name='学生手机号'
    )
    # 学生性别
    STUDENT_SEX_CHOICES = (
        ('男', '男'),
        ('女', '女'),
    )
    student_sex = models.CharField(
        max_length=20,
        choices=STUDENT_SEX_CHOICES,
        default='男',
        verbose_name='学生性别'
    )
    # 与学生的关系
    RELATIONSHIP_CHOICES = (
        ('老师', '老师'),
        ('父亲', '父亲'),
        ('母亲', '母亲'),
    )
    relationship = models.CharField(
        max_length=20,
        choices=RELATIONSHIP_CHOICES,
        default='老师',
        verbose_name='与学生的关系'
    )
    # 教师/家长账号
    teacher_or_parent = models.ForeignKey(
        Profile,
        on_delete=models.CASCADE,
        related_name='teacher_or_parent_connection',
        verbose_name='老师/家长账号'
    )
    # 教师/家长姓名（从 Profile 动态获取）
    teacher_or_parent_name = models.CharField(
        max_length=50,
        null=True,
        blank=True,
        verbose_name='老师/家长姓名'
    )
    # 教师/家长手机号（从 Profile 动态获取）
    teacher_or_parent_phone = models.CharField(
        max_length=20,
        null=True,
        blank=True,
        verbose_name='老师/家长手机号'
    )
    # 学生照片
    student_image = models.ImageField(
        upload_to='student_image',
        verbose_name='学生照片',
        null=True,
        blank=True
    )
    # 关联时间
    connect_time = models.DateTimeField(
        auto_now_add=True,
        verbose_name='关联时间'
    )

    class Meta:
        verbose_name = '学生与教师/家长关联'
        verbose_name_plural = '学生与教师/家长关联'

    def __str__(self):
        teacher_or_parent_name = self.teacher_or_parent_name or "未设置"
        teacher_or_parent = self.teacher_or_parent if hasattr(self, 'teacher_or_parent') else "未设置"
        return f"学生: {self.student_name or self.student} - 老师/家长: {teacher_or_parent_name or teacher_or_parent}"


class Draw_Video(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='videos')
    video_file = models.FileField(upload_to='video_chunks/') # FileField会存储到media/+这里的地址
    ai_analyse_result = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.user.username}的视频模型"
