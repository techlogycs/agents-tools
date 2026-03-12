# ts-typed-methods-and-query-results

> Prefer typed SDK methods and typed `query()` results in TypeScript instead of falling back to `any`.

## Why It Matters

The JavaScript SDK exposes generic CRUD methods and typed query result collection. If TypeScript call sites discard that typing, SurrealDB records become loosely shaped blobs and refactors lose most of the safety the SDK can provide.

## Bad

```typescript
const db = new Surreal();
await db.connect("wss://localhost:8000");

const rows: any = await db.select("person");
const result: any = await db.query(
  "SELECT * FROM person WHERE age >= $minAge",
  {
    minAge: 18,
  },
);

console.log(result[0][0].unknownField);
```

## Good

```typescript
import { RecordId, Surreal, Table } from "surrealdb";

type Person = {
  id: RecordId;
  name: string;
  age: number;
};

const db = new Surreal();
await db.connect("wss://localhost:8000", {
  namespace: "app",
  database: "app",
});

const people = await db.select<Person>(new Table("person"));

const [adults] = await db.query<[Person[]]>(
  "SELECT * FROM person WHERE age >= $minAge ORDER BY name",
  { minAge: 18 },
);
```

## Prefer These APIs

- `select<T>()`, `create<T>()`, and `update<T>()` for common record operations.
- `query<[A, B, ...]>()` when multiple statements return distinct result shapes.
- `collect<[A, B, ...]>()` or `responses<[A, B, ...]>()` when you need explicit result handling.
- Bound parameters instead of string interpolation when using `query()`.

## See Also

- [query-bind-parameters](./query-bind-parameters.md)
- [query-typed-results](./query-typed-results.md)
- [ts-shared-client-and-session-boundaries](./ts-shared-client-and-session-boundaries.md)
