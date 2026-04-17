cask "yanmo" do
  version "0.5.8"
  sha256 "932610c791bd858debe68a5656e2cdd2b60d6c85efdd1a0e070932ce316db927"

  url "https://github.com/yanmo-ai/homebrew-yanmo/releases/download/release-2026-04-17/Yanmo-v0.5.8.zip"
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
