#!/bin/bash

DOTFILES="$HOME/dotfiles"

link() {
  local src="$DOTFILES/$1"
  local dest="$2"

  mkdir -p "$(dirname "$dest")"
  ln -sf "$src" "$dest"
  echo "Linked $dest -> $src"
}

link "ncspot/config.toml" "$HOME/.config/ncspot/config.toml"
link "vscode/settings.json" "$HOME/.config/Code/User/settings.json"
link "vscode/keybindings.json" "$HOME/.config/Code/User/keybindings.json"
link "tmux/tmux.conf" "$HOME/.tmux.conf"
link "opencode/opencode.json" "$HOME/.config/opencode/opencode.json"

# VS Code extensions
if command -v code &> /dev/null; then
  echo "Installing VS Code extensions..."
  xargs -L 1 code --install-extension < "$DOTFILES/vscode/extensions.txt"
fi
