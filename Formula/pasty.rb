class Pasty < Formula
  desc "Clipboard manager for macOS with one board and inline pins"
  homepage "https://github.com/markoboskoauroville/Pasty"
  head "https://github.com/markoboskoauroville/Pasty.git", branch: "main"
  license "MIT"

  depends_on macos: :sonoma
  depends_on xcode: ["15.0", :build]

  def install
    ENV["VERSION"] = "1.0.0"
    ENV["BUILD"] = Time.now.strftime("%Y%m%d%H%M")
    system "bash", "scripts/build_app.sh"
    prefix.install "packaging/Pasty.app"
  end

  # A formula has no App stanza the way a cask does, so the bundle is linked
  # into the Applications folder by hand. opt_prefix is stable across upgrades,
  # so the link keeps pointing at the current build and never goes stale.
  def post_install
    source = opt_prefix/"Pasty.app"
    dir = File.writable?("/Applications") ? "/Applications" : File.expand_path("~/Applications")
    FileUtils.mkdir_p(dir)
    target = File.join(dir, "Pasty.app")
    FileUtils.rm_rf(target) if File.exist?(target) || File.symlink?(target)
    FileUtils.ln_sf(source, target)
    ohai "Linked #{target}"
  end

  def caveats
    <<~EOS
      Pasty.app is now in your Applications folder. It is a link to the build
      Homebrew manages, so an upgrade updates the app in place.

      It is a menu bar app with no Dock icon. Open it once from Applications,
      then reach it with Cmd Shift V or the clipboard icon in the menu bar.

      Grant Accessibility permission when asked. That grant is what lets one
      click paste straight into the app you came from. The app is built locally
      and not signed with a Developer ID, so macOS forgets that grant whenever
      the binary changes. After each upgrade, switch Pasty off and on again in
      System Settings, Privacy and Security, Accessibility.

      Login at startup is best set inside Pasty's own Settings rather than by
      dragging the link into System Settings.

      Update:    brew upgrade --fetch-HEAD pasty
      Uninstall: rm -f /Applications/Pasty.app && brew uninstall pasty
    EOS
  end

  test do
    assert_predicate prefix/"Pasty.app/Contents/MacOS/Pasty", :exist?
  end
end
