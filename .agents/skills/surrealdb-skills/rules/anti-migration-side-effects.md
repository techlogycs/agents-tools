# anti-migration-side-effects

Do not hide heavy data rewrites in startup migrations.

## Why

- It turns deploy and restart behavior into an operational gamble.

## Prefer

- Explicit backfill jobs or controlled migration phases.
