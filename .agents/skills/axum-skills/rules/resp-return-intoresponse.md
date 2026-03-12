# resp-return-intoresponse

> Return typed values that implement `IntoResponse` instead of building raw HTTP responses by hand

## Why It Matters

Axum treats `IntoResponse` as the normal response boundary. Returning tuples, `Json<T>`, status-code pairs, or custom error types is easier to read than manually constructing `http::Response` values. It also keeps success and failure paths composable.

## Bad

```rust
use axum::{http::StatusCode, response::Response};

async fn create_note() -> Response<String> {
    Response::builder()
        .status(StatusCode::CREATED)
        .header("content-type", "text/plain")
        .body("created".to_string())
        .unwrap()
}
```

## Good

```rust
use axum::{http::StatusCode, Json};
use serde::Serialize;

#[derive(Serialize)]
struct CreateNoteResponse {
    status: &'static str,
}

async fn create_note() -> (StatusCode, Json<CreateNoteResponse>) {
    (
        StatusCode::CREATED,
        Json(CreateNoteResponse { status: "created" }),
    )
}
```

## Custom Error Example

```rust
use axum::{http::StatusCode, response::{IntoResponse, Response}, Json};
use serde::Serialize;

#[derive(Serialize)]
struct ErrorBody {
    error: &'static str,
}

enum AppError {
    NotFound,
}

impl IntoResponse for AppError {
    fn into_response(self) -> Response {
        match self {
            AppError::NotFound => (
                StatusCode::NOT_FOUND,
                Json(ErrorBody { error: "not found" }),
            )
                .into_response(),
        }
    }
}
```

## See Also

- [extract-use-typed-extractors](./extract-use-typed-extractors.md)
- [state-use-state-extractor](./state-use-state-extractor.md)
