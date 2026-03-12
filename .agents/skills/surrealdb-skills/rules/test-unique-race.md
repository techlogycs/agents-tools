# test-unique-race

Test uniqueness and concurrent write assumptions under contention.

## Apply when

- Business invariants depend on deduplication or race resistance.

## Do

- Exercise concurrent attempts that should converge safely.

## Avoid

- Assuming sequential tests prove concurrency safety.
