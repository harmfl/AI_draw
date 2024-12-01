# login/urls.py

from django.urls import path
from .views import login_view, register_view, home_view
"""
超级管理员：http://127.0.0.1:8000/admin
登录页面：http://127.0.0.1:8000/accounts/login/
注册页面：http://127.0.0.1:8000/accounts/register/
"""
urlpatterns = [
    path('login/', login_view, name='login'),        # 登录页面的 URL
    path('register/', register_view, name='register'), # 注册页面的 URL
    path('home/', home_view, name='home'),
    # path('ai_chat/', ai_chat_view, name='ai_chat_view')
]
