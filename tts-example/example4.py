import edge_tts
import os

cwd = os.path.dirname(__file__)

TEXT = "Hello World!"
VOICE = "en-GB-SoniaNeural"
OUTPUT_FILE = cwd + "\\test.mp3"

# 同步的运行函数(更直接的版本)
def main():
    communicate = edge_tts.Communicate(TEXT, VOICE)
    communicate.save_sync(OUTPUT_FILE)


if __name__ == "__main__":
    main()
# 我发现直接使用.save来存储音频文件的话很容易发生异步错误，所以最好还是用example3的方法来写入
