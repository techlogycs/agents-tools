# schema-hot-cold-split

Split hot mutable attributes from cold large payloads when access patterns diverge.

## Apply when

- The same record mixes frequently updated state with bulky seldom-read data.

## Do

- Separate tables or projections along read-write boundaries.

## Avoid

- Paying large read and write costs for unrelated payloads.
