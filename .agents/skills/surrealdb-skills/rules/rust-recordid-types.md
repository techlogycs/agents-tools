# rust-recordid-types

Represent record IDs explicitly rather than as unvalidated strings.

## Apply when

- Working with SurrealDB identities in Rust code.

## Do

- Use `RecordId` or validated wrappers where identity matters.

## Avoid

- Treating IDs as arbitrary strings throughout the codebase.
