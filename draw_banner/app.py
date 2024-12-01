from flask import Flask, request, jsonify
import asyncio
import edge_tts
import os
import pygame

app = Flask(__name__)

cwd = os.path.dirname(__file__)
output_file = os.path.join(cwd, "test.mp3")

@app.route("/generate_audio", methods=["POST"])
async def generate_audio():
    data = request.get_json()
    text = data.get("text", "")
    if text:
        await generate_audio_file(text, output_file)
        return jsonify({"status": "success"})
    return jsonify({"status": "error", "message": "No text provided"}), 400

async def generate_audio_file(text, file_path):
    voice = "en-GB-SoniaNeural"
    communicate = edge_tts.Communicate(text, voice)
    async for chunk in communicate.stream():
        if chunk["type"] == "audio":
            with open(file_path, "wb") as f:
                f.write(chunk["data"])

@app.route("/play_audio", methods=["GET"])
def play_audio():
    pygame.mixer.init()
    pygame.mixer.music.load(output_file)
    pygame.mixer.music.play()
    return jsonify({"status": "playing"})

if __name__ == "__main__":
    app.run()
