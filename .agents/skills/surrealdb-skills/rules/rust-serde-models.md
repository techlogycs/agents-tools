# rust-serde-models

Keep request and response structs explicit with `serde` derives.

## Apply when

- Crossing the boundary between SurrealDB and Rust domain code.

## Do

- Model data contracts in typed structs and enums.

## Avoid

- Passing raw `Value` types deep into business logic.
