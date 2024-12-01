import json
import os
import time
from ultralytics import YOLO
import cv2
import argparse
from zhipuai import ZhipuAI

current_directory = os.getcwd()
parent_directory = os.path.dirname(current_directory)
duration_dir = f'{current_directory}\\media\\yolo_output\\duration'
yolo_analyse_dir = f'{current_directory}\\media\\yolo_output\\yolo_analyse'
result_dir = f'{current_directory}\\media\\yolo_output\\result'

# 用于存储每个帧的输出信息
yolo_output_list = []

frame_duration = None  # 全局变量用于存储每帧的时间间隔

def detect(video_path, model_path, save_name):
    global frame_duration  # 使用全局变量

    # 加载模型
    model = YOLO(model_path)

    # 创建视频捕获对象
    cap = cv2.VideoCapture(video_path)
    if not cap.isOpened():
        print(f"无法打开视频文件：{video_path}")
        return

    frame_count = 0
    # fps = cap.get(cv2.CAP_PROP_FPS)
    fps = 40
    print('帧率：',fps)
    frame_duration = 1 / fps  # 每帧的时间间隔，单位为秒

    while True:
        ret, frame = cap.read()
        if not ret:
            break

        # 使用YOLO模型对当前帧进行推理
        results = model.predict(source=frame, save=False, show=False, exist_ok=True, verbose=False)

        # 保存YOLO输出信息
        for result in results:
            boxes = result.boxes  # 检测到的边界框信息
            for box in boxes:
                cls = box.cls.item()  # 类别索引
                conf = box.conf.item()  # 置信度
                label = model.names[int(cls)]  # 类别名称
                yolo_output_list.append({
                    "frame": frame_count,
                    "label": label,
                    "confidence": round(conf, 2)
                })

        frame_count += 1

    # 释放视频捕获对象
    cap.release()

    yolo_analyse_output_dir = f'{yolo_analyse_dir}\\{save_name}.json'

    # 保存YOLO输出结果到JSON文件
    with open(yolo_analyse_output_dir, "w") as json_file:
        json.dump(yolo_output_list, json_file, indent=4)

    print("已将yolo输出保存")

    return yolo_analyse_output_dir

def calculate_duration(yolo_analyse_output_dir, save_name):
    global frame_duration  # 使用全局变量

    # 读取YOLO输出结果
    with open(yolo_analyse_output_dir, "r") as json_file:
        yolo_output_list = json.load(json_file)

    # 用于存储每个类别的累计持续时间
    duration_dict = {}

    # 遍历所有帧的信息，计算每种类别的持续时间
    for entry in yolo_output_list:
        label = entry["label"]
        if label not in duration_dict:
            duration_dict[label] = 0.0
        duration_dict[label] += frame_duration

    # 打印每种类别的持续时间
    for label, duration in duration_dict.items():
        print(f"类别 '{label}' 的累计持续时间：{duration:.2f} 秒")

    duration_output_dir = f'{duration_dir}\\{save_name}.json'

    # 保存持续时间到JSON文件
    with open(duration_output_dir, "w") as json_file:
        json.dump(duration_dict, json_file, indent=4)

    print("已将yolo识别各类别时间保存")

    return duration_output_dir

def json_to_text(duration_output_dir, save_name):
    with open(duration_output_dir, "r") as json_file:
        data = json.load(json_file)

    emotion_mapping = {
        "sad": "开心",
        "happy": "惊喜",
        "fear": "恐惧",
        "anger": "愤怒",
        "surprise": "惊讶"
    }

    descriptions = []

    # 遍历每个表情及其对应的持续时间
    for emotion, duration in data.items():
        if duration >= 3:  # 仅当持续时间大于等于3秒时才进行描述
            emotion_name = emotion_mapping.get(emotion, emotion)  # 获取中文名称
            descriptions.append(f"{emotion_name}持续了{int(duration)}秒")

    client = ZhipuAI(api_key="ed32a2eb7a646aca09f226be7bf59eab.hOS38Uyn8FjwUJPx")

    response = client.chat.completions.create(
        model="glm-4-flash",
        messages=[
            {
                "role": "system",
                "content": "这是小孩在画画时的状态，根据文本写出100字左右的小孩的情绪分析和给家长的建议"
            },
            {
                "role": "user",
                "content": f"{descriptions}"
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
        # print(trunk.choices[0].delta.content, end='')
        story += trunk.choices[0].delta.content

    result_output_dir = f'{result_dir}\\{save_name}.txt'
    # 将描述写入txt文件
    with open(result_output_dir, 'w', encoding='utf-8') as f:
        for desc in story:
            f.write(desc)

    print('最终分析结果已生成')

def run(video_path, model_path, save_name):
    # 调用检测函数
    yolo_analyse_output_dir=detect(video_path=video_path, model_path=model_path, save_name=save_name)
    # 计算每种类别的持续时间
    duration_output_dir=calculate_duration(yolo_analyse_output_dir=yolo_analyse_output_dir,save_name=save_name)
    json_to_text(duration_output_dir=duration_output_dir,save_name=save_name)


if __name__ == "__main__":
    # 设置参数解析器
    parser = argparse.ArgumentParser(description="YOLO11 目标检测脚本")
    parser.add_argument('--video', type=str, required=True, help="需要检测的视频")
    parser.add_argument('--model', type=str, required=True, help="模型权重文件的路径")
    parser.add_argument('--save', type=str, required=True, help="输出文件保存的名字，拼凑路径")
    args = parser.parse_args()

    run(video_path=args.video, model_path=args.model, save_name=args.save)
