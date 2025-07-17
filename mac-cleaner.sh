#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "[${YELLOW}RUN${NC}] Working..."

FREE_BEFORE=$(df -k ~ | tail -1 | awk '{print $4}')

rm -rf ~/Library/Caches/* 2>/dev/null
rm -rf ~/.Trash/* 2>/dev/null

FREE_AFTER=$(df -k ~ | tail -1 | awk '{print $4}')

FREED_KIB=$(($FREE_AFTER - $FREE_BEFORE))

if [ "$FREED_KIB" -lt 1024 ]; then
    FREED="${FREED_KIB} KiB"
else
    FREED_MIB=$(echo "scale=2; $FREED_KIB / 1024" | bc)
    FREED="${FREED_MIB} MiB"
fi

if [ "$FREED_KIB" -le 0 ]; then
    echo -e "[${BLUE}INFO${NC}] Nothing to clean, no disk space freed"
else
    echo -e "[${GREEN}OK${NC}] Freed $FREED"
fi
