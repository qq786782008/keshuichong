# 企业微信双向通信完整指南

## 🎯 目标实现
企业微信 ↔ OpenClaw 双向通信

## 📊 当前状态
- ✅ OpenClaw → 企业微信：已实现
- ❌ 企业微信 → OpenClaw：待实现

## 💡 推荐方案：ngrok隧道

### 🔧 快速设置
```bash
# 1. 运行设置脚本
cd /home/codespace/.openclaw/workspace
chmod +x setup_wechat_bidirectional.sh
./setup_wechat_bidirectional.sh
```

### 📋 配置步骤
1. **获取公网URL** - ngrok提供临时公网地址
2. **配置企业微信** - 在管理后台设置Webhook URL
3. **测试连接** - 发送消息验证双向通信

## 🔗 企业微信配置

### 第一步：获取公网URL
```bash
# 运行ngrok脚本获取URL
./setup_wechat_bidirectional.sh
```

### 第二步：企业微信后台配置
1. 登录企业微信管理后台
2. 进入"机器人" → "编辑"
3. 找到"Webhook URL"设置
4. 填入ngrok提供的URL
5. 设置安全Token（如果需要）
6. 保存配置

### 第三步：测试双向通信
```bash
# 测试企业微信消息接收
curl -X POST "YOUR_NGROK_URL" \
  -H "Content-Type: application/json" \
  -d '{
    "msgtype": "text",
    "text": {
      "content": "测试双向通信"
    }
  }'
```

## 🚨 注意事项

### ngrok限制
- 免费版本有带宽限制
- 每次重启会获得新URL
- 建议使用付费版本获得稳定URL

### 安全考虑
- 配置IP白名单
- 设置验证Token
- 定期更新URL

## 🔄 替代方案

### 方案A：GitHub Actions
使用GitHub Actions接收企业微信消息，但需要配置webhook访问权限。

### 方案B：第三方服务
- 云函数服务（如AWS Lambda）
- 无服务器平台（如Vercel）
- 专门的Webhook服务

## 🎉 完整实现后的流程

### 发送消息流程
```
企业微信用户 → 企业微信机器人 → ngrok → 本地接收器 → OpenClaw处理
```

### 接收回复流程
```
OpenClaw → 企业微信Webhook → 企业微信群用户
```

## 📞 技术支持

如果遇到问题：
1. 检查ngrok是否正常运行
2. 验证企业微信Webhook配置
3. 查看Python接收器日志
4. 确认网络连接正常

---

**建议优先尝试ngrok方案，这是最快速和经济的双向通信解决方案。**