# 企业微信和微信集成指南

## 📋 概述

OpenClaw 目前**原生不支持**企业微信（WeChat Work）和个人微信，但可以通过以下方式实现集成：

## 🔧 方案一：企业微信Webhook机器人 ✅

### 1.1 创建企业微信机器人

#### 步骤1：获取企业微信Webhook URL
1. 登录企业微信管理后台
2. 进入"应用管理" → "添加应用" → 选择"机器人"
3. 填写应用信息并创建
4. 在"机器人"页面获取 **Webhook URL**
   - 格式：`https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=YOUR_KEY`

#### 步骤2：配置OpenClaw
```bash
# 设置环境变量
export WECHAT_WORK_WEBHOOK_URL="https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=YOUR_KEY"

# 运行集成脚本
python3 /home/codespace/.openclaw/workspace/wechat_work_integration.py
```

### 1.2 测试连接
```bash
# 测试企业微信连接
python3 -c "
from wechat_work_integration import WeChatWorkBot
bot = WeChatWorkBot('YOUR_WEBHOOK_URL')
result = bot.send_message('测试消息')
print(result)
"
```

### 1.3 消息转发脚本
创建的消息转发脚本：

```bash
# 使用方法
./wechat_forward.sh "要发送的消息内容"
```

## 🔧 方案二：个人微信集成（复杂方案）

### 2.1 使用微信开发者工具
需要微信开发者账号和认证：

#### 步骤1：申请开发者账号
1. 访问：https://open.weixin.qq.com/
2. 注册开发者账号
3. 申请服务号或订阅号

#### 步骤2：配置消息接口
1. 在"设置与开发" → "基本配置"
2. 配置服务器URL和Token
3. 启用消息接收

#### 步骤3：OpenClaw集成
```bash
# 配置微信接收
openclaw channels add --channel webhook --webhook-url "YOUR_WECHAT_CALLBACK_URL"
```

### 2.2 第三方平台方案
使用第三方微信平台作为中间层：

1. **选择平台**：如WechatBot、WeCom等
2. **配置Webhook**：将平台指向OpenClaw
3. **双向集成**：消息转发和回复

## 🔧 方案三：飞书替代方案 ✅

### 3.1 飞书功能对比
| 功能 | 企业微信 | 飞书 | OpenClaw支持 |
|------|---------|------|-------------|
| 消息机器人 | ✅ | ✅ | ✅ |
| 群组管理 | ✅ | ✅ | ✅ |
| API接口 | ✅ | ✅ | ✅ |
| 文件传输 | ✅ | ✅ | ✅ |
| 视频会议 | ✅ | ✅ | ❌ |

### 3.2 飞书配置（推荐）
```bash
# 添加飞书渠道
openclaw channels add --channel feishu --token "YOUR_FEISHU_BOT_TOKEN"

# 登录飞书
openclaw channels login --channel feishu --verbose

# 验证配置
openclaw channels list
```

## 🚀 快速开始

### 最简单方案：飞书
```bash
# 1. 创建飞书应用（如果还没有）
# 访问：https://open.feishu.cn/app

# 2. 获取Bot Token
# 在"机器人管理"中创建机器人并获取Token

# 3. 配置OpenClaw
openclaw channels add --channel feishu --token "YOUR_BOT_TOKEN"
openclaw channels login --channel feishu
```

### 企业微信方案
```bash
# 1. 创建企业微信机器人
# 2. 获取Webhook URL
# 3. 运行集成脚本
python3 wechat_work_integration.py

# 4. 测试连接
./wechat_forward.sh "OpenClaw测试消息"
```

## 📝 完整配置流程

### 企业微信完整配置
```bash
# 1. 设置环境变量
export WECHAT_WORK_WEBHOOK_URL="your_webhook_url_here"

# 2. 运行集成脚本
python3 wechat_work_integration.py

# 3. 测试连接
python3 -c "
from wechat_work_integration import test_wechat_work_connection
test_wechat_work_connection()
"

# 4. 添加到OpenClaw（如果支持webhook）
openclaw channels add --channel webhook --webhook-url "$WECHAT_WORK_WEBHOOK_URL"

# 5. 验证配置
openclaw channels list
```

### 飞书完整配置
```bash
# 1. 添加飞书渠道
openclaw channels add --channel feishu --token "your_bot_token_here"

# 2. 登录飞书
openclaw channels login --channel feishu --verbose

# 3. 验证配置
openclaw channels list

# 4. 测试消息
openclaw agent --to feishu --message "飞书测试消息" --deliver
```

## 🔍 故障排除

### 企业微信常见问题

**问题1：Webhook URL无效**
```bash
# 检查Webhook URL格式
echo $WECHAT_WORK_WEBHOOK_URL
# 应该是：https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=YOUR_KEY
```

**问题2：消息发送失败**
```bash
# 检查网络连接
curl -X POST "$WECHAT_WORK_WEBHOOK_URL" \
  -H "Content-Type: application/json" \
  -d '{"msgtype": "text", "text": {"content": "测试"}}'
```

**问题3：安全限制**
- 确保企业微信应用有发送消息权限
- 检查IP白名单设置
- 验证Token有效性

### 飞书常见问题

**问题1：Bot Token无效**
```bash
# 重新获取Bot Token
# 检查飞书应用权限设置
```

**问题2：连接失败**
```bash
# 查看详细日志
openclaw channels login --channel feishu --verbose
openclaw channels logs
```

## 🎯 推荐方案

### 推荐：飞书 ✅
- ✅ OpenClaw原生支持
- ✅ 功能与企业微信相似
- ✅ 配置简单，文档完善
- ✅ API稳定可靠

### 备选：企业微信 + Webhook
- ✅ 可以使用现有企业微信
- ❌ 配置相对复杂
- ❌ 需要额外脚本支持
- ❌ 依赖企业微信机器人API

## 💡 最佳实践

1. **优先选择飞书**：功能相似，配置简单
2. **测试连接**：使用提供的测试脚本验证连接
3. **监控日志**：定期检查连接状态和消息日志
4. **权限管理**：确保机器人有足够的权限
5. **错误处理**：实现消息发送失败的回退机制

---

**最后更新**: 2026-02-12 05:46 UTC  
**状态**: 提供企业微信和飞书两种集成方案