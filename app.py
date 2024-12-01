# app.py
from flask import Flask, request, jsonify
import asyncio
import edge_tts
import aiofiles
import os
import pygame
from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # 允许所有来源访问

cwd = os.path.dirname(__file__)
output_file = os.path.join(cwd, "test.mp3")


@app.route("/generate_audio", methods=["POST"])
async def generate_audio():
    data = request.get_json()
    text = data.get("text", "")
    if text:
        file_path = await generate_audio_file(text, output_file)
        return jsonify({"status": "success", "file_path": file_path})
    return jsonify({"status": "error", "message": "No text provided"}), 400



import time

async def generate_audio_file(text, file_path):
    # 使用时间戳生成唯一的文件名
    timestamped_file_path = file_path.replace(".mp3", f"_{int(time.time())}.mp3")
    voice = "zh-CN-XiaoxiaoNeural"
    communicate = edge_tts.Communicate(text, voice)
    async with aiofiles.open(timestamped_file_path, "wb") as f:
        async for chunk in communicate.stream():
            if chunk["type"] == "audio":
                await f.write(chunk["data"])

    # 返回生成的文件路径，以便在其他地方使用
    return timestamped_file_path



@app.route("/play_audio", methods=["POST"])
def play_audio():
    data = request.get_json()
    file_path = data.get("file_path")
    if not file_path:
        return jsonify({"status": "error", "message": "No file path provided"}), 400
    try:
        pygame.mixer.init()
        pygame.mixer.music.load(file_path)
        pygame.mixer.music.play()
        return jsonify({"status": "playing"})
    except Exception as e:
        print(f"Error playing audio: {e}")
        return jsonify({"status": "error", "message": str(e)}), 500



# 停止播放并释放文件资源的路由
@app.route("/stop_audio", methods=["GET"])
def stop_audio():
    try:
        pygame.mixer.music.stop()
        return jsonify({"status": "stopped"})
    except Exception as e:
        print(f"Error stopping audio: {e}")
        return jsonify({"status": "error", "message": str(e)}), 500


if __name__ == "__main__":
    app.run()
