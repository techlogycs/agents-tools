# rust-typed-crud-first

> Prefer typed SDK CRUD methods before raw query strings

## Why It Matters

Typed CRUD operations are easier to read, easier to refactor, and usually safer than embedding raw query text for ordinary record operations.

## Bad

```rust
let mut response = db
	.query("CREATE user CONTENT { email: $email, active: true }")
	.bind(("email", email))
	.await?;

let created: Option<User> = response.take(0)?;
```

## Good

```rust
#[derive(serde::Serialize)]
struct NewUser<'a> {
	email: &'a str,
	active: bool,
}

let created: Option<User> = db
	.create("user")
	.content(NewUser {
		email,
		active: true,
	})
	.await?;
```

## See Also

- [rust-query-when-needed](./rust-query-when-needed.md)
- [query-typed-results](./query-typed-results.md)
