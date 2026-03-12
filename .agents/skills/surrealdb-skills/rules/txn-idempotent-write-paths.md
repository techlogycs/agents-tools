# txn-idempotent-write-paths

Make externally triggered write paths idempotent when retries are possible.

## Apply when

- Clients, jobs, or gateways may replay requests.

## Do

- Key writes or state transitions so safe retries are possible.

## Avoid

- Assuming every caller sees commit success exactly once.
