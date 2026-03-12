# react-effect-cleanup-for-live-sdk

> Manage SurrealDB SDK connections and live subscriptions as effect-owned external resources with cleanup.

## Why It Matters

React treats sockets, subscriptions, and database clients as external systems. The SurrealDB JavaScript SDK can open connections and live streams that outlive a render. If a component starts those resources without effect cleanup, reconnects and route changes can leak work, duplicate subscriptions, or keep writing state after the component has moved on.

## Bad

```tsx
import { Surreal } from "surrealdb";

function PeopleFeed() {
  const db = new Surreal();
  void db.connect("wss://localhost:8000");
  void db.live("person");

  return <div>Live feed</div>;
}
```

## Good

```tsx
import { useEffect, useState } from "react";
import { Surreal, Table } from "surrealdb";

type Person = { name: string };

function PeopleFeed() {
  const [people, setPeople] = useState<Person[]>([]);

  useEffect(() => {
    const db = new Surreal();
    let cancelled = false;

    void (async () => {
      await db.connect("wss://localhost:8000", {
        namespace: "app",
        database: "app",
      });

      const feed = await db.live(new Table("person"));
      for await (const { action, value } of feed) {
        if (cancelled) break;
        if (action === "CREATE") {
          setPeople((current) => [...current, value]);
        }
      }
    })();

    return () => {
      cancelled = true;
      void db.close();
    };
  }, []);

  return <div>{people.length} people</div>;
}
```

## Apply This In React

- Create SDK connections and subscriptions inside effects, not during render.
- Return cleanup that closes the connection or otherwise tears down the external resource.
- Recreate the effect only when the namespace, database, query target, or auth context actually changes.
- Treat live updates as streaming input and keep downstream UI work bounded.

## See Also

- [rt-live-when-needed](./rt-live-when-needed.md)
- [rt-cancel-cleanly](./rt-cancel-cleanly.md)
- [ts-shared-client-and-session-boundaries](./ts-shared-client-and-session-boundaries.md)
