#!/bin/bash
# 简化的企业微信GitHub Actions配置演示

echo "🔧 企业微信双向通信配置演示"
echo "=============================="

echo ""
echo "📋 配置步骤："
echo "1. 创建GitHub Personal Access Token"
echo "2. 配置企业微信Webhook URL"
echo "3. 设置GitHub仓库Secrets"
echo "4. 测试双向通信"
echo ""

# 检查当前状态
echo "🔍 检查当前配置状态..."
echo ""

# 检查GitHub CLI
if command -v gh &> /dev/null; then
    echo "✅ GitHub CLI已安装"
else
    echo "❌ GitHub CLI未安装，请先安装"
    echo "   安装命令: curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg"
    echo "   echo \"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main\" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null"
    echo "   sudo apt update"
    echo "   sudo apt install gh"
fi

# 检查工作流文件
if [ -f ".github/workflows/wechat-bidirectional.yml" ]; then
    echo "✅ GitHub Actions工作流文件已存在"
    echo "   文件: .github/workflows/wechat-bidirectional.yml"
else
    echo "❌ 工作流文件缺失"
fi

# 检查企业微信Webhook
echo ""
echo "📱 企业微信配置检查："
echo "   当前配置的Webhook URL: $WECHAT_WEBHOOK_URL (未设置)"

echo ""
echo "🚀 快速配置命令："
echo "=================="
echo ""
echo "1. 设置GitHub Token（如果已创建）："
echo "   gh auth login"
echo ""
echo "2. 设置企业微信Webhook Secret："
echo "   gh secret set WECHAT_WEBHOOK_URL"
echo ""
echo "3. 运行测试："
echo "   gh workflow run wechat-bidirectional.yml --field inputs.action=test"
echo ""
echo "4. 查看运行状态："
echo "   gh run list --workflow=wechat-bidirectional.yml"
echo ""

echo "📖 手动配置步骤："
echo "================="
echo ""
echo "步骤1 - 创建GitHub Token："
echo "   1. 访问: https://github.com/settings/tokens"
echo "   2. 点击 'Generate new token' → 'Generate new token (classic)'"
echo "   3. 名称: 'WeChat Integration'"
echo "   4. 权限: 勾选 'repo' 和 'workflow'"
echo "   5. 复制生成的Token"
echo ""
echo "步骤2 - 配置企业微信："
echo "   1. 登录企业微信管理后台"
echo "   2. 进入机器人 → 编辑"
echo "   3. Webhook URL: https://api.github.com/repos/qq786782008/keshuichong/dispatches"
echo "   4. 保存配置"
echo ""
echo "步骤3 - 设置Secret："
echo "   gh secret set WECHAT_WEBHOOK_URL"
echo "   (输入您的企业微信Webhook URL)"
echo ""
echo "步骤4 - 测试配置："
echo "   在企业微信中发送测试消息，检查是否收到回复"
echo ""

echo "🎯 配置完成后效果："
echo "=================="
echo "✅ 企业微信消息自动接收"
echo "✅ GitHub Issue自动创建"
echo "✅ OpenClaw自动处理和回复"
echo "✅ 系统状态自动通知"
echo ""

echo "💡 提示："
echo "   - 配置完成后，任何人在企业微信中发送消息都会自动处理"
echo "   - 消息记录会保存在GitHub Issues中"
echo "   - 系统会自动回复处理结果"
echo ""

echo "🔧 需要帮助吗？请告诉我："
echo "   1. 是否需要帮助创建GitHub Token"
echo "   2. 是否需要验证企业微信Webhook配置"
echo "   3. 是否需要运行测试"
echo ""