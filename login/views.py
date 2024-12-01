from django.shortcuts import render

from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login
from django.contrib.auth import login
from .forms import LoginForm, UserRegisterForm
from django.contrib import messages
from .models import Profile
# Create your views here.


# 注册视图
def register_view(request):
    if request.method == 'POST':
        form = UserRegisterForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, '注册成功，请登录。')
            return redirect('login')
        else:
            messages.error(request, '请检查表单中的错误并重新提交。')
    else:
        form = UserRegisterForm()
    return render(request, 'login/register.html', {'form': form})


# 自定义登录视图，用于处理用户登录请求
from django.shortcuts import render, redirect
from .forms import LoginForm

def login_view(request):
    if request.method == 'POST':
        form = LoginForm(request.POST)
        if form.is_valid():
            username = form.cleaned_data.get('username')
            password = form.cleaned_data.get('password')
            identity = form.cleaned_data.get('identity')  # 获取身份字段
            user = authenticate(request, username=username, password=password)
            # 如果用户存在且密码正确
            if user is not None:
                # 根据用户的身份验证
                if hasattr(user, 'profile'):
                    user_identity = user.profile.user_type
                    if user_identity == identity:
                        login(request, user)
                        # messages.success(request, '登录成功！')
                        return redirect('draw_main')
                    else:
                        messages.error(request, '身份验证失败，请选择正确的身份。')
            else:
                # 如果用户名或密码不正确，向用户显示错误信息
                messages.error(request, '用户名或密码不正确，请重新尝试。')
        else:
            messages.error(request, '用户名或密码不正确，请重新尝试。')
            return redirect('login')
    else:
        form = LoginForm()

    return render(request, 'login/login.html', {'form': form})

def home_view(request):
    return render(request, 'login/home.html')