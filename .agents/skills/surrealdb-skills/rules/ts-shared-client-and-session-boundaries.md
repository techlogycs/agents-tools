# ts-shared-client-and-session-boundaries

> Reuse a connected TypeScript client, and create new SDK sessions only when isolation is required.

## Why It Matters

The JavaScript SDK keeps connection, authentication, namespace, database, and parameters on the client session. Reconnecting for every operation is wasteful, but mutating one shared session across unrelated auth or namespace boundaries is also risky. The right boundary is a long-lived client for one app context, and `newSession()` or `forkSession()` when you truly need isolation.

## Bad

```typescript
import { Surreal } from "surrealdb";

export async function loadUsers() {
  const db = new Surreal();
  await db.connect("wss://localhost:8000");
  await db.use({ namespace: "app", database: "app" });
  await db.signin({ username: "root", password: "secret" });
  return db.select("user");
}
```

## Good

```typescript
import { Surreal } from "surrealdb";

const db = new Surreal();

export async function connectDb() {
  await db.connect("wss://localhost:8000", {
    namespace: "app",
    database: "app",
    authentication: {
      username: "service",
      password: "secret",
    },
  });
  return db;
}

export async function adminSession() {
  const session = await db.newSession();
  await session.use({ namespace: "admin", database: "ops" });
  return session;
}
```

## Session Notes

- Use one connected client per server process, worker, or browser app boundary.
- Use `newSession()` for isolated auth, namespace, database, or parameter state.
- Use `forkSession()` when you want a child session to inherit current state and then diverge safely.
- Close temporary sessions when they are no longer needed.

## See Also

- [rust-shared-client](./rust-shared-client.md)
- [ts-typed-methods-and-query-results](./ts-typed-methods-and-query-results.md)
- [react-effect-cleanup-for-live-sdk](./react-effect-cleanup-for-live-sdk.md)
