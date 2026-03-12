# schema-record-links

> Use `record<table>` fields for typed references

## Why It Matters

Typed links preserve identity semantics in the schema and reduce stringly-typed join logic in queries and Rust code.

## Bad

```surql
DEFINE TABLE order SCHEMAFULL;
DEFINE FIELD customer_id ON TABLE order TYPE string;
```

## Good

```surql
DEFINE TABLE customer SCHEMAFULL;
DEFINE TABLE order SCHEMAFULL;
DEFINE FIELD customer ON TABLE order TYPE record<customer>;
DEFINE FIELD total ON TABLE order TYPE decimal;

CREATE order CONTENT {
	customer: customer:alice,
	total: 99.00
};
```

## See Also

- [schema-relate-many-to-many](./schema-relate-many-to-many.md)
- [query-fetch-selective](./query-fetch-selective.md)
