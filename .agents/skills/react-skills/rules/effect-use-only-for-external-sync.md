# effect-use-only-for-external-sync

> Use effects to synchronize with external systems, not to express ordinary render-time data flow

## Why It Matters

React documents effects as an escape hatch for synchronization with systems outside React: network, subscriptions, DOM APIs, widgets, and similar integrations. Using effects for internal data derivation creates extra renders, stale logic, dependency bugs, and cleanup issues.

## Bad

```tsx
import { useEffect, useState } from "react";

export function FullName({
  firstName,
  lastName,
}: {
  firstName: string;
  lastName: string;
}) {
  const [fullName, setFullName] = useState("");

  useEffect(() => {
    setFullName(`${firstName} ${lastName}`);
  }, [firstName, lastName]);

  return <p>{fullName}</p>;
}
```

## Good

```tsx
export function FullName({
  firstName,
  lastName,
}: {
  firstName: string;
  lastName: string;
}) {
  const fullName = `${firstName} ${lastName}`;
  return <p>{fullName}</p>;
}
```

## Good Effect Example

```tsx
import { useEffect } from "react";

export function ChatRoom({ roomId }: { roomId: string }) {
  useEffect(() => {
    const connection = createConnection(roomId);
    connection.connect();

    return () => connection.disconnect();
  }, [roomId]);

  return <h1>Room: {roomId}</h1>;
}

declare function createConnection(roomId: string): {
  connect(): void;
  disconnect(): void;
};
```

## Prefer This Pattern

- Derive values during render when possible.
- Use event handlers for interaction-driven side effects.
- Use effects only when render must synchronize with an external system.
- Always include correct dependencies and return cleanup when setup must be undone.

## See Also

- [render-keep-components-pure](./render-keep-components-pure.md)
- [hook-top-level-only](./hook-top-level-only.md)
