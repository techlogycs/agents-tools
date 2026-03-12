# perf-unique-enforce

> Enforce business uniqueness with unique indexes instead of app-only checks

## Why It Matters

Concurrency defeats pre-check logic. The performance guide also points out that `UPSERT` is the right companion when a unique index defines record identity.

## Bad

```surql
LET $exists = SELECT * FROM user WHERE email = $email LIMIT 1;
IF array::len($exists) = 0 {
	CREATE user CONTENT { email: $email };
};
```

## Good

```surql
DEFINE INDEX user_email_idx ON TABLE user COLUMNS email UNIQUE;

UPSERT user SET email = $email, name = $name;
```

## See Also

- [txn-unique-over-race](./txn-unique-over-race.md)
- [query-only-single-record](./query-only-single-record.md)
