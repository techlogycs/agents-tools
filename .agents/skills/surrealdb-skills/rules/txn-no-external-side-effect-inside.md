# txn-no-external-side-effect-inside

Avoid coupling external side effects tightly to transactional success paths.

## Apply when

- A write path also sends emails, webhooks, or cross-system calls.

## Do

- Separate durable state changes from external effects cleanly.

## Avoid

- Assuming outside systems share database atomicity.
