from django.shortcuts import render
from .forms import ConnectStudentTeacherForm
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from .models import ConnectStudentTeacher, Profile, Draw_Video
from draw_banner.models import Drawing
from django.contrib.auth.decorators import login_required
import socket
from django.template import loader
from django.http import HttpResponse, JsonResponse
import json
from django.contrib.auth.models import User

def get_local_ip():
    """获取服务器的局域网IP地址"""
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    try:
        # 连接到外部服务器（不实际发送数据），以获取局域网IP
        s.connect(("8.8.8.8", 80))
        ip = s.getsockname()[0]
    except Exception:
        ip = "127.0.0.1"
    finally:
        s.close()
    return ip

def connect_account(request):
    if request.method == 'POST':
        form = ConnectStudentTeacherForm(request.POST, request.FILES)
        if form.is_valid():
            form.save(commit=True)
            messages.success(request, "关联成功，可以继续关联其他学生")
            # return redirect('connect_account')  # 可选：重定向到当前页面
        else:
            messages.error(request, "关联失败，请检查输入内容。")
            print(form.errors)  # 打印错误信息以便调试
    else:
        form = ConnectStudentTeacherForm()

    user = request.user
    full_account = user.username
    display_name = full_account[:5]
    context = {
        'form': form,  # 确保将表单传递到模板中
        'display': display_name,
    }
    return render(request, 'html/connect.html', context)

@login_required
def connect_master(request):
    user = request.user
    students = []
    try:
        profile = user.profile
        # print(ConnectStudentTeacher.objects.all())  # 查看 ConnectStudentTeacher 表中的所有记录
        students = ConnectStudentTeacher.objects.filter(teacher_or_parent=profile)
    except AttributeError:
        profile = None

    if request.method == 'POST' and profile:
        # 获取要删除的学生记录 ID
        student_id = request.POST.get('delete_student')
        if student_id:
            # 获取关联的学生记录，并确保属于当前用户
            student_record = get_object_or_404(ConnectStudentTeacher, id=student_id, teacher_or_parent=profile)
            student_record.delete()
            messages.success(request, "学生记录已删除。")
            return redirect('connect_manager')  # 重定向到管理页面

    user = request.user
    full_account = user.username
    display_name = full_account[:5]
    context = {
        'students': students,  # 传递学生记录到模板
        'display':display_name,
    }
    return render(request, 'html/connect_manage.html', context)


def view_painting_history(request):
    user = request.user
    full_account = user.username
    display_name = full_account[:5]
    # 获取当前用户的 Profile
    profile = get_object_or_404(Profile, user=user)

    # 获取用户关联的学生列表
    students = ConnectStudentTeacher.objects.filter(teacher_or_parent=profile)
    selected_student = None
    artworks_list = None
    if request.method == 'POST':
        # 处理学生选择
        student_id = request.POST.get('student_id')
        if student_id:
            selected_student = get_object_or_404(ConnectStudentTeacher, id=student_id, teacher_or_parent=profile)
            # messages.success(request, f"已选择学生：{selected_student.student_name}")

    if selected_student:
        artworks_list = Drawing.objects.filter(user=selected_student.student.user).order_by('-created_at')

    context = {
        'display': display_name,
        'students': students,  # 所有关联的学生
        'selected_student': selected_student,  # 选中的学生
        'artworks_list': artworks_list,  # 全部画作列表
    }

    return render(request, 'html/view_patinting.html', context)

def camera_page(request):
    user = request.user
    full_account = user.username
    display_name = full_account[:5]

    profile = get_object_or_404(Profile, user=user)
    students = ConnectStudentTeacher.objects.filter(teacher_or_parent=profile)

    context = {
        'display': display_name,
        'students': students,  # 所有关联的学生
    }

    return render(request, 'html/camera_page.html', context)

def camera_page_post(request):
    if request.method == 'POST':
        user = request.user
        profile = get_object_or_404(Profile, user=user)
        local_ip = get_local_ip()# 处理学生选择
        ws_url_base = f"ws://{local_ip}:8080/ws/remote-stream/frontend"
        data = json.loads(request.body)
        student_id = data.get('student_id')
        if student_id:
            selected_student = get_object_or_404(ConnectStudentTeacher, id=student_id, teacher_or_parent=profile)
            student_id = selected_student.student.re_id()
            # selected_student_ws_url = f"{ws_url_base}/{selected_student_id}/"
            selected_student_ws_url = f"{ws_url_base}/{student_id}/"
            print(selected_student_ws_url)

            context = {
                # 'student_id': selected_student_id,
                'student_id':student_id,
                'selected_student_ws_url': selected_student_ws_url,
            }
            return JsonResponse(context)

def ai_analyse_camera(request):
    user = request.user
    full_account = user.username
    display_name = full_account[:5]
    # 获取当前用户的 Profile
    profile = get_object_or_404(Profile, user=user)

    # 获取用户关联的学生列表
    students = ConnectStudentTeacher.objects.filter(teacher_or_parent=profile)

    context = {
        'display': display_name,
        'students': students,  # 所有关联的学生
    }

    return render(request, 'html/ai_analyse_page.html', context)

def ai_analyse_camera_post(request):
    user = request.user
    full_account = user.username
    display_name = full_account[:5]
    selected_student = None
    camera_list = None
    if request.method == 'POST':
        user = request.user
        # 获取当前用户的 Profile
        profile = get_object_or_404(Profile, user=user)
        students = ConnectStudentTeacher.objects.filter(teacher_or_parent=profile)
        # 处理学生选择
        student_id = request.POST.get('student_id')
        if student_id:
            selected_student = get_object_or_404(ConnectStudentTeacher, id=student_id, teacher_or_parent=profile)
            # messages.success(request, f"已选择学生：{selected_student.student_name}")

        if selected_student:
            camera_list = Draw_Video.objects.filter(user=selected_student.student.user).order_by('-created_at')

        context = {
            'display': display_name,
            'selected_student': selected_student,  # 选中的学生
            'camera_list': camera_list,
            'students': students,
        }

        return render(request, 'html/ai_analyse_page.html', context)

# def AI_analyse_main(request):
#     user = request.user
#     full_account = user.username
#     display_name = full_account[:5]
#     context = {
#         'display': display_name,
#     }
#     return render(request, 'html/index.html',context)
