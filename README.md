

<!-- PROJECT SHIELDS -->



<!-- [![Version](https://img.shields.io/badge/version-v1.0.0-blue)](https://github.com/harmfl/AI_draw/releases) -->
<!-- [![Build Status](https://travis-ci.org/QingdaoU/OnlineJudge.svg?branch=master)](https://travis-ci.org/QingdaoU/OnlineJudge) -->
<!-- [![Forks][forks-shield]][forks-url] -->
<!-- [![Stargazers][stars-shield]][stars-url] -->
<!-- [![Issues][issues-shield]][issues-url] -->

<!-- [![LinkedIn][linkedin-shield]][linkedin-url] -->

<!-- PROJECT LOGO -->
<br />

<p align="center">
  <!-- <a href="https://github.com/harmfl/AI_draw/blob/master/AI_analyse/static/logo2.jpg"> -->
    <!-- <img src="images/logo.png" alt="Logo" width="80" height="80"> -->
  <!-- </a> -->

<h1 align="center">童心绘语</h1>
<p align="center">
  一个基于大模型技术的智能儿童绘画分析与故事生成陪伴系统
  <br>
    <a href="https://www.python.org/downloads/release/python-362/">
    <img src="https://img.shields.io/badge/python-3.8.0-blue.svg?style=flat-square" alt="Python 3.8.0" />
  </a>
  <a href="https://www.djangoproject.com/">
    <img src="https://img.shields.io/badge/django-3.2.9-blue.svg?style=flat-square" alt="Django 3.2.9" />
  </a>
  <a href="https://github.com/harmfl/AI_draw/blob/master/LICENSE">
    <img src="https://img.shields.io/badge/License-MIT-green" alt="MIT License" />
  </a>
  <br>
  <a href="https://github.com/WLtao5023/ai_draw1"><strong>探索本项目的文档</strong></a>
  <br />
  <!-- 插入徽章 -->
  <br />



 ## 目录

- [概览](#概览)
- [docker配置](#docker配置)
- [运行截图](#运行截图)

<br>

## 概览

“童心绘语”是一个基于大模型技术的智能儿童绘画分析与故事生成陪伴系统，旨在通过创新的AI技术为儿童提供一个富有创意、教育性和心理关怀的数字化成长平台。

系统的核心功能包括：
- **智能绘画分析**：利用YOLO11算法对儿童绘画过程中的情感和表情进行分析，实时监测孩子的心理状态。
- **个性化故事生成**：基于儿童的绘画作品，系统会生成个性化的故事，结合Fuyu-8B和微调后的glm-4-flash模型讲述故事，增强孩子的情感认知与理解。
- **家长端实时监控**：家长可以实时查看孩子的绘画作品、情感分析报告以及创作时长，及时掌握孩子的情绪变化和心理发展。
- **绘画成长反馈**：通过创作时长和情感状态的监控，帮助家长合理安排孩子的创作活动，防止长时间绘画带来的视力问题。

“童心绘语”不仅是一个艺术创作工具，更是一个多维度的儿童成长平台，通过绘画、情感分析、故事生成等功能，全面促进儿童的心理健康、语言能力和创意思维发展。

<br>

## python环境配置

### 部署前准备：
1. 配置Anaconda，mysql，cuda等常用python和机器学习环境。
2. 获取GLM-4-Flash的api，获取Fuyu-8B对应的api。

### 开始部署：

4.打开Anaconda Prompt运行下面的指令

（1）创建环境
```sh
conda create -n your_envirment python==3.8
```
(2)激活环境
```sh
conda activate your_envirment
```
(3)到下载项目对应的地址上
```sh
cd your_path
```
5.下载所需要的包
```sh
pip install -r requirement.txt
```
6.打开项目的ai_draw文件夹
配置settings
### 设置为mysql登录
```sh
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql', # 设置为 MySQL
        'NAME': 'ai_draw',                    # 数据库名称
        'USER': 'root',                       # 数据库用户名
        'PASSWORD': 'root',                   # 数据库密码
        'HOST': 'localhost',                  # 数据库主机，通常是 localhost
        'PORT': '3306',                       # 数据库端口，MySQL 默认是 3306
    }
}
```
7.执行迁移指令
（1）生成迁移表
```sh
python manage.py makemigrations
```
（2）执行迁移命令
```sh
python manage.py migrate
```
8.打开终端执行命令启动项目
```sh
 daphne -b 0.0.0.0 -p 8080 ai_draw.asgi:application  
```

<br>

## 运行截图

![首页](https://github.com/user-attachments/assets/6c79dd7d-da78-4238-a2ca-48381bb782c4)
![登录页](https://github.com/user-attachments/assets/81b6e09b-fbdf-4ca2-a7bb-e5734ed2e5e2)
![注册页](https://github.com/user-attachments/assets/87c8293d-3f82-415b-80ca-1d5086e90265)
![绘画](https://github.com/user-attachments/assets/1b712553-7cb1-4392-829c-b734b48c38a8)
![AI对话](https://github.com/user-attachments/assets/abdd6749-9a17-49a2-bd3b-5eefc7bf7eb0)
![历史画作](https://github.com/user-attachments/assets/aca6d97a-e6df-4cd0-a50e-520f5b1e0c49)
![名画鉴赏](https://github.com/user-attachments/assets/307aeb2a-7f71-45df-82a6-d6b7ed54ccde)
![名画鉴赏AI分析](https://github.com/user-attachments/assets/1011d281-a759-4c3f-8988-daca19b5946c)
![账号关联](https://github.com/user-attachments/assets/78714803-fef6-4442-af66-6062c7351473)
![管理关联](https://github.com/user-attachments/assets/b3ce7361-680a-4619-b863-3ceb8a6dc2fa)
![查看学生画作](https://github.com/user-attachments/assets/5074cace-60b7-49d6-88f0-f99cef8a88ab)
![摄像头页面](https://github.com/user-attachments/assets/01e6d308-298c-4baa-8fc7-9a83dff26152)
![绘画状态分析](https://github.com/user-attachments/assets/df38b638-688a-457f-a17e-81422296f73a)