import pygame
import os

cwd = os.path.dirname(__file__)
dir = cwd + '\\test.mp3'
# 使用音频文件进行输出
pygame.mixer.init()
pygame.mixer.music.load(dir)
pygame.mixer.music.play()
while pygame.mixer.music.get_busy():# 音乐播放时等待
    pygame.time.Clock().tick(10)    # 播放这段音频时每0.1秒检查一次音乐是否正在播放
