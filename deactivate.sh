#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

if grep -q free-my-mac ~/.zshrc; then
    sed -i '' "/^alias free-my-mac=/d" ~/.zshrc
    echo -e "[${GREEN}OK${NC}] Alias removed from ~/.zshrc"
    echo -e "[${BLUE}INFO${NC}] Restart terminal or run: source ~/.zshrc"
else
    echo -e "[${RED}ERR${NC}] Alias not found in ~/.zshrc"
fi
