# react-provider-context-boundary

> Keep SurrealDB connection ownership in a React provider or equivalent app-level boundary.

## Why It Matters

The official SurrealDB React framework guidance centers on a connection provider that exposes the client and connection state through context. That keeps connection setup, close behavior, and auth lifecycle in one place instead of scattering `new Surreal()` and `connect()` calls through leaf components. Without that boundary, apps duplicate setup logic, reconnect unpredictably, and make it harder to coordinate query and auth state.

## Bad

```tsx
import { Surreal } from "surrealdb";

function NotesPage() {
  const db = new Surreal();
  void db.connect("http://127.0.0.1:8000", {
    namespace: "app",
    database: "app",
  });

  return <div>Notes</div>;
}

function ProfilePage() {
  const db = new Surreal();
  void db.connect("http://127.0.0.1:8000", {
    namespace: "app",
    database: "app",
  });

  return <div>Profile</div>;
}
```

## Good

```tsx
import React, { createContext, useContext, useEffect, useState } from "react";
import { Surreal } from "surrealdb";

const SurrealContext = createContext<Surreal | null>(null);

export function SurrealProvider({ children }: { children: React.ReactNode }) {
  const [client] = useState(() => new Surreal());

  useEffect(() => {
    void client.connect("http://127.0.0.1:8000", {
      namespace: "app",
      database: "app",
    });

    return () => {
      void client.close();
    };
  }, [client]);

  return (
    <SurrealContext.Provider value={client}>{children}</SurrealContext.Provider>
  );
}

export function useSurrealClient() {
  const client = useContext(SurrealContext);
  if (!client) {
    throw new Error("useSurrealClient must be used within SurrealProvider");
  }
  return client;
}
```

## Apply This In React

- Place connection ownership near the application root.
- Expose the client and connection state through context or an equivalent boundary.
- Keep component-level hooks focused on queries, mutations, and subscriptions, not on bootstrapping a new client each render.
- Centralize connect, close, and auth transitions so they can be coordinated with routing and query cache behavior.

## See Also

- [ts-shared-client-and-session-boundaries](./ts-shared-client-and-session-boundaries.md)
- [react-effect-cleanup-for-live-sdk](./react-effect-cleanup-for-live-sdk.md)
- [auth-service-vs-user](./auth-service-vs-user.md)
