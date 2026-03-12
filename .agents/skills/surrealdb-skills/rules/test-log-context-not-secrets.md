# test-log-context-not-secrets

> Log namespace, database, table, and operation context without leaking secrets

## Why It Matters

The observability guide emphasizes structured logs, metrics, OpenTelemetry export, and runtime inspection tools such as `tokio-console`. Logs need enough operation context to correlate failures, but they should never become a data leak.

## Good

```rust
tracing::error!(
	ns = "synux",
	db = "synux",
	table = "user",
	operation = "select_by_email",
	error = %error,
	"surrealdb query failed"
);
```

Also prefer operational hooks such as:

- OpenTelemetry metrics and traces for database-facing paths
- log output settings appropriate to environment
- `tokio-console` during async contention or latency debugging

## Avoid

- Logging passwords, tokens, raw auth headers, or full sensitive record payloads.

## See Also

- [test-latency-and-errors](./test-latency-and-errors.md)
- [rust-error-context](./rust-error-context.md)
