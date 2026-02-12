#!/bin/bash
# 企业微信双向通信GitHub Actions配置脚本

echo "🔧 企业微信双向通信 - GitHub Actions配置向导"
echo "=============================================="

# 检查当前目录
if [ ! -d ".github" ]; then
    echo "❌ 错误：请在GitHub仓库根目录运行此脚本"
    exit 1
fi

echo "📋 配置步骤说明："
echo "1. 创建GitHub Personal Access Token"
echo "2. 配置企业微信Webhook"
echo "3. 设置GitHub仓库Secrets"
echo "4. 测试双向通信"
echo ""

# 第一步：获取GitHub Token
echo "🔑 第一步：创建GitHub Personal Access Token"
echo "============================================="
echo "请按以下步骤创建Token："
echo "1. 访问：https://github.com/settings/tokens"
echo "2. 点击 'Generate new token' → 'Generate new token (classic)'"
echo "3. 设置Token名称：'WeChat Integration'"
echo "4. 选择权限："
echo "   ✅ repo (Full control of private repositories)"
echo "   ✅ workflow (Update GitHub Action workflows)"
echo "5. 点击 'Generate token'"
echo "6. 复制生成的Token（只显示一次！）"
echo ""

read -p "请输入您的GitHub Personal Access Token: " GITHUB_TOKEN

if [ -z "$GITHUB_TOKEN" ]; then
    echo "❌ Token不能为空"
    exit 1
fi

# 验证Token
echo "🔍 验证GitHub Token..."
if curl -s -H "Authorization: token $GITHUB_TOKEN" \
   https://api.github.com/user | grep -q "login"; then
    echo "✅ GitHub Token验证成功"
    USERNAME=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
        https://api.github.com/user | grep '"login"' | cut -d'"' -f4)
    echo "👤 用户名: $USERNAME"
else
    echo "❌ GitHub Token验证失败，请检查Token是否正确"
    exit 1
fi

# 第二步：获取企业微信Webhook URL
echo ""
echo "📱 第二步：企业微信Webhook URL配置"
echo "====================================="
echo "请确保您已配置企业微信机器人的Webhook URL："
echo ""
echo "🌐 Webhook URL格式："
echo "https://api.github.com/repos/$USERNAME/keshuichong/dispatches"
echo ""
echo "📋 企业微信后台配置步骤："
echo "1. 登录企业微信管理后台"
echo "2. 进入'机器人' → '编辑'"
echo "3. 找到'Webhook URL'设置"
echo "4. 填入上面的URL"
echo "5. 设置'安全令牌'（可选，用于验证请求来源）"
echo "6. 保存配置"
echo ""

read -p "企业微信Webhook URL [直接回车跳过]: " WECHAT_WEBHOOK_URL

# 第三步：设置GitHub Secrets
echo ""
echo "🔐 第三步：设置GitHub仓库Secrets"
echo "=================================="

# 设置WeChat Webhook URL Secret
if [ -n "$WECHAT_WEBHOOK_URL" ]; then
    echo "📱 设置企业微信Webhook URL Secret..."
    
    # 使用GitHub CLI设置Secret
    if command -v gh &> /dev/null; then
        echo "🔧 使用GitHub CLI设置Secret..."
        echo "$WECHAT_WEBHOOK_URL" | gh secret set WECHAT_WEBHOOK_URL --repo "$USERNAME/keshuichong"
        if [ $? -eq 0 ]; then
            echo "✅ WECHAT_WEBHOOK_URL Secret设置成功"
        else
            echo "❌ WECHAT_WEBHOOK_URL Secret设置失败"
        fi
    else
        echo "⚠️ GitHub CLI未安装，请手动设置Secret："
        echo "   1. 访问：https://github.com/$USERNAME/keshuichong/settings/secrets/actions"
        echo "   2. 点击 'New repository secret'"
        echo "   3. Name: WECHAT_WEBHOOK_URL"
        echo "   4. Secret: $WECHAT_WEBHOOK_URL"
        echo "   5. 点击 'Add secret'"
    fi
fi

# 第四步：测试配置
echo ""
echo "🧪 第四步：测试双向通信配置"
echo "=============================="

# 创建测试脚本
cat > test_wechat_config.py << EOF
#!/usr/bin/env python3
import requests
import json
import sys
import os

# 企业微信Webhook URL
WECHAT_WEBHOOK_URL = os.getenv('WECHAT_WEBHOOK_URL', '$WECHAT_WEBHOOK_URL')

def test_wechat_connection():
    """测试企业微信连接"""
    if not WECHAT_WEBHOOK_URL:
        print("❌ 企业微信Webhook URL未配置")
        return False
    
    test_message = {
        "msgtype": "text",
        "text": {
            "content": f"""🧪 **配置测试消息**

⏰ 测试时间: $(date -u +'%Y-%m-%d %H:%M:%S UTC')
🔧 测试类型: GitHub Actions配置测试
✅ 状态: 企业微信连接测试

🚀 配置完成后，您可以：
1. 在企业微信中发送消息
2. 消息将自动转发到GitHub Actions
3. OpenClaw处理并回复

💡 正在测试企业微信连接..."""
        }
    }
    
    try:
        response = requests.post(WECHAT_WEBHOOK_URL, json=test_message, timeout=10)
        if response.status_code == 200:
            result = response.json()
            if result.get('errcode') == 0:
                print("✅ 企业微信连接测试成功！")
                return True
            else:
                print(f"❌ 企业微信连接失败: {result.get('errmsg')}")
                return False
        else:
            print(f"❌ HTTP请求失败: {response.status_code}")
            return False
    except Exception as e:
        print(f"❌ 连接异常: {e}")
        return False

if __name__ == "__main__":
    print("🧪 开始企业微信连接测试...")
    if test_wechat_connection():
        print("🎉 企业微信配置成功！")
        print("📋 下一步：")
        print("   1. 在企业微信中发送测试消息")
        print("   2. 查看GitHub Actions运行状态")
        print("   3. 确认OpenClaw回复功能")
    else:
        print("❌ 企业微信配置失败，请检查配置")
        sys.exit(1)
EOF

chmod +x test_wechat_config.py

if [ -n "$WECHAT_WEBHOOK_URL" ]; then
    echo "📱 测试企业微信连接..."
    python3 test_wechat_config.py
fi

# 第五步：使用说明
echo ""
echo "📖 第五步：使用说明"
echo "=================="
echo "✅ 配置完成！以下是使用方法："
echo ""
echo "📱 发送消息到企业微信："
echo "   企业微信用户 → 机器人 → 自动转发到GitHub Actions"
echo ""
echo "🔄 自动处理流程："
echo "   1. GitHub Actions接收企业微信消息"
echo "   2. 创建GitHub Issue记录消息"
echo "   3. OpenClaw处理消息内容"
echo "   4. 自动回复到企业微信"
echo ""
echo "🛠️ 管理命令："
echo "   手动触发测试："
echo "     gh workflow run wechat-bidirectional.yml --field inputs.action=test"
echo ""
echo "   查看运行状态："
echo "     gh run list --workflow=wechat-bidirectional.yml"
echo ""
echo "   查看消息记录："
echo "     gh issue list --label=wechat-message"
echo ""
echo "📁 重要文件："
echo "   .github/workflows/wechat-bidirectional.yml - 主要工作流"
echo "   test_wechat_config.py - 配置测试脚本"
echo "   WeChat-Bidirectional-Guide.md - 详细指南"
echo ""
echo "🎉 恭喜！企业微信双向通信配置完成！"
echo ""

# 清理
rm -f test_wechat_config.py

echo "💡 提示：如果需要进一步帮助，请查看相关文档或发送消息到企业微信。"