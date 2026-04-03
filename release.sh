#!/bin/bash
# Release Yanmo via Homebrew: DMG → ZIP → GitHub Release → Update Cask
#
# 用法：bash release.sh ~/Desktop/Yanmo_v0.5.6.dmg
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BUILD_DIR="/tmp/yanmo-release"
APP_NAME="Yanmo"
HOMEBREW_REPO="yanmo-ai/homebrew-yanmo"
CASK_FILE="$SCRIPT_DIR/Casks/yanmo.rb"

DMG_FILE="${1:-}"
if [ -z "$DMG_FILE" ] || [ ! -f "$DMG_FILE" ]; then
    echo "用法: bash release.sh <path-to-dmg>"
    exit 1
fi

# Step 1: DMG → ZIP
echo "==> Step 1: Extracting app from DMG and creating ZIP..."
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"
MOUNT_POINT="/Volumes/Yanmo Installer"
hdiutil detach "$MOUNT_POINT" -force 2>/dev/null || true
hdiutil attach "$DMG_FILE" -nobrowse -quiet

APP_PATH="$BUILD_DIR/$APP_NAME.app"
cp -R "$MOUNT_POINT/$APP_NAME.app" "$APP_PATH"
hdiutil detach "$MOUNT_POINT" -quiet

VERSION=$(/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" "$APP_PATH/Contents/Info.plist")
ZIP_NAME="${APP_NAME}-v${VERSION}.zip"
ZIP_FILE="$BUILD_DIR/$ZIP_NAME"

cd "$BUILD_DIR"
ditto -c -k --keepParent "$APP_NAME.app" "$ZIP_FILE"

SHA256=$(shasum -a 256 "$ZIP_FILE" | awk '{print $1}')
TAG="release-$(date +%Y-%m-%d)"

echo "    Version: $VERSION"
echo "    SHA256:  $SHA256"
echo "    ZIP:     $ZIP_FILE"
echo "    Tag:     $TAG"

# Step 2: GitHub Release + upload
echo ""
echo "==> Step 2: Creating GitHub Release..."
if gh release view "$TAG" --repo "$HOMEBREW_REPO" >/dev/null 2>&1; then
    echo "    Release $TAG exists, uploading asset..."
    gh release upload "$TAG" "$ZIP_FILE" --repo "$HOMEBREW_REPO" --clobber
else
    gh release create "$TAG" "$ZIP_FILE" \
        --repo "$HOMEBREW_REPO" \
        --title "Yanmo v${VERSION}" \
        --notes "Yanmo 言墨 macOS v${VERSION}"
fi
DOWNLOAD_URL="https://github.com/${HOMEBREW_REPO}/releases/download/${TAG}/${ZIP_NAME}"
echo "    URL: $DOWNLOAD_URL"

# Step 3: Update Cask
echo ""
echo "==> Step 3: Updating Cask..."
sed -i '' "s|version \".*\"|version \"${VERSION}\"|" "$CASK_FILE"
sed -i '' "s|sha256 \".*\"|sha256 \"${SHA256}\"|" "$CASK_FILE"
sed -i '' "s|url \".*\"|url \"${DOWNLOAD_URL}\"|" "$CASK_FILE"
echo "    Updated: $CASK_FILE"

# Step 4: Push
echo ""
echo "==> Step 4: Pushing..."
cd "$SCRIPT_DIR"
git add -A
git diff --cached --quiet && echo "    No changes." || {
    git commit -m "Bump yanmo to ${VERSION}"
    git push
    echo "    Pushed."
}

# Cleanup
rm -rf "$BUILD_DIR"

echo ""
echo "==> Done! Install with:"
echo "    brew tap yanmo-ai/yanmo"
echo "    brew install --cask yanmo"
