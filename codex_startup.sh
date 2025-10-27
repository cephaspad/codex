#!/bin/bash
set -euo pipefail

export NVM_DIR="${NVM_DIR:-/root/.nvm}"
if [ -s "${NVM_DIR}/nvm.sh" ]; then
    # shellcheck disable=SC1091
    . "${NVM_DIR}/nvm.sh"
    nvm use default >/dev/null 2>&1 || true
elif [ -r "/etc/profile" ]; then
    # shellcheck disable=SC1091
    . "/etc/profile"
fi

if ! command -v npm >/dev/null 2>&1; then
    echo "npm command not found; skipping Codex CLI install." >&2
elif ! command -v codex >/dev/null 2>&1; then
    echo "Installing codex CLI..."
    npm install -g @openai/codex@latest
else
    echo "codex CLI already available; skipping install."
fi

git config --global user.name "cephaspad"
git config --global user.email "cephaspad@users.noreply.github.com"
