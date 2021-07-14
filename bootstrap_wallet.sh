#!/bin/bash
WALLET=`curl -sd '{ "action": "wallet_create" }' localhost:17076 | head -n 2 | tail -n 1`
echo WALLET is: $WALLET
DATA='{ "action": "wallet_add", '$WALLET', "key": "0000000000000000000000000000000000000000000000000000000000000000" }'
echo DATA is: $DATA
curl -d "$DATA" localhost:17076

