#!/bin/bash
TXID="b71fb9ab7707407cc7265591e0c0d47d07afede654f91de1f63c0cb522914bcb"
TX_JSON=$(bitcoin-cli -signet getrawtransaction "$TXID" true)

# Sum outputs
OUT_VAL=$(echo "$TX_JSON" | jq '[.vout[].value] | add')

# Sum inputs
IN_VAL=0
while read -r ptx pvout; do
    VAL=$(bitcoin-cli -signet getrawtransaction "$ptx" true | jq -r --argjson v "$pvout" '.vout[$v].value')
    IN_VAL=$(jq -n "$IN_VAL + $VAL")
done < <(echo "$TX_JSON" | jq -r '.vin[] | "\(.txid) \(.vout)"')

# Fee = (Input - Output) in Satoshis
jq -n "($IN_VAL - $OUT_VAL) * 100000000 | round"
