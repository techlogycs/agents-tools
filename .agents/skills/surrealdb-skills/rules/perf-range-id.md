# perf-range-id

Design record IDs for efficient range queries on append-like datasets.

## Apply when

- Reads depend on time-ordered or partition-friendly ranges.

## Do

- Shape IDs to match the range access pattern directly.

## Avoid

- Using opaque IDs when the workload is dominated by ordered scans.
