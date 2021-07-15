# nano_node_standalone
A nanocurrency node, configured as a standalone test net (not to be confused with the official test net), where you have control over the genesis funds. This is very useful for testing and debugging code that interacts with nano nodes!

## First, build and start the docker image:
Either use docker compose:
```
docker-compose up --build
```
Or use direct docker commands:
```
docker build . -t nano_node_standalone
```
```
docker run \
 -e PEER_HOST=localhost \ 
 -e NANO_TEST_GENESIS_PUB=19D3D919475DEED4696B5D13018151D1AF88B2BD3BCFF048B45031C1F36D1858 \
 -e NANO_TEST_GENESIS_BLOCK='{
        "type": "open",
        "source": "19D3D919475DEED4696B5D13018151D1AF88B2BD3BCFF048B45031C1F36D1858",
        "representative": "nano_18gmu6engqhgtjnppqam181o5nfhj4sdtgyhy36dan3jr9spt84rzwmktafc",
        "account": "nano_18gmu6engqhgtjnppqam181o5nfhj4sdtgyhy36dan3jr9spt84rzwmktafc",
        "work": "820cc9d17342799c",
        "signature": "012B814F60A97B9C40D066C3C104383C335633D74A0566E0A0C6D1DDA7BBFA4011547AA0374B6B3146F290352E5EC6C81551032583219F8A372C236DD65BA90D"
}' \
 -p 17075:17075 -p 17076:17076 -p 17078:17078 \
 nano_node_standalone nano_node \
 --daemon \
 --disable_legacy_bootstrap \
 --network test \
 --config node.logging.log_to_cerr=true \
 --config node.enable_voting=true
```

## Then bootstrap the nano wallet:
```
./nano_standalone/bootstrap_wallet.sh
```
NOTE: You *must* run this before using the wallets (below) to generate any transactions. Otherwise, the node will not actually vote/cement/confirm transactions. If you mess this up, you may need to kill the container, then run `docker system prune` and `docker volume prune` before restarting it. 

## Then setup a nano wallet (we use nault.cc and Navano)
### Nault.cc
Go to https://nault.cc
1. Settings > App Settings > Server Settings
   1. Server Configuration -> Custom
   1. API Server -> http://localhost:17076
   1. WebSocket Server -> ws://localhost:17078
1. Settings > Configure New Wallet > More Options > Import Private Key
   1. Use private key 0000000000000000000000000000000000000000000000000000000000000000

You should then get account: nano_18gmu6engqhgtjnppqam181o5nfhj4sdtgyhy36dan3jr9spt84rzwmktafc, with a huge balance!

### Navano
1. Install Navano from https://chrome.google.com/webstore/detail/navano/ipncmlepbgkephhmehjhnfgefeehaeab
1. Click on the extension icon to create a wallet
1. Click on the gear icon > Set connection
   1. RPC URL -> http://localhost:17076
   1. Websocket URL -> ws://localhost:17078

Now you should be able to send and receive nano between the wallets.
