#!/bin/bash
# 企业微信双向通信设置脚本

echo "🔧 企业微信双向通信设置..."

# 安装ngrok（如果还没有）
if ! command -v ngrok &> /dev/null; then
    echo "📦 安装ngrok..."
    # 下载ngrok
    wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz -O ngrok.tgz 2>/dev/null || curl -L -o ngrok.tgz https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
    tar xvzf ngrok.tgz
    chmod +x ngrok
    echo "✅ ngrok安装完成"
fi

# 检查Python消息接收器
if [ ! -f "/home/codespace/.openclaw/workspace/wechat_receiver.py" ]; then
    echo "❌ 消息接收器不存在"
    exit 1
fi

# 设置环境变量
export WECHAT_WEBHOOK_PORT=8080

echo "🚀 启动企业微信消息接收器..."
cd /home/codespace/.openclaw/workspace

# 启动Python接收器（后台运行）
python3 wechat_receiver.py &
RECEIVER_PID=$!
echo "📡 消息接收器PID: $RECEIVER_PID"

# 等待接收器启动
sleep 3

echo "🌐 启动ngrok隧道..."
./ngrok http 8080 &
NGROK_PID=$!
echo "🔗 ngrok PID: $NGROK_PID"

# 等待ngrok启动
sleep 5

# 获取ngrok URL
echo "📋 获取ngrok公网URL..."
NGROK_URL=$(curl -s http://localhost:4040/api/tunnels | grep -o '"public_url":"[^"]*"' | head -1 | cut -d'"' -f4)

if [ -z "$NGROK_URL" ]; then
    echo "❌ 无法获取ngrok URL"
    kill $RECEIVER_PID 2>/dev/null
    kill $NGROK_PID 2>/dev/null
    exit 1
fi

echo "🎉 企业微信双向通信配置完成！"
echo ""
echo "📋 配置信息:"
echo "🌐 公网URL: $NGROK_URL"
echo "📡 本地端口: 8080"
echo "🤖 接收器PID: $RECEIVER_PID"
echo ""
echo "📱 下一步操作:"
echo "1. 在企业微信管理后台配置Webhook URL"
echo "2. 设置URL为: $NGROK_URL"
echo "3. 配置安全设置（Token等）"
echo "4. 保存配置"
echo ""
echo "🔧 测试命令:"
echo "   curl -X POST \"$NGROK_URL\" -H \"Content-Type: application/json\" -d '{\"msgtype\":\"text\",\"text\":{\"content\":\"测试消息\"}}'"
echo ""
echo "⚠️  注意: ngrok隧道需要保持运行，此终端会话关闭后隧道会断开"
echo "💡 建议: 使用nohup或screen来保持服务运行"

# 保存配置信息
echo "$NGROK_URL" > /home/codespace/.openclaw/workspace/wechat_webhook_url.txt
echo "$RECEIVER_PID" > /home/codespace/.openclaw/workspace/wechat_receiver_pid.txt

echo "✅ 配置信息已保存到 /home/codespace/.openclaw/workspace/"