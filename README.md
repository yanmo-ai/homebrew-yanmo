# Homebrew Tap for Yanmo 言墨

macOS 语音听写工具，自然说话，即刻获得润色文本。

## 安装

需要 [Homebrew](https://brew.sh/) 和 macOS 14.0+ (Sonoma)。

```bash
brew tap yanmo-ai/yanmo
brew install --cask yanmo
```

## 升级

```bash
brew upgrade --cask yanmo
```

## 卸载

```bash
brew uninstall --cask yanmo
```

彻底清理（包括配置、日志、缓存）：

```bash
brew zap yanmo
```

---

## 发布新版本（维护者）

### 一次性准备

```bash
# 1. 安装 GitHub CLI
brew install gh

# 2. 登录 GitHub
gh auth login

# 3. 克隆本仓库
git clone https://github.com/yanmo-ai/homebrew-yanmo.git ~/Repos/homebrew-yanmo
```

### 发布流程

1. 在主项目中构建 DMG：`bash scripts/create-dmg.sh`
2. 运行发布脚本：

```bash
cd ~/Repos/homebrew-yanmo
bash release.sh ~/Desktop/Yanmo_vX.Y.Z.dmg
```

脚本自动完成：

| 步骤 | 操作 |
|------|------|
| 1 | DMG 提取 app → ZIP 打包 |
| 2 | 创建 GitHub Release + 上传 ZIP |
| 3 | 更新 Cask（version、sha256、url） |
| 4 | Commit + Push 到本仓库 |

### 验证

```bash
# 更新 tap 并重新安装
brew update
brew reinstall --cask yanmo

# 验证版本
/Applications/Yanmo.app/Contents/MacOS/Yanmo --version 2>/dev/null || \
  /usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" /Applications/Yanmo.app/Contents/Info.plist
```
