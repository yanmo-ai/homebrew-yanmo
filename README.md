# Homebrew Tap for Yanmo 言墨

macOS 语音听写工具，自然说话，即刻获得润色文本。

## 安装

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

## 发布新版本

```bash
bash release.sh ~/Desktop/Yanmo_vX.Y.Z.dmg
```

脚本自动完成：DMG 提取 → ZIP 打包 → GitHub Release 上传 → Cask 更新 → Push。

需要 [GitHub CLI](https://cli.github.com/)（`brew install gh`）并已登录（`gh auth login`）。
