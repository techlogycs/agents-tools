# perf-search-index

Use search indexes for full-text workloads instead of scan-heavy text predicates.

## Apply when

- Supporting free text or ranked search.

## Do

- Use the database's search indexing features intentionally.

## Avoid

- Emulating search with broad substring scans.
