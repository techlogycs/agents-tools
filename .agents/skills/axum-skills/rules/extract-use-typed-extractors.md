# extract-use-typed-extractors

> Model request inputs with Axum extractors instead of manually parsing request state

## Why It Matters

Axum is built around extractors. They turn routing parameters, query strings, JSON bodies, headers, and shared state into typed inputs at the handler boundary. This keeps handlers declarative, reduces parsing bugs, and lets rejection behavior stay consistent.

## Bad

```rust
use axum::{body::Body, http::Request, response::Response};

async fn search(req: Request<Body>) -> Response<String> {
    let uri = req.uri().to_string();
    let query = uri
        .split('?')
        .nth(1)
        .and_then(|raw| raw.strip_prefix("q="))
        .unwrap_or_default()
        .to_string();

    Response::new(format!("searching for {query}"))
}
```

## Good

```rust
use axum::{extract::Query, Json};
use serde::{Deserialize, Serialize};

#[derive(Deserialize)]
struct SearchParams {
    q: String,
}

#[derive(Serialize)]
struct SearchResponse {
    query: String,
}

async fn search(Query(params): Query<SearchParams>) -> Json<SearchResponse> {
    Json(SearchResponse { query: params.q })
}
```

## Prefer This Pattern

- `Path<T>` for route parameters
- `Query<T>` for query strings
- `Json<T>` for request and response bodies
- `State<T>` for shared dependencies
- Header or typed request-part extractors when protocol details matter

## See Also

- [state-use-state-extractor](./state-use-state-extractor.md)
- [resp-return-intoresponse](./resp-return-intoresponse.md)
