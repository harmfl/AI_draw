# login/urls.py

from django.urls import path
from .views import *
urlpatterns = [
    path('',draw_main_views,name='draw_main'),
    path('draw_banner/', draw_banner_views, name='draw_banner'),
    path('save_video_chunk/', save_video_chunk, name='save_video_chunk'),
    path('draw_main/', draw_main_views, name='draw_main'),
    path('gallery/<str:category>/', artwork_gallery, name='artwork_gallery'),
    path('save_drawing/', save_drawing, name='save_drawing'),
    # path('ai_chat/', ai_chat_view, name='ai_chat'),  # 确保只有一个 /ai_chat/ 路由
    path('ai_chat/', ai_chat_view, name='ai_chat_view'),
    path('generate_story/', generate_story, name='generate_story'),
    path('history/', draw_history_user_view, name='history'),  # 用户历史页面
    # path('search_history/', drawing_history, name='drawing-history'),  # 搜索页面
    path('upload_drawing/', upload_drawing, name='upload_drawing'),
]
