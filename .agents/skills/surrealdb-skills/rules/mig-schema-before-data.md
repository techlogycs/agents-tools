# mig-schema-before-data

Apply schema and access definitions before dependent data migrations.

## Apply when

- A migration both defines structure and reshapes data.

## Do

- Establish the contract first, then move dependent records.

## Avoid

- Rewriting data before the new schema exists.
