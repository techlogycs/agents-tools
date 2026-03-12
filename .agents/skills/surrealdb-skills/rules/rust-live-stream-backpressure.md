# rust-live-stream-backpressure

Consume live query streams with bounded downstream handling.

## Apply when

- Bridging SurrealDB live updates into channels, sockets, or background tasks.

## Do

- Protect consumers with buffering, shedding, or backpressure strategy.

## Avoid

- Letting one slow subscriber destabilize the process.
