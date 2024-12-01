import cv2
import base64
import torch
from channels.generic.websocket import AsyncWebsocketConsumer
from channels.layers import get_channel_layer
import asyncio

connected_students = {}

class RemoteStreamConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        print('接收到连接')
        self.client_type = self.scope['url_route']['kwargs']['client_type']
        self.student_id = self.scope['url_route']['kwargs'].get('student_id')

        if self.client_type == "camera_group" and self.student_id:
            connected_students[self.student_id] = self.channel_name
            await self.channel_layer.group_add(f"camera_group_{self.student_id}", self.channel_name)
            print(f"学生摄像头已连接: 学生ID {self.student_id}")

        elif self.client_type == "frontend" and self.student_id:
            await self.channel_layer.group_add(f"camera_group_{self.student_id}", self.channel_name)
            print(f"教师端已连接: 查看学生ID {self.student_id}")

        await self.accept()

    async def disconnect(self, close_code):
        if self.client_type == "camera_group" and self.student_id:
            if self.student_id in connected_students:
                del connected_students[self.student_id]
            await self.channel_layer.group_discard(f"camera_group_{self.student_id}", self.channel_name)
            print(f"学生摄像头已断开连接: 学生ID {self.student_id}")

            # 处理教师端的断开连接
        elif self.client_type == "frontend" and self.student_id:
            await self.channel_layer.group_discard(f"camera_group_{self.student_id}", self.channel_name)
            print(f"教师端已断开连接: 查看学生ID {self.student_id}")

    async def receive(self, text_data=None, bytes_data=None):
        # if self.client_type == "camera_group" and text_data:
        #     # 处理来自学生摄像头的视频帧数据
        #     await self.channel_layer.group_send(
        #         f"camera_group_{self.student_id}",
        #         {
        #             "type": "send_video_frame",
        #             "text": text_data,
        #         }
        #     )
        if self.client_type == "camera_group" and bytes_data:
            # 处理来自学生摄像头的二进制视频帧数据
            await self.channel_layer.group_send(
                f"camera_group_{self.student_id}",
                {
                    "type": "send_video_frame",
                    "bytes": bytes_data,
                }
            )

    async def send_video_frame(self, event):
        # 将视频帧发送给教师端
        # text_data = event["text"]
        # await self.send(text_data=text_data)
        bytes_data = event.get("bytes")
        if bytes_data:
            await self.send(bytes_data=bytes_data)
