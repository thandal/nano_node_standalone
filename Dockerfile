from nanocurrency/nano-test

# All this does is enable RPC, which I just could *not* get working with --config, etc.
COPY config-rpc.toml /usr/share/nano/config/config-rpc.toml
