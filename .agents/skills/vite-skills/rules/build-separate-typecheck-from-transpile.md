# build-separate-typecheck-from-transpile

> Run TypeScript checking separately from the Vite build pipeline

## Why It Matters

Vite documents that it transpiles TypeScript but does not perform full type checking. Treating `vite build` as both bundling and validation leaves real type errors undetected until another tool catches them.

## Bad

```json
{
  "scripts": {
    "build": "vite build"
  }
}
```

## Good

```json
{
  "scripts": {
    "typecheck": "tsc --noEmit",
    "build": "tsc --noEmit && vite build"
  }
}
```

## Notes

- Keep bundling and type analysis as separate steps, even if one script runs both.
- Prefer failing fast on type errors before doing production bundling.
- In TypeScript Vite apps, `isolatedModules` aligns well with Vite's transpilation model.

## See Also

- [cfg-use-defineconfig-and-loadenv](./cfg-use-defineconfig-and-loadenv.md)
- [env-expose-only-safe-client-vars](./env-expose-only-safe-client-vars.md)
