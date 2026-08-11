# Homebrew tap for Mantra tools

## FKeys

Menu bar switch between function keys and media controls. Prebuilt, no
toolchain needed.

```
brew install --cask markoboskoauroville/pasty/fkeys
```

## Pasty

Clipboard manager with a single board and inline pinning.

```
brew install --HEAD markoboskoauroville/pasty/pasty
```

Pasty builds from source out of a private repository, so Homebrew clones it with
your own git credentials. Run `gh auth login` once. It also needs a working
Swift toolchain; FKeys does not, because the cask downloads a finished app.
