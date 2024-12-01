from django.shortcuts import render, redirect
from .models import Artwork
import socket
from django.contrib.auth.decorators import login_required
import base64
from django.core.files.base import ContentFile
from django.http import JsonResponse
from .models import Drawing
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.models import User
import os
from AI_analyse.models import Draw_Video
from django.core.files import File
from django.conf import settings
import json
from .models import ChatMessage
from qianfan.resources import Image2Text, ChatCompletion
from zhipuai import ZhipuAI
from login.models import Profile
from django.core.paginator import Paginator
from .forms import DrawingForm
from ai_draw.settings import MODEL_PATH, DETECT_PATH
import subprocess
from threading import Thread

def run_detection_script(video_path, model_path, save_name, user):
    print('----------------------------------------------------已启动分析脚本----------------------------------------------------')
    subprocess.run([
        'python', DETECT_PATH,
        '--video', video_path,
        '--model', model_path,
        '--save', save_name,
    ], check=True)
    folder_dir = settings.MEDIA_ROOT + '/yolo_output/result'
    mp3_save_name = save_name + '.mp3'
    txt_save_name = save_name + '.txt'
    result_dir = os.path.join(folder_dir, txt_save_name)
    with open(result_dir, 'r', encoding='utf-8') as f:
        content = f.read()
    Draw_Video.objects.create(user=user, ai_analyse_result=content, video_file=f'/video_chunks/{mp3_save_name}')

@csrf_exempt
def save_video_chunk(request):
    if request.method == 'POST':
        user_id = request.POST.get('user_id')
        file = request.FILES.get('video_chunk')
        if file and user_id:
            # 确保用户存在
            try:
                user = User.objects.get(id=user_id)
            except User.DoesNotExist:
                return JsonResponse({"message": "User not found"}, status=404)
            # 确保视频文件夹存在
            video_folder = os.path.join(settings.MEDIA_ROOT, 'video_chunks')
            os.makedirs(video_folder, exist_ok=True)

            # 获取用户已有的视频数量，作为文件编号
            user_videos_count = Draw_Video.objects.filter(user=user).count()  # 获取用户已有的视频数量
            video_number = user_videos_count + 1  # 下一个视频编号

            # 保存每个视频块，形成一个文件
            file_name = f'{user.username}_{video_number}.mp3'
            file_path = os.path.join(video_folder, file_name)

            with open(file_path, 'wb') as f:
                for chunk in file.chunks():
                    f.write(chunk)

            # Draw_Video.objects.create(user=user, video_file=f'/video_chunks/{user.username}_{video_number}.mp3')
            # print('视频文件已保存')

            # 启动一个新线程来执行检测任务
            save_name = f'{user.username}_{video_number}'
            detection_thread = Thread(target=run_detection_script, args=(file_path, MODEL_PATH, save_name, user))
            detection_thread.start()

            return JsonResponse({"message": "Chunk saved"}, status=200)

        return JsonResponse({"message": "No chunk or user_id received"}, status=400)
    return JsonResponse({"message": "Invalid request"}, status=400)

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

def draw_main_views(request):
    return render(request, 'draw/draw_main.html')

def artwork_gallery(request, category='original'):
    # 查询指定分类的画作
    artworks = Artwork.objects.filter(category=category)

    # 检测是否为 AJAX 请求
    if request.headers.get('x-requested-with') == 'XMLHttpRequest':
        return render(request, 'draw/partial_artwork_gallery.html', {'artworks': artworks, 'category': category})
    else:
        # 如果是普通请求（非 AJAX），渲染整个页面
        return render(request, 'draw/draw_main.html', {
            'artworks': artworks,
            'category': category
        })

@login_required  # 只有登录用户才能访问此视图
def draw_banner_views(request):
    user = request.user
    user_id = user.id
    local_ip = get_local_ip()
    ws_url = f"ws://{local_ip}:8080"  # 包含端口号的完整 WebSocket 地址前缀
    context = {
        'ws_url': ws_url,
        'user_id': user_id,
    }
    return render(request, 'draw/draw_banner.html', context)

@login_required
def save_drawing_view(request):
    if request.method == 'POST':
        data = request.POST
        image_data = data.get('image_data')  # 接收前端传来的 base64 图片数据
        name = data.get('name', '未命名')
        feedback = data.get('feedback', '')

        # 将 base64 图像数据解码为图片文件
        format, imgstr = image_data.split(';base64,')
        ext = format.split('/')[-1]
        image = ContentFile(base64.b64decode(imgstr), name=f"{name}.{ext}")

        # 保存到数据库
        drawing = Drawing.objects.create(
            user=request.user,
            name=name,
            image=image,
            feedback=feedback
        )

        return JsonResponse({"status": "success", "message": "作品保存成功"})
    return JsonResponse({"status": "failed", "message": "只接受 POST 请求"})

def save_drawing(request):
    if request.method == 'POST':
        image_data = request.POST.get('image_data')
        name = request.POST.get('name')
        feedback = request.POST.get('feedback')

        if not request.user.is_authenticated:
            return JsonResponse({"status": "error", "message": "用户未登录"})

        # 处理图像数据并保存
        format, imgstr = image_data.split(';base64,')
        ext = format.split('/')[-1]
        data = ContentFile(base64.b64decode(imgstr), name=f"{name or 'drawing'}.{ext}")

        # 保存到数据库
        drawing = Drawing(user=request.user, name=name, feedback=feedback)
        drawing.image.save(f"{name or 'drawing'}.{ext}", data, save=True)

        return JsonResponse({"status": "success", "message": "绘画已保存"})
    return JsonResponse({"status": "error", "message": "无效请求"})


os.environ["QIANFAN_AK"] = "WmeIlBRs999NpxqExDlIE8qc"
os.environ["QIANFAN_SK"] = "GC6qLeCBtTMBntYq86MIE4eShB8jAomu"

client = ZhipuAI(api_key="ed32a2eb7a646aca09f226be7bf59eab.hOS38Uyn8FjwUJPx")
@csrf_exempt  # 测试用，确保生产环境中 CSRF 设置正确
def ai_chat_view(request):
    if request.method == 'POST':
        try:
            # 使用 JSON 解码请求数据
            data = json.loads(request.body)
            message = data.get('message')
            message_type = data.get('message_type')

            chat_comp = ChatCompletion()
            ai_response = "未生成AI回复"  # 设置一个默认值

            # 根据消息类型生成 AI 响应
            if message_type == 'text':
                response = client.chat.completions.create(
                    model="glm-4-flash",
                    messages=[
                        {
                            "role": "system",
                            "content": "请用温柔的语气"
                        },
                        {
                            "role": "user",
                            "content": message
                        }
                    ],
                    top_p=0.7,
                    temperature=0.35,
                    max_tokens=1024,
                    tools=[{"type": "web_search", "web_search": {"search_result": True}}],
                    stream=True
                )
                story = ''
                for trunk in response:
                    print(trunk.choices[0].delta.content, end='')
                    story += trunk.choices[0].delta.content
                    ai_response=story
            elif message_type == 'image':
                image_data = data.get('image')
                if image_data:
                    encoded_image = image_data.split(',')[1]
                    i2t = Image2Text(model="Fuyu-8B")
                    ai_response = i2t.do(prompt="请帮我表述图片内容", image=encoded_image)["result"]
                else:
                    return JsonResponse({"status": "error", "message": "图片数据缺失"})
            else:
                return JsonResponse({"status": "error", "message": "不支持的消息类型"})

            # 将响应存储到数据库
            ChatMessage.objects.create(
                user=request.user,
                message_type=message_type,
                content=message or "图片",
                ai_response=ai_response
            )

            return JsonResponse({"status": "success", "user_message": message, "ai_response": ai_response})

        except json.JSONDecodeError:
            return JsonResponse({"status": "error", "message": "请求数据格式错误"})
        except Exception as e:
            return JsonResponse({"status": "error", "message": str(e)})
    else:
        return JsonResponse({"status": "error", "message": "仅支持 POST 请求"})


# client = ZhipuAI(api_key="ed32a2eb7a646aca09f226be7bf59eab.hOS38Uyn8FjwUJPx")
# 设置 API 凭证
os.environ["QIANFAN_AK"] = "WmeIlBRs999NpxqExDlIE8qc"
os.environ["QIANFAN_SK"] = "GC6qLeCBtTMBntYq86MIE4eShB8jAomu"


@csrf_exempt  # 测试环境下使用，确保生产环境的 CSRF 安全
def generate_story(request):
    if request.method == 'POST':
        try:
            # 解析 JSON 数据
            data = json.loads(request.body)
            image_data = data.get('image_data')  # 从前端获取 base64 图片数据

            if not image_data:
                return JsonResponse({"status": "error", "message": "图片数据缺失"})

            # 使用 Fuyu-8B 识别图片内容
            i2t = Image2Text(model="Fuyu-8B")
            image_content = i2t.do(prompt="请描述图片内容", image=image_data.split(',')[1])["result"]

            # 使用 Yi-34B-Chat 生成基于图片内容的故事
            # chat_comp = ChatCompletion()
            # story_response = chat_comp.do(
            #     model="Yi-34B-Chat",
            #     messages=[{"role": "user", "content": f"根据以下描述生成一个故事：{image_content}"}]
            # )
            # story = story_response["body"].get('result', "抱歉，我无法生成故事")
            response = client.chat.completions.create(
                model="glm-4-flash",
                messages=[
                    {
                        "role": "system",
                        "content": "提供关于小孩画画内容的文本，生成一个200字左右的童话故事"
                    },
                    {
                        "role": "user",
                        "content": f"根据以下描述生成一个故事：{image_content}"
                    }
                ],
                top_p=0.7,
                temperature=0.35,
                max_tokens=1024,
                tools=[{"type": "web_search", "web_search": {"search_result": True}}],
                stream=True
            )
            story=''
            for trunk in response:
                print(trunk.choices[0].delta.content, end='')
                story+=trunk.choices[0].delta.content
            return JsonResponse({"status": "success", "story": story})

        except json.JSONDecodeError:
            return JsonResponse({"status": "error", "message": "请求数据格式错误"})
        except Exception as e:
            return JsonResponse({"status": "error", "message": str(e)})

    return JsonResponse({"status": "error", "message": "仅支持 POST 请求"})

@login_required
def draw_history_user_view(request):
    user = request.user
    full_account = user.username
    short_account = full_account[:4] + '****'
    display_name = full_account[:5]

    query = request.GET.get('q')  # 获取搜索关键词
    if query:
        # 如果有搜索关键词，根据画作名称或留言信息模糊查询
        artworks_list = Drawing.objects.filter(
            user=user
        ).filter(name__icontains=query) | Drawing.objects.filter(
            user=user
        ).filter(feedback__icontains=query)
    else:
        # 默认加载所有画作，并添加排序
        artworks_list = Drawing.objects.filter(user=user).order_by('-created_at')

    # 打印 artworks_list 查看是否有数据
    print("artworks_list:", artworks_list)

    # 使用 Paginator 进行分页
    paginator = Paginator(artworks_list, 6)
    page_number = request.GET.get('page')  # 获取当前页码
    page_obj = paginator.get_page(page_number)

    context = {
        'display': display_name,
        'short_account': short_account,
        'full_account': full_account,
        'page_obj': page_obj,  # 分页对象
        'query': query,
    }
    return render(request, 'draw/draw_history.html', context)

@login_required
def upload_drawing(request):
    if request.method == "POST":
        # 获取表单数据
        name = request.POST.get('name', '未命名')  # 如果名称为空，设置为“未命名”
        feedback = request.POST.get('feedback', '')  # 留言默认设置为空字符串
        image = request.FILES.get('image')  # 获取上传的文件

        # 检查是否上传了文件
        if not image:
            return redirect('history')  # 如果未选择文件，返回历史页面

        # 保存到数据库
        drawing = Drawing.objects.create(
            user=request.user,
            name=name,
            feedback=feedback,
            image=image
        )
        return redirect('history')  # 上传成功后跳转到历史页面

    return redirect('history')  # 如果请求不是 POST，直接返回历史页面
