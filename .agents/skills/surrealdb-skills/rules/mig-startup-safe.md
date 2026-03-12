# mig-startup-safe

Keep startup migration paths safe for repeated execution.

## Apply when

- The application applies migrations during bootstrap.

## Do

- Make startup migration steps deterministic and rerunnable.

## Avoid

- Embedding one-shot assumptions in startup code.
