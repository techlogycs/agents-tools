# txn-unique-over-race

Prefer database uniqueness guarantees over race-prone application checks.

## Apply when

- Competing writes could create duplicates.

## Do

- Let indexes and transactional constraints carry the invariant.

## Avoid

- Trusting a pre-read alone to guarantee uniqueness.
