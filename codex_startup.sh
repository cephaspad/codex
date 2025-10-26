#!/bin/bash
set -euo pipefail

if ! command -v codex >/dev/null 2>&1; then
    echo "Installing codex CLI..."
    npm install -g @openai/codex@latest
else
    echo "codex CLI already available; skipping install."
fi

git config --global user.name "cephaspad"
git config --global user.email "cephaspad@users.noreply.github.com"
