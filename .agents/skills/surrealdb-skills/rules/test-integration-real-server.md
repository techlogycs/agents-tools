# test-integration-real-server

Use a real SurrealDB server for permissions, indexing, and live query behavior.

## Apply when

- Behavior depends on actual server semantics.

## Do

- Add integration tests against the deployed engine mode where it matters.

## Avoid

- Assuming embedded-only tests prove operational equivalence.
