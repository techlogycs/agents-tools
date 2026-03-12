# auth-no-root-runtime

> Do not run normal application traffic with root credentials

## Why It Matters

Root credentials turn ordinary request-path bugs into full-database incidents. They should be a bootstrap and maintenance tool, not the identity behind normal traffic.

## Bad

```rust
db.signin(surrealdb::opt::auth::Root {
	username: "root",
	password: "secret",
}).await?;

// This client is then reused for all user-driven reads and writes.
```

## Good

```rust
async fn bootstrap(db: &Db) -> anyhow::Result<()> {
	db.signin(surrealdb::opt::auth::Root {
		username: "root",
		password: &std::env::var("SURREALDB_PASS")?,
	}).await?;

	run_migrations(db).await?;
	Ok(())
}

// Normal request handling should use constrained access instead.
```

## See Also

- [auth-least-privilege](./auth-least-privilege.md)
- [anti-root-in-prod](./anti-root-in-prod.md)
