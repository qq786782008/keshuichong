#!/usr/bin/env python3
"""
演示企业微信集成功能
"""

from openclaw_wechat_bridge import OpenClawWeChatBridge
import datetime

def demonstrate_features():
    """演示所有功能"""
    bridge = OpenClawWeChatBridge()
    
    print("🎬 开始企业微信集成功能演示...")
    
    # 1. 简单文本消息
    print("\n1️⃣ 发送简单文本消息")
    success1 = bridge.send_openclaw_message("🎯 这是简单文本消息演示")
    
    # 2. 详细消息
    print("\n2️⃣ 发送详细消息")
    detailed_msg = """
📊 OpenClaw企业微信集成演示

✅ 功能特性:
  - 文本消息发送
  - 自动时间戳
  - 格式化显示
  - 错误处理

🚀 使用方法:
  python3 openclaw_wechat_bridge.py "您的消息"

⏰ 演示时间: {}
""".format(datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S UTC'))
    
    success2 = bridge.send_openclaw_message(detailed_msg)
    
    # 3. Markdown消息
    print("\n3️⃣ 发送Markdown格式消息")
    success3 = bridge.send_markdown_message(
        "🎉 OpenClaw集成演示",
        """
成功配置了企业微信集成！

**功能特点**:
- ✅ 即时消息发送
- ✅ 支持Markdown格式
- ✅ 自动添加时间戳
- ✅ 完整错误处理

**使用场景**:
- 工作汇报
- 团队通知
- 系统状态更新
- 自动化消息推送

**技术实现**:
- 企业微信Webhook API
- Python脚本集成
- Shell命令支持
- OpenClaw桥接系统
"""
    )
    
    # 4. 状态总结
    print("\n📊 演示结果汇总:")
    print(f"   简单文本消息: {'✅ 成功' if success1 else '❌ 失败'}")
    print(f"   详细消息:     {'✅ 成功' if success2 else '❌ 失败'}")
    print(f"   Markdown消息:  {'✅ 成功' if success3 else '❌ 失败'}")
    
    if success1 and success2 and success3:
        print("\n🎉 所有演示都成功了！企业微信集成完全正常工作！")
        return True
    else:
        print("\n⚠️ 部分演示失败，请检查网络连接和企业微信配置")
        return False

if __name__ == "__main__":
    demonstrate_features()