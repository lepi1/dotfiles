# dotfiles

Personal configuration files, managed with symlinks.

## Contents

| Config | Path | Description |
|--------|------|-------------|
| [ncspot](ncspot/) | `~/.config/ncspot/config.toml` | Terminal Spotify client with orange/purple theme |
| [vscode](vscode/) | `~/.config/Code/User/` | VS Code settings and keybindings |
| [tmux](tmux/) | `~/.tmux.conf` | Tmux config with purple status line |
| [opencode](opencode/) | `~/.config/opencode/opencode.json` | OpenCode keybindings |
| [ghostty](ghostty/) | `~/.config/ghostty/` | Ghostty terminal config + tmux-on-launch script |
| [claude](claude/) | `~/.claude/` | Claude Code settings + custom statusline |
| [zsh](zsh/) | `~/.zshrc`, `~/.p10k.zsh` | Zsh config (uses oh-my-zsh + powerlevel10k) |
| [git](git/) | `~/.config/git/ignore` | Global gitignore |
| [mise](mise/) | `~/.config/mise/config.toml` | mise tool/runtime settings |

## Setup

```sh
git clone https://github.com/<user>/dotfiles ~/dotfiles
cd ~/dotfiles
./install.sh             # link everything
./install.sh --help      # see skip flags
./install.sh --skip-zsh  # example: skip a section
```

## Platform support

Developed on Linux (Fedora). The install script is plain bash (`ln -sf`, `mkdir -p`, `xargs`) so it *should* work on any POSIX system, but only the Fedora setup is actually tested.

- **Fedora / Ubuntu / Arch** — expected to work as-is; all target paths (`~/.config/...`, `~/.tmux.conf`, `~/.claude/...`, `~/.zshrc`) are the same across Linux distros.
- **macOS** — expected to work *except* VS Code, which uses `~/Library/Application Support/Code/User/` instead of `~/.config/Code/User/`. Run with `--skip-vscode` or symlink VS Code manually.

## Prerequisites

The install script only creates symlinks — the underlying tools must already be installed.

### Zsh stack (skip with `--skip-zsh`)
- [oh-my-zsh](https://ohmyz.sh/) — its installer will overwrite `~/.zshrc`; run `install.sh` afterwards
- [powerlevel10k](https://github.com/romkatv/powerlevel10k) — clone into `${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k`
- **MesloLGS NF** font (powerlevel10k recommended)
- [mise](https://mise.jdx.dev/), [zoxide](https://github.com/ajeetdsouza/zoxide), [fzf](https://github.com/junegunn/fzf) — sourced from `zshrc`

### Other tools
- **tmux** — for `tmux/tmux.conf` and ghostty's launch script
- **ghostty** — [ghostty.org](https://ghostty.org/); config uses `MesloLGS NF` + Dracula theme
- **ncspot** — terminal Spotify client
- **opencode** — [opencode.ai](https://opencode.ai/)
- **VS Code** — `code` on `$PATH`; install script also runs `code --install-extension` for everything in `vscode/extensions.txt`
- **Claude Code** — [claude.com/claude-code](https://claude.com/claude-code); statusline needs `jq`
