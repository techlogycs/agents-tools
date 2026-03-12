# auth-if-not-exists

Use `IF NOT EXISTS` for idempotent access bootstrap and migrations.

## Apply when

- Defining users, access methods, or repeatable setup statements.

## Do

- Make bootstrap safe to rerun across environments.

## Avoid

- Requiring manual cleanup before applying definitions again.
