# cfg-use-defineconfig-and-loadenv

> Structure Vite config with `defineConfig` and explicit env loading

## Why It Matters

Vite documents `defineConfig` as the standard configuration wrapper and provides `loadEnv` for controlled environment loading inside config files. Using both keeps configuration typed, explicit, and consistent across modes.

## Bad

```ts
export default {
  server: {
    port: process.env.PORT,
  },
};
```

## Good

```ts
import { defineConfig, loadEnv } from "vite";

export default defineConfig(({ mode }) => {
  const env = loadEnv(mode, process.cwd(), "");

  return {
    server: {
      port: Number(env.PORT ?? 5173),
    },
  };
});
```

## Notes

- Distinguish Vite mode from `NODE_ENV`; they are related but not the same concept.
- Parse string env values into booleans, numbers, or URLs explicitly.
- Keep config-time env usage explicit instead of reading scattered globals.

## See Also

- [env-expose-only-safe-client-vars](./env-expose-only-safe-client-vars.md)
- [build-separate-typecheck-from-transpile](./build-separate-typecheck-from-transpile.md)
