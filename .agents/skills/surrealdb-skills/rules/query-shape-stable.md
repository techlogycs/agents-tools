# query-shape-stable

Keep query result shapes stable across read paths.

## Apply when

- A query feeds handlers, APIs, or cached views.

## Do

- Return predictable projections instead of accidental whole records.

## Avoid

- Letting callers depend on incidental fields.
