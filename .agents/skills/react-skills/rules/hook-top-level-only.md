# hook-top-level-only

> Call Hooks only at the top level of function components or custom Hooks

## Why It Matters

React depends on Hook call order being stable across renders. Calling Hooks in conditions, loops, nested functions, or after early returns breaks that ordering and leads to incorrect state association.

## Bad

```tsx
import { useEffect, useState } from "react";

export function SearchPanel({ enabled }: { enabled: boolean }) {
  if (!enabled) {
    return null;
  }

  const [query, setQuery] = useState("");

  function handleFocus() {
    useEffect(() => {
      console.log("focused");
    }, []);
  }

  return (
    <input
      value={query}
      onChange={(e) => setQuery(e.target.value)}
      onFocus={handleFocus}
    />
  );
}
```

## Good

```tsx
import { useEffect, useState } from "react";

export function SearchPanel({ enabled }: { enabled: boolean }) {
  const [query, setQuery] = useState("");

  useEffect(() => {
    if (!enabled) {
      setQuery("");
    }
  }, [enabled]);

  if (!enabled) {
    return null;
  }

  return <input value={query} onChange={(e) => setQuery(e.target.value)} />;
}
```

## Allowed Locations

- Top level of a function component
- Top level of a custom Hook

## Forbidden Locations

- Conditions and loops
- Event handlers
- `try`/`catch` blocks
- Functions passed into `useMemo`, `useEffect`, or reducers
- Class components and ordinary utility functions

## See Also

- [render-keep-components-pure](./render-keep-components-pure.md)
- [effect-use-only-for-external-sync](./effect-use-only-for-external-sync.md)
