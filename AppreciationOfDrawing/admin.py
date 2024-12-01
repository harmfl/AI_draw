from django.contrib import admin
from .models import DrawingWarehouse

@admin.register(DrawingWarehouse)
class DrawingWarehouseAdmin(admin.ModelAdmin):
    """
    画作仓库管理界面配置。
    """
    list_display = ('DrawingID', 'DrawingName', 'DrawingTag', 'DrawingYear', 'likes', 'views')  # 列表中显示的字段
    list_filter = ('DrawingTag', 'DrawingYear')  # 侧边筛选器
    search_fields = ('DrawingName', 'DrawingTag')  # 搜索框
    ordering = ('-views', 'DrawingID')  # 排序方式
