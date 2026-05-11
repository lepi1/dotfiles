#!/usr/bin/env bash
# Claude Code status line - mirrors Powerlevel10k lean prompt style

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input" | jq -r '.model.display_name // .model.id')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Shorten home directory to ~
home="$HOME"
short_cwd="${cwd/#$home/\~}"

# Git info (skip optional locks)
git_info=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
  branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    # Check for dirty state
    if ! git -C "$cwd" diff --quiet 2>/dev/null || ! git -C "$cwd" diff --cached --quiet 2>/dev/null; then
      git_info=" "$'\033[33m'"${branch}*"$'\033[0m'
    else
      git_info=" "$'\033[32m'"${branch}"$'\033[0m'
    fi
  fi
fi

# Context usage
ctx_info=""
if [ -n "$used_pct" ]; then
  used_int=$(printf "%.0f" "$used_pct")
  if [ "$used_int" -ge 80 ]; then
    ctx_info=" "$'\033[31m'"ctx:${used_int}%"$'\033[0m'
  elif [ "$used_int" -ge 50 ]; then
    ctx_info=" "$'\033[33m'"ctx:${used_int}%"$'\033[0m'
  else
    ctx_info=" ctx:${used_int}%"
  fi
fi

printf '\033[34m%s\033[0m%s \033[2m%s\033[0m%s' "$short_cwd" "$git_info" "$model" "$ctx_info"
