# Claude Code + DeepSeek

一行命令，让 Claude Code 走 DeepSeek API，无需代理。

## 快速开始

### 1. 安装 Claude Code

```bash
npm install -g @anthropic-ai/claude-code
```

或者用 Homebrew（macOS）：

```bash
brew install --cask claude-code
```

### 2. 配置 DeepSeek API

```bash
# 复制环境变量模板
cp deepseek-env.template.sh deepseek-env.sh

# 编辑文件，填入你的 DeepSeek API Key
# 把 *** 替换成你的 key
vi deepseek-env.sh
```

### 3. 加载配置并开始用

```bash
source deepseek-env.sh
claude
```

搞定！输入你的任务，Claude Code 就会用 DeepSeek 的模型来执行。

## 验证

跑个简单测试确认一切正常：

```bash
source deepseek-env.sh
claude -p "Say hello in Chinese, one sentence." --max-turns 1 --output-format text
```

预期输出类似：`你好！很高兴见到你。`

## 配置说明

| 环境变量 | 作用 |
|---------|------|
| `ANTHROPIC_BASE_URL` | 指向 DeepSeek 的 Anthropic 兼容端点 |
| `ANTHROPIC_AUTH_TOKEN` | 你的 DeepSeek API Key |
| `ANTHROPIC_MODEL` | 默认模型 |
| `ANTHROPIC_DEFAULT_OPUS_MODEL` | Claude Code 内部请求 "opus" 时重定向 |
| `ANTHROPIC_DEFAULT_SONNET_MODEL` | Claude Code 内部请求 "sonnet" 时重定向 |
| `ANTHROPIC_DEFAULT_HAIKU_MODEL` | Claude Code 内部请求 "haiku" 时重定向 |
| `CLAUDE_CODE_SUBAGENT_MODEL` | 子 agent 用的模型（建议用 flash 省钱） |
| `CLAUDE_CODE_EFFORT_LEVEL` | 推理深度：low/medium/high/max |
| `CLAUDE_CODE_MAX_CONTEXT_TOKENS` | 上下文窗口（DeepSeek v4 支持 1M） |

## 模型选择

| 场景 | 推荐模型 | 说明 |
|------|---------|------|
| 主力干活 | `deepseek-v4-pro` | 最强推理，1M 上下文 |
| 快任务 / 子 agent | `deepseek-v4-flash` | 便宜快速 |
| 超长上下文 | `deepseek-v4-pro` + `CLAUDE_CODE_MAX_CONTEXT_TOKENS=1000000` | 解锁完整 1M |

## 持久化配置

如果不想每次 `source`，把 `deepseek-env.sh` 里的 export 行加到 `~/.zshrc` 或 `~/.bashrc`：

```bash
cat deepseek-env.sh >> ~/.zshrc
source ~/.zshrc
```

## 常见问题

**Q: 为什么有那么多 `DEFAULT_*_MODEL` 变量？**

Claude Code 内部会对不同任务请求不同的 Claude 模型名（opus/sonnet/haiku）。如果只设 `ANTHROPIC_MODEL`，当它请求 `claude-sonnet-4-6` 时 DeepSeek 会返回 "model not found"。这些变量把所有模型请求都重定向到 DeepSeek 的模型。

**Q: 需要代理/翻墙吗？**

不需要。DeepSeek 提供的是原生 Anthropic 兼容端点（`https://api.deepseek.com/anthropic`），Claude Code 直接连接即可。没有任何中间代理。

**Q: 支持哪些 DeepSeek 模型？**

目前支持 `deepseek-v4-pro` 和 `deepseek-v4-flash`。

**Q: 报错 404？**

检查 `ANTHROPIC_BASE_URL` 是不是小写的 `/anthropic`（不是 `/Anthropic`），大写会返回 404。

## 参考

- [DeepSeek API 文档 - Claude Code 集成](https://api-docs.deepseek.com)
- [Claude Code 官方文档](https://code.claude.com/docs/en/cli-reference)
