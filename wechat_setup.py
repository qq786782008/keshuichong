#!/usr/bin/env python3
"""
企业微信机器人集成脚本 - 使用提供的webhook URL
"""

import requests
import json
import time
from datetime import datetime

class WeChatWorkBot:
    def __init__(self, webhook_url):
        self.webhook_url = webhook_url
        self.session = requests.Session()
    
    def send_message(self, message, mentioned_list=None):
        """发送文本消息"""
        try:
            data = {
                "msgtype": "text",
                "text": {
                    "content": message,
                    "mentioned_list": mentioned_list or []
                }
            }
            response = self.session.post(self.webhook_url, json=data, timeout=10)
            return response.json()
        except Exception as e:
            print(f"发送企业微信消息失败: {e}")
            return {"errcode": -1, "errmsg": str(e)}
    
    def send_markdown(self, content):
        """发送Markdown消息"""
        try:
            data = {
                "msgtype": "markdown",
                "markdown": {"content": content}
            }
            response = self.session.post(self.webhook_url, json=data, timeout=10)
            return response.json()
        except Exception as e:
            print(f"发送Markdown消息失败: {e}")
            return {"errcode": -1, "errmsg": str(e)}

def test_wechat_work_connection():
    """测试企业微信连接"""
    webhook_url = "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=2453f995-49b0-44c7-a38e-0397fdea5d2d"
    
    bot = WeChatWorkBot(webhook_url)
    
    # 发送测试消息
    test_message = f"""
🤖 OpenClaw 企业微信集成测试

⏰ 时间: {datetime.now().strftime('%Y-%m-%d %H:%M:%S UTC')}
📢 类型: 连接测试
✅ 状态: 成功连接

OpenClaw已准备就绪，可以开始处理您的消息！
"""
    
    result = bot.send_markdown(test_message)
    
    if result.get("errcode") == 0:
        print("✅ 企业微信连接成功！")
        print(f"📋 响应: {result}")
        return True
    else:
        print(f"❌ 企业微信连接失败: {result}")
        return False

def setup_wechat_work_integration():
    """设置企业微信集成"""
    print("🚀 开始配置企业微信集成...")
    
    # 测试连接
    if not test_wechat_work_connection():
        return False
    
    # 创建OpenClaw集成脚本
    integration_script = """#!/bin/bash
# OpenClaw企业微信消息转发脚本

WEBHOOK_URL="https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=2453f995-49b0-44c7-a38e-0397fdea5d2d"
MESSAGE="$1"

if [ -z "$MESSAGE" ]; then
    echo "Usage: $0 \"message content\""
    echo "Example: $0 \"Hello from OpenClaw!\""
    exit 1
fi

curl -X POST "$WEBHOOK_URL" \\
    -H "Content-Type: application/json" \\
    -d '{
        "msgtype": "text",
        "text": {
            "content": "'"$MESSAGE"'"
        }
    }' \\
    -s

echo "消息已发送到企业微信"
"""
    
    script_path = "/home/codespace/.openclaw/workspace/wechat_forward.sh"
    with open(script_path, "w") as f:
        f.write(integration_script)
    
    os.chmod(script_path, 0o755)
    
    print("✅ 企业微信集成配置完成！")
    print(f"📄 脚本位置: {script_path}")
    print("💡 使用方法:")
    print(f"   {script_path} \"您的消息\"")
    
    # 测试转发脚本
    print("\\n🧪 测试消息转发脚本...")
    import subprocess
    try:
        result = subprocess.run([script_path, "测试消息来自OpenClaw"], 
                              capture_output=True, text=True, timeout=10)
        if result.returncode == 0:
            print("✅ 转发脚本测试成功！")
        else:
            print(f"⚠️ 转发脚本测试: {result.stderr}")
    except Exception as e:
        print(f"❌ 转发脚本测试失败: {e}")
    
    return True

def send_welcome_message():
    """发送欢迎消息"""
    webhook_url = "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=2453f995-49b0-44c7-a38e-0397fdea5d2d"
    bot = WeChatWorkBot(webhook_url)
    
    welcome_message = f"""
🎉 OpenClaw企业微信集成成功！

🤖 集成状态: 已成功连接
⏰ 时间: {datetime.now().strftime('%Y-%m-%d %H:%M:%S UTC')}
📋 功能: 
  - 支持文本消息发送
  - 支持Markdown格式
  - 消息转发功能已启用

📞 联系方式: 通过OpenClaw助手
🚀 使用方法: 直接向OpenClaw发送消息，将自动转发到企业微信

现在您可以开始使用OpenClaw的企业微信集成功能了！
"""
    
    result = bot.send_message(welcome_message)
    return result.get("errcode") == 0

if __name__ == "__main__":
    import os
    
    # 设置成功后发送欢迎消息
    if setup_wechat_work_integration():
        print("\\n🎊 正在发送欢迎消息...")
        if send_welcome_message():
            print("✅ 欢迎消息发送成功！")
        else:
            print("⚠️ 欢迎消息发送失败，但集成配置已完成")
    else:
        print("❌ 企业微信集成配置失败")