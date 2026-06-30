# ============================================================
# Claude Code + DeepSeek API 配置 (PowerShell)
#
# 使用方式:
#   . .\deepseek-env.ps1    # 加载配置
#   claude                  # 启动 Claude Code
#
# 参考: https://api-docs.deepseek.com (Agent Integrations - Claude Code)
# ============================================================

# DeepSeek 原生 Anthropic 兼容端点 (注意: 小写 /anthropic, 大写会 404)
$env:ANTHROPIC_BASE_URL = "https://api.deepseek.com/anthropic"

# 你的 DeepSeek API Key — 在这里填入你的 key
$env:ANTHROPIC_AUTH_TOKEN = "***"

# 默认模型
$env:ANTHROPIC_MODEL = "deepseek-v4-pro"

# Claude Code 内部会用不同的模型别名, 全部重定向到 DeepSeek
$env:ANTHROPIC_DEFAULT_OPUS_MODEL = "deepseek-v4-pro"
$env:ANTHROPIC_DEFAULT_SONNET_MODEL = "deepseek-v4-pro"
$env:ANTHROPIC_DEFAULT_HAIKU_MODEL = "deepseek-v4-flash"

# 子 agent 用快速模型 (省钱)
$env:CLAUDE_CODE_SUBAGENT_MODEL = "deepseek-v4-flash"

# 推理深度: low | medium | high | max
$env:CLAUDE_CODE_EFFORT_LEVEL = "max"

# 上下文窗口 (DeepSeek v4 支持 1M token, 但 Claude Code 默认只开 200K)
# 取消下面这行注释来解锁完整的 1M:
# $env:CLAUDE_CODE_MAX_CONTEXT_TOKENS = 1000000

Write-Host "✅ DeepSeek 环境变量已加载" -ForegroundColor Green
Write-Host "   claude 启动 Claude Code" -ForegroundColor Gray
