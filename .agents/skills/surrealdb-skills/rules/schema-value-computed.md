# schema-value-computed

> Use `VALUE` or computed fields for stable derived projections

## Why It Matters

The reference guide leans on computed fields, futures, and `VALUE` definitions to keep derivations close to the data model. That prevents the same logic from drifting across handlers, jobs, and clients.

## Bad

```rust
// Each caller recomputes display_name differently.
format!("{} {}", user.first_name, user.last_name)
```

## Good

```surql
DEFINE FIELD full_name ON TABLE user
	VALUE string::concat(first_name, " ", last_name);

DEFINE FIELD total_value ON TABLE contract COMPUTED
	original_value + math::sum(SELECT VALUE amount FROM change_order WHERE contract = $parent.id);
```

## See Also

- [schema-default-generated](./schema-default-generated.md)
- [rt-views-for-reads](./rt-views-for-reads.md)
