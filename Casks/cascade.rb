cask "cascade" do
  version :latest
  # The rolling `latest` tag is rebuilt on every push, so the artifact's hash
  # changes each time and cannot be pinned.
  sha256 :no_check

  url "https://github.com/markoboskoauroville/Cascade/releases/download/latest/Cascade.zip",
      verified: "github.com/markoboskoauroville/Cascade/"
  name "Cascade"
  desc "One click window cascading per display, pairs with AutoRaise"
  homepage "https://github.com/markoboskoauroville/Cascade"

  depends_on macos: ">= :ventura"

  app "Cascade.app"

  # The app is ad-hoc signed rather than notarized, so macOS would refuse to
  # open it while the quarantine attribute is present.
  #
  # Note that Cascade needs Accessibility permission, and because each build is
  # ad-hoc signed its cdhash changes, so macOS quietly drops the existing grant
  # on every upgrade. Toggle it off and on in System Settings afterwards.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Cascade.app"]
  end

  uninstall quit: "com.mantraproductions.cascade"

  zap trash: [
    "~/Library/Preferences/com.mantraproductions.cascade.plist",
  ]
end
