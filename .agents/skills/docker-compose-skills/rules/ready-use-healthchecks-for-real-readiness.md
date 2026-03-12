# ready-use-healthchecks-for-real-readiness

> Model startup readiness with health checks and conditional dependencies instead of assuming running means ready

## Why It Matters

Docker documents that Compose waits only for a container to be running, not for it to be ready. Services like databases or brokers often need additional startup time before they can accept real traffic. Readiness should therefore be expressed with health checks and `depends_on` conditions.

## Bad

```yaml
services:
  web:
    build: .
    depends_on:
      - db

  db:
    image: postgres:18
```

## Good

```yaml
services:
  web:
    build: .
    depends_on:
      db:
        condition: service_healthy
        restart: true

  db:
    image: postgres:18
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U $${POSTGRES_USER} -d $${POSTGRES_DB}"]
      interval: 10s
      timeout: 10s
      retries: 5
      start_period: 30s
```

## Prefer This Pattern

- Use `service_healthy` when real readiness matters.
- Add health checks to stateful dependencies.
- Use `service_completed_successfully` for one-shot setup jobs when needed.

## See Also

- [merge-validate-merged-compose-config](./merge-validate-merged-compose-config.md)
