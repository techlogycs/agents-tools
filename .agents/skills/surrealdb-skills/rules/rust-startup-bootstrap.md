# rust-startup-bootstrap

> Keep startup bootstrap deterministic: connect, auth, select namespace, migrate, then serve

## Why It Matters

Database bootstrap is part of application correctness. If the server accepts traffic before database auth, namespace selection, or migrations complete, failures become nondeterministic and harder to recover.

## Bad

```rust
#[tokio::main]
async fn main() {
	let listener = tokio::net::TcpListener::bind("0.0.0.0:3000").await.unwrap();
	let db = connect().await.unwrap();

	tokio::spawn(async move {
		run_migrations(&db).await.unwrap();
	});

	axum::serve(listener, app()).await.unwrap();
}
```

## Good

```rust
#[tokio::main]
async fn main() -> anyhow::Result<()> {
	let db = connect().await?;
	run_migrations(&db).await?;

	let state = AppState {
		db: std::sync::Arc::new(db),
	};

	let listener = tokio::net::TcpListener::bind("0.0.0.0:3000").await?;
	axum::serve(listener, app(state)).await?;
	Ok(())
}
```

## See Also

- [rust-shared-client](./rust-shared-client.md)
- [mig-startup-safe](./mig-startup-safe.md)
