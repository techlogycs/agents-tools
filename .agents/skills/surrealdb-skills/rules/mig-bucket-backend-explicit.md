# mig-bucket-backend-explicit

> Choose bucket backends intentionally and document the runtime requirements for each one.

## Why It Matters

SurrealDB buckets can run against ephemeral memory, local files, or a global backend. Those choices change durability, path handling, operational dependencies, and security posture. Treating bucket backend selection as an implicit default leads to surprises such as data loss on restart, file-backend access denied errors, or namespace/database path prefixing from global storage.

## Bad

```surql
-- Durable uploads were expected, but memory storage disappears on restart.
DEFINE BUCKET uploads BACKEND "memory";
```

```bash
# File buckets are defined, but the server was not configured to allow the path.
surreal start --user root --pass secret --allow-experimental files
```

## Good

```surql
-- Ephemeral cache or session data.
DEFINE BUCKET session_cache BACKEND "memory";

-- Durable local storage with an allowlisted directory.
DEFINE BUCKET uploads BACKEND "file:/var/lib/surreal/uploads";

-- Global backend selected through environment and prefixed by namespace/database.
DEFINE BUCKET shared_assets;
```

```bash
# Allow the file-backed bucket path explicitly.
SURREAL_BUCKET_FOLDER_ALLOWLIST="/var/lib/surreal/uploads" \
surreal start --user root --pass secret --allow-experimental files
```

## Backend Selection Guide

- Use `memory` for transient files such as caches, scratch output, or short-lived session assets.
- Use `file:` for durable on-disk storage when local filesystem persistence is acceptable and the path can be allowlisted.
- Use a global bucket when operators need one shared storage backend across namespaces and databases, and account for the automatic namespace/database path prefixing.
- If global storage is enforced through environment configuration, keep `DEFINE BUCKET` statements minimal and document that behavior in deployment docs and migrations.

## File Methods to Review

Buckets should be reviewed as part of the data model, not as an afterthought. The common file methods are:

- `put`
- `get`
- `head`
- `delete`
- `copy`
- `rename`
- `exists`
- `list`

Each exposed method should have an explicit permission story and a matching operational expectation.

## See Also

- [auth-bucket-permissions](./auth-bucket-permissions.md)
- [mig-doc-operational-assumptions](./mig-doc-operational-assumptions.md)
- [mig-startup-safe](./mig-startup-safe.md)
