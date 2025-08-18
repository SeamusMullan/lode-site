#!/usr/bin/env bash
#
# Windows layout:
#  1. editor   - placeholder for your editor (vim/nvim) focused on src/
#  2. dev      - runs `bun run dev` (Vite dev server)
#  3. build    - on-demand build / preview
#  4. logs     - tail logs (if any) or show git graph
#  5. misc     - scratch shell for ad‑hoc commands
#
# Usage: ./scripts/tmux-dev.sh [session-name]
# Optionally set ENV vars:
#   TMUX_SESSION (default: lode)
#   EDITOR_CMD (default: nvim)
#   DEV_CMD (default: bun run dev)
#   BUILD_CMD (default: bun run build)
#   PREVIEW_CMD (default: bun run preview)
#
# Requires: tmux >= 3.1
set -euo pipefail

# Color configuration (disable with NO_COLOR=1 or TMUX_NO_COLOR=1)
if [ -n "${NO_COLOR:-}" ] || [ -n "${TMUX_NO_COLOR:-}" ]; then
  C_RESET=""; C_DIM=""; C_BOLD=""; C_EDITOR=""; C_DEV=""; C_BUILD=""; C_LOGS=""; C_MISC="";
else
  C_RESET="\033[0m"
  C_DIM="\033[2m"
  C_BOLD="\033[1m"
  # Distinct colors for each window (using 256-color codes where supported)
  C_EDITOR="\033[38;5;39m"   # Blue/cyan
  C_DEV="\033[38;5;202m"      # Orange
  C_BUILD="\033[38;5;141m"    # Purple
  C_LOGS="\033[38;5;178m"     # Yellow
  C_MISC="\033[38;5;47m"      # Green
fi

banner() { # banner <color> <label>
  printf '%b' "${1}${C_BOLD}[$2]${C_RESET} "
}

SESSION_NAME="${1:-${TMUX_SESSION:-lode}}"
EDITOR_CMD="${EDITOR_CMD:-nvim}"
DEV_CMD="${DEV_CMD:-bun run dev}"   # uses vite
BUILD_CMD="${BUILD_CMD:-bun run build}"
PREVIEW_CMD="${PREVIEW_CMD:-bun run preview}"
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# If already inside tmux and session exists, just switch
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  if [ -n "${TMUX:-}" ]; then
    tmux switch-client -t "$SESSION_NAME"
  else
    tmux attach -t "$SESSION_NAME"
  fi
  exit 0
fi

# Create the session (detached)
tmux new-session -d -s "$SESSION_NAME" -c "$PROJECT_ROOT" -n editor

# Window 1: editor (split vertical for file tree / code optionally)
# Left pane: editor
# Right pane: shell for quick git operations
# (We create right pane after launching editor so focus stays intuitive)
TMUX_EDITOR_PANE_CMD="$EDITOR_CMD src"
# Start editor in pane 0
# shellcheck disable=SC2016
 tmux send-keys -t "$SESSION_NAME":1.0 "echo -e \"$(banner $C_EDITOR EDITOR)Launching $EDITOR_CMD...\"" C-m
 tmux send-keys -t "$SESSION_NAME":1.0 "$TMUX_EDITOR_PANE_CMD" C-m
# Split (right) 35% for git quick commands
 tmux split-window -h -p 35 -t "$SESSION_NAME":1 -c "$PROJECT_ROOT"
 tmux send-keys -t "$SESSION_NAME":1.1 "echo -e \"$(banner $C_EDITOR EDITOR-SIDE)shell ready (git status)\"" C-m
 tmux send-keys -t "$SESSION_NAME":1.1 'git status' C-m

# Window 2: dev server
 tmux new-window -t "$SESSION_NAME":2 -n dev -c "$PROJECT_ROOT"
 tmux send-keys -t "$SESSION_NAME":2.0 "echo -e \"$(banner $C_DEV DEV)Starting: $DEV_CMD\"" C-m
 tmux send-keys -t "$SESSION_NAME":2.0 "$DEV_CMD" C-m

# Window 3: build / preview helper
 tmux new-window -t "$SESSION_NAME":3 -n build -c "$PROJECT_ROOT"
 tmux send-keys -t "$SESSION_NAME":3.0 "echo -e \"$(banner $C_BUILD BUILD)On-demand build / preview\"" C-m
 tmux send-keys -t "$SESSION_NAME":3.0 '# On-demand build or preview:' C-m
 tmux send-keys -t "$SESSION_NAME":3.0 "echo 'Run build: $BUILD_CMD'" C-m
 tmux send-keys -t "$SESSION_NAME":3.0 "echo 'Run preview: $PREVIEW_CMD'" C-m

# Window 4: logs (tail placeholder)
 tmux new-window -t "$SESSION_NAME":4 -n logs -c "$PROJECT_ROOT"
 if ls -1 logs/*.log >/dev/null 2>&1; then
   tmux send-keys -t "$SESSION_NAME":4.0 "echo -e \"$(banner $C_LOGS LOGS)Tailing log files...\"" C-m
   tmux send-keys -t "$SESSION_NAME":4.0 'tail -f logs/*.log' C-m
 else
   tmux send-keys -t "$SESSION_NAME":4.0 "echo -e \"$(banner $C_LOGS LOGS)No logs yet -> git graph (q to exit)\"; sleep 1; git --no-pager log --oneline --graph --decorate --all | less" C-m
 fi

# Window 5: misc
 tmux new-window -t "$SESSION_NAME":5 -n misc -c "$PROJECT_ROOT"
 tmux send-keys -t "$SESSION_NAME":5.0 "echo -e \"$(banner $C_MISC MISC)Scratch shell ready.\"" C-m

# Select dev window by default so server output visible on attach
 tmux select-window -t "$SESSION_NAME":2

# Attach
if [ -n "${TMUX:-}" ]; then
  tmux switch-client -t "$SESSION_NAME"
else
  tmux attach -t "$SESSION_NAME"
fi
