#!/usr/bin/env python3
"""
企业微信消息接收和转发到OpenClaw的服务
"""

from http.server import HTTPServer, BaseHTTPRequestHandler
import json
import requests
import urllib.parse
from datetime import datetime
import os

class OpenClawWeChatHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        """处理企业微信的消息回调"""
        try:
            # 获取消息内容
            content_length = int(self.headers['Content-Length'])
            post_data = self.rfile.read(content_length)
            message_data = json.loads(post_data.decode('utf-8'))
            
            # 解析企业微信消息
            self.handle_wechat_message(message_data)
            
            # 返回成功响应
            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.end_headers()
            response = {"code": 0, "msg": "success"}
            self.wfile.write(json.dumps(response).encode('utf-8'))
            
        except Exception as e:
            print(f"处理消息失败: {e}")
            self.send_response(500)
            self.end_headers()
    
    def handle_wechat_message(self, message_data):
        """处理企业微信消息并转发到OpenClaw"""
        try:
            # 解析企业微信消息格式
            if message_data.get('msgtype') == 'text':
                content = message_data.get('text', {}).get('content', '')
                sender = message_data.get('sender', {}).get('userid', 'Unknown')
                
                # 格式化消息
                openclaw_message = f"""
📱 企业微信消息

👤 发送者: {sender}
💬 内容: {content}
⏰ 时间: {datetime.now().strftime('%Y-%m-%d %H:%M:%S UTC')}

🤖 OpenClaw助手正在处理...
"""
                
                # 发送到OpenClaw（这里需要配置OpenClaw的接收方式）
                # 暂时打印到日志
                print(f"收到企业微信消息: {content} (来自: {sender})")
                
                # 如果OpenClaw有API接口，可以在这里调用
                # self.send_to_openclaw(openclaw_message)
                
        except Exception as e:
            print(f"处理消息时出错: {e}")
    
    def log_message(self, format, *args):
        """自定义日志格式"""
        print(f"[{datetime.now().strftime('%Y-%m-%d %H:%M:%S UTC')}] {format % args}")

def run_server(port=8080):
    """启动Webhook服务器"""
    server_address = ('', port)
    httpd = HTTPServer(server_address, OpenClawWeChatHandler)
    
    print(f"🚀 企业微信消息接收服务器启动")
    print(f"📡 监听端口: {port}")
    print(f"📱 等待企业微信消息...")
    print(f"⏰ 启动时间: {datetime.now().strftime('%Y-%m-%d %H:%M:%S UTC')}")
    
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print(f"\n🛑 服务器已停止")
        httpd.server_close()

if __name__ == '__main__':
    # 设置端口
    PORT = int(os.getenv('WECHAT_WEBHOOK_PORT', 8080))
    
    print("🎯 企业微信消息接收服务")
    print("=" * 50)
    
    run_server(PORT)