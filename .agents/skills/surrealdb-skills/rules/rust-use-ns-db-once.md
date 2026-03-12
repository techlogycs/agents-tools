# rust-use-ns-db-once

Select namespace and database during startup before serving traffic.

## Apply when

- Initializing the shared database client.

## Do

- Set namespace and database once in bootstrap.

## Avoid

- Repeating namespace selection in every request path.
