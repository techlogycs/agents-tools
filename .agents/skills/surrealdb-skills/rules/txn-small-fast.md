# txn-small-fast

Keep transactions short and focused.

## Apply when

- Writing critical multi-step updates.

## Do

- Include only the statements required for the invariant.

## Avoid

- Mixing long reads, retries, and side work into one transaction.
