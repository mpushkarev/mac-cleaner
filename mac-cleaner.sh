#!/bin/bash

FREE_BEFORE=$(df -k ~ | tail -1 | awk '{print $4}')
rm -rf ~/Library/Caches/*
rm -rf ~/.Trash/*
FREE_AFTER=$(df -k ~ | tail -1 | awk '{print $4}')

FREED_KB=$(($FREE_AFTER - $FREE_BEFORE))

if [ "$FREED_KB" -lt 1024 ]; then
  FREED="${FREED_KB} KiB"
else
  FREED_MIB=$(echo "scale=2; $FREED_KB / 1024" | bc)
  FREED="${FREED_MIB} MiB"
fi

echo "Freed $FREED"
