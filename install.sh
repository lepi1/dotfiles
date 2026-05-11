#!/bin/bash

DOTFILES="$HOME/dotfiles"

SKIP=()

usage() {
  cat <<EOF
Usage: install.sh [--skip-<app>]...

Available skip flags:
  --skip-ncspot
  --skip-vscode
  --skip-vscode-extensions
  --skip-tmux
  --skip-opencode
  --skip-ghostty
  -h, --help    Show this help
EOF
}

for arg in "$@"; do
  case "$arg" in
    --skip-*) SKIP+=("${arg#--skip-}") ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown argument: $arg" >&2; usage; exit 1 ;;
  esac
done

skipped() {
  local name="$1"
  for s in "${SKIP[@]}"; do
    [[ "$s" == "$name" ]] && return 0
  done
  return 1
}

link() {
  local src="$DOTFILES/$1"
  local dest="$2"

  mkdir -p "$(dirname "$dest")"
  ln -sf "$src" "$dest"
  echo "Linked $dest -> $src"
}

skipped ncspot   || link "ncspot/config.toml"          "$HOME/.config/ncspot/config.toml"
skipped vscode   || link "vscode/settings.json"        "$HOME/.config/Code/User/settings.json"
skipped vscode   || link "vscode/keybindings.json"     "$HOME/.config/Code/User/keybindings.json"
skipped tmux     || link "tmux/tmux.conf"              "$HOME/.tmux.conf"
skipped opencode || link "opencode/opencode.json"      "$HOME/.config/opencode/opencode.json"
skipped ghostty  || link "ghostty/config.ghostty"      "$HOME/.config/ghostty/config.ghostty"
skipped ghostty  || link "ghostty/tmux-session.sh"     "$HOME/.config/ghostty/tmux-session.sh"

# VS Code extensions
if ! skipped vscode && ! skipped vscode-extensions && command -v code &> /dev/null; then
  echo "Installing VS Code extensions..."
  xargs -L 1 code --install-extension < "$DOTFILES/vscode/extensions.txt"
fi
