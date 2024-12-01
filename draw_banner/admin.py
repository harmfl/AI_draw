from django.contrib import admin

# Register your models here.
from .models import Artwork

class ArtworkAdmin(admin.ModelAdmin):
    list_display = ('title', 'author', 'category', 'views', 'likes')  # 在列表视图中显示的字段
    search_fields = ('title', 'author')  # 添加搜索功能，支持按标题和作者搜索
    list_filter = ('category',)  # 添加过滤器，按分类筛选
    ordering = ('-views',)  # 默认按查看数倒序排列

admin.site.register(Artwork, ArtworkAdmin)
from .models import Drawing,ChatMessage  # 更新为新的模型名

# 注册模型以便在 Django 管理后台中查看和管理
admin.site.register(Drawing)
admin.site.register(ChatMessage)
