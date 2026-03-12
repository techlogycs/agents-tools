# query-take-explicit

> Read multi-statement results with explicit `take(index)` handling

## Why It Matters

Each statement in a SurrealDB query produces its own result slot. Consuming those slots implicitly is an easy way to deserialize the wrong thing into the wrong type.

## Bad

```rust
let mut response = db
	.query("CREATE audit CONTENT { action: 'login' }; SELECT * FROM user LIMIT 10;")
	.await?;

let users: Vec<User> = response.take(0)?;
```

## Good

```rust
let mut response = db
	.query("CREATE audit CONTENT { action: 'login' }; SELECT * FROM user LIMIT 10;")
	.await?;

let _audit: Option<AuditRow> = response.take(0)?;
let users: Vec<User> = response.take(1)?;
```

## See Also

- [query-minimize-multi-statement](./query-minimize-multi-statement.md)
- [query-typed-results](./query-typed-results.md)
