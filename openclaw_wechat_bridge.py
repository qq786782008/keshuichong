#!/usr/bin/env python3
"""
OpenClaw企业微信消息集成器
用于将OpenClaw消息转发到企业微信
"""

import requests
import json
import sys
import os
from datetime import datetime

class OpenClawWeChatBridge:
    def __init__(self):
        self.webhook_url = "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=2453f995-49b0-44c7-a38e-0397fdea5d2d"
        self.session = requests.Session()
    
    def send_openclaw_message(self, message, user_name="OpenClaw助手"):
        """发送OpenClaw消息到企业微信"""
        try:
            # 格式化消息
            formatted_message = f"""
🤖 {user_name} ⚡

💬 消息内容:
{message}

⏰ 时间: {datetime.now().strftime('%Y-%m-%d %H:%M:%S UTC')}
📡 来源: OpenClaw集成系统
"""
            
            data = {
                "msgtype": "text",
                "text": {
                    "content": formatted_message
                }
            }
            
            response = self.session.post(self.webhook_url, json=data, timeout=10)
            result = response.json()
            
            if result.get("errcode") == 0:
                print("✅ 消息已发送到企业微信")
                return True
            else:
                print(f"❌ 消息发送失败: {result.get('errmsg')}")
                return False
                
        except Exception as e:
            print(f"❌ 发送异常: {e}")
            return False
    
    def send_markdown_message(self, title, content):
        """发送Markdown格式消息"""
        try:
            markdown_content = f"""### {title}
{content}

---
*🤖 OpenClaw企业微信集成 | {datetime.now().strftime('%Y-%m-%d %H:%M:%S UTC')}*"""
            
            data = {
                "msgtype": "markdown",
                "markdown": {"content": markdown_content}
            }
            
            response = self.session.post(self.webhook_url, json=data, timeout=10)
            result = response.json()
            
            return result.get("errcode") == 0
            
        except Exception as e:
            print(f"❌ Markdown发送异常: {e}")
            return False

def main():
    """主函数"""
    bridge = OpenClawWeChatBridge()
    
    if len(sys.argv) > 1:
        # 从命令行参数获取消息
        message = " ".join(sys.argv[1:])
        success = bridge.send_openclaw_message(message)
    else:
        # 测试模式
        test_message = """🎉 OpenClaw企业微信集成测试成功！

✅ 连接状态: 正常
📱 集成功能: 已启用
🚀 系统就绪: 可以开始使用

现在您可以通过OpenClaw向企业微信群发送消息了！"""
        
        success = bridge.send_markdown_message("OpenClaw集成测试", test_message)
    
    if success:
        print("🎊 企业微信消息发送成功！")
        sys.exit(0)
    else:
        print("❌ 企业微信消息发送失败")
        sys.exit(1)

if __name__ == "__main__":
    main()