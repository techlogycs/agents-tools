# anti-app-only-uniqueness

Do not rely on application-only uniqueness checks.

## Why

- Concurrent writers can bypass pre-check logic easily.

## Prefer

- Database uniqueness enforced by indexes and transactions.
