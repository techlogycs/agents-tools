# run-use-bun-runtime-explicitly

> Use Bun runtime invocation intentionally and keep flag placement correct

## Why It Matters

Bun documents that runtime flags like `--watch` apply to Bun itself and must appear before `run`. It also documents resolution differences between `bun run` and direct file execution. Being explicit avoids commands that look valid but do something different than intended.

## Bad

```sh
bun run dev --watch
```

## Good

```sh
bun --watch run dev
```

## Also Good

```sh
bun run build
bun src/index.ts
```

## Notes

- Put Bun runtime flags before `run`.
- Use `bun run <script>` for package scripts.
- Execute entry files directly when you mean to run source, not a package script.

## See Also

- [ws-use-workspaces-and-filters](./ws-use-workspaces-and-filters.md)
