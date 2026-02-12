# 企业微信双向通信 - 手动配置指南

## 🎯 当前状态
- ✅ GitHub Actions工作流已创建
- ✅ GitHub CLI已登录
- ✅ 配置脚本已准备
- ❌ 需要手动设置Secrets

## 📋 手动配置步骤

### 第1步：设置GitHub Secrets（手动方法）

#### 方法A：通过网页界面
1. 访问：https://github.com/qq786782008/keshuichong/settings/secrets/actions
2. 点击 "New repository secret"
3. 名称：`WECHAT_WEBHOOK_URL`
4. 值：`https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=2453f995-49b0-44c7-a38e-0397fdea5d2d`
5. 点击 "Add secret"

#### 方法B：使用GitHub CLI（如果权限允许）
```bash
gh secret set WECHAT_WEBHOOK_URL
# 然后输入：https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=2453f995-49b0-44c7-a38e-0397fdea5d2d
```

### 第2步：验证企业微信Webhook配置

#### 企业微信后台设置：
1. 登录企业微信管理后台
2. 进入 "机器人" → "编辑"
3. 设置 "Webhook URL"：
   ```
   https://api.github.com/repos/qq786782008/keshuichong/dispatches
   ```
4. 设置 "安全令牌"（可选，用于验证请求）
5. 保存配置

### 第3步：测试配置

#### 测试工作流：
```bash
# 手动触发测试
gh workflow run wechat-bidirectional.yml --field inputs.action=test
```

#### 查看运行状态：
```bash
gh run list --workflow=wechat-bidirectional.yml
```

#### 测试消息发送：
在企业微信中发送测试消息，检查：
1. 是否创建GitHub Issue
2. 是否收到OpenClaw回复

## 🔧 完整配置命令

### 自动化测试脚本
```bash
# 创建测试脚本
cat > test_wechat_integration.py << 'EOF'
#!/usr/bin/env python3
import requests
import json
import os

# 企业微信Webhook URL
WEBHOOK_URL = "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=2453f995-49b0-44c7-a38e-0397fdea5d2d"

def send_test_message():
    """发送测试消息"""
    test_message = {
        "msgtype": "text",
        "text": {
            "content": """🧪 **双向通信测试**

⏰ 测试时间: 2026-02-12 14:21 UTC
🔧 测试类型: GitHub Actions集成测试
📱 测试状态: 配置验证

✅ 如果您收到此消息，说明：
1. 企业微信Webhook配置成功
2. GitHub Actions工作流正常运行
3. 双向通信连接正常

🚀 配置完成！您可以开始使用双向通信功能。"""
        }
    }
    
    try:
        response = requests.post(WEBHOOK_URL, json=test_message, timeout=10)
        if response.status_code == 200:
            result = response.json()
            if result.get('errcode') == 0:
                print("✅ 测试消息发送成功！")
                return True
            else:
                print(f"❌ 消息发送失败: {result.get('errmsg')}")
                return False
        else:
            print(f"❌ HTTP请求失败: {response.status_code}")
            return False
    except Exception as e:
        print(f"❌ 发送异常: {e}")
        return False

if __name__ == "__main__":
    print("🧪 开始企业微信双向通信测试...")
    if send_test_message():
        print("🎉 企业微信配置验证成功！")
    else:
        print("❌ 企业微信配置验证失败，请检查配置")
EOF

# 运行测试
python3 test_wechat_integration.py
```

## 📊 配置完成后的功能

### 自动化流程
```
企业微信用户 → GitHub Actions → Issue记录 → OpenClaw处理 → 自动回复
```

### 管理命令
```bash
# 查看工作流运行历史
gh run list --workflow=wechat-bidirectional.yml

# 查看消息记录
gh issue list --label=wechat-message

# 手动触发测试
gh workflow run wechat-bidirectional.yml --field inputs.action=test

# 查看工作流文件
cat .github/workflows/wechat-bidirectional.yml
```

## 🎉 配置成功标志

配置完成后，您应该能看到：

1. ✅ 企业微信消息正常接收
2. ✅ GitHub Issues自动创建
3. ✅ OpenClaw自动回复
4. ✅ 系统状态通知

## 🔍 故障排除

### 常见问题
1. **企业微信消息不发送**
   - 检查Webhook URL配置
   - 验证Token权限

2. **GitHub Actions不运行**
   - 检查Secrets设置
   - 验证工作流权限

3. **OpenClaw不回复**
   - 检查API连接
   - 验证消息格式

### 调试命令
```bash
# 检查工作流语法
gh workflow validate .github/workflows/wechat-bidirectional.yml

# 查看工作流日志
gh run watch --workflow=wechat-bidirectional.yml
```

---

**下一步：**
1. 设置GitHub Secrets
2. 配置企业微信Webhook
3. 运行测试验证配置