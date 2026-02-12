#!/bin/bash
# OpenClaw企业微信消息转发脚本

WEBHOOK_URL="https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=2453f995-49b0-44c7-a38e-0397fdea5d2d"
MESSAGE="$1"

if [ -z "$MESSAGE" ]; then
    echo "Usage: $0 "message content""
    echo "Example: $0 "Hello from OpenClaw!""
    exit 1
fi

curl -X POST "$WEBHOOK_URL" \
    -H "Content-Type: application/json" \
    -d '{
        "msgtype": "text",
        "text": {
            "content": "'"$MESSAGE"'"
        }
    }' \
    -s

echo "消息已发送到企业微信"
