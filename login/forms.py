from django import forms
from django.contrib.auth.models import User
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth.forms import UserCreationForm
from .models import Profile
# 自定义登录表单，继承 Django 的 AuthenticationForm
class LoginForm(forms.Form):
    username = forms.CharField(label='用户名', max_length=100)
    password = forms.CharField(label='密码', widget=forms.PasswordInput)
    identity_choices = [
        ('teacher', '教师'),
        ('student', '学生'),
        ('parent', '家长'),
    ]
    identity = forms.ChoiceField(choices=identity_choices, label='身份', required=True)


# 继承 UserCreationForm，添加身份选择字段
class UserRegisterForm(forms.Form):
    identity_choices = [
        ('teacher', '教师'),
        ('student', '学生'),
        ('parent', '家长'),
    ]

    username = forms.CharField(max_length=100, label="用户名")
    password1 = forms.CharField(widget=forms.PasswordInput, label="密码")
    password2 = forms.CharField(widget=forms.PasswordInput, label="密码确认")
    identity = forms.ChoiceField(choices=identity_choices, label="身份")

    def clean(self):
        cleaned_data = super().clean()
        password1 = cleaned_data.get("password1")
        password2 = cleaned_data.get("password2")

        if password1 != password2:
            raise forms.ValidationError("两次输入的密码不一致。")
        return cleaned_data

    def save(self):
        # 创建 User 和 Profile 实例
        username = self.cleaned_data.get('username')
        password = self.cleaned_data.get('password1')
        identity = self.cleaned_data.get('identity')

        # 创建 User
        user = User.objects.create_user(username=username, password=password)

        # 创建 Profile
        Profile.objects.create(user=user, user_type=identity)

        return user
