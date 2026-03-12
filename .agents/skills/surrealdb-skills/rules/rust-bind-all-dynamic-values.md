# rust-bind-all-dynamic-values

> Bind all user-controlled values in Rust `query()` calls

## Why It Matters

The Rust SDK should preserve the same query boundary as SurrealQL itself: query structure stays fixed, and runtime values travel separately as parameters.

## Bad

```rust
let email = input.email;
let sql = format!("SELECT * FROM user WHERE email = '{email}' LIMIT 1");
let mut response = db.query(sql).await?;
```

## Good

```rust
let mut response = db
	.query("SELECT * FROM user WHERE email = $email LIMIT 1")
	.bind(("email", input.email))
	.await?;
```

## See Also

- [query-bind-parameters](./query-bind-parameters.md)
- [anti-string-interpolation](./anti-string-interpolation.md)
