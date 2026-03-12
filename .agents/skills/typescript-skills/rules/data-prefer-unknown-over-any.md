# data-prefer-unknown-over-any

> Use `unknown` for untrusted data and refine it before use instead of defaulting to `any`

## Why It Matters

The handbook documents `unknown` as the safe counterpart to `any`. With `any`, every property access and call is allowed, so type checking stops helping. With `unknown`, code must prove what the value is before using it.

## Bad

```ts
function parseUser(json: string): any {
  return JSON.parse(json);
}

const user = parseUser(payload);
console.log(user.name.toUpperCase());
```

## Good

```ts
type User = {
  name: string;
};

function parseUser(json: string): unknown {
  return JSON.parse(json);
}

function isUser(value: unknown): value is User {
  return (
    typeof value === "object" &&
    value !== null &&
    "name" in value &&
    typeof (value as { name: unknown }).name === "string"
  );
}

const parsed = parseUser(payload);

if (!isUser(parsed)) {
  throw new Error("invalid user payload");
}

console.log(parsed.name.toUpperCase());
```

## See Also

- [cfg-enable-strict-mode](./cfg-enable-strict-mode.md)
- [narrow-before-member-access](./narrow-before-member-access.md)
- [fn-prefer-unions-over-overloads](./fn-prefer-unions-over-overloads.md)
