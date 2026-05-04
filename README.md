[English](README_en.md) | 中文

# jr

[![License: AGPL v3](https://img.shields.io/badge/License-AGPL%20v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)
![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20macOS%20%7C%20BSD-lightgrey.svg)
![Version](https://img.shields.io/badge/version-2.0.0-green.svg)

极简主义的终端日志工具，为那些习惯用终端思考的开发者而生。

jr 不试图成为另一个笔记应用。它只做一件事：让你在终端里快速记录日志，然后安静地离开。数据是你的，格式是 Markdown，同步由 Git 处理。

## 设计哲学

**做一件事，并做好它。**

- 输入即记录，零摩擦
- Markdown 即格式，可读可迁移
- Git 即同步，冲突自愈
- 隔离即安全，敏感数据永不上传

## 安装

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/DonJone/jr/main/install.sh)"
```

脚本会自动检测环境、安装依赖、配置 PATH。如果需要云同步，会引导你完成 GitHub 授权。

### 依赖

| 组件 | 必需 | 说明 |
|------|------|------|
| `git` | ✓ | 版本控制 |
| `curl` | ✓ | 下载安装 |
| `gh` | 可选 | GitHub CLI，用于云同步 |

## 快速开始

```bash
# 记录一条日志
jr "今天重构了认证模块"

# 用编辑器打开今天的日志
jr -c

# 仅记录到本地备份（不触发云端同步）
jr -l "本地调试笔记"

# 记录到隔离区（永远不会上传）
jr -p "服务器密码: xxx"

# 从管道读取
echo "自动化脚本输出" | jr

# 查看当前状态
jr --status
```

## 目录结构

```
~/Documents/
├── Journal/              # 同步区 → GitHub
│   └── 2026/05/
│       └── 2026-05-04.md
├── Journal_local/        # 本地备份（有网时也会同步）
│   └── 2026/05/
│       └── 2026-05-04_local.md
└── Journal_private/      # 隔离区（永不上传）
    └── 2026/05/
        └── 2026-05-04_private.md
```

## 用法

```
jr [选项] [内容]

记录模式:
  "内容"                  记录到同步区 + 本地备份
  -l, --local "内容"      仅记录到本地备份
  -p, --private "内容"    记录到隔离区（永不上传）

编辑器:
  -c, --code              VS Code
  -g, --gnome             GNOME Text Editor
  -k, --kde               Kate
  -m, --macos             macOS TextEdit
  -e, --edit              $EDITOR 或系统默认
  -x, --xdg               xdg-open (Linux)

管理:
  --login                 GitHub 登录
  --status                查看状态
  -q, --quiet             静默模式
  -v, --verbose           调试模式
  -V, --version           版本信息
  -h, --help              帮助
```

## 配置

配置文件：`~/.config/jr/config`

```bash
# 自定义目录路径
sync_dir="$HOME/Documents/Journal"
local_dir="$HOME/Documents/Journal_local"
private_dir="$HOME/Documents/Journal_private"
```

## 平台支持

| 平台 | 状态 |
|------|------|
| Linux (Ubuntu/Debian/Fedora/Arch) | ✓ |
| macOS | ✓ |
| FreeBSD | ✓ |
| OpenBSD | ✓ |
| NetBSD | ✓ |
| DragonFlyBSD | ✓ |

## 设计决策

**为什么用 Markdown？**
纯文本，可 grep，可 Git diff，任何编辑器都能打开。十年后你的日志依然可读。

**为什么用 Git 同步？**
冲突解决是已解决的问题。不发明轮子，用 Git 的 rebase 策略处理多设备同步。

**为什么有隔离区？**
密码、token、私人笔记不应该出现在 Git 历史里。物理隔离是最安全的隔离。

**为什么需要 gh？**
GitHub CLI 处理 OAuth 认证和仓库操作，比手写 token 更安全，比配置 SSH 更简单。

## 卸载

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/DonJone/jr/main/uninstall.sh)"
```

卸载不会删除你的日志数据。

## 协议

[AGPL-3.0](LICENSE)
