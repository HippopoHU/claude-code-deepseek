#!/bin/bash
# ============================================================
# Claude Code + DeepSeek 一键配置脚本
# ============================================================
set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "============================================"
echo " Claude Code + DeepSeek 安装配置"
echo "============================================"
echo ""

# 检查 Node.js
if ! command -v node &> /dev/null; then
    echo -e "${RED}❌ 未检测到 Node.js, 请先安装: https://nodejs.org${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Node.js $(node -v)${NC}"

# 安装 Claude Code
if command -v claude &> /dev/null; then
    echo -e "${GREEN}✅ Claude Code 已安装${NC}"
else
    echo "📦 正在安装 Claude Code..."
    npm install -g @anthropic-ai/claude-code
    echo -e "${GREEN}✅ Claude Code 安装完成${NC}"
fi

# 检查 API Key 是否已配置
if [ -f deepseek-env.sh ]; then
    if grep -qF 'ANTHROPIC_AUTH_TOKEN=***' deepseek-env.sh 2>/dev/null; then
        HAS_KEY=false
    else
        HAS_KEY=true
    fi
else
    HAS_KEY=false
fi

if $HAS_KEY; then
    echo -e "${GREEN}✅ deepseek-env.sh 已配置 API Key${NC}"
else
    if [ -n "$DEEPSEEK_KEY" ]; then
        echo "📝 检测到 DEEPSEEK_KEY 环境变量, 自动创建配置文件..."
        python3 -c "
import os
with open('deepseek-env.template.sh') as f:
    content = f.read()
content = content.replace('ANTHROPIC_AUTH_TOKEN=***', f'ANTHROPIC_AUTH_TOKEN={os.environ[\"DEEPSEEK_KEY\"]}')
with open('deepseek-env.sh', 'w') as f:
    f.write(content)
"
        chmod 600 deepseek-env.sh
        echo -e "${GREEN}✅ deepseek-env.sh 已创建${NC}"
    else
        echo ""
        echo -e "${YELLOW}⚠️  请配置你的 DeepSeek API Key:${NC}"
        echo "   方式1: cp deepseek-env.template.sh deepseek-env.sh && vi deepseek-env.sh"
        echo "          把 *** 替换成你的 key"
        echo "   方式2: export DEEPSEEK_KEY=你的key && ./setup.sh"
        echo ""
        echo "获取 API Key: https://platform.deepseek.com/api_keys"
        exit 0
    fi
fi

echo ""
echo "============================================"
echo -e " ${GREEN}✅ 安装完成!${NC}"
echo "============================================"
echo ""
echo "使用方式:"
echo "  source deepseek-env.sh   # 加载配置"
echo "  claude                   # 启动 Claude Code"
echo ""
echo "测试一下:"
echo "  source deepseek-env.sh && claude -p '你好' --max-turns 1 --output-format text"
echo ""
