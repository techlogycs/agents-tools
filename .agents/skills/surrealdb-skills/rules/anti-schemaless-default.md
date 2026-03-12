# anti-schemaless-default

Do not choose `SCHEMALESS` by default for core domain data.

## Why

- Silent shape drift becomes an application correctness problem later.

## Prefer

- `SCHEMAFULL` plus explicit migration steps.
