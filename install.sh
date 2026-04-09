#!/bin/bash

# ==========================================
# jr 日志工具  一键安装脚本
# ==========================================

# 配置
REPO_URL="https://raw.githubusercontent.com/DonJone/Jr/main"
BIN_DIR="$HOME/.local/bin"
TARGET="$BIN_DIR/jr"

# 颜色控制
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}>>> 正在启动 jr 日志工具一键安装...${NC}"

# 1. 环境预检
# 检查强制依赖
for cmd in git curl; do
    if ! command -v $cmd &> /dev/null; then
        echo -e "${RED}错误: 未检测到 $cmd，请先安装它以继续。${NC}"
        exit 1
    fi
done

# 交互式检查 GitHub CLI (gh)
if ! command -v gh &> /dev/null; then
    echo -e "${YELLOW}提示: 未检测到 GitHub CLI (gh)。${NC}"
    echo -e "注意：jr 的云端同步与自愈功能依赖 gh 访问 GitHub。"
    
    # 引导用户选择
    read -p "是否现在安装 gh? (y/n/s 跳过): " ACTION
    case "$ACTION" in
        y|Y)
            echo -e "${BLUE}>>> 正在尝试引导安装...${NC}"
            if [[ "$OSTYPE" == "linux-gnu"* ]]; then
                echo -e "请运行: ${CYAN}sudo apt install gh${NC} 或参考 https://cli.github.com/"
            elif [[ "$OSTYPE" == "darwin"* ]]; then
                echo -e "请运行: ${CYAN}brew install gh${NC}"
            fi
            echo -e "${YELLOW}请在安装并执行 'gh auth login' 后重新运行此脚本。${NC}"
            exit 0
            ;;
        n|N|s|S)
            echo -e "${YELLOW}警告: 跳过 gh 安装。jr 将仅能运行在本地模式 (-l)，云端同步将失效。${NC}"
            sleep 2
            ;;
        *)
            echo -e "无效输入，默认跳过。"
            ;;
    esac
else
    # 已安装 gh，进一步检查登录状态
    if ! gh auth status &> /dev/null; then
        echo -e "${YELLOW}提示: gh 已安装但未登录。${NC}"
        echo -e "建议执行 ${CYAN}gh auth login${NC} 以确保 jr 同步功能正常。"
    fi
fi

# 2. 准备目录
mkdir -p "$BIN_DIR"

# 3. 下载并授权
echo -e "正在从云端下载主程序..."
if curl -fsSL "$REPO_URL/jr" -o "$TARGET"; then
    chmod +x "$TARGET"
    echo -e "${GREEN}成功: 已安装至 $BIN_DIR/jr${NC}"
else
    echo -e "${RED}错误: 下载失败，请检查网络连接。${NC}"
    exit 1
fi

# 4. 智能识别 Shell 并配置 PATH
# 优先识别当前活跃的 Shell，其次识别系统默认 Shell
CURRENT_SHELL=$(basename "$SHELL")
RC_FILE=""

case "$CURRENT_SHELL" in
    zsh)  RC_FILE="$HOME/.zshrc" ;;
    bash) RC_FILE="$HOME/.bashrc" ;;
    *)    RC_FILE="$HOME/.profile" ;;
esac

echo -e "检测到 Shell 环境: ${BLUE}$CURRENT_SHELL${NC}"
echo -e "配置文件路径: ${BLUE}$RC_FILE${NC}"

# 检查 PATH 是否已配置
PATH_STR='export PATH="$HOME/.local/bin:$PATH"'
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    if ! grep -q ".local/bin" "$RC_FILE" 2>/dev/null; then
        echo -e "${YELLOW}正在自动更新 $RC_FILE 中的 PATH 配置...${NC}"
        echo -e "\n# jr CLI path\n$PATH_STR" >> "$RC_FILE"
        echo -e "${GREEN}配置已完成。${NC}"
    else
        echo "PATH 记录已存在，跳过写入。"
    fi
else
    echo -e "${GREEN}PATH 环境已就绪，无需修改。${NC}"
fi

# 5. 完成提示
echo -e "\n${BLUE}==========================================${NC}"
echo -e "${GREEN}安装成功！(Installation Complete)${NC}"
echo -e "  主目录: ~/Documents/Journal        (推送至云端)"
echo -e "  本地目录: ~/Documents/Journal_local (仅存本地)"
echo -e "\n${YELLOW}请执行以下命令使配置立即生效：${NC}"
echo -e "source $RC_FILE"
echo -e "${BLUE}==========================================${NC}"
