# test-migration-empty-and-current

Test migrations from both empty state and the latest prior state.

## Apply when

- Evolving schema across releases.

## Do

- Verify bootstrap and upgrade paths separately.

## Avoid

- Testing only a fresh database while ignoring upgrades.
