# fn-prefer-unions-over-overloads

> Prefer union parameters over overloads when the valid call shapes are compatible

## Why It Matters

The TypeScript handbook recommends preferring union parameters to overloads when possible. Union-based signatures are easier to read, easier for callers to satisfy, and avoid overload resolution failures when a value is already a union.

## Bad

```ts
function len(value: string): number;
function len(value: any[]): number;
function len(value: string | any[]) {
  return value.length;
}

const input = Math.random() > 0.5 ? "hello" : [1, 2, 3];
len(input);
```

## Good

```ts
function len(value: string | any[]) {
  return value.length;
}

const input = Math.random() > 0.5 ? "hello" : [1, 2, 3];
len(input);
```

## Prefer Overloads Only When

- argument counts differ materially
- return types genuinely depend on distinct call shapes
- a single union signature would obscure the API instead of simplifying it

## See Also

- [narrow-before-member-access](./narrow-before-member-access.md)
- [data-prefer-unknown-over-any](./data-prefer-unknown-over-any.md)
