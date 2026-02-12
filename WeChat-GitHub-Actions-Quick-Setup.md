# 企业微信双向通信 - GitHub Actions配置指南

## 🎯 快速开始

### 一键配置
```bash
cd /home/codespace/.openclaw/workspace
./setup_wechat_github_actions.sh
```

### 配置步骤

#### 第1步：创建GitHub Personal Access Token
1. 访问：https://github.com/settings/tokens
2. 点击 "Generate new token" → "Generate new token (classic)"
3. 设置Token名称：`WeChat Integration`
4. 选择权限：
   - ✅ `repo` (Full control of private repositories)
   - ✅ `workflow` (Update GitHub Action workflows)
5. 点击 "Generate token"
6. 复制生成的Token（只显示一次！）

#### 第2步：配置企业微信Webhook
在企业微信管理后台：
1. 进入"机器人" → "编辑"
2. 设置Webhook URL：
   ```
   https://api.github.com/repos/您的用户名/keshuichong/dispatches
   ```
3. 设置安全令牌（可选）
4. 保存配置

#### 第3步：设置GitHub Secrets
使用以下命令设置Secret：
```bash
gh secret set WECHAT_WEBHOOK_URL --repo 您的用户名/keshuichong
```

#### 第4步：测试配置
运行配置脚本会自动测试连接

## 📋 工作流功能

### 接收消息流程
```
企业微信用户 → GitHub Actions → 创建Issue → OpenClaw处理 → 回复企业微信
```

### 自动化功能
- ✅ 消息接收和处理
- ✅ GitHub Issue记录
- ✅ OpenClaw自动回复
- ✅ 系统健康检查
- ✅ 状态通知

## 🚀 使用方法

### 手动触发测试
```bash
gh workflow run wechat-bidirectional.yml --field inputs.action=test
```

### 查看运行状态
```bash
gh run list --workflow=wechat-bidirectional.yml
```

### 查看消息记录
```bash
gh issue list --label=wechat-message
```

## 📱 消息格式

### 企业微信消息格式
```json
{
  "msgtype": "text",
  "text": {
    "content": "消息内容"
  }
}
```

### GitHub Actions处理
- 自动解析消息内容
- 创建GitHub Issue记录
- 调用OpenClaw处理
- 发送回复到企业微信

## ⚠️ 注意事项

1. **Token安全**：妥善保管GitHub Token，不要泄露
2. **权限设置**：确保Token有足够的权限
3. **网络连接**：确保企业微信和GitHub网络互通
4. **Secret管理**：定期更新Webhook URL Secret

## 🎉 完成后的效果

配置完成后，您将拥有：
- 📱 企业微信消息自动接收
- 🤖 OpenClaw自动回复
- 📝 GitHub Issue消息记录
- 🔔 系统状态通知
- 🔄 完整的双向通信功能

---

**运行配置脚本开始：** `./setup_wechat_github_actions.sh`