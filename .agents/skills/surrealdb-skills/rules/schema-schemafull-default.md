# schema-schemafull-default

> Prefer `SCHEMAFULL` tables for core application data

## Why It Matters

Core domain tables should reject shape drift. `SCHEMAFULL` keeps typo fields, incompatible payloads, and client-specific junk from silently becoming part of durable state.

## Bad

```surql
DEFINE TABLE invoice SCHEMALESS;

CREATE invoice CONTENT {
	total: 42.50,
	status: "paid",
	statuz: "paid"
};
```

## Good

```surql
DEFINE TABLE invoice SCHEMAFULL;
DEFINE FIELD total ON TABLE invoice TYPE decimal;
DEFINE FIELD status ON TABLE invoice TYPE string
	ASSERT $value INSIDE ["draft", "sent", "paid", "void"];
DEFINE FIELD paid_at ON TABLE invoice TYPE option<datetime>;

CREATE invoice CONTENT {
	total: 42.50,
	status: "paid"
};
```

## See Also

- [schema-define-fields-explicitly](./schema-define-fields-explicitly.md)
- [anti-schemaless-default](./anti-schemaless-default.md)
