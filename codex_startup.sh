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

echo "Ensuring Spec Kit CLI is available..."
if ! command -v uv >/dev/null 2>&1; then
    echo "uv command not found; unable to install Spec Kit CLI." >&2
elif uv tool list 2>/dev/null | grep -q '^specify-cli '; then
    if ! uv tool upgrade specify-cli >/dev/null 2>&1; then
        echo "Spec Kit CLI upgrade failed; attempting reinstall..." >&2
        if ! uv tool install specify-cli --from git+https://github.com/github/spec-kit.git --force; then
            echo "Spec Kit CLI reinstall failed; continuing without it." >&2
        fi
    fi
else
    echo "Spec Kit CLI not detected; installing..."
    if ! uv tool install specify-cli --from git+https://github.com/github/spec-kit.git; then
        echo "Spec Kit CLI installation failed; continuing without it." >&2
    fi
fi

if command -v specify >/dev/null 2>&1; then
    specify --help >/dev/null 2>&1 || true
fi

git config --global user.name "cephaspad"
git config --global user.email "cephaspad@users.noreply.github.com"
