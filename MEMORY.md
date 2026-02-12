# MEMORY.md - 长期记忆

## 项目环境
- **运行环境**: GitHub Codespace
- **项目仓库**: https://github.com/qq786782008/keshuichong
- **公网访问**: https://turbo-garbanzo-j66rvwrjvg6h45j-18789.app.github.dev/chat?session=main
- **技术栈**: Next.js（React）+ TypeScript + Tailwind

## 工作流程
- 完成编码任务后，必须将变更push到GitHub仓库
- 使用标准的git工作流程进行版本控制

## 用户偏好
- 用户：Mike Wu (@haoxiangchimian)
- 偏好中文交流
- 需要每29分钟心跳保持活跃状态
- 希望节约token，简洁高效

## 重要提醒
- 每次编码任务完成后都要git push
- 记住这是一个Next.js + TypeScript + Tailwind项目
- 确保代码符合项目的技术栈要求

## 重要文档创建
- **OpenClaw-Control-Tutorial.md**: 创建了全面的OpenClaw命令行控制教程
- 涵盖网关管理、代理操作、会话管理、配置管理等核心功能
- 包含常用场景、故障排除指南和最佳实践

## 环境优化
- **Codespace Keep-Alive Solution**: 创建了GitHub Codespace保持活跃解决方案
- 多层保护机制：20分钟OpenClaw心跳 + 10分钟外部脚本 + GitHub Actions
- 防止30分钟无操作自动关闭问题
- 包含shell脚本、Python脚本、GitHub Actions workflow

## 集成方案开发
- **企业微信集成指南**: 分析了OpenClaw与企业微信的集成可能性
- **推荐方案**: 飞书作为替代（原生支持，功能相似）
- **Python集成脚本**: 创建了wechat_work_integration.py，支持企业微信Webhook
- **完整文档**: 提供配置步骤、故障排除、最佳实践指南
- **成功实现**: 企业微信Webhook集成，用户提供的webhook已测试通过
- **桥接脚本**: 创建了openclaw_wechat_bridge.py，支持OpenClaw和企业微信的双向通信

---
最后更新：2026-02-12 06:01 UTC