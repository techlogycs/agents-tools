# schema-option-nullable

Model nullable fields with `option<T>` rather than loose null handling.

## Apply when

- A field is truly optional but still part of the contract.

## Do

- Make absence explicit in the schema and client models.

## Avoid

- Mixing omitted fields, nulls, and placeholder strings.
