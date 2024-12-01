"""ai_draw URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from django.conf.urls.static import static
from django.conf import settings

urlpatterns = [
    path('',include('draw_banner.urls')),
    path('admin/', admin.site.urls),
    path('accounts/', include('login.urls')),  # 包含 login 应用的 URL 路由
    path('draw/', include('draw_banner.urls')),  # 包含 draw_banner 应用的 URL 路由
    path('ai_analyse/',include('AI_analyse.urls')),
    path('Drawing/',include('AppreciationOfDrawing.urls')),
]

# 确保在开发环境中提供媒体文件访问路径
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)