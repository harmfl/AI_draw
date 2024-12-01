from django.urls import path
from . import views

urlpatterns = [
    # 列表视图
    path('drawings/', views.drawing_list, name='drawing_list'),
    # 详细视图
    path('drawing/<int:drawing_id>/', views.drawing_detail, name='drawing_detail'),
    # 点赞视图
    path('update_count/<str:action>/<int:drawing_id>/', views.update_count, name='update_count'),
    # 收藏视图
    path('toggle_favorite/<int:drawing_id>/', views.toggle_favorite, name='toggle_favorite'),
    path('user_favorites/', views.user_favorites, name='user_favorites'),
    path('recommendations/', views.hybrid_recommendations, name='recommendations'),
    path('collaborative_filtering/', views.collaborative_filtering_recommendations, name='collaborative_filtering'),
    path('hybrid_recommendations/',views.hybrid_recommendations,name='hybrid_recommendations'),
    path('generate_story/', views.generate_story, name='generate_story'),
]
