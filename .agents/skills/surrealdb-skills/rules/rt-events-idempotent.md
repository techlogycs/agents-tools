# rt-events-idempotent

Keep `DEFINE EVENT` logic idempotent and operationally predictable.

## Apply when

- Using database events to react to state changes.

## Do

- Make repeated triggering safe and easy to reason about.

## Avoid

- Embedding fragile once-only assumptions in event logic.
