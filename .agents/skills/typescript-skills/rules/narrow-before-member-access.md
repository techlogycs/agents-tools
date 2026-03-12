# narrow-before-member-access

> Narrow union values before using operations that only exist on some members

## Why It Matters

TypeScript only allows operations that are valid for every member of a union. The handbook documents narrowing with `typeof`, `in`, `instanceof`, equality checks, discriminants, and user-defined predicates. Using those checks keeps logic aligned with real runtime behavior.

## Bad

```ts
function printId(id: string | number) {
  return id.toUpperCase();
}
```

## Good

```ts
function printId(id: string | number) {
  if (typeof id === "string") {
    return id.toUpperCase();
  }

  return id.toString();
}
```

## Discriminated Union Example

```ts
type Circle = { kind: "circle"; radius: number };
type Square = { kind: "square"; sideLength: number };
type Shape = Circle | Square;

function area(shape: Shape) {
  switch (shape.kind) {
    case "circle":
      return Math.PI * shape.radius ** 2;
    case "square":
      return shape.sideLength ** 2;
    default: {
      const exhaustiveCheck: never = shape;
      return exhaustiveCheck;
    }
  }
}
```

## See Also

- [cfg-enable-strict-mode](./cfg-enable-strict-mode.md)
- [data-prefer-unknown-over-any](./data-prefer-unknown-over-any.md)
