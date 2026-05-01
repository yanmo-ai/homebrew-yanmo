cask "yanmo" do
  version "0.5.9"
  sha256 "003dba88d0f39892838c32811346c8014a8e53ca5cf3409507c7b9f48b5f699d"

  url "https://github.com/yanmo-ai/homebrew-yanmo/releases/download/release-2026-05-01/Yanmo-v0.5.9.zip"
  name "Yanmo"
  name "言墨"
  desc "AI-powered voice dictation tool"
  homepage "https://github.com/yanmo-ai/yanmo"

  depends_on macos: ">= :sonoma"

  auto_updates true

  app "Yanmo.app"

  postflight do
    system_command "/usr/bin/xattr", args: ["-d", "com.apple.quarantine", "#{appdir}/Yanmo.app"]
  end

  uninstall quit: "com.microsoft.aidictation.mac"

  zap trash: [
    "~/Library/Preferences/com.microsoft.aidictation.mac.plist",
    "~/Library/Application Support/Yanmo",
    "~/Library/Logs/Yanmo",
    "~/Library/Caches/com.microsoft.aidictation.mac",
    "~/Library/HTTPStorages/com.microsoft.aidictation.mac",
    "~/Library/HTTPStorages/com.microsoft.aidictation.mac.binarycookies",
  ]
end
