# txn-compensate-explicitly

Use explicit compensation logic when cross-system atomicity is impossible.

## Apply when

- Multiple systems must converge after a partially successful flow.

## Do

- Design compensating actions intentionally and test them.

## Avoid

- Hoping partial failures self-heal without a plan.
