# anti-root-in-prod

Do not serve normal application traffic with root credentials.

## Why

- It collapses isolation and turns ordinary bugs into full-database incidents.

## Prefer

- Scoped service credentials and controlled bootstrap flows.
