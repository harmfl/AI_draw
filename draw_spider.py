import requests
import json
class draw_spider():
    def __init__(self):
        #ip池url
        self.ip_url="https://share.proxy.qg.net/get?key=B8B3E205"
        self.ip=self.read_ip()
        # 导航url
        self.home_url='https://www.namoc.org/zgmsg/gczp/gczp.shtml'
        self.home_headers={
                            "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
                            "accept-encoding": "gzip, deflate, br, zstd",
                            "accept-language": "zh-CN,zh;q=0.9",
                            "cache-control": "max-age=0",
                            "connection": "keep-alive",
                            "cookie": "Hm_lvt_32806cb69e00ddaaf3847937c32700c8=1731981833; HMACCOUNT=27C8E300AB4A009A; arialoadData=false; Hm_lpvt_32806cb69e00ddaaf3847937c32700c8=1731985687",
                            "host": "www.namoc.org",
                            "referer": "https://www.namoc.org/zgmsg/lhh/gczp_list.shtml",
                            "sec-ch-ua": '"Google Chrome";v="131", "Chromium";v="131", "Not_A Brand";v="24"',
                            "sec-ch-ua-mobile": "?0",
                            "sec-ch-ua-platform": '"Windows"',
                            "sec-fetch-dest": "document",
                            "sec-fetch-mode": "navigate",
                            "sec-fetch-site": "same-origin",
                            "sec-fetch-user": "?1",
                            "upgrade-insecure-requests": "1",
                            "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"
                        }
    def get_ip(self):
        response=requests.get(url=self.ip_url)
        if response.status_code==200:
            print(response.text)
            with open('response_ip.json','w',encoding='utf-8') as file:
                json.dump(json.loads(response.text),file,ensure_ascii=False,indent=4)
        else:
            print('余额不足')

    def read_ip(self):
        try:
            # 打开文件
            with open('response_ip.json', 'r', encoding='utf-8') as file:
                file_content = file.read()  # 读取文件内容，转换为字符串

                # 如果文件内容为空，则获取新的IP
                if not file_content.strip():  # 判断文件内容是否为空或仅包含空白字符
                    return self.get_ip()

                # 将字符串解析为字典
                load_data = json.loads(file_content)
                proxy_ip = load_data['data'][0]['proxy_ip']
                proxies = {
                    "http": f"http://{proxy_ip}",
                    "https": f"http://{proxy_ip}"
                }

                # 验证代理
                if self.validate_proxy(proxies):
                    return proxies
                else:
                    return self.get_ip()

        except FileNotFoundError:
            return self.get_ip()

        except json.JSONDecodeError:
            return self.get_ip()

    def validate_proxy(self,proxy):
        test_url = "http://www.baidu.com"
        try:
            response = requests.get(test_url, proxies=proxy, timeout=5)
            if response.status_code == 200:
                print('该ip有效')
                return True
        except requests.exceptions.RequestException:
            return False
        return False
    def get_home_data(self):
        while True:
            try:
                url_data = requests.get(url=self.home_url, headers=self.home_headers, proxies=self.ip, timeout=10)
                if url_data.status_code == 200:
                    print(url_data.text)
                    break
            except (TimeoutError, requests.exceptions.ProxyError, requests.exceptions.ConnectTimeout):
                print("代理不可用，尝试获取新代理...")
                self.get_ip()
                self.read_ip()


        print(url_data.text)


if __name__ == '__main__':
    draw_spider=draw_spider()
    draw_spider.get_ip()
    draw_spider.get_home_data()

