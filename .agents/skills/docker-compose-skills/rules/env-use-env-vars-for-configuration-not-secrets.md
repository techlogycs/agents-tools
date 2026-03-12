# env-use-env-vars-for-configuration-not-secrets

> Use environment variables for configuration and interpolation, not for secret material

## Why It Matters

Docker documents environment variables and interpolation as tools for reusable, flexible Compose configuration. They are appropriate for non-sensitive configuration like ports, modes, hostnames, and feature flags. Secrets should use Compose secrets instead.

## Bad

```yaml
services:
  api:
    environment:
      DATABASE_PASSWORD: super-secret-password
      JWT_SECRET: another-secret
```

## Good

```yaml
services:
  api:
    environment:
      APP_ENV: ${APP_ENV:-development}
      API_PORT: ${API_PORT:-8080}
      LOG_LEVEL: ${LOG_LEVEL:-info}
```

## Prefer This Pattern

- Use env variables for non-secret configuration.
- Keep interpolation readable and explicit.
- Understand precedence rules before mixing shell env, `.env`, and file-defined values.

## See Also

- [secret-use-compose-secrets-for-sensitive-data](./secret-use-compose-secrets-for-sensitive-data.md)
- [merge-validate-merged-compose-config](./merge-validate-merged-compose-config.md)
