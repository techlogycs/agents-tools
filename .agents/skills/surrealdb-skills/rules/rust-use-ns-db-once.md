# rust-use-ns-db-once

> Select namespace and database during bootstrap before serving traffic.

## Why It Matters

The Rust SDK keeps namespace and database selection on the client session. Repeating `use_ns().use_db()` in request handlers spreads connection state across the codebase, adds avoidable latency, and makes it easier to mix bootstrap concerns with request work.

## Bad

```rust
async fn get_user(db: &surrealdb::Surreal<surrealdb::engine::remote::ws::Client>) -> surrealdb::Result<()> {
	db.use_ns("app").use_db("app").await?;
	let _: Vec<User> = db.select("user").await?;
	Ok(())
}

async fn create_user(db: &surrealdb::Surreal<surrealdb::engine::remote::ws::Client>, new_user: NewUser) -> surrealdb::Result<()> {
	db.use_ns("app").use_db("app").await?;
	let _: Option<User> = db.create("user").content(new_user).await?;
	Ok(())
}
```

## Good

```rust
use surrealdb::engine::remote::ws::Ws;
use surrealdb::opt::auth::Root;
use surrealdb::Surreal;

type Db = Surreal<surrealdb::engine::remote::ws::Client>;

async fn connect_db() -> surrealdb::Result<Db> {
	let db = Surreal::new::<Ws>("127.0.0.1:8000").await?;
	db.signin(Root {
		username: "root",
		password: "secret",
	}).await?;
	db.use_ns("app").use_db("app").await?;
	Ok(db)
}

async fn get_users(db: &Db) -> surrealdb::Result<Vec<User>> {
	db.select("user").await
}
```

## See Also

- [rust-shared-client](./rust-shared-client.md)
- [rust-startup-bootstrap](./rust-startup-bootstrap.md)
