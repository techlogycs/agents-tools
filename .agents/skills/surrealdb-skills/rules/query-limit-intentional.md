# query-limit-intentional

Add `LIMIT` intentionally instead of assuming low cardinality.

## Apply when

- The caller needs a bounded subset or first match.

## Do

- Bound result size explicitly and pair it with ordering when needed.

## Avoid

- Letting large tables decide your response size implicitly.
