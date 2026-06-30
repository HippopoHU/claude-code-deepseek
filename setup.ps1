# ============================================================
# Claude Code + DeepSeek 一键配置脚本 (PowerShell)
# ============================================================

Write-Host "============================================"  -ForegroundColor Cyan
Write-Host " Claude Code + DeepSeek 安装配置 (Windows)" -ForegroundColor Cyan
Write-Host "============================================"  -ForegroundColor Cyan
Write-Host ""

# 检查 Node.js
try {
    $nodeVersion = node -v
    Write-Host "✅ Node.js $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ 未检测到 Node.js, 请先安装: https://nodejs.org" -ForegroundColor Red
    Write-Host "   推荐下载 LTS 版本 (Windows Installer .msi)" -ForegroundColor Yellow
    exit 1
}

# 安装 Claude Code
try {
    $claudeVersion = claude --version 2>$null
    Write-Host "✅ Claude Code 已安装" -ForegroundColor Green
} catch {
    Write-Host "📦 正在安装 Claude Code..." -ForegroundColor Yellow
    npm install -g @anthropic-ai/claude-code
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Claude Code 安装完成" -ForegroundColor Green
    } else {
        Write-Host "❌ Claude Code 安装失败, 请检查 Node.js 和 npm 配置" -ForegroundColor Red
        exit 1
    }
}

# 检查配置文件
$envConfigured = $false
if (Test-Path "deepseek-env.ps1") {
    $content = Get-Content "deepseek-env.ps1" -Raw
    if ($content -notmatch 'ANTHROPIC_AUTH_TOKEN = "\*\*\*"') {
        $envConfigured = $true
    }
}

if ($envConfigured) {
    Write-Host "✅ deepseek-env.ps1 已配置 API Key" -ForegroundColor Green
} else {
    if ($env:DEEPSEEK_KEY) {
        Write-Host "📝 检测到 DEEPSEEK_KEY 环境变量, 自动创建配置文件..." -ForegroundColor Yellow
        $template = Get-Content "deepseek-env.ps1" -Raw
        if (-not $template) {
            # Use the template file
            $template = Get-Content "deepseek-env.template.sh" -Raw
            # Convert bash format to PowerShell
            $template = $template -replace 'export (\w+)="([^"]*)"', '$env:$1 = "$2"'
            $template = $template -replace '# (.*)', '# $1'
            $template = $template -replace 'source.*', '. .\deepseek-env.ps1'
            $template += "`nWrite-Host `"✅ DeepSeek 环境变量已加载`" -ForegroundColor Green`n"
        }
        $template = $template -replace 'ANTHROPIC_AUTH_TOKEN = "\*\*\*"', "ANTHROPIC_AUTH_TOKEN = `"$env:DEEPSEEK_KEY`""
        $template | Out-File -FilePath "deepseek-env.ps1" -Encoding utf8
        Write-Host "✅ deepseek-env.ps1 已创建" -ForegroundColor Green
    } else {
        Write-Host ""
        Write-Host "⚠️  请配置你的 DeepSeek API Key:" -ForegroundColor Yellow
        Write-Host "   方式1: 编辑 deepseek-env.ps1, 把 *** 替换成你的 key" -ForegroundColor White
        Write-Host "   方式2: `$env:DEEPSEEK_KEY='你的key'; .\setup.ps1" -ForegroundColor White
        Write-Host ""
        Write-Host "获取 API Key: https://platform.deepseek.com/api_keys" -ForegroundColor Gray
        exit 0
    }
}

Write-Host ""
Write-Host "============================================"  -ForegroundColor Cyan
Write-Host " ✅ 安装完成!" -ForegroundColor Green
Write-Host "============================================"  -ForegroundColor Cyan
Write-Host ""
Write-Host "使用方式:" -ForegroundColor White
Write-Host "  . .\deepseek-env.ps1   # 加载配置" -ForegroundColor Gray
Write-Host "  claude                 # 启动 Claude Code" -ForegroundColor Gray
Write-Host ""
Write-Host "测试一下:" -ForegroundColor White
Write-Host "  . .\deepseek-env.ps1; claude -p '你好' --max-turns 1 --output-format text" -ForegroundColor Gray
Write-Host ""
Write-Host "💡 提示: 如果 PowerShell 提示执行策略限制, 先运行:" -ForegroundColor Yellow
Write-Host "   Set-ExecutionPolicy -Scope CurrentUser RemoteSigned" -ForegroundColor Gray
Write-Host ""
