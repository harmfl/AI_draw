from django.contrib import admin
from .models import Profile
from django.contrib.auth.models import User

class ProfileAdmin(admin.ModelAdmin):
    list_display = ('username', 'password', 'user_type_display')  # 显示用户名、密码和身份
    search_fields = ('user__username',)  # 添加搜索功能
    list_filter = ('user_type',)  # 添加筛选功能

    # 自定义显示用户名和密码字段
    def username(self, obj):
        return obj.user.username
    username.short_description = '用户名'

    def password(self, obj):
        return obj.user.password
    password.short_description = '密码'

    def user_type_display(self, obj):
        return obj.get_user_type_display()
    user_type_display.short_description = '身份'


admin.site.register(Profile, ProfileAdmin)
