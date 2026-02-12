#!/bin/bash
# 两小时内每5分钟提醒用户

echo "🚀 启动5分钟提醒系统..."
echo "⏰ 持续时间：2小时（24次提醒）"
echo "🔔 间隔：每5分钟"
echo ""

# 设置结束时间（2小时后）
END_TIME=$(date -d "+2 hours" +%s)
CURRENT_TIME=$(date +%s)

# 初始化计数器
COUNT=0

echo "📋 开始提醒：$(date -u +'%Y-%m-%d %H:%M:%S UTC')"
echo "=================================="

while [ $CURRENT_TIME -lt $END_TIME ]; do
    COUNT=$((COUNT + 1))
    REMINDER_TIME=$(date -u +'%Y-%m-%d %H:%M:%S UTC')
    
    echo "🔔 第$COUNT次提醒 - $REMINDER_TIME"
    echo "⏰ 时间: $REMINDER_TIME"
    echo "💡 提醒: 该休息一下或者检查任务了！"
    echo ""
    
    # 每5分钟等待一次（300秒）
    sleep 300
    
    # 更新当前时间
    CURRENT_TIME=$(date +%s)
    
    # 检查是否还在2小时内
    if [ $CURRENT_TIME -ge $END_TIME ]; then
        break
    fi
done

echo "✅ 提醒系统完成"
echo "📊 总提醒次数: $COUNT"
echo "⏰ 结束时间: $(date -u +'%Y-%m-%d %H:%M:%S UTC')"
echo ""