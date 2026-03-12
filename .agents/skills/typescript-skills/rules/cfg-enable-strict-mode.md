# cfg-enable-strict-mode

> Treat `strict` mode as the baseline TypeScript configuration

## Why It Matters

The TypeScript docs describe `strict` as enabling a family of stronger correctness checks, and note that future versions may strengthen it further. Using `strict` early surfaces nullability, implicit `any`, and type-flow bugs before they become runtime failures.

## Bad

```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "ESNext"
  }
}
```

```ts
function greet(name) {
  return name.toUpperCase();
}
```

## Good

```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "ESNext",
    "strict": true
  }
}
```

```ts
function greet(name: string) {
  return name.toUpperCase();
}
```

## Notes

- `strict` is a baseline, not an optional extra, for new code.
- Expect `strictNullChecks` and `noImplicitAny` issues to surface first.
- If migration requires exceptions, isolate and document them instead of disabling strictness globally.

## See Also

- [narrow-before-member-access](./narrow-before-member-access.md)
- [data-prefer-unknown-over-any](./data-prefer-unknown-over-any.md)
