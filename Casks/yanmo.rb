cask "yanmo" do
  version "0.5.10"
  sha256 "858f29f7121d0f315ad842a4b4e9b576c802c41e601bce71d7021fce328e8d0d"

  url "https://github.com/yanmo-ai/homebrew-yanmo/releases/download/release-2026-05-08/Yanmo-v0.5.10.zip"
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
