# OpenClaw 控制教程

## 📋 简介

本教程帮助您快速掌握 OpenClaw 的命令行控制，包括最常用的操作和配置管理。

## 🔧 基础命令

### 1. OpenClaw 网关控制 (Gateway)

OpenClaw 的网关是整个系统的核心，负责处理连接、会话和消息路由。

#### 启动网关
```bash
# 使用默认设置启动网关
openclaw gateway run

# 指定端口启动
openclaw gateway --port 18789 run

# 强制启动（杀死占用端口的进程）
openclaw gateway --force run

# 开发模式启动
openclaw gateway --dev run

# 使用密码认证
openclaw gateway --auth password --password your-password run

# 使用 Token 认证
openclaw gateway --auth token --token your-token run
```

#### 网关服务管理
```bash
# 启动网关服务
openclaw gateway start

# 停止网关服务
openclaw gateway stop

# 重启网关服务
openclaw gateway restart

# 查看网关服务状态
openclaw gateway status

# 查看网关健康状态
openclaw gateway health

# 卸载网关服务
openclaw gateway uninstall

# 安装网关服务
openclaw gateway install

# 探索本地网关
openclaw gateway discover
```

#### 网关连接测试
```bash
# 测试网关可访问性
openclaw gateway probe
```

### 2. 代理管理 (Agent)

Agent 是 OpenClaw 的智能助手，可以执行各种任务。

#### 基础 Agent 命令
```bash
# 发送消息给 Agent
openclaw agent --to +15555550123 --message "你好，我需要帮助"

# 使用特定 Agent
openclaw agent --agent ops --message "分析日志文件"

# 启用思考模式
openclaw agent --to +15555550123 --message "复杂问题" --thinking medium

# 本地运行（不使用网关）
openclaw agent --local --message "测试命令"

# 发送回复到指定渠道
openclaw agent --to +15555550123 --message "请回复" --deliver --reply-channel telegram --reply-to @yourchannel

# JSON 输出
openclaw agent --to +15555550123 --message "获取状态" --json
```

### 3. 会话管理 (Sessions)

查看和管理对话会话。

```bash
# 列出所有会话
openclaw sessions

# 列出最近2小时的活跃会话
openclaw sessions --active 120

# JSON 格式输出
openclaw sessions --json

# 使用自定义会话存储路径
openclaw sessions --store ./custom-sessions.json
```

### 4. 配置管理 (Config)

管理 OpenClaw 的配置文件。

```bash
# 配置向导（交互式）
openclaw config

# 获取配置值
openclaw config get gateway.port

# 设置配置值
openclaw config set gateway.port 18789

# 删除配置值
openclaw config unset gateway.port

# 批量配置特定部分
openclaw config --section gateway --section channels
```

### 5. 消息管理 (Message)

直接发送和管理消息。

```bash
# 发送文本消息
openclaw message send --target +15555550123 --message "你好！"

# 发送带媒体的消息
openclaw message send --target +15555550123 --message "看看这个" --media photo.jpg

# 发送投票
openclaw message poll --channel telegram --target @channel --poll-question "你喜欢什么？" --poll-option 🍕 --poll-option 🍜

# 添加表情反应
openclaw message react --channel telegram --target +15555550123 --message-id 123 --emoji 👍

# 编辑消息
openclaw message edit --channel telegram --target +15555550123 --message-id 123 --text "修改后的消息"

# 删除消息
openclaw message delete --channel telegram --target +15555550123 --message-id 123
```

## 🎯 常用场景

### 场景1：首次设置
```bash
# 1. 初始设置（交互式）
openclaw setup

# 2. 配置渠道
openclaw channels login --verbose

# 3. 启动网关
openclaw gateway start

# 4. 验证状态
openclaw status
```

### 场景2：开发调试
```bash
# 1. 开发模式启动
openclaw --dev gateway run

# 2. 查看会话
openclaw sessions --active 60

# 3. 测试代理
openclaw agent --local --message "Debug this issue"

# 4. 查看健康状态
openclaw doctor
```

### 场景3：生产部署
```bash
# 1. 安装服务
openclaw gateway install

# 2. 启动服务
openclaw gateway start

# 3. 配置认证
openclaw config set gateway.auth token
openclaw config set gateway.token your-secret-token

# 4. 监控状态
openclaw gateway status
openclaw gateway health
```

### 场景4：消息调度
```bash
# 1. 查看当前渠道状态
openclaw status

# 2. 检查连接的健康状态
openclaw channels

# 3. 发送测试消息
openclaw message send --channel telegram --target @yourchannel --message "测试连接"

# 4. 配置自动回复
openclaw config set channels.telegram.autoReply.enabled true
```

## 🔍 高级命令

### 系统健康检查
```bash
# 完整健康检查
openclaw doctor

# 查看渠道健康状态
openclaw status

# 系统事件
openclaw system
```

### 内存和搜索
```bash
# 搜索内存
openclaw memory search "项目配置"

# 查看完整内存
openclaw memory
```

### 技能管理
```bash
# 列出可用技能
openclaw skills list

# 安装技能
openclaw skills install skill-name

# 更新技能
openclaw skills update skill-name

# 卸载技能
openclaw skills uninstall skill-name
```

### 设备管理
```bash
# 列出已配对设备
openclaw devices list

# 配对新设备
openclaw devices pair

# 查看设备状态
openclaw devices status
```

## 🛠️ 故障排除

### 常见问题

1. **端口被占用**
   ```bash
   openclaw gateway --force run
   ```

2. **服务启动失败**
   ```bash
   openclaw doctor
   openclaw logs
   ```

3. **认证问题**
   ```bash
   openclaw config get gateway.auth
   openclaw config get gateway.token
   ```

4. **连接问题**
   ```bash
   openclaw gateway probe
   openclaw status
   ```

5. **消息发送失败**
   ```bash
   openclaw channels --verbose
   openclaw message send --channel telegram --target @channel --message "test" --json
   ```

### 日志和调试
```bash
# 查看网关日志
openclaw logs

# 详细模式启动
openclaw gateway --verbose run

# 开发模式（隔离配置）
openclaw --dev gateway run
```

## 📖 参考资源

- **官方文档**: https://docs.openclaw.ai
- **CLI 帮助**: `openclaw --help`
- **子命令帮助**: `openclaw <command> --help`
- **配置文档**: `openclaw config --help`

## 💡 最佳实践

1. **使用配置文件**: 避免在命令行中硬编码敏感信息
2. **定期检查状态**: 使用 `openclaw status` 和 `openclaw doctor`
3. **备份配置**: 定期备份配置文件和会话数据
4. **使用开发模式**: 在测试时使用 `--dev` 避免影响生产环境
5. **监控资源**: 定期检查 Token 使用量和会话状态

---

**提示**: 每个命令都有详细的帮助信息，使用 `--help` 查看更多选项和示例。