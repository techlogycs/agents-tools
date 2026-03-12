# anti-unbounded-live-consumer

Do not attach unbounded consumers to live streams.

## Why

- Slow subscribers can accumulate unbounded memory and lag.

## Prefer

- Bounded queues, shedding, and explicit cancellation.
