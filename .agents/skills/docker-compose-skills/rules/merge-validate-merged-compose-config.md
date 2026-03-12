# merge-validate-merged-compose-config

> Design multi-file Compose setups around the merged output and validate it explicitly

## Why It Matters

Docker documents that multiple Compose files merge in command order and that relative paths are evaluated from the base file. Complex setups should therefore be reasoned about as the final merged configuration, not as isolated YAML fragments.

## Bad

```sh
docker compose -f compose.yml -f compose.dev.yml up
```

```yaml
# compose.dev.yml
services:
  api:
    volumes:
      - ./src:/app/src
```

````

Assumes the override file's directory changes path resolution.

## Good

```sh
docker compose -f compose.yml -f compose.dev.yml config
docker compose -f compose.yml -f compose.dev.yml up
````

## Prefer This Pattern

- Treat the first file as the base path anchor.
- Use later files only to override or extend intentionally.
- Validate the merged configuration with `docker compose config` before relying on it.

## See Also

- [ready-use-healthchecks-for-real-readiness](./ready-use-healthchecks-for-real-readiness.md)
- [env-use-env-vars-for-configuration-not-secrets](./env-use-env-vars-for-configuration-not-secrets.md)
