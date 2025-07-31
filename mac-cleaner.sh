#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

if [[ "$OSTYPE" != "darwin"* ]]; then
    echo -e "[${RED}ERR${NC}] Looks like you're not on macOS. Nice try :)"
    exit 1
fi

PURGE=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        -p|--purge)
            PURGE=true
            shift
            ;;
        *)
            echo -e "[${RED}ERR${NC}] Unknown argument: $1"
            exit 1
            ;;
    esac
done

echo -e "[${YELLOW}RUN${NC}] Working..."

FREE_BEFORE=$(df -k ~ | tail -1 | awk '{print $4}')

rm -rf ~/Library/Caches/* 2>/dev/null
rm -rf ~/.Trash/* 2>/dev/null
rm -rf ~/Library/Metadata/* 2>/dev/null
rm -rf ~/Library/DuetExpertCenter/* 2>/dev/null

if [ "$PURGE" = true ]; then
    echo -e "[${BLUE}INFO${NC}] Purge mode enabled..."

    rm -rf ~/Library/Group\ Containers/group.com.apple.CoreSpeech/ 2>/dev/null
    rm -rf ~/Library/Group\ Containers/6N38VWS5BX.ru.keepcoder.Telegram/stable/logs/ 2>/dev/null
    rm -rf ~/Library/Group\ Containers/6N38VWS5BX.ru.keepcoder.Telegram/stable/account-*/postbox/media/ 2>/dev/null
    rm -rf ~/Library/Containers/com.apple.AvatarUI.AvatarPickerMemojiPicker/Data/Library/Caches/ 2>/dev/null
    rm -rf ~/Library/Containers/com.apple.mediaanalysisd/Data/Library/Caches/ 2>/dev/null
    rm -rf ~/Library/Application\ Support/Google/Chrome/Default/Service\ Worker/CacheStorage/* 2>/dev/null
    rm -rf ~/Library/Application\ Support/Code/CachedData/* 2>/dev/null
    rm -rf ~/Library/Logs/* 2>/dev/null
fi

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
