from django.core.paginator import Paginator
from django.shortcuts import render, get_object_or_404
from .models import DrawingWarehouse

def drawing_list(request):
    # 获取所有画作的信息并排序
    drawings = DrawingWarehouse.objects.all().order_by('DrawingID')

    # 搜索功能
    query_name = request.GET.get('name', '').strip()
    query_author = request.GET.get('author', '').strip()
    query_tag = request.GET.get('tag', '').strip()
    query_year = request.GET.get('year', '').strip()

    if query_name:
        drawings = drawings.filter(DrawingName__icontains=query_name)
    if query_author:
        drawings = drawings.filter(feekback__icontains=query_author)
    if query_tag:
        drawings = drawings.filter(DrawingTag=query_tag)
    if query_year:
        drawings = drawings.filter(DrawingYear__icontains=query_year)

        # 获取 DrawingTag 的所有选择项
    tag_choices = DrawingWarehouse.DrawTagChoice

    # 分页功能，每页12个画作
    paginator = Paginator(drawings, 12)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    # 用户信息
    user = request.user
    full_account = user.username if user.is_authenticated else "游客"
    short_account = full_account[:4] + '****'
    display_name = full_account[:4]

    context = {
        'display': display_name,
        'short_account': short_account,
        'full_account': full_account,
        'page_obj': page_obj,
        'tag_choices': tag_choices,  # 将品类选项传递到模板
    }

    # 渲染模板
    return render(request, 'AppreciationOfDrawing/AppreciationOfDrawing.html', context)

def drawing_detail(request, drawing_id):
    drawing = get_object_or_404(DrawingWarehouse, pk=drawing_id)
    drawing.views += 1
    drawing.save()
    return render(request, 'AppreciationOfDrawing/drawing_detail.html', {'drawing': drawing})

#
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
from django.shortcuts import get_object_or_404
from .models import DrawingWarehouse

@csrf_exempt
def update_count(request, action, drawing_id):
    if request.method == 'POST':
        drawing = get_object_or_404(DrawingWarehouse, pk=drawing_id)

        # 动态更新字段
        if action == 'likes':
            drawing.likes += 1
            drawing.save()
            return JsonResponse({'success': True, 'count': drawing.likes})
        elif action == 'views':
            drawing.views += 1
            drawing.save()
            return JsonResponse({'success': True, 'count': drawing.views})
        # 其他的动作类型处理...
        else:
            return JsonResponse({'success': False, 'error': 'Invalid action'})

    return JsonResponse({'success': False, 'error': 'Invalid request method'}, status=400)

from django.views.decorators.csrf import csrf_protect
from django.contrib.auth.decorators import login_required
from django.shortcuts import get_object_or_404
from django.http import JsonResponse
from .models import DrawingWarehouse, MyLike

@csrf_protect
@login_required(login_url='/accounts/login/')
def toggle_favorite(request, drawing_id):
    if request.method == 'POST':
        drawing = get_object_or_404(DrawingWarehouse, pk=drawing_id)
        user = request.user

        # 检查是否已经收藏
        existing_like = MyLike.objects.filter(user=user, drawing=drawing).first()
        if existing_like:
            # 如果已经收藏，执行取消收藏操作
            existing_like.delete()
            message = "已取消收藏"
        else:
            # 如果未收藏，添加到收藏
            MyLike.objects.create(user=user, drawing=drawing)
            message = "收藏成功"

        return JsonResponse({'success': True, 'message': message})

    return JsonResponse({'success': False, 'error': 'Invalid request method'}, status=400)

from django.contrib.auth.decorators import login_required
from django.http import JsonResponse
from .models import MyLike

@login_required(login_url='/accounts/login/')
def user_favorites(request):
    user = request.user
    favorite_drawings = MyLike.objects.filter(user=user).select_related('drawing')
    data = [
        {
            'id': like.drawing.DrawingID,
            'name': like.drawing.DrawingName,
            'picture_url': like.drawing.DrawingPicture.url,
            'likes': like.drawing.likes,
            'views': like.drawing.views,
        }
        for like in favorite_drawings
    ]
    return JsonResponse({'success': True, 'favorites': data})

from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
from django.http import JsonResponse
from .models import DrawingWarehouse, MyLike
import pandas as pd


import random
# 'picture_url': DrawingWarehouse.objects.get(DrawingID=row.DrawingID).DrawingPicture.url

def recommend_drawings_ml(request):
    # 获取所有画作
    drawings = DrawingWarehouse.objects.all()
    df = pd.DataFrame(list(drawings.values('DrawingID', 'DrawingName', 'DrawingTag', 'DrawingYear')))

    if df.empty:
        return JsonResponse({'success': False, 'message': '没有可推荐的画作'})

    # 为特征处理引入随机性
    random.seed(random.randint(1, 100000))
    df['DrawingYear'] = df['DrawingYear'].fillna('未知')
    df['combined_features'] = df['DrawingTag'] + ' ' + df['DrawingYear']

    # 使用TF-IDF计算特征向量
    vectorizer = TfidfVectorizer()
    feature_matrix = vectorizer.fit_transform(df['combined_features'])
    cosine_sim = cosine_similarity(feature_matrix, feature_matrix)

    user = request.user if request.user.is_authenticated else None
    if user:
        liked_drawings = MyLike.objects.filter(user=user).values_list('drawing_id', flat=True)
        if liked_drawings:
            liked_indices = df[df['DrawingID'].isin(liked_drawings)].index.tolist()
            recommendation_scores = cosine_sim[liked_indices].sum(axis=0)
            recommended_indices = recommendation_scores.argsort()[::-1]
            recommended_drawings = df.iloc[recommended_indices].drop_duplicates(subset='DrawingID').sample(12)
        else:
            recommended_drawings = df.sample(12).drop_duplicates(subset='DrawingID')
    else:
        recommended_drawings = df.sample(12).drop_duplicates(subset='DrawingID')

    data = [
        {
            'id': row.DrawingID,
            'name': row.DrawingName,
            'tag': row.DrawingTag,
            'year': row.DrawingYear,
            'picture_url': DrawingWarehouse.objects.get(DrawingID=row.DrawingID).DrawingPicture.url,
            'views': DrawingWarehouse.objects.get(DrawingID=row.DrawingID).views,
            'likes': DrawingWarehouse.objects.get(DrawingID=row.DrawingID).likes,
        }
        for _, row in recommended_drawings.iterrows()
    ]
    print("推荐的画作数据：", data)  # 打印调试信息
    return JsonResponse({'success': True, 'recommendations': data})


# # 随机取 12 件
#


from surprise import Dataset, Reader, SVD
from surprise.model_selection import train_test_split
import pandas as pd

def collaborative_filtering_recommendations(request):
    # Step 1: 构建用户-画作行为矩阵
    likes = MyLike.objects.all()
    data = pd.DataFrame(list(likes.values('user_id', 'drawing_id')))
    if data.empty:
        return JsonResponse({'success': False, 'message': '没有用户行为数据'})

    # 添加评分列，默认评分为 1
    data['rating'] = 1

    # Step 2: 使用 Surprise 数据集格式
    reader = Reader(rating_scale=(1, 1))  # 收藏的作品评分为 1
    dataset = Dataset.load_from_df(data[['user_id', 'drawing_id', 'rating']], reader)
    trainset = dataset.build_full_trainset()

    # Step 3: 训练协同过滤模型
    algo = SVD()
    algo.fit(trainset)

    # Step 4: 为当前用户推荐画作
    user_id = request.user.id if request.user.is_authenticated else None
    if user_id:
        all_drawings = DrawingWarehouse.objects.all().values_list('DrawingID', flat=True)
        recommendations = [
            (drawing, algo.predict(user_id, drawing).est)
            for drawing in all_drawings
        ]
        # 按预测评分排序
        recommendations.sort(key=lambda x: x[1], reverse=True)
        # recommendations = recommendations[:10]
        recommendations = recommendations[:12]  # 返回前12个推荐
        # 构造返回数据
        data = [
            {'id': rec[0], 'predicted_rating': rec[1]}
            for rec in recommendations
        ]
        return JsonResponse({'success': True, 'recommendations': data})

    # 未登录用户返回错误消息
    return JsonResponse({'success': False, 'message': '用户未登录'})



def hybrid_recommendations(request):
    content_based_data = recommend_drawings_ml(request).content
    collaborative_data = collaborative_filtering_recommendations(request).content

    import json
    content_recommendations = json.loads(content_based_data).get('recommendations', [])
    collaborative_recommendations = json.loads(collaborative_data).get('recommendations', [])

    # 去重并合并两种推荐结果
    hybrid_results = {rec['id']: rec for rec in content_recommendations + collaborative_recommendations}

    # 截取前12个推荐
    sorted_results = list(hybrid_results.values())[:12]

    return JsonResponse({'success': True, 'recommendations': sorted_results})


import os
import json
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from qianfan.resources import Image2Text
from zhipuai import ZhipuAI

# 设置 ZhipuAI 客户端
client = ZhipuAI(api_key="ed32a2eb7a646aca09f226be7bf59eab.hOS38Uyn8FjwUJPx")

# 设置 Qianfan API 凭证
os.environ["QIANFAN_AK"] = "WmeIlBRs999NpxqExDlIE8qc"
os.environ["QIANFAN_SK"] = "GC6qLeCBtTMBntYq86MIE4eShB8jAomu"

@csrf_exempt
def generate_story(request):
    if request.method == 'POST':
        try:
            # 解析请求中的 JSON 数据
            data = json.loads(request.body)
            image_data = data.get('image_data')
            drawing_id = data.get('drawing_id')  # 从前端获取画作 ID

            if not image_data or not drawing_id:
                return JsonResponse({"status": "error", "message": "图片数据或画作 ID 缺失"}, status=400)

            # 获取画作详细信息
            drawing = DrawingWarehouse.objects.get(DrawingID=drawing_id)

            # 使用 Fuyu-8B 识别图片内容
            i2t = Image2Text(model="Fuyu-8B")
            result = i2t.do(prompt="请描述图片内容", image=image_data.split(',')[1])

            if not result.get("result"):
                return JsonResponse({"status": "error", "message": "图片内容识别失败"}, status=500)

            image_content = result["result"]

            # 使用 ZhipuAI 生成基于图片内容的描述
            response = client.chat.completions.create(
                model="glm-4-flash",
                messages=[
                    {"role": "system", "content": "以专业的艺术评论风格"},
                    {"role": "user", "content": f"这些是画作的基本信息,画作名字：{drawing.DrawingName}，画作大小：{drawing.DrawingSize}，画作年份：{drawing.DrawingYear}，画作类型：{drawing.DrawingTag},大致内容：{image_content}，请你介绍一下这个画作"}
                ],
                top_p=0.7,
                temperature=0.35,
                max_tokens=1024,
                tools=[{"type": "web_search", "web_search": {"search_result": True}}],
                stream=True
            )

            story = ""

            for trunk in response:
                print(trunk.choices[0].delta.content, end='')
                story += trunk.choices[0].delta.content

            # 返回画作详细信息和生成的故事
            return JsonResponse({
                "status": "success",
                "story": story,
                "drawing_details": {
                    "name": drawing.DrawingName,
                    "size": drawing.DrawingSize,
                    "year": drawing.DrawingYear,
                    "tag": drawing.DrawingTag,
                    "story":story,
                }
            })

        except DrawingWarehouse.DoesNotExist:
            return JsonResponse({"status": "error", "message": "画作不存在"}, status=404)

        except Exception as e:
            return JsonResponse({"status": "error", "message": str(e)}, status=500)

    return JsonResponse({"status": "error", "message": "仅支持 POST 请求"}, status=405)

