# auth-record-access-default

> Use `DEFINE ACCESS ... TYPE RECORD` for end-user authentication flows

## Why It Matters

Record access lets the database own sign-in and token rules close to the identity data itself, which reduces drift between auth logic and data access.

## Bad

```surql
DEFINE TABLE user SCHEMAFULL;
-- Application code handles auth separately and the database sees only broad service access.
```

## Good

```surql
DEFINE TABLE user SCHEMAFULL;
DEFINE FIELD email ON TABLE user TYPE string ASSERT string::is::email($value);
DEFINE FIELD password_hash ON TABLE user TYPE string;

DEFINE ACCESS account ON DATABASE TYPE RECORD
	SIGNUP (
		CREATE user CONTENT {
			email: $email,
			password_hash: crypto::argon2::generate($pass)
		}
	)
	SIGNIN (
		SELECT * FROM user
		WHERE email = $email
			AND crypto::argon2::compare(password_hash, $pass)
	)
	DURATION FOR TOKEN 15m, FOR SESSION 12h;
```

## See Also

- [auth-password-hash](./auth-password-hash.md)
- [auth-table-permissions](./auth-table-permissions.md)
