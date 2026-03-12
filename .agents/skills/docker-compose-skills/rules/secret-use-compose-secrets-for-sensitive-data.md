# secret-use-compose-secrets-for-sensitive-data

> Use Compose secrets for sensitive values instead of plain environment variables

## Why It Matters

Docker documents secrets as the safer mechanism for passwords, API keys, and certificates. Secrets are mounted into `/run/secrets/<name>` and granted per service, whereas environment variables are easier to leak through logs, debug output, or broad process visibility.

## Bad

```yaml
services:
  db:
    image: mysql:latest
    environment:
      MYSQL_ROOT_PASSWORD: super-secret-password
```

## Good

```yaml
services:
  db:
    image: mysql:latest
    environment:
      MYSQL_ROOT_PASSWORD_FILE: /run/secrets/db_root_password
    secrets:
      - db_root_password

secrets:
  db_root_password:
    file: ./db_root_password.txt
```

## Notes

- Grant each secret only to services that need it.
- Prefer `_FILE` environment conventions when supported by the image.
- Use build secrets separately when a secret is needed only during image build.

## See Also

- [env-use-env-vars-for-configuration-not-secrets](./env-use-env-vars-for-configuration-not-secrets.md)
