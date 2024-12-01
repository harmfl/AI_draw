# login/urls.py

from django.urls import path
# from .views import login_view, register_view, home_view
from .views import *
from AI_analyse.utils import *
from django.conf import settings
from django.conf.urls.static import static
"""
超级管理员：http://127.0.0.1:8000/admin
登录页面：http://127.0.0.1:8000/accounts/login/
注册页面：http://127.0.0.1:8000/accounts/register/
"""
urlpatterns = [
    # path('login/', login_view, name='login'),        # 登录页面的 URL
    # path('register/', register_view, name='register'), # 注册页面的 URL
    # path('home/', home_view, name='home'),
    # path('ai_chat/', ai_chat_view, name='ai_chat_view')
    # path('',AI_analyse_main,name='AI_analyse_main'),
    path('11/', connect_account, name='connect_account'),
    path('connect_manage/', connect_master, name='connect_manager'),
    path('view_painting', view_painting_history, name='view_painting_history'),
    path('camera_record', camera_page, name='camera_record'),
    path('camera_record_post', camera_page_post, name='camera_record_post'),
    path('ai_analyse_camera', ai_analyse_camera, name='ai_analyse_camera'),
    path('ai_analyse_camera/post', ai_analyse_camera_post, name='ai_analyse_camera_post'),
    # path('dashboard/',AI_analyse_main, name='index'),
    path('', role_required(['teacher', 'parent'])(connect_account), name='ai_analyse_home'),
]

if settings.DEBUG:
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
