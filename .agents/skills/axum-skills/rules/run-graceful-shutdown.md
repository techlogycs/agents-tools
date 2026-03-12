# run-graceful-shutdown

> Implement explicit graceful shutdown instead of relying on abrupt process termination

## Why It Matters

Tokio documents graceful shutdown as a three-part workflow: detect shutdown, notify tasks, and wait for them to finish. Axum services sit on Tokio, so production services should stop accepting new work while allowing in-flight work to wind down cleanly.

## Bad

```rust
use axum::{routing::get, Router};
use tokio::net::TcpListener;

#[tokio::main]
async fn main() {
    let app = Router::new().route("/health", get(|| async { "ok" }));
    let listener = TcpListener::bind("0.0.0.0:3000").await.unwrap();

    axum::serve(listener, app).await.unwrap();
}
```

## Good

```rust
use axum::{routing::get, Router};
use tokio::{net::TcpListener, signal};
use tokio_util::sync::CancellationToken;

async fn shutdown_signal(token: CancellationToken) {
    signal::ctrl_c().await.expect("failed to install Ctrl+C handler");
    token.cancel();
}

#[tokio::main]
async fn main() {
    let shutdown = CancellationToken::new();
    let app = Router::new().route("/health", get(|| async { "ok" }));
    let listener = TcpListener::bind("0.0.0.0:3000").await.unwrap();

    let shutdown_task = shutdown.clone();
    tokio::spawn(shutdown_signal(shutdown_task));

    axum::serve(listener, app)
        .with_graceful_shutdown(async move {
            shutdown.cancelled().await;
        })
        .await
        .unwrap();
}
```

## Prefer This Pattern

- Detect shutdown from OS signals or internal control channels.
- Notify workers and background tasks with a cancellation token or channel.
- Wait for in-flight tasks to finish before exiting.

## See Also

- [state-use-state-extractor](./state-use-state-extractor.md)
- [resp-return-intoresponse](./resp-return-intoresponse.md)
