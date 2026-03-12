# install-use-lockfile-and-frozen-installs

> Commit the Bun lockfile and use frozen installs in CI

## Why It Matters

Bun documents `bun.lock` as the lockfile it writes during install, and provides frozen install modes such as `bun install --frozen-lockfile` and `bun ci` for deterministic environments. Reproducible installs reduce CI drift and debugging noise.

## Bad

```json
{
  "scripts": {
    "ci:install": "bun install"
  }
}
```

## Good

```json
{
  "scripts": {
    "ci:install": "bun ci"
  }
}
```

## Also Good

```sh
bun install --frozen-lockfile
```

## Notes

- Commit `bun.lock`.
- Use frozen installs in CI and release pipelines.
- Avoid letting CI rewrite dependency resolution unless the change is intentional.

## See Also

- [trust-whitelist-dependency-scripts](./trust-whitelist-dependency-scripts.md)
- [ws-use-workspaces-and-filters](./ws-use-workspaces-and-filters.md)
