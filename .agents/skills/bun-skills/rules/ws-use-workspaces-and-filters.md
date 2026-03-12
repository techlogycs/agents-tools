# ws-use-workspaces-and-filters

> Use Bun workspaces and filters instead of ad hoc multi-package shell loops

## Why It Matters

Bun supports workspaces natively and documents filtering installs and commands for targeted operations. Using Bun's workspace model makes dependency management and scoped execution explicit, reproducible, and easier to maintain than custom scripting.

## Bad

```sh
for dir in packages/*; do
  (cd "$dir" && bun install)
done
```

## Good

```json
{
  "workspaces": ["packages/*"]
}
```

```sh
bun install
bun install --filter './packages/web'
```

## Notes

- Let the workspace graph define package relationships.
- Use filters for targeted installs or commands instead of manual directory iteration.
- Prefer one shared dependency workflow over package-local drift.

## See Also

- [install-use-lockfile-and-frozen-installs](./install-use-lockfile-and-frozen-installs.md)
- [run-use-bun-runtime-explicitly](./run-use-bun-runtime-explicitly.md)
