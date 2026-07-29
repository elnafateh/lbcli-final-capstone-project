# what is the coinbase tx in this block 243,834
HASH=$(bitcoin-cli -signet getblockhash 243834)
bitcoin-cli -signet getblock "$HASH" 2 | jq -r '.tx[0].txid'
