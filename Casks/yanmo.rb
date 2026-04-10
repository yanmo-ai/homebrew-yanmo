cask "yanmo" do
  version "0.5.7"
  sha256 "49fbeebc8ab9b00902bc0c76e15a399576cd2f1204152138fa5dd724ecfb5d4d"

  url "https://github.com/yanmo-ai/homebrew-yanmo/releases/download/release-2026-04-09/Yanmo-v0.5.7.zip"
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
