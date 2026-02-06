# dotfiles

Personal configuration files, managed with symlinks.

## Contents

| Config | Path | Description |
|--------|------|-------------|
| [ncspot](ncspot/) | `~/.config/ncspot/config.toml` | Terminal Spotify client with orange/purple theme |
| [vscode](vscode/) | `~/.config/Code/User/` | VS Code settings and keybindings |
| [tmux](tmux/) | `~/.tmux.conf` | Tmux config with purple status line |

## Setup

Symlink configs to their expected locations:

```sh
ln -sf ~/dotfiles/ncspot/config.toml ~/.config/ncspot/config.toml
ln -sf ~/dotfiles/vscode/settings.json ~/.config/Code/User/settings.json
ln -sf ~/dotfiles/vscode/keybindings.json ~/.config/Code/User/keybindings.json
ln -sf ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
```
