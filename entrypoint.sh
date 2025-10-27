#!/bin/bash

echo "=================================="
echo "Welcome to openai/codex-universal!"
echo "=================================="

/opt/codex/setup_universal.sh

/opt/codex/codex_startup.sh

ensure_node_path() {
    export NVM_DIR="${NVM_DIR:-/root/.nvm}"
    if [ -s "${NVM_DIR}/nvm.sh" ]; then
        # shellcheck disable=SC1091
        . "${NVM_DIR}/nvm.sh"
        nvm use default >/dev/null 2>&1 || true
    elif [ -r "/etc/profile" ]; then
        # shellcheck disable=SC1091
        . "/etc/profile"
    fi
}

ensure_node_path

if [ -n "${NVM_BIN:-}" ]; then
    case ":$PATH:" in
        *":$NVM_BIN:"*) ;;
        *) export PATH="$NVM_BIN:$PATH" ;;
    esac
fi

hash -r 2>/dev/null || true

if [ "$#" -gt 0 ]; then
    exec "$@"
fi

if command -v codex >/dev/null 2>&1; then
    echo "Environment ready. Starting codex CLI..."
    exec codex
fi

echo "codex CLI unavailable; dropping you into a bash shell."
exec bash --login
