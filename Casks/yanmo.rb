cask "yanmo" do
  version "0.5.6"
  sha256 "82b5c6a5af53c79dd6a8bdd5a9f99ac6faf776651ac010e55369852270f0ba81"

  url "https://github.com/yanmo-ai/homebrew-yanmo/releases/download/release-2026-04-02/Yanmo-v#{version}.zip"
  name "Yanmo"
  name "言墨"
  desc "AI-powered voice dictation tool"
  homepage "https://github.com/yanmo-ai/yanmo"

  depends_on macos: ">= :sonoma"

  app "Yanmo.app"

  postflight do
    system_command "/usr/bin/xattr", args: ["-d", "com.apple.quarantine", "#{appdir}/Yanmo.app"]
  end

  zap trash: [
    "~/Library/Preferences/com.microsoft.aidictation.mac.plist",
    "~/Library/Application Support/default.store",
    "~/Library/Application Support/default.store-shm",
    "~/Library/Application Support/default.store-wal",
    "~/Library/Application Support/Yanmo",
    "~/Library/Logs/Yanmo",
    "~/Library/Caches/com.microsoft.aidictation.mac",
    "~/Library/HTTPStorages/com.microsoft.aidictation.mac",
    "~/Library/HTTPStorages/com.microsoft.aidictation.mac.binarycookies",
  ]
end
