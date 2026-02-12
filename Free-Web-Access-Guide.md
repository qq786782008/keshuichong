# OpenClaw 免费网络访问配置指南

## 🆓 免费网络访问方案

### ⭐ 方案一：Brave Search API（推荐）

#### 🎯 优势
- ✅ 完全免费
- ✅ 每月1,000次搜索
- ✅ 无需信用卡
- ✅ 支持中文搜索

#### 🔧 获取免费API密钥

##### 步骤1：注册账户
1. 访问：https://api.search.brave.com/
2. 点击 "Sign Up" 或 "Register"
3. 使用邮箱注册（免费）

##### 步骤2：获取API密钥
1. 登录后进入控制台
2. 找到 "API Key" 或 "Keys" 部分
3. 复制您的API密钥（类似：`xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`）

##### 步骤3：配置到OpenClaw

###### 方法A：环境变量（推荐）
```bash
# 设置环境变量
export BRAVE_API_KEY="your_actual_api_key_here"

# 验证设置
echo $BRAVE_API_KEY

# 使环境变量永久生效
echo 'export BRAVE_API_KEY="your_actual_api_key_here"' >> ~/.bashrc
source ~/.bashrc
```

###### 方法B：配置文件
```bash
# 设置配置
openclaw config set web.apiKey "$BRAVE_API_KEY"
```

#### 🧪 测试网络搜索
```bash
# 测试搜索
openclaw web_search "科技共享 OpenClaw"

# 查看YouTube相关内容
openclaw web_search "site:youtube.com 科技共享 OpenClaw"
```

### 🦆 方案二：其他免费API

#### DuckDuckGo API
```bash
# 可能有免费选项
export DUCKDUCKGO_API_KEY="your_key"
```

#### Google Custom Search
```bash
# 需要设置Google API
export GOOGLE_API_KEY="your_google_key"
export SEARCH_ENGINE_ID="your_engine_id"
```

### 📡 方案三：直接链接分析

如果您已经找到视频链接，我可以直接分析：

#### 支持的链接格式
```
https://www.youtube.com/watch?v=视频ID
https://youtube.com/视频ID
```

#### 分析能力
- 📝 提取视频标题和描述
- 🎬 分析视频内容摘要
- 📊 统计视频信息
- 💬 提取关键观点

### 🚨 方案四：临时解决方案

#### 使用代理或VPN
```bash
# 如果您有网络代理
export HTTP_PROXY="http://proxy:port"
export HTTPS_PROXY="http://proxy:port"
```

### 🔍 立即行动

#### 选择1：获取Brave API密钥（推荐）
1. 访问：https://api.search.brave.com/
2. 注册免费账户
3. 获取API密钥
4. 配置环境变量

#### 选择2：提供视频链接
如果您已经找到"科技共享"博主的视频，直接链接给我，我可以分析内容。

#### 选择3：描述视频内容
如果您记得视频内容，我可以基于您的描述整理总结。

### 💡 使用示例

#### 配置后搜索
```bash
# 配置完成后搜索
export BRAVE_API_KEY="your_key"
openclaw web_search "科技共享 OpenClaw 视频教程"
```

#### 视频链接分析
```
# 提供链接后
请分析这个视频：https://www.youtube.com/watch?v=xxx
```

### ⚡ 快速开始

1. **最简单**：提供YouTube视频链接给我
2. **最推荐**：配置Brave免费API密钥
3. **最快捷**：描述视频主要内容

---

**提示**：Brave Search API是目前最好的免费选择，注册简单，无需付费！