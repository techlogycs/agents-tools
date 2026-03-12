# env-expose-only-safe-client-vars

> Only expose intentionally public client variables through the Vite env surface

## Why It Matters

Vite only exposes prefixed variables to client code to avoid accidental leaks, and it explicitly warns that anything exposed to Vite-processed source ends up in the client bundle. Client env values must therefore be treated as public configuration, never secrets.

## Bad

```env
VITE_API_TOKEN=super-secret-token
DB_PASSWORD=database-password
```

```ts
console.log(import.meta.env.VITE_API_TOKEN);
```

## Good

```env
VITE_API_BASE_URL=https://api.example.com
DB_PASSWORD=database-password
```

```ts
const apiBaseUrl = import.meta.env.VITE_API_BASE_URL;
```

## Also Good

```ts
interface ImportMetaEnv {
  readonly VITE_API_BASE_URL: string;
}

interface ImportMeta {
  readonly env: ImportMetaEnv;
}
```

## Notes

- Only variables with the configured prefix are exposed to client code.
- Env values arrive as strings and should be parsed explicitly.
- Restart the dev server after editing `.env` files.

## See Also

- [cfg-use-defineconfig-and-loadenv](./cfg-use-defineconfig-and-loadenv.md)
- [build-separate-typecheck-from-transpile](./build-separate-typecheck-from-transpile.md)
