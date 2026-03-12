# rt-websocket-only

Treat realtime features as WebSocket-centric and plan transport accordingly.

## Apply when

- Exposing live subscriptions to clients or services.

## Do

- Build connection lifecycle, auth, and reconnect behavior deliberately.

## Avoid

- Assuming realtime behaves like stateless HTTP reads.
