#!/bin/bash
# 恢复保活脚本

echo "🔧 恢复GitHub Codespace保活机制..."

# 设置环境变量
export OPENCLAW_GATEWAY_PORT=18789
export OPENCLAW_STATE_DIR=/home/codespace/.openclaw/workspace

# 检保活脚本权限
chmod +x /home/codespace/.openclaw/workspace/keep-alive.sh
chmod +x /home/codespace/.openclaw/workspace/codespace_keepalive.py
chmod +x /home/codespace/.openclaw/workspace/openclaw_wechat_bridge.py

# 手动运行一次保活
echo "🚀 执行手动保活..."
/home/codespace/.openclaw/workspace/keep-alive.sh

echo "✅ 保活机制已恢复！"
echo "📝 您可以手动运行以下命令来触发保活："
echo "   /home/codespace/.openclaw/workspace/keep-alive.sh"
echo "   python3 /home/codespace/.openclaw/workspace/codespace_keepalive.py"
