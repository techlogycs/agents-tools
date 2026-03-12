# schema-assert-at-boundary

> Use `ASSERT` to encode invariants close to the data

## Why It Matters

Validation that lives only in services drifts over time. Schema assertions keep the contract attached to the record itself, and `THROW` can make failures much more diagnosable.

## Bad

```surql
DEFINE FIELD email ON TABLE user TYPE string;
DEFINE FIELD tags ON TABLE user TYPE array<string>;
```

## Good

```surql
DEFINE FIELD email ON TABLE user TYPE string
	ASSERT {
		IF string::is::email($value) {
			RETURN true;
		};
		THROW "email must be a valid address";
	};

DEFINE FIELD tags ON TABLE user TYPE array<string>
	ASSERT array::len($value) <= 8;
```

## See Also

- [schema-define-fields-explicitly](./schema-define-fields-explicitly.md)
- [schema-option-nullable](./schema-option-nullable.md)
