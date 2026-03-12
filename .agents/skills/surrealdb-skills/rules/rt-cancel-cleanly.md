# rt-cancel-cleanly

Cancel live subscriptions cleanly on shutdown or disconnect.

## Apply when

- Managing long-lived streams in services or clients.

## Do

- Tie subscription lifecycle to explicit cancellation and cleanup.

## Avoid

- Leaking streams after callers disappear.
