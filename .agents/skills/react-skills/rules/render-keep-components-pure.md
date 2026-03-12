# render-keep-components-pure

> Keep component and Hook render logic pure and idempotent

## Why It Matters

React relies on pure rendering so it can re-run render logic, interrupt work, and apply only the minimal DOM changes. If rendering mutates shared values, performs side effects, or depends on non-idempotent expressions, React behavior becomes harder to reason about and bugs become timing-sensitive.

## Bad

```tsx
let nextId = 0;

export function Counter() {
  document.title = "Counter";

  const id = nextId++;
  const now = new Date().toISOString();

  return (
    <p>
      {id}: {now}
    </p>
  );
}
```

## Good

```tsx
import { useEffect, useState } from "react";

function useNow() {
  const [now, setNow] = useState(() => new Date().toISOString());

  useEffect(() => {
    const id = setInterval(() => {
      setNow(new Date().toISOString());
    }, 1000);

    return () => clearInterval(id);
  }, []);

  return now;
}

export function Clock() {
  const now = useNow();
  return <p>{now}</p>;
}
```

## Keep Out Of Render

- DOM writes
- network requests
- timers and subscriptions
- mutation of props, state snapshots, or module-level collections
- non-idempotent calls like `Math.random()` or `new Date()` when they define rendered output

## See Also

- [hook-top-level-only](./hook-top-level-only.md)
- [effect-use-only-for-external-sync](./effect-use-only-for-external-sync.md)
