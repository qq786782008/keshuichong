#!/usr/bin/env python3
"""
企业微信机器人集成脚本
用于将OpenClaw与企业微信连接
"""

import requests
import json
import time
from datetime import datetime
import os

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
    # 这里需要您提供企业微信的webhook URL
    webhook_url = os.getenv("WECHAT_WORK_WEBHOOK_URL")
    
    if not webhook_url:
        print("错误: 请设置环境变量 WECHAT_WORK_WEBHOOK_URL")
        print("格式: https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=YOUR_KEY")
        return False
    
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

def forward_openclaw_to_wechat():
    """转发OpenClaw消息到企业微信"""
    # 这里可以实现消息转发逻辑
    pass

def setup_wechat_work_integration():
    """设置企业微信集成"""
    print("🚀 开始配置企业微信集成...")
    
    # 1. 检查环境变量
    webhook_url = os.getenv("WECHAT_WORK_WEBHOOK_URL")
    if not webhook_url:
        print("❌ 请先设置企业微信Webhook URL")
        print("   export WECHAT_WORK_WEBHOOK_URL='https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=YOUR_KEY'")
        return False
    
    # 2. 测试连接
    if not test_wechat_work_connection():
        return False
    
    # 3. 创建OpenClaw集成脚本
    integration_script = """
#!/bin/bash
# OpenClaw企业微信消息转发脚本

WEBHOOK_URL="$WECHAT_WORK_WEBHOOK_URL"
MESSAGE="$1"

if [ -z "$MESSAGE" ]; then
    echo "Usage: $0 \"message content\""
    exit 1
fi

curl -X POST "$WEBHOOK_URL" \\
    -H "Content-Type: application/json" \\
    -d '{
        "msgtype": "text",
        "text": {
            "content": "'"$MESSAGE"'"
        }
    }'
"""
    
    script_path = "/home/codespace/.openclaw/workspace/wechat_forward.sh"
    with open(script_path, "w") as f:
        f.write(integration_script)
    
    os.chmod(script_path, 0o755)
    
    print("✅ 企业微信集成配置完成！")
    print(f"📄 脚本位置: {script_path}")
    print("💡 使用方法:")
    print(f"   {script_path} \"您的消息\"")
    
    return True

if __name__ == "__main__":
    setup_wechat_work_integration()