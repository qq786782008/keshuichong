# GitHub Codespace 保持活跃解决方案

## 🚨 问题
GitHub Codespace 有30分钟无操作的自动关闭机制，影响长时间工作。

## 🔧 解决方案

### 方案1：调整OpenClaw心跳（已实施 ✅）
- **频率**: 每20分钟发送一次心跳（原29分钟）
- **触发器**: cron任务自动执行
- **命令**: `HEARTBEAT_OK`

**当前状态**: 
- 任务ID: `468d849f-98ec-4886-b8c2-44594a277068`（OpenClaw心跳）
- 任务ID: `b350d061-cf9e-4823-9397-f0c5ce6dc4bd`（保持活跃）

### 方案2：Shell脚本保持活跃
**文件**: `keep-alive.sh`
```bash
#!/bin/bash
# 每10分钟运行一次，执行：
# - 触发OpenClaw代理
# - Git操作
# - 更新内存文件
```

**运行方式**:
```bash
# 手动运行
./keep-alive.sh

# 设置cron任务
*/10 * * * * /home/codespace/.openclaw/workspace/keep-alive.sh
```

### 方案3：Python脚本保持活跃
**文件**: `codespace_keepalive.py`
```python
# Python实现的完整keep-alive方案
# - HTTP请求触发
# - Git操作
# - 内存文件更新
# - 错误处理
```

**运行方式**:
```bash
# 手动运行
python3 codespace_keepalive.py

# 设置定时任务
*/10 * * * * python3 /home/codespace/.openclaw/workspace/codespace_keepalive.py
```

### 方案4：GitHub Actions Workflow
**文件**: `.github/workflows/keep-alive.yml`
- 每10分钟自动运行
- 通过API触发
- 不需要本地执行

## 📋 当前激活的机制

### 1. OpenClaw内部心跳
- **频率**: 20分钟
- **功能**: 保持OpenClaw会话活跃
- **状态**: ✅ 运行中

### 2. 外部保持活跃
- **频率**: 10分钟  
- **功能**: 防止codespace关闭
- **状态**: ✅ 配置完成

## 🎯 使用建议

### 立即可用
1. **OpenClaw心跳**（已自动运行）
2. **手动触发**：
   ```bash
   ./keep-alive.sh
   python3 codespace_keepalive.py
   ```

### 设置定时任务
```bash
# 编辑crontab
crontab -e

# 添加以下行：
*/10 * * * * /home/codespace/.openclaw/workspace/keep-alive.sh
*/15 * * * * python3 /home/codespace/.openclaw/workspace/codespace_keepalive.py
```

## 🔍 监控和调试

### 检查状态
```bash
# 查看cron任务
crontab -l

# 查看OpenClaw心跳
openclaw sessions --active 60

# 查看临时文件
cat /tmp/codespace-activity.log
cat /tmp/codespace-keepalive.log
```

### 手动测试
```bash
# 测试shell脚本
./keep-alive.sh

# 测试Python脚本
python3 codespace_keepalive.py

# 测试Git操作
git status
```

## 🚀 最佳实践

1. **多重保障**: 使用多个keep-alive机制
2. **频率合理**: 每10-15分钟触发一次
3. **错误处理**: 各方案都有容错机制
4. **状态监控**: 定期检查运行状态

## ⚠️ 注意事项

- 确保 GitHub Actions 的 workflow 已启用
- 定期检查 cron 任务的运行状态
- 注意API调用频率限制
- 保持网络连接稳定

---

**最后更新**: 2026-02-12 05:40 UTC  
**状态**: ✅ 多重keep-alive机制已部署