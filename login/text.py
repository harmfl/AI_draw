# import requests
# import json
#
# API_KEY = ""
# SECRET_KEY = ""
#
#
# def main():
#     url = "https://aip.baidubce.com/rest/2.0/image-classify/v1/image-understanding/get-result?access_token=" + get_access_token()
#
#     payload = json.dumps("")
#     headers = {
#         'Content-Type': 'application/json'
#     }
#
#     response = requests.request("POST", url, headers=headers, data=payload)
#
#     print(response.text)
#
#
# def get_access_token():
#     """
#     使用 AK，SK 生成鉴权签名（Access Token）
#     :return: access_token，或是None(如果错误)
#     """
#     url = "https://aip.baidubce.com/oauth/2.0/token"
#     params = {"grant_type": "client_credentials", "client_id": 'CCLIKBXlMzN3IffBs29cH9Uh', "client_secret": 'A9rid5OpJuhBdArV6g11IekH0hhTadvL'}
#     return str(requests.post(url, params=params).json().get("access_token"))
#
#
# if __name__ == '__main__':
#     main()
#
#
#
#


# encoding:utf-8

# encoding:utf-8
#
# import requests
#
# '''
# 图像识别组合API
# '''
#
# request_url = "https://aip.baidubce.com/api/v1/solution/direct/imagerecognition/combination"
#
# params = r"{\"imgUrl\":\"https://preview.qiantucdn.com/58pic/70/95/81/74V58PICJrJtaBJXy9n4z_origin_PIC2018.jpg!qt_w320\",\"scenes\":[\"animal\",\"plant\",\"ingredient\",\"dishs\", \"red_wine\",\"currency\",\"landmark\"]}"
# access_token = '25.2d5fd584acf03421bc5b00e1f757b032.315360000.2045644893.282335-116057883'
# request_url = request_url + "?access_token=" + access_token
# headers = {'content-type': 'application/json'}
# response = requests.post(request_url, data=params, headers=headers)
# if response:
#     print (response.json())



# # encoding:utf-8
# import requests
#
# # client_id 为官网获取的AK， client_secret 为官网获取的SK
# host = 'https://aip.baidubce.com/oauth/2.0/token?grant_type=client_credentials&client_id=CCLIKBXlMzN3IffBs29cH9Uh&client_secret=A9rid5OpJuhBdArV6g11IekH0hhTadvL'
# response = requests.get(host)
# if response:
#     print(response.json())

# import requests
# import json
#
# API_KEY = "CCLIKBXlMzN3IffBs29cH9Uh"
# SECRET_KEY = "A9rid5OpJuhBdArV6g11IekH0hhTadvL"
#
#
# def main():
#     url = "https://aip.baidubce.com/rest/2.0/image-classify/v1/image-understanding/request?access_token=" + get_access_token()
#
#     payload = json.dumps("")
#     headers = {
#         'Content-Type': 'application/json'
#     }
#
#     response = requests.request("POST", url, headers=headers, data=payload)
#
#     print(response.text)
#
#
# def get_access_token():
#     """
#     使用 AK，SK 生成鉴权签名（Access Token）
#     :return: access_token，或是None(如果错误)
#     """
#     url = "https://aip.baidubce.com/oauth/2.0/token"
#     params = {"grant_type": "client_credentials", "client_id": API_KEY, "client_secret": SECRET_KEY}
#     return str(requests.post(url, params=params).json().get("access_token"))
#
#
# if __name__ == '__main__':
#     main()


# 安装包(Python >= 3.7)：pip install qianfan
import os
import qianfan
import base64
from qianfan.resources import Image2Text
os.environ["QIANFAN_AK"] = "WmeIlBRs999NpxqExDlIE8qc"
os.environ["QIANFAN_SK"] = "GC6qLeCBtTMBntYq86MIE4eShB8jAomu"

#【推荐】建议您在生产环境使用IAM认证鉴权，文档地址 https://cloud.baidu.com/doc/Reference/s/9jwvz2egb
# os.environ["QIANFAN_ACCESS_KEY"] = "your_iam_ak"
# os.environ["QIANFAN_SECRET_KEY"] = "your_iam_sk"

# chat_comp = qianfan.ChatCompletion()
#
# # 指定特定模型
# resp = chat_comp.do(model="Yi-34B-Chat", messages=[{
#     "role": "user",
#     "content": "can you tell me a story"
# }])
#
# print(resp["body"]['result'])



# 请替换图片对应的路径地址
# with open(r"F:\ai_draw\draw_banner\templates\draw\img\shouhuituyaertongjiechahua-27029356_1.jpg", "rb") as image_file:
#     encoded_string = base64.b64encode(image_file.read()).decode()
#
# # 使用model参数
# i2t = Image2Text(model="Fuyu-8B")
# resp = i2t.do(prompt="请帮我表述图片内容", image=encoded_string)
#
# print(resp["result"])
#
# chat_comp = qianfan.ChatCompletion()
#
# # 指定特定模型
# resp = chat_comp.do(model="Yi-34B-Chat", messages=[{
#     "role": "user",
#     "content": f'{resp["result"]} base on the context upon, tell me a story'
# }])
#
# print(resp["body"]['result'])
#
#
#
#
#
#
#
#
#
#
#
#
#
# # os.environ["QIANFAN_ACCESS_KEY"] = "your_iam_ak"
# # os.environ["QIANFAN_SECRET_KEY"] = "your_iam_sk"
#
#
#
# resp = qianfan.Text2Image().do(endpoint="sd_xl", messages=[], size="1024x1024", n=1, steps=20, sampler_index="Euler a", style="Anime", cfg_scale=5, refiner=True, prompt="一个蓝色头发女生")
# print(resp.body)



# https://www.bigmodel.cn/console/trialcenter?modelCode=glm-4-flash


# pip install zhipuai 请先在终端进行安装

from zhipuai import ZhipuAI

client = ZhipuAI(api_key="ed32a2eb7a646aca09f226be7bf59eab.hOS38Uyn8FjwUJPx")

response = client.chat.completions.create(
    model="glm-4-flash",
    messages=[
        {
            "role": "system",
            "content": "请用温柔的语气"
        },
        {
            "role": "user",
            "content": "帮我看看今天肇庆的天气"
        }
    ],
    top_p= 0.7,
    temperature= 0.35,
    max_tokens=1024,
    tools = [{"type":"web_search","web_search":{"search_result":True}}],
    stream=True
)
for trunk in response:
    print(trunk.choices[0].delta.content,end='')