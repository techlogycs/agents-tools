# schema-schemaless-exception

> Use `SCHEMALESS` only when variability is an explicit requirement

## Why It Matters

`SCHEMALESS` is useful for capture and ingestion workloads, but it shifts correctness back into the application. That tradeoff should be explicit instead of accidental.

## Bad

```surql
DEFINE TABLE customer SCHEMALESS;
```

## Good

```surql
DEFINE TABLE webhook_event SCHEMALESS;
DEFINE FIELD source ON TABLE webhook_event TYPE string;
DEFINE FIELD received_at ON TABLE webhook_event TYPE datetime DEFAULT time::now();

CREATE webhook_event CONTENT {
	source: "billing-provider",
	payload: {
		vendor_specific_shape: {
			nested: true
		}
	}
};
```

## See Also

- [schema-schemafull-default](./schema-schemafull-default.md)
- [schema-hot-cold-split](./schema-hot-cold-split.md)
