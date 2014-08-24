# Docker recipe for [dogepartyd](https://github.com/dogeparty/dogepartyd)

See the global picture how this container interacts with other components to run Dogeparty:

[Global Component Overview](http://www.inkpad.io/1GMXYwxl4Q)


## Build

    docker build -t dogepartyd:v1 .


## Instantiate Data Container

    docker run -d --name=dogepartyd-data dogepartyd:v1 bash


## Run Container

    docker run -it --name dogepartyd --volumes-from=dogepartyd-data --link dogecoind:dogecoind --link insight-doge:insight dogepartyd:v1 bash


## Run Process

    counterpartyd --backend-rpc-connect=$DOGECOIND_PORT_22555_TCP_ADDR --backend-rpc-port=$DOGECOIND_PORT_22555_TCP_PORT --blockchain-service-connect=$(echo $INSIGHT_PORT_3000_TCP|sed -e "s/tcp/http/") --verbose server


## Debug

    docker run -it --rm --volumes-from=dogepartyd-data dogepartyd:v1 bash


## Test API Call

curl http://172.17.1.175:4000/ --user user:pass -H 'Content-Type: application/json; charset=UTF-8' -H 'Accept: application/json, text/javascript' --data-binary '{"jsonrpc":"2.0","id":0,"method":"get_balances","params":{"filters": {"field": "address", "op": "==", "value": "DKuDk3hBfdk6aMU4Bj9zpyCcAqLwhLQPKo"}}}'


## Test CLI cmd

counterpartyd --backend-rpc-connect=$DOGECOIND_PORT_22555_TCP_ADDR --backend-rpc-port=$DOGECOIND_PORT_22555_TCP_PORT --blockchain-service-connect=$(echo $INSIGHT_PORT_3000_TCP|sed -e "s/tcp/http/") --verbose balances DKuDk3hBfdk6aMU4Bj9zpyCcAqLwhLQPKo

