# Homebrew Cask for Lori.
#
# This file belongs in your TAP repo, not here — create a PUBLIC GitHub repo named
# `homebrew-lori` and put this at `Casks/lori.rb`. Users then install with:
#
#     brew install --cask MatheusChein/lori/lori
#
# (This copy is kept in the main repo as the source of truth; copy/sync it to the tap
# on each release.)
#
# Per release, update `version` + `sha256` (sha256: `shasum -a 256 dist/Lori.dmg`),
# upload the notarized Lori.dmg to a PUBLIC, stable, versioned URL (the code repo is
# private, so use a public releases repo or your webpage's host), and point `url` at it.
cask "lori" do
  version "0.2.1"
  sha256 "991658d0e8d87e9976ae4a291b87861c380d08ce4accb24c1d1b377059b5fa86"

  url "https://lori-app.sh/download/v#{version}/Lori.dmg"
  name "Lori"
  desc "Lightweight terminal intellisense overlay for macOS"
  homepage "https://lori-app.sh"

  # The app updates itself via Sparkle, so `brew upgrade` should not fight it.
  auto_updates true

  # Let `brew livecheck` discover new versions from the Sparkle feed.
  livecheck do
    url "https://lori-app.sh/appcast.xml"
    strategy :sparkle
  end

  depends_on macos: ">= :ventura" # SwiftUI NavigationSplitView needs macOS 13+

  app "Lori.app"

  caveats <<~EOS
    Lori runs in the menu bar (no Dock icon).

    To finish setup, open Lori → Preferences → Setup and:
      • Grant Accessibility (so the popup can follow your cursor), and
      • Add the shell integration for fish or zsh (one click — no terminal).

    Then open a new terminal tab.
  EOS

  uninstall quit: "com.matheuschein.lori"

  # `brew uninstall --cask --zap lori` also removes these. The shell-config line is
  # NOT touched here (editing dotfiles from a cask is unsafe) — remove it from
  # Lori → Preferences → Setup → Remove before uninstalling.
  zap trash: [
    "~/Library/Preferences/com.matheuschein.lori.plist",
    "~/Library/Application Support/Lori",
  ]
end
