# Which tx in block 257,343 spends the coinbase output of block 256,128?
c_blockhash=$(bitcoin-cli getblockhash 256128)
coinbase_txid=$(bitcoin-cli getblock $c_blockhash 2 | jq -r .tx[0].txid)

blockhash=$(bitcoin-cli getblockhash 257343)
for tx in $(bitcoin-cli getblock $blockhash 2 | jq -rc 'walk(if type == "string" then gsub("[ \\n\\t]"; "-") else . end) | .tx[]')
do
  for txid in $(echo $tx | jq -r .vin[].txid)
  do
    if [ "$txid" = "$coinbase_txid" ]; then
      echo $tx | jq -r .txid
      exit 0
    fi
  done
done
