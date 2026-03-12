# mig-idempotent-defines

Prefer repeat-safe definitions in migrations.

## Apply when

- Defining tables, fields, indexes, users, or access methods.

## Do

- Use `IF NOT EXISTS` and compatible idempotent patterns where available.

## Avoid

- Requiring destructive cleanup just to rerun setup.
