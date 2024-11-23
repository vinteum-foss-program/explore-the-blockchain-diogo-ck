# Only one single output remains unspent from block 123,321. What address was it sent to?
blockhash=$(bitcoin-cli getblockhash 123321)
for tx in $(bitcoin-cli getblock $blockhash 2 | jq -rc 'walk(if type == "string" then gsub("[ \\n\\t]"; "-") else . end) | .tx[]')
do
  txid=$(echo $tx | jq -r .txid)
  for n in $(echo $tx | jq -rc .vout[].n)
  do
    txout=$(bitcoin-cli gettxout $txid $n)
    if [ ! -z "$txout" ]; then
      echo $txout | jq -r .scriptPubKey.address
      exit 0
    fi
  done
done

