#!/usr/bin/env python3
"""
测试企业微信双向通信
"""

import requests
import json

# 企业微信Webhook URL
WEBHOOK_URL = "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=2453f995-49b0-44c7-a38e-0397fdea5d2d"

def send_test_message():
    """发送测试消息"""
    test_message = {
        "msgtype": "text",
        "text": {
            "content": """🔄 企业微信双向通信测试

📱 此消息可以发送到企业微信
🤖 现在需要配置企业微信 → OpenClaw 的反向通信

⏰ 测试时间: 2026-02-12 13:40 UTC
🎯 目标: 实现双向通信

💡 下一步:
1. 在企业微信管理后台配置Webhook
2. 设置GitHub Actions接收消息
3. 实现OpenClaw自动回复

✅ 单向通信: 已完成
❌ 双向通信: 配置中"""
        }
    }
    
    try:
        response = requests.post(WEBHOOK_URL, json=test_message, timeout=10)
        if response.status_code == 200:
            result = response.json()
            if result.get('errcode') == 0:
                print("✅ 测试消息发送成功！")
                return True
            else:
                print(f"❌ 消息发送失败: {result.get('errmsg')}")
                return False
        else:
            print(f"❌ HTTP请求失败: {response.status_code}")
            return False
    except Exception as e:
        print(f"❌ 发送异常: {e}")
        return False

if __name__ == "__main__":
    print("🧪 企业微信双向通信测试...")
    send_test_message()