# How many new outputs were created by block 243,825?
HASH=$(bitcoin-cli -signet getblockhash 243825)
bitcoin-cli -signet getblock "$HASH" 2 | jq '[.tx[].vout] | flatten | length'
