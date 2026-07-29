# Only one tx in block 243,821 signals opt-in RBF. What is its txid?
HASH=$(bitcoin-cli -signet getblockhash 243821)
bitcoin-cli -signet getblock "$HASH" 2 | jq -r '.tx[] | select(.vin[0].sequence < 4294967294 and .vin[0].coinbase == null) | .txid'
