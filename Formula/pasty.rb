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

  def caveats
    <<~EOS
      The source repository is private, so Homebrew clones it with your own git
      credentials. Run this once if you have not already:

        gh auth login

      Link the app where macOS will find it:

        ln -sfn #{opt_prefix}/Pasty.app ~/Applications/Pasty.app

      Then open it and grant Accessibility permission when asked. That grant is
      what lets one click paste straight into the app you came from.

      Update later with:

        brew upgrade --fetch-HEAD pasty
    EOS
  end

  test do
    assert_predicate prefix/"Pasty.app/Contents/MacOS/Pasty", :exist?
  end
end
