# mig-forward-fix

Prefer forward fixes over ad hoc destructive rollback procedures.

## Apply when

- A migration behaves unexpectedly after partial rollout.

## Do

- Repair state with explicit follow-up migrations.

## Avoid

- Improvised destructive rollback under uncertain partial execution.
