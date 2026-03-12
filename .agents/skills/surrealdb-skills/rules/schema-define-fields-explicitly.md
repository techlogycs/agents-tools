# schema-define-fields-explicitly

> Define every persisted field with an explicit type

## Why It Matters

Explicit field definitions make read models predictable and let the database reject invalid writes before application code has to clean them up.

## Bad

```surql
DEFINE TABLE user SCHEMAFULL;

CREATE user CONTENT {
	email: "alice@example.com",
	marketing_opt_in: "yes"
};
```

## Good

```surql
DEFINE TABLE user SCHEMAFULL;
DEFINE FIELD email ON TABLE user TYPE string
	ASSERT string::is::email($value);
DEFINE FIELD marketing_opt_in ON TABLE user TYPE bool DEFAULT false;
DEFINE FIELD created_at ON TABLE user TYPE datetime DEFAULT time::now();
```

## See Also

- [schema-assert-at-boundary](./schema-assert-at-boundary.md)
- [schema-option-nullable](./schema-option-nullable.md)
