# trust-whitelist-dependency-scripts

> Explicitly trust dependency lifecycle scripts instead of assuming they run

## Why It Matters

Bun documents that it does not run arbitrary dependency lifecycle scripts by default. That behavior is intentional supply-chain hardening. Projects that require dependency scripts should opt in explicitly using trusted dependency configuration.

## Bad

```json
{
  "dependencies": {
    "some-native-package": "^1.0.0"
  }
}
```

```sh
bun install
# assumes postinstall ran
```

## Good

```json
{
  "dependencies": {
    "some-native-package": "^1.0.0"
  },
  "trustedDependencies": ["some-native-package"]
}
```

## Prefer This Pattern

- Keep the trust list small and auditable.
- Add entries only when a dependency is known to require lifecycle scripts.
- Re-review trusted packages during upgrades.

## See Also

- [install-use-lockfile-and-frozen-installs](./install-use-lockfile-and-frozen-installs.md)
