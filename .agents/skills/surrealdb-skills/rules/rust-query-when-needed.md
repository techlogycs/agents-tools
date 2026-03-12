# rust-query-when-needed

Use raw SurrealQL only when typed methods are not expressive enough.

## Apply when

- The operation needs multiple statements, advanced filtering, or database-specific constructs.

## Do

- Keep raw queries focused and reviewable.

## Avoid

- Making every repository call a free-form query string.
