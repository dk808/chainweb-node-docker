#!/usr/bin/env bash

export CHAINWEB_NETWORK=${CHAINWEB_NETWORK:-mainnet01}
export CHAINWEB_PORT=${CHAINWEB_PORT:-443}

DAYS_IN_SEC=86400
CURRENT_TIME=$(date '+%s')
BASE_TIME=1611710552
BASE_HEIGHT=26212040
TIME_DIFF=$((CURRENT_TIME-BASE_TIME))
BLOCKS_PASSED_DIFF=$((TIME_DIFF/30*20))
BLOCKS_TIMEFRAME=$((DAYS_IN_SEC/30*20))
CURRENT_BLOCK_EST=$((BASE_HEIGHT+BLOCKS_PASSED_DIFF))
MIN_ACCEPTED_HEIGHT=$((CURRENT_BLOCK_EST-BLOCKS_TIMEFRAME-200000))
CURRENT_NODE_HEIGHT=$(curl -fsLk "https://localhost:$CHAINWEB_PORT/chainweb/0.0/$CHAINWEB_NETWORK/cut" | jq '.height')


if ((CURRENT_NODE_HEIGHT>MIN_ACCEPTED_HEIGHT)); then echo "Node is at block ${CURRENT_NODE_HEIGHT} and meets minimum height of ${MIN_ACCEPTED_HEIGHT}"; else exit 1; fi
