cask "yanmo" do
  version "0.5.6"
  sha256 "82b5c6a5af53c79dd6a8bdd5a9f99ac6faf776651ac010e55369852270f0ba81"

  url "https://yanmoreleases.blob.core.windows.net/yanmo-releases/Yanmo-v#{version}.zip"
  name "Yanmo"
  name "言墨"
  desc "AI-powered voice dictation tool"
  homepage "https://github.com/yanmo-ai/yanmo"

  depends_on macos: ">= :sonoma"

  app "Yanmo.app"

  zap trash: [
    "~/Library/Preferences/com.microsoft.aidictation.mac.plist",
    "~/Library/Application Support/Yanmo",
    "~/Library/Logs/Yanmo",
    "~/Library/Caches/com.microsoft.aidictation.mac",
  ]
end
