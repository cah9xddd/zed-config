#!/usr/bin/env bash
# Sync the Zed config: push local changes and pull changes from other machines.
# Run it from a terminal:  ./sync.sh ["what I changed"]
# On Windows, double-click it (opens in Git Bash) or run it from Git Bash.

cd "$(dirname "$0")" || exit 1
host="${COMPUTERNAME:-$(hostname 2>/dev/null || echo unknown)}"
msg="${1:-Update Zed config from $host}"

# A double-clicked Git Bash window closes on exit, so wait for Enter there.
pause() {
    case "$OSTYPE" in
        msys* | cygwin*) read -r -p "Press Enter to close this window" _ ;;
    esac
}
fail() { printf '\033[31m%s\033[0m\n' "$*"; pause; exit 1; }

git add -A
if ! git diff --cached --quiet; then
    git commit -q -m "$msg" || fail "Commit failed"
fi

git pull --rebase origin main ||
    fail "Pull hit a conflict: fix the files, run 'git rebase --continue', then run this again"

git push origin HEAD:main || fail "Push failed"

printf '\033[32mSynced.\033[0m If the theme changed, restart Zed (themes are read only at startup).\n'
pause
