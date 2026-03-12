# auth-table-permissions

> Encode row-level access with explicit table permissions

## Why It Matters

Handler-only filtering is fragile. Table permissions ensure direct database access and forgotten endpoints still respect the intended access model.

## Bad

```surql
DEFINE TABLE post SCHEMAFULL;
-- Access policy exists only in API code.
```

## Good

```surql
DEFINE TABLE post SCHEMAFULL
	PERMISSIONS
		FOR select WHERE published = true OR author = $auth.id
		FOR create WHERE author = $auth.id
		FOR update WHERE author = $auth.id
		FOR delete WHERE author = $auth.id OR $auth.admin = true;
```

## See Also

- [auth-least-privilege](./auth-least-privilege.md)
- [auth-test-denials](./auth-test-denials.md)
