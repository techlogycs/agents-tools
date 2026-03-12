# test-query-shape

Lock down result shapes for important read queries.

## Apply when

- Query outputs feed APIs, views, or contracts with stable structure.

## Do

- Assert the fields and nesting callers rely on.

## Avoid

- Letting projection drift break downstream code silently.
