# auth-password-hash

> Hash secrets in database auth flows with strong password primitives

## Why It Matters

User passwords should never be stored as plain strings or reversible values. SurrealDB already exposes `crypto::argon2`, which is the right default for password-style secrets.

## Bad

```surql
CREATE user CONTENT {
	email: $email,
	password: $pass
};
```

## Good

```surql
CREATE user CONTENT {
	email: $email,
	password_hash: crypto::argon2::generate($pass)
};

SELECT * FROM user
WHERE email = $email
	AND crypto::argon2::compare(password_hash, $pass);
```

## See Also

- [auth-record-access-default](./auth-record-access-default.md)
- [auth-short-token-duration](./auth-short-token-duration.md)
