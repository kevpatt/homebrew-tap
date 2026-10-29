# kevpatt/tap

Homebrew formulae by Kevin H. Patterson.

| Formula | Description |
|---|---|
| [`zar`](Formula/zar.rb) | [zar and unzar](https://github.com/kevpatt/zar): random-access archives, compressed with zstd |

## Installing

```sh
brew install kevpatt/tap/zar
```

or, to keep the tap for later updates:

```sh
brew tap kevpatt/tap
brew install zar
```

`brew install --HEAD kevpatt/tap/zar` builds the latest commit on `main`
instead of the latest release.

## Updating the formula for a new release

After tagging `vX.Y.Z` in zar:

```sh
brew bump-formula-pr --version=X.Y.Z kevpatt/tap/zar
```

or edit `url` and `sha256` in `Formula/zar.rb` by hand; the checksum is
`curl -sL <url> | shasum -a 256`. Check the result with:

```sh
brew install --build-from-source kevpatt/tap/zar
brew test kevpatt/tap/zar
brew audit --strict --online kevpatt/tap/zar
```
