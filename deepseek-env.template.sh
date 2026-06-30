# ============================================================
# Claude Code + DeepSeek API 配置模板
# 
# 使用方式:
#   1. 复制此文件: cp deepseek-env.template.sh deepseek-env.sh
#   2. 把 *** 替换成你的 DeepSeek API Key
#   3. source deepseek-env.sh
#   4. claude
#
# 参考: https://api-docs.deepseek.com (Agent Integrations - Claude Code)
# ============================================================

# DeepSeek 原生 Anthropic 兼容端点 (注意: 小写 /anthropic, 大写会 404)
export ANTHROPIC_BASE_URL="https://api.deepseek.com/anthropic"

# 你的 DeepSeek API Key — 在这里填入你的 key
export ANTHROPIC_AUTH_TOKEN=***

# 默认模型
export ANTHROPIC_MODEL="deepseek-v4-pro"

# Claude Code 内部会用不同的模型别名, 全部重定向到 DeepSeek
export ANTHROPIC_DEFAULT_OPUS_MODEL="deepseek-v4-pro"
export ANTHROPIC_DEFAULT_SONNET_MODEL="deepseek-v4-pro"
export ANTHROPIC_DEFAULT_HAIKU_MODEL="deepseek-v4-flash"

# 子 agent 用快速模型 (省钱)
export CLAUDE_CODE_SUBAGENT_MODEL="deepseek-v4-flash"

# 推理深度: low | medium | high | max
export CLAUDE_CODE_EFFORT_LEVEL="max"

# 上下文窗口 (DeepSeek v4 支持 1M token, 但 Claude Code 默认只开 200K)
# 取消下面这行注释来解锁完整的 1M:
# export CLAUDE_CODE_MAX_CONTEXT_TOKENS=1000000
