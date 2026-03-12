# schema-default-generated

Use `DEFAULT` for values the database should generate consistently.

## Apply when

- Creating timestamps, counters, or other server-owned defaults.

## Do

- Prefer database time and generated defaults for persisted state.

## Avoid

- Spreading default logic across multiple clients.
