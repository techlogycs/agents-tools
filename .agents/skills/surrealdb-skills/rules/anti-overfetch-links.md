# anti-overfetch-links

Do not eagerly expand linked records everywhere.

## Why

- It inflates latency, payload size, and query cost.

## Prefer

- Targeted projections and selective `FETCH` usage.
