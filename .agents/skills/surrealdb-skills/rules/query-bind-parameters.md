# query-bind-parameters

> Bind every dynamic value instead of interpolating raw SurrealQL strings

## Why It Matters

Bound parameters protect query structure and reduce injection-style mistakes and malformed SurrealQL from user-controlled input.

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

- [rust-bind-all-dynamic-values](./rust-bind-all-dynamic-values.md)
- [anti-string-interpolation](./anti-string-interpolation.md)
