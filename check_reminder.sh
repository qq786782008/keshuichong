#!/bin/bash
# 检查提醒系统状态

echo "📊 5分钟提醒系统状态"
echo "==================="
echo "⏰ 当前时间: $(date -u +'%Y-%m-%d %H:%M:%S UTC')"
echo ""
echo "🔔 提醒系统状态:"
if pgrep -f "reminder_2hour.sh" > /dev/null; then
    echo "✅ 状态: 运行中"
    echo "📋 进程ID: $(pgrep -f reminder_2hour.sh)"
    echo "⏱️ 下次提醒: $(date -d "+5 minutes" -u +'%H:%M:%S UTC')"
    echo ""
    echo "💡 提醒系统将每5分钟提醒您，持续2小时"
    echo "🔗 使用 'ps aux | grep reminder' 查看详细状态"
    echo "⏹️  停止提醒: pkill -f reminder_2hour.sh"
else
    echo "❌ 状态: 未运行"
    echo "🚀 启动提醒: /home/codespace/.openclaw/workspace/reminder_2hour.sh"
fi
echo ""
echo "📝 记录文件位置:"
echo "   - 提醒脚本: /home/codespace/.openclaw/workspace/reminder_2hour.sh"
echo "   - 简化版本: /home/codespace/.openclaw/workspace/reminder_5min.sh"