# query-id-over-scan

Address records by ID when identity is known.

## Apply when

- The caller already has a record ID or unique identifier.

## Do

- Prefer direct record addressing over table scans.

## Avoid

- Re-querying large tables to find known records.
