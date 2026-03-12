# state-use-state-extractor

> Prefer `State<T>` for shared application state instead of ad hoc per-request extensions

## Why It Matters

Axum documents `State` as the primary mechanism for typed shared state. It makes dependencies visible in handler signatures, keeps state wiring uniform across the router tree, and avoids hiding core dependencies behind looser extension-based patterns.

## Bad

```rust
use axum::{extract::Extension, routing::get, Router};
use std::sync::Arc;

#[derive(Clone)]
struct AppState {
    app_name: String,
}

async fn health(Extension(state): Extension<Arc<AppState>>) -> String {
    format!("{} is healthy", state.app_name)
}

fn app() -> Router {
    let state = Arc::new(AppState {
        app_name: "api".to_string(),
    });

    Router::new()
        .route("/health", get(health))
        .layer(axum::Extension(state))
}
```

## Good

```rust
use axum::{extract::State, routing::get, Router};
use std::sync::Arc;

#[derive(Clone)]
struct AppState {
    app_name: String,
}

async fn health(State(state): State<Arc<AppState>>) -> String {
    format!("{} is healthy", state.app_name)
}

fn app(state: Arc<AppState>) -> Router {
    Router::new()
        .route("/health", get(health))
        .with_state(state)
}
```

## Notes

- Keep application-wide dependencies in a dedicated state struct.
- Derive `Clone` on the state container you pass to the router.
- Use finer-grained state types only when that boundary is intentional and documented.

## See Also

- [extract-use-typed-extractors](./extract-use-typed-extractors.md)
- [resp-return-intoresponse](./resp-return-intoresponse.md)
- [run-graceful-shutdown](./run-graceful-shutdown.md)
