# perf-avoid-overfetch

Select only needed fields on hot paths.

## Apply when

- Serving latency-sensitive endpoints or large result sets.

## Do

- Return narrow projections aligned with the caller contract.

## Avoid

- Pulling full records and linked data by default.
