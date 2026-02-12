#!/bin/bash
# 5分钟提醒脚本

# 发送提醒到用户（这里通过echo记录，实际可以通过其他方式发送）
echo "🔔 $(date -u +'%Y-%m-%d %H:%M:%S UTC') - 5分钟提醒 - 该休息一下或者检查任务了！"

# 如果需要发送到Telegram或其他平台，可以在这里添加相应的命令
# 例如：
# curl -X POST "TELEGRAM_BOT_API" -d "chat_id=USER_ID&text=提醒内容"