# 企业微信双向通信 - GitHub Actions方案

## 🎯 解决方案
使用GitHub Actions作为企业微信消息的接收和处理中心。

### 📋 配置步骤

#### 第一步：设置Webhook URL
在GitHub仓库设置中配置企业微信的Webhook URL：
```
https://api.github.com/repos/您的用户名/您的仓�ename/dispatches
```

#### 第二步：配置访问令牌
1. 在GitHub设置中创建Personal Access Token
2. 给予`repo`和`workflow`权限
3. 在企业微信中配置认证

#### 第三步：企业微信配置
在企业微信管理后台：
1. 设置Webhook URL为GitHub API地址
2. 配置认证Token
3. 启用消息接收

## 📁 已配置的文件
- `.github/workflows/wechat-receiver.yml` - 接收和处理企业微信消息
- `wechat_receiver.py` - 本地消息接收器

## 🚀 使用方法

### 方法A：GitHub Actions处理
```bash
# 配置GitHub Actions
# 1. 创建Personal Access Token
# 2. 在企业微信中配置webhook
# 3. 测试消息接收
```

### 方法B：本地处理（无ngrok）
```bash
# 创建本地Web服务器处理企业微信消息
python3 wechat_receiver.py --port 8080
```

## 📱 配置企业微信

### Webhook设置
1. 登录企业微信管理后台
2. 进入"机器人" → "编辑"
3. 设置"服务器地址"：
   ```
   https://api.github.com/repos/您的用户名/仓库名/dispatches
   ```
4. 设置"令牌"（GitHub Token）
5. 保存配置

### 安全设置
- 启用"加解密"
- 配置企业微信验证
- 设置IP白名单

## 🧪 测试方法

### 测试GitHub Actions
```bash
# 触发GitHub Actions
curl -X POST \
  -H "Authorization: token YOUR_GITHUB_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/您的用户名/仓库名/dispatches \
  -d '{"event_type": "wechat-message", "client_payload": {"message": "测试消息"}}'
```

### 测试本地接收器
```bash
# 本地测试
curl -X POST http://localhost:8080 \
  -H "Content-Type: application/json" \
  -d '{"msgtype": "text", "text": {"content": "测试消息"}}'
```

## 💡 优势对比

| 方案 | 优势 | 劣势 |
|------|------|------|
| GitHub Actions | 免费稳定，无需额外服务 | 配置相对复杂 |
| ngrok | 配置简单 | 需要认证，URL不稳定 |
| 本地服务 | 完全可控 | 需要公网IP |

## 🎯 推荐方案

**推荐使用GitHub Actions**：
- ✅ 免费且稳定
- ✅ 与GitHub集成自然
- ✅ 可自动化处理流程
- ✅ 无需维护外部服务

---

**下一步**：
1. 配置GitHub Personal Access Token
2. 在企业微信中设置Webhook
3. 测试双向通信功能