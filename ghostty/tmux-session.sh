#!/bin/bash

# Always start a fresh unnamed tmux session.
# tmux will auto-number them: 0, 1, 2 ...
exec tmux new-session
