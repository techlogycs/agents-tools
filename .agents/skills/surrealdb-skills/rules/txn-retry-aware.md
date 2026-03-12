# txn-retry-aware

Treat transient transaction failures as retryable only when the operation is safe.

## Apply when

- Recovering from network or contention-related write failures.

## Do

- Retry at the service boundary with idempotency in mind.

## Avoid

- Blindly replaying non-idempotent transactional work.
