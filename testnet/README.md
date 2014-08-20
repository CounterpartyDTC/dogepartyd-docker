## Build

    docker build -t dogepartyd:testnet .


## Instantiate Data Container

    docker run -d --name=dogepartyd-testnet-data dogepartyd:testnet bash


## Run Container

    docker run -it --name dogepartyd-testnet --volumes-from=dogepartyd-testnet-data --link dogecoind-testnet:dogecoind --link insight-doge-testnet:insight dogepartyd:testnet bash


## Run Process

    counterpartyd --testnet --backend-rpc-connect=$DOGECOIND_PORT_44555_TCP_ADDR --backend-rpc-port=$DOGECOIND_PORT_44555_TCP_PORT --blockchain-service-connect=$(echo $INSIGHT_PORT_3001_TCP|sed -e "s/tcp/http/") --verbose server


## Debug

    docker run -it --rm --volumes-from=dogepartyd-testnet-data dogepartyd:testnet bash


## Test API Call

curl http://172.17.1.175:14000/ --user user:pass -H 'Content-Type: application/json; charset=UTF-8' -H 'Accept: application/json, text/javascript' --data-binary '{"jsonrpc":"2.0","id":0,"method":"get_balances","params":{"filters": {"field": "address", "op": "==", "value": "nZJKgvdQu2xsLwxVAknkrsXmYQiH4eEC9N"}}}'


## Test CLI cmd

counterpartyd --testnet --backend-rpc-connect=$DOGECOIND_PORT_44555_TCP_ADDR --backend-rpc-port=$DOGECOIND_PORT_44555_TCP_PORT --blockchain-service-connect=$(echo $INSIGHT_PORT_3001_TCP|sed -e "s/tcp/http/") --verbose balances nZJKgvdQu2xsLwxVAknkrsXmYQiH4eEC9N

