# perf-index-filter-join

Index fields used in frequent filters, joins, uniqueness checks, and sorts.

## Apply when

- A read path is important and appears repeatedly in production traffic.

## Do

- Add indexes that correspond to concrete, measured query patterns.

## Avoid

- Indexing fields speculatively with no named workload.
