# mig-separate-backfills

Separate large backfills from startup-critical schema migrations.

## Apply when

- A deploy introduces heavy data rewrites or recalculation work.

## Do

- Isolate bulky backfills into controlled operational steps.

## Avoid

- Hiding long-running rewrites in app startup.
