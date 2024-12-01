import asyncio
import edge_tts
import os

cwd = os.path.dirname(__file__)
asyncio.set_event_loop_policy(asyncio.WindowsProactorEventLoopPolicy())# 设置 Windows 专用的 Proactor 事件循环策略

TEXT = "Hello World!"         #要转换的文字
VOICE = "en-GB-SoniaNeural"   #用与转换的模型
OUTPUT_FILE = cwd + '\\test.mp3'        #生成的音频文件名


async def amain():# 使用异步函数
    communicate = edge_tts.Communicate(TEXT, VOICE)      # 生成音频对象
    with open(OUTPUT_FILE, "wb") as file:                # 开始创造mp3文件
        async for chunk in communicate.stream():         # communicate是异步生成器，所以用异步迭代器
            if chunk["type"] == "audio":                 # 存储音频数据到文件
                file.write(chunk["data"])                
            elif chunk["type"] == "WordBoundary":        # 输出数据块文本信息，可注释
                print(f"WordBoundary: {chunk}")


if __name__ == "__main__":
    asyncio.run(amain()) # 后台自动运行异步函数，但我发现直接用run很容易报错
    
    
    # 稳定的运行方法
    # loop = asyncio.get_event_loop()                     # 获取当前线程的事件循环核心，可以用这个对象来控制异步任务
    # loop.run_until_complete(amain())                    # 运行异步函数到完成为止，中途会阻塞主线程


