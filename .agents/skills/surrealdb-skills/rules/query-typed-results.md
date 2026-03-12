# query-typed-results

> Deserialize query results into explicit types

## Why It Matters

Typed results catch schema drift earlier, reduce ad hoc field indexing, and make repository contracts clearer.

## Bad

```rust
let mut response = db.query("SELECT * FROM user WHERE active = true").await?;
let rows: Vec<serde_json::Value> = response.take(0)?;
```

## Good

```rust
use serde::Deserialize;
use surrealdb::RecordId;

#[derive(Debug, Deserialize)]
struct UserRow {
	id: RecordId,
	email: String,
	active: bool,
}

let mut response = db
	.query("SELECT id, email, active FROM user WHERE active = true")
	.await?;
let rows: Vec<UserRow> = response.take(0)?;
```

## See Also

- [rust-serde-models](./rust-serde-models.md)
- [query-shape-stable](./query-shape-stable.md)
