# mig-bucket-s3-global-explicit

> Use S3-backed bucket storage through explicit operator-managed global configuration, not ad hoc migration logic.

## Why It Matters

SurrealDB documents global bucket storage as the mechanism for shared object storage across namespaces and databases. In practice, that is the clean fit for S3-style backends: operators control the storage backend and credentials, while schemas and migrations keep bucket definitions minimal. Mixing cloud-storage setup into migrations creates unclear ownership, leaks operational concerns into schema code, and makes environment drift harder to detect.

## Bad

```surql
-- The migration implies durable shared storage, but there is no operator-owned
-- global backend configuration behind it.
DEFINE BUCKET uploads BACKEND "memory";

f"uploads:/reports/q1.csv".put("...");
```

```surql
-- Buckets are used like shared cloud storage, but backend assumptions are hidden.
DEFINE BUCKET shared_assets;
```

## Good

```surql
-- Keep the schema-side definition minimal when operators provide global storage.
DEFINE BUCKET shared_assets
	PERMISSIONS
		FOR put WHERE $auth.admin = true
		FOR get WHERE $auth != NONE
		FOR delete WHERE $auth.admin = true
		FOR copy WHERE $auth.admin = true
		FOR rename WHERE $auth.admin = true
		FOR list WHERE $auth.admin = true;

-- When a global backend is configured, SurrealDB prefixes files with
-- namespace/database automatically.
f"shared_assets:/docs/readme.txt".put("Hello, SurrealDB!");
```

## Review Guidance

- Treat S3 bucket selection, credentials, region, endpoint, and lifecycle policy as operator-managed deployment concerns.
- Keep `DEFINE BUCKET` focused on the local bucket name and permissions when a global backend is configured.
- Account for the automatic namespace and database path prefixing that SurrealDB applies to global bucket storage.
- Review `copy`, `rename`, `exists`, `head`, and `list` as carefully as `put` and `get`, because metadata exposure matters in shared object storage.
- If the deployment enforces a global backend, document that clearly so developers do not assume local `memory` or `file:` semantics.

## When to Prefer This

- Shared assets must survive restarts and be available across application instances.
- Storage should be owned by platform or infrastructure configuration rather than per-migration filesystem paths.
- The workload needs cloud-object-storage characteristics instead of local-disk semantics.

## See Also

- [mig-bucket-backend-explicit](./mig-bucket-backend-explicit.md)
- [auth-bucket-permissions](./auth-bucket-permissions.md)
- [mig-doc-operational-assumptions](./mig-doc-operational-assumptions.md)
