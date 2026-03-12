# rust-error-context

Add context around connection, auth, migration, and query failures.

## Apply when

- Propagating SurrealDB-related errors through application layers.

## Do

- Attach operation context so failures are diagnosable.

## Avoid

- Returning generic database errors with no surrounding signal.
