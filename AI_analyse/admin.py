from django.contrib import admin
from .models import ConnectStudentTeacher, Draw_Video

@admin.register(ConnectStudentTeacher)
class ConnectStudentTeacherAdmin(admin.ModelAdmin):
    # 在列表视图中显示的字段
    list_display = (
        'student_name',
        'student_phone',
        'student_sex',
        'relationship',
        'teacher_or_parent_name',
        'teacher_or_parent_phone',
        'connect_time',
    )
    # 可搜索字段
    search_fields = ('student_name', 'student_phone', 'teacher_or_parent_name', 'teacher_or_parent_phone')
    # 可过滤字段
    list_filter = ('student_sex', 'relationship', 'connect_time')
    # 编辑时的字段显示顺序
    fieldsets = (
        ('学生信息', {
            'fields': ('student', 'student_name', 'student_phone', 'student_sex', 'student_image'),
        }),
        ('关系信息', {
            'fields': ('relationship',),
        }),
        ('教师/家长信息', {
            'fields': ('teacher_or_parent', 'teacher_or_parent_name', 'teacher_or_parent_phone'),
        }),

    )

@admin.register(Draw_Video)
class DrawVideoAdmin(admin.ModelAdmin):
    list_display = ('user', 'created_at', 'ai_analyse_result')  # 显示用户和创建时间
    search_fields = ('user__username',)  # 支持按用户名搜索
    list_filter = ('user', 'video_file', 'ai_analyse_result')  # 按创建时间过滤
    readonly_fields = ('created_at',)

