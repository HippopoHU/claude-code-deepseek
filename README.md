# Claude Code + DeepSeek

无需代理，让 Claude Code 直接使用 DeepSeek API。支持 macOS / Linux / Windows。

> DeepSeek 提供了原生 Anthropic 兼容端点 (`api.deepseek.com/anthropic`)，Claude Code 可以直接连接，无需任何中间代理。

## 🚀 快速开始

### macOS / Linux

```bash
# 1. 安装 Claude Code
npm install -g @anthropic-ai/claude-code

# 2. 一键配置 (填入你的 DeepSeek API Key)
export DEEPSEEK_KEY=你的key
./setup.sh

# 3. 开始用
source deepseek-env.sh
claude
```

### Windows (PowerShell)

```powershell
# 1. 安装 Claude Code
npm install -g @anthropic-ai/claude-code

# 2. 一键配置 (填入你的 DeepSeek API Key)
$env:DEEPSEEK_KEY='你的key'
.\setup.ps1

# 3. 开始用
. .\deepseek-env.ps1
claude
```

> 💡 如果 PowerShell 提示执行策略限制，先运行：`Set-ExecutionPolicy -Scope CurrentUser RemoteSigned`

---

## ✅ 验证

**macOS / Linux:**
```bash
source deepseek-env.sh
claude -p "你好" --max-turns 1 --output-format text
```

**Windows:**
```powershell
. .\deepseek-env.ps1
claude -p "你好" --max-turns 1 --output-format text
```

预期输出：`你好！很高兴见到你。`

---

## 📋 手动配置

如果不想用一键脚本，也可以手动配置环境变量：

**macOS / Linux** — 编辑 `deepseek-env.sh`，把 `***` 替换成你的 API Key：
```bash
export ANTHROPIC_BASE_URL="https://api.deepseek.com/anthropic"
export ANTHROPIC_AUTH_TOKEN=你的key
export ANTHROPIC_MODEL="deepseek-v4-pro"
export ANTHROPIC_DEFAULT_OPUS_MODEL="deepseek-v4-pro"
export ANTHROPIC_DEFAULT_SONNET_MODEL="deepseek-v4-pro"
export ANTHROPIC_DEFAULT_HAIKU_MODEL="deepseek-v4-flash"
export CLAUDE_CODE_SUBAGENT_MODEL="deepseek-v4-flash"
export CLAUDE_CODE_EFFORT_LEVEL="max"
```

**Windows** — 编辑 `deepseek-env.ps1`，把 `***` 替换成你的 API Key：
```powershell
$env:ANTHROPIC_BASE_URL = "https://api.deepseek.com/anthropic"
$env:ANTHROPIC_AUTH_TOKEN = "你的key"
$env:ANTHROPIC_MODEL = "deepseek-v4-pro"
$env:ANTHROPIC_DEFAULT_OPUS_MODEL = "deepseek-v4-pro"
$env:ANTHROPIC_DEFAULT_SONNET_MODEL = "deepseek-v4-pro"
$env:ANTHROPIC_DEFAULT_HAIKU_MODEL = "deepseek-v4-flash"
$env:CLAUDE_CODE_SUBAGENT_MODEL = "deepseek-v4-flash"
$env:CLAUDE_CODE_EFFORT_LEVEL = "max"
```

---

## 📖 配置说明

| 环境变量 | 作用 |
|---------|------|
| `ANTHROPIC_BASE_URL` | 指向 DeepSeek 的 Anthropic 兼容端点 |
| `ANTHROPIC_AUTH_TOKEN` | 你的 DeepSeek API Key |
| `ANTHROPIC_MODEL` | 默认模型 |
| `ANTHROPIC_DEFAULT_OPUS_MODEL` | Claude Code 内部请求 "opus" 时重定向 |
| `ANTHROPIC_DEFAULT_SONNET_MODEL` | Claude Code 内部请求 "sonnet" 时重定向 |
| `ANTHROPIC_DEFAULT_HAIKU_MODEL` | Claude Code 内部请求 "haiku" 时重定向 |
| `CLAUDE_CODE_SUBAGENT_MODEL` | 子 agent 用的模型（建议用 flash 省钱） |
| `CLAUDE_CODE_EFFORT_LEVEL` | 推理深度：low / medium / high / max |
| `CLAUDE_CODE_MAX_CONTEXT_TOKENS` | 上下文窗口（DeepSeek v4 支持 1M） |

## 🎯 模型选择

| 场景 | 推荐模型 | 说明 |
|------|---------|------|
| 主力干活 | `deepseek-v4-pro` | 最强推理，1M 上下文 |
| 快任务 / 子 agent | `deepseek-v4-flash` | 便宜快速 |
| 超长上下文 | `deepseek-v4-pro` + 解锁 1M | 设置 `CLAUDE_CODE_MAX_CONTEXT_TOKENS=*** |

## 🔧 持久化配置

**macOS / Linux** — 加到 shell 配置文件：
```bash
cat deepseek-env.sh >> ~/.zshrc   # 或 ~/.bashrc
source ~/.zshrc
```

**Windows** — 加到 PowerShell Profile：
```powershell
notepad $PROFILE
# 加入: . C:\path\to\deepseek-env.ps1
```

## ❓ 常见问题

**Q: 为什么有那么多 `DEFAULT_*_MODEL` 变量？**

Claude Code 内部会对不同任务请求不同的 Claude 模型名（opus/sonnet/haiku）。如果只设 `ANTHROPIC_MODEL`，当它请求 `claude-sonnet-4-6` 时 DeepSeek 会返回 "model not found"。这些变量把所有模型请求都重定向到 DeepSeek 的模型。

**Q: 需要代理/翻墙吗？**

不需要。DeepSeek 提供的是原生 Anthropic 兼容端点，Claude Code 直接连接即可。没有任何中间代理。

**Q: 支持哪些 DeepSeek 模型？**

目前支持 `deepseek-v4-pro` 和 `deepseek-v4-flash`。

**Q: 报错 404？**

检查 `ANTHROPIC_BASE_URL` 是不是小写的 `/anthropic`（不是 `/Anthropic`），大写会返回 404。

**Q: Windows 上报错 "无法加载文件 ... 因为在此系统上禁止运行脚本"？**

运行：`Set-ExecutionPolicy -Scope CurrentUser RemoteSigned`

---

## 📚 参考

- [DeepSeek API 文档 - Claude Code 集成](https://api-docs.deepseek.com)
- [Claude Code 官方文档](https://code.claude.com/docs/en/cli-reference)
