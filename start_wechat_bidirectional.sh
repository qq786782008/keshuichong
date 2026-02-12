#!/bin/bash
# 简化的企业微信双向通信设置

echo "🔧 企业微信双向通信设置（简化版）"

# 设置端口
export WECHAT_WEBHOOK_PORT=8080

echo "🚀 启动消息接收器..."
cd /home/codespace/.openclaw/workspace

# 启动Python接收器（后台运行）
echo "📡 启动Python消息接收器..."
python3 wechat_receiver.py &
RECEIVER_PID=$!
echo "🤖 接收器PID: $RECEIVER_PID"

# 等待接收器启动
sleep 3

echo "🌐 启动ngrok隧道..."
echo "📡 创建公网隧道（免费版）..."
./ngrok http 8080 &
NGROK_PID=$!
echo "🔗 ngrok PID: $NGROK_PID"

# 等待ngrok启动
sleep 8

# 获取ngrok URL
echo "📋 获取公网URL..."
NGROK_URL=$(curl -s http://localhost:4040/api/tunnels | grep -o '"public_url":"https://[^"]*"' | head -1 | cut -d'"' -f4)

if [ -z "$NGROK_URL" ]; then
    echo "❌ 无法获取ngrok URL"
    echo "💡 可能原因：网络连接问题或ngrok启动失败"
    
    # 清理进程
    kill $RECEIVER_PID 2>/dev/null
    kill $NGROK_PID 2>/dev/null
    exit 1
fi

echo ""
echo "🎉 企业微信双向通信配置完成！"
echo "================================"
echo "📋 配置信息:"
echo "🌐 公网URL: $NGROK_URL"
echo "📡 本地端口: 8080"
echo "🤖 接收器PID: $RECEIVER_PID"
echo ""
echo "📱 企业微信配置步骤:"
echo "1. 登录企业微信管理后台"
echo "2. 进入机器人 → 编辑"
echo "3. 找到'Webhook URL'设置"
echo "4. 填入: $NGROK_URL"
echo "5. 保存配置"
echo ""
echo "🧪 测试命令:"
echo "curl -X POST \"$NGROK_URL\" \\"
echo "  -H \"Content-Type: application/json\" \\"
echo "  -d '{\"msgtype\":\"text\",\"text\":{\"content\":\"测试消息\"}}'"
echo ""
echo "⚠️  重要提示:"
echo "- ngrok免费URL每次重启会变化"
echo "- 此隧道约2小时后过期"
echo "- 请尽快测试和配置企业微信"
echo ""
echo "🔧 停止服务:"
echo "kill $RECEIVER_PID $NGROK_PID"

# 保存配置
echo "$NGROK_URL" > /home/codespace/.openclaw/workspace/wechat_webhook_url.txt
echo "$RECEIVER_PID" > /home/codespace/.openclaw/workspace/wechat_receiver_pid.txt

echo "✅ 配置信息已保存"