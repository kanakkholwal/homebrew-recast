# Homebrew Cask formula for Recast.
#
# This file is the template; `scripts/release/update-homebrew-cask.sh`
# substitutes 0.1.8 / 3d45a9ebed2aafd8ccbeb9099b3ef8f9ece432f33c6d6da23f39ab31b449c507 / 6d91a237a02fda2548cc473e4d0133f697ed492e14c996ee8fd5162c45c144e8 on each release
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
  version "0.1.8"

  # Apple Silicon (M-series) Mac
  on_arm do
    sha256 "3d45a9ebed2aafd8ccbeb9099b3ef8f9ece432f33c6d6da23f39ab31b449c507"

    url "https://github.com/kanakkholwal/recast/releases/download/v#{version}/recast_#{version}_aarch64.dmg",
        verified: "github.com/kanakkholwal/recast/"
  end

  # Intel Mac
  on_intel do
    sha256 "6d91a237a02fda2548cc473e4d0133f697ed492e14c996ee8fd5162c45c144e8"

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
