# txn-consistent-clock

Use database time for persisted audit timestamps that define consistency.

## Apply when

- Stored timestamps affect ordering, auditing, or conflict resolution.

## Do

- Prefer a single authoritative clock inside persisted state.

## Avoid

- Mixing client and server clocks for important write ordering.
