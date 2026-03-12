# rust-shared-client

> Reuse a shared `Surreal` client instead of reconnecting per request

## Why It Matters

Connection setup, authentication, and namespace selection belong in bootstrap. Repeating them in every request adds latency and spreads database state across the codebase.

## Bad

```rust
async fn handler() -> anyhow::Result<()> {
	let db = surrealdb::Surreal::new::<surrealdb::engine::remote::ws::Ws>("localhost:8000").await?;
	db.signin(surrealdb::opt::auth::Root {
		username: "root",
		password: "secret",
	}).await?;
	db.use_ns("app").use_db("app").await?;
	Ok(())
}
```

## Good

```rust
use std::sync::Arc;

struct AppState {
	db: Arc<Db>,
}

async fn build_state() -> anyhow::Result<AppState> {
	let db = connect().await?;
	Ok(AppState { db: Arc::new(db) })
}
```

## See Also

- [rust-startup-bootstrap](./rust-startup-bootstrap.md)
- [rust-use-ns-db-once](./rust-use-ns-db-once.md)
