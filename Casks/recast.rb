# Homebrew Cask formula for Recast.
#
# This file is the template; `scripts/release/update-homebrew-cask.sh`
# substitutes 0.3.1 / c45006773015bc386051ebcf774c9aea9f3692eada6e94a05a19054facd99d5b / 4067e3683e6e3741d624cad9f900e42387e607fe6289c3f767f4e2bf8cf690e2 on each release
# and pushes the rendered file to `kanakkholwal/homebrew-recast` as
# `Casks/recast.rb`. End users then install with
#
#     brew install --cask kanakkholwal/recast/recast
#
# or — after a one-time `brew tap kanakkholwal/recast` — with the short
#
#     brew install --cask recast
#
# Homebrew strips the macOS quarantine attribute automatically during
# its install, so users on this path never see the Gatekeeper
# "is damaged" error and don't need the `xattr -dr com.apple.quarantine`
# workaround documented for direct-DMG downloads.

cask "recast" do
  version "0.3.1"

  # Apple Silicon (M-series) Mac
  on_arm do
    sha256 "c45006773015bc386051ebcf774c9aea9f3692eada6e94a05a19054facd99d5b"

    url "https://github.com/kanakkholwal/recast/releases/download/v#{version}/recast_#{version}_aarch64.dmg",
        verified: "github.com/kanakkholwal/recast/"
  end

  # Intel Mac
  on_intel do
    sha256 "4067e3683e6e3741d624cad9f900e42387e607fe6289c3f767f4e2bf8cf690e2"

    url "https://github.com/kanakkholwal/recast/releases/download/v#{version}/recast_#{version}_x64.dmg",
        verified: "github.com/kanakkholwal/recast/"
  end

  name "Recast"
  desc "Offline-first desktop screen recorder and editor"
  homepage "https://github.com/kanakkholwal/recast"

  # `brew livecheck` follows the `url` and looks for a newer GitHub
  # release tag. Lets users (and the official homebrew/cask bots, if we
  # ever graduate to it) detect when a new release is available.
  livecheck do
    url :url
    strategy :github_latest
  end

  # Tauri's built-in updater handles in-app upgrades, so we don't want
  # Homebrew also trying to "update" by reinstalling on `brew upgrade`.
  auto_updates true

  app "Recast.app"

  # On `brew uninstall --cask --zap recast`, remove the user-data
  # directories Recast writes outside the app bundle. Bundle identifier
  # mirrors the macOS app's CFBundleIdentifier — verify against
  # `apps/desktop/src-tauri/tauri.conf.json#identifier` if it changes.
  zap trash: [
    "~/Library/Application Support/com.nexonauts.recast",
    "~/Library/Caches/com.nexonauts.recast",
    "~/Library/Preferences/com.nexonauts.recast.plist",
    "~/Library/Saved Application State/com.nexonauts.recast.savedState",
    "~/Library/WebKit/com.nexonauts.recast",
  ]
end
