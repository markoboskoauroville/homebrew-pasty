# Homebrew tap for Pasty

```
brew tap markoboskoauroville/pasty
brew install --HEAD pasty
```

Pasty is a macOS clipboard manager with a single board and inline pinning.

The formula builds from source and links `Pasty.app` into your Applications
folder, since a formula has no App stanza the way a cask does. The link points
at the build Homebrew manages, so `brew upgrade --fetch-HEAD pasty` updates the
app in place.

The source repository is private, so Homebrew clones it with your own git
credentials. Run `gh auth login` once and it works. This tap contains only the
formula and no code.
