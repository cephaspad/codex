#!/bin/bash

echo "=================================="
echo "Welcome to openai/codex-universal!"
echo "=================================="

/opt/codex/setup_universal.sh

/opt/codex/codex_startup.sh

echo "Environment ready. Dropping you into a bash shell."
exec bash --login "$@"
