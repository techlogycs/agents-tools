# perf-table-view-read-model

Use table views when repeated aggregates justify a database-side read model.

## Apply when

- The same grouped or derived query is read often.

## Do

- Materialize recurring read shapes where it simplifies the system.

## Avoid

- Recomputing expensive aggregates on every request path.
