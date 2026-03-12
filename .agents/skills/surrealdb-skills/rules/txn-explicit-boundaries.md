# txn-explicit-boundaries

Use explicit transaction boundaries for multi-write invariants.

## Apply when

- Several writes must succeed or fail together.

## Do

- Mark the exact transactional unit around the invariant.

## Avoid

- Spreading one invariant across unrelated autonomous writes.
