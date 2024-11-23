# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`
wit=$(bitcoin-cli getrawtransaction e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163 true | jq -r .vin[].txinwitness[-1])
bitcoin-cli decodescript $wit | jq -r '.asm | split(" ") | if .[0] == "OP_IF" then .[1] else . end'
