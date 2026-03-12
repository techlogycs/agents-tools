# query-only-single-record

Use single-record patterns when exactly one logical row is expected.

## Apply when

- Reading by identity, unique key, or singleton resource.

## Do

- Model the result as one optional or one required record.

## Avoid

- Treating singular reads as unbounded collections.
