#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

if [ -f "~/.zshrc" ] && grep -q free-my-mac ~/.zshrc; then
    echo -e "[${RED}ERR${NC}] Alias already exists in ~/.zshrc"
else
    echo "alias free-my-mac='$(pwd)/mac-cleaner.sh'" >> ~/.zshrc
    echo -e "[${GREEN}OK${NC}] Alias added to ~/.zshrc"
    echo -e "[${BLUE}INFO${NC}] Restart terminal or run: source ~/.zshrc"
fi
