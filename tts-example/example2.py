import asyncio
import edge_tts
import os

cwd = os.path.dirname(__file__)
asyncio.set_event_loop_policy(asyncio.WindowsProactorEventLoopPolicy())

TEXT = "Hello World!"
VOICE = "en-GB-SoniaNeural"
OUTPUT_FILE = cwd + '\\test.mp3'

# 更加简单直接的方式，
async def amain():
    communicate = edge_tts.Communicate(TEXT, VOICE)
    await communicate.save(OUTPUT_FILE)


if __name__ == "__main__":
    asyncio.run(amain())
