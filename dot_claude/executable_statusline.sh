#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)

# Colors
BLUE='\033[38;5;75m'
MAGENTA='\033[38;5;213m'
GREEN='\033[38;5;114m'
YELLOW='\033[33m'
RED='\033[31m'
DIM='\033[2m'
RESET='\033[0m'

# Git status (cached 5s)
GIT_CACHE="/tmp/claude-statusline-git-cache"
git_cache_stale() {
    [ ! -f "$GIT_CACHE" ] || \
    [ $(($(date +%s) - $(stat -f %m "$GIT_CACHE" 2>/dev/null || stat -c %Y "$GIT_CACHE" 2>/dev/null || echo 0))) -gt 5 ]
}
if git_cache_stale; then
    if git rev-parse --git-dir > /dev/null 2>&1; then
        BRANCH=$(git branch --show-current 2>/dev/null)
        DIRTY=$(git status --porcelain 2>/dev/null | head -1)
        [ -n "$DIRTY" ] && echo "${BRANCH}|dirty" > "$GIT_CACHE" || echo "${BRANCH}|clean" > "$GIT_CACHE"
    else
        echo "" > "$GIT_CACHE"
    fi
fi
GIT_INFO=$(cat "$GIT_CACHE")

GIT_SECTION=""
if [ -n "$GIT_INFO" ]; then
    BRANCH="${GIT_INFO%%|*}"
    STATE="${GIT_INFO##*|}"
    if [ "$STATE" = "dirty" ]; then
        GIT_SECTION=" ${DIM}|${RESET} ${GREEN}⎇ ${BRANCH}${RESET} ${YELLOW}●${RESET}"
    else
        GIT_SECTION=" ${DIM}|${RESET} ${GREEN}⎇ ${BRANCH}${RESET}"
    fi
fi

# Context with compaction warning
CONTEXT="⏳ ${PCT}%"
if [ "$PCT" -ge 90 ]; then
    CONTEXT="${RED}⏳ ${PCT}% ⚠ compaction soon${RESET}"
elif [ "$PCT" -ge 80 ]; then
    CONTEXT="${YELLOW}⏳ ${PCT}%${RESET}"
fi

echo -e "${BLUE}📁 ${DIR##*/}${RESET}${GIT_SECTION} ${DIM}|${RESET} ${MAGENTA}🤖 ${MODEL}${RESET} ${DIM}|${RESET} ${CONTEXT}"
