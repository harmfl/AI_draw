import edge_tts
import os

cwd = os.path.dirname(__file__)

TEXT = "Hello World!"
VOICE = "en-GB-SoniaNeural"
OUTPUT_FILE = cwd + "\\test.mp3"

# 同步的运行函数
def main():
    communicate = edge_tts.Communicate(TEXT, VOICE)
    with open(OUTPUT_FILE, "wb") as file:
        for chunk in communicate.stream_sync():
            if chunk["type"] == "audio":
                file.write(chunk["data"])
            # elif chunk["type"] == "WordBoundary":
            #     print(f"WordBoundary: {chunk}")


if __name__ == "__main__":
    main()
