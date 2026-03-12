# auth-service-vs-user

Separate service credentials from end-user auth models.

## Apply when

- One system has both server-side automation and user-facing access.

## Do

- Treat machine and human identities as different trust domains.

## Avoid

- Reusing the same access path for internal services and users.
