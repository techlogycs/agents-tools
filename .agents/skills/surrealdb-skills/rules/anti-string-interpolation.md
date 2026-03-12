# anti-string-interpolation

Do not interpolate user data directly into SurrealQL strings.

## Why

- It weakens query safety and makes intent harder to review.

## Prefer

- Bound parameters and stable query text.
