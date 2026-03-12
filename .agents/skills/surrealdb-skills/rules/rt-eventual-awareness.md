# rt-eventual-awareness

Design consumers to tolerate ordering gaps and eventual delivery behavior.

## Apply when

- Building workflows on top of live notifications.

## Do

- Make consumers resilient to replay, lag, and reconnects.

## Avoid

- Assuming every update arrives exactly once in perfect order.
