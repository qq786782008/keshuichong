#!/bin/bash

# GitHub Codespace Keep-Alive Script
# 每10分钟运行一次，防止自动关闭

TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S UTC")
echo "Keep-alive script running at: $TIMESTAMP"

# 方法1: 触发OpenClaw心跳
echo "Triggering OpenClaw heartbeat..."
openclaw agent --local --message "Keep-alive ping - $TIMESTAMP" --json 2>/dev/null || echo "OpenClaw agent command failed"

# 方法2: Git操作保持活跃
echo "Performing git operations..."
if [ -d ".git" ]; then
    git add . 2>/dev/null || true
    git commit -m "Keep-alive commit - $TIMESTAMP" 2>/dev/null || echo "No changes to commit"
    git push 2>/dev/null || echo "Git push failed (expected if no changes)"
fi

# 方法3: 检查并更新内存文件
MEMORY_FILE="memory/$(date +%Y-%m-%d).md"
echo "Updating memory file..."
if [ -f "$MEMORY_FILE" ]; then
    echo "# Keep-alive update at $TIMESTAMP" >> "$MEMORY_FILE"
else
    echo "# Memory file created at $TIMESTAMP" > "$MEMORY_FILE"
fi

# 方法4: 创建临时文件标记活动
echo "Creating activity marker..."
echo "$TIMESTAMP" > /tmp/codespace-activity.log

echo "Keep-alive script completed successfully at $(date "+%Y-%m-%d %H:%M:%S UTC")"