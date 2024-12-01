from django import forms
from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from .models import ConnectStudentTeacher, Profile

class ConnectStudentTeacherForm(forms.ModelForm):
    student_account = forms.CharField(
        max_length=100,
        label="学生账号",
        widget=forms.TextInput(attrs={'class': 'form-control', 'placeholder': '请输入学生账号...'}),
    )
    student_password = forms.CharField(
        max_length=100,
        label="学生密码",
        widget=forms.PasswordInput(attrs={'class': 'form-control', 'placeholder': '请输入学生密码...'}),
    )
    student_name = forms.CharField(
        max_length=100,
        label="学生姓名",
        widget=forms.TextInput(attrs={'class': 'form-control', 'placeholder': '请输入学生姓名...'}),
    )
    student_phone = forms.CharField(
        max_length=20,
        label="学生手机号",
        widget=forms.TextInput(attrs={'class': 'form-control', 'placeholder': '请输入学生手机号...'}),
    )
    student_sex = forms.ChoiceField(
        choices=[('男', '男'), ('女', '女')],
        label="学生性别",
        widget=forms.Select(attrs={'class': 'form-control'}),
    )
    relationship = forms.ChoiceField(
        choices=[('老师', '老师'), ('父亲', '父亲'), ('母亲', '母亲')],
        label="与学生的关系",
        widget=forms.Select(attrs={'class': 'form-control'}),
    )
    teacher_or_parent = forms.CharField(
        max_length=100,
        label="您的账号",
        widget=forms.TextInput(attrs={'class': 'form-control', 'placeholder': '请输入用户名...'}),
    )
    teacher_or_parent_name = forms.CharField(
        max_length=100,
        label="您的姓名",
        widget=forms.TextInput(attrs={'class': 'form-control', 'placeholder': '请输入您的姓名...'}),
    )
    teacher_or_parent_phone = forms.CharField(
        max_length=20,
        label="您的手机号",
        widget=forms.TextInput(attrs={'class': 'form-control', 'placeholder': '请输入您的手机号...'}),
    )
    student_image = forms.ImageField(
        label="学生照片",
        widget=forms.ClearableFileInput(attrs={'class': 'form-control'}),
        required=False,
    )

    class Meta:
        model = ConnectStudentTeacher
        fields = [
            'student_name', 'student_phone', 'student_sex', 'relationship','teacher_or_parent',
            'teacher_or_parent_name', 'teacher_or_parent_phone', 'student_image'
        ]
        widgets = {
            'student_name': forms.TextInput(attrs={'class': 'form-control', 'placeholder': '请输入学生姓名'}),
            'student_phone': forms.TextInput(attrs={'class': 'form-control', 'placeholder': '请输入学生手机号'}),
            'student_sex': forms.Select(attrs={'class': 'form-control'}),
            'relationship': forms.Select(attrs={'class': 'form-control'}),
            'teacher_or_parent': forms.TextInput(attrs={'class': 'form-control', 'placeholder': '请输入学生姓名'}),
            'teacher_or_parent_name': forms.TextInput(attrs={'class': 'form-control', 'placeholder': '请输入您的姓名'}),
            'teacher_or_parent_phone': forms.TextInput(attrs={'class': 'form-control', 'placeholder': '请输入您的手机号'}),
            'student_image': forms.ClearableFileInput(attrs={'class': 'form-control'}),
        }

    def clean(self):
        cleaned_data = super().clean()

        # 验证学生账号和密码
        student_account = cleaned_data.get('student_account')
        student_password = cleaned_data.get('student_password')

        try:
            user = User.objects.get(username=student_account)
        except User.DoesNotExist:
            self.add_error('student_account', "学生账号不存在。")
            return cleaned_data

        if not authenticate(username=student_account, password=student_password):
            self.add_error('student_password', "学生账号或密码错误。")

            # 验证手机号格式
        student_phone = cleaned_data.get('student_phone')
        if student_phone and not student_phone.isdigit():
            self.add_error('student_phone', "学生手机号必须是数字。")

        teacher_or_parent_phone = cleaned_data.get('teacher_or_parent_phone')
        if teacher_or_parent_phone and not teacher_or_parent_phone.isdigit():
            self.add_error('teacher_or_parent_phone', "您的手机号必须是数字。")

        return cleaned_data

    def save(self, commit=True):
        """
        自定义保存逻辑，处理非模型字段 student_account 和 student_password。
        """
        # print('进入保存')
        instance = super().save(commit=False)

        student_account = self.cleaned_data.get('student_account')
        teacher_or_parent_profile = self.cleaned_data.get('teacher_or_parent')
        instance.teacher_or_parent = teacher_or_parent_profile
        try:
            user = User.objects.get(username=student_account)
            profile = user.profile  # 假设 Profile 使用 OneToOneField 关联到 User
            instance.student = profile
        except User.DoesNotExist:
            raise forms.ValidationError("无法找到对应的学生账号。")

        # 保存模型实例
        if commit:
            instance.save()

        return instance

    def clean_teacher_or_parent(self):
        teacher_or_parent_input = self.cleaned_data.get('teacher_or_parent')
        try:
            # 根据用户名查找 Profile 对象
            profile = Profile.objects.get(user__username=teacher_or_parent_input)
        except Profile.DoesNotExist:
            raise forms.ValidationError("未找到对应的用户账号，请检查用户名是否正确。")

        return profile  # 返回 Profile 对象

# class ConnectStudentCameraForm(forms.ModelForm):
#
