cask "fkeys" do
  version :latest
  # The rolling `latest` tag is rebuilt on every push, so the artifact's hash
  # changes each time and cannot be pinned.
  sha256 :no_check

  url "https://github.com/markoboskoauroville/FKeys/releases/download/latest/FKeys.zip",
      verified: "github.com/markoboskoauroville/FKeys/"
  name "FKeys"
  desc "Menu bar switch between function keys and media controls"
  homepage "https://github.com/markoboskoauroville/FKeys"

  depends_on macos: ">= :ventura"

  app "FKeys.app"

  # The app is ad-hoc signed rather than notarized, so macOS would refuse to
  # open it while the quarantine attribute is present.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/FKeys.app"]
  end

  uninstall quit: "com.mantraproductions.fkeys"

  zap trash: [
    "~/Library/Preferences/com.mantraproductions.fkeys.plist",
  ]
end
