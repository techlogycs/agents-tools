---
name: surrealdb-skills
description: >
  Comprehensive SurrealDB 2.x guidelines for schema design, SurrealQL,
  permissions, indexing, migrations, realtime features, and Rust, TypeScript,
  and React SDK usage.
  Use when designing, reviewing, or refactoring SurrealDB-backed systems.
  Covers 2026 best and standard practices. Invoke with /surrealdb-skills.
license: MIT
metadata:
  author: GitHub Copilot
  version: "1.0.0"
  sources:
    - SurrealDB documentation
    - SurrealDB reference guide
    - SurrealDB performance best practices
    - SurrealDB schema creation best practices
    - SurrealDB Rust SDK documentation
    - SurrealDB JavaScript SDK documentation
    - SurrealDB JavaScript SDK React framework documentation
    - React useEffect documentation
    - SurrealDB security best practices
    - SurrealDB real-time best practices
    - SurrealDB sample industry schemas
    - SurrealDB observability guide
---

# SurrealDB Best Practices

Comprehensive guide for building production-grade SurrealDB 2.x systems with the Rust SDK and the official JavaScript SDK in TypeScript and React environments. This skill bundles rule documents for schema design, query safety, permissions, file storage buckets, migrations, performance, realtime features, and operational review.

## When to Apply

Use this skill when:

- designing SurrealDB schemas, fields, indexes, and access models
- writing or reviewing SurrealQL queries, transactions, and migrations
- implementing Rust services on top of the SurrealDB SDK
- implementing TypeScript services, browser clients, or React apps on top of the SurrealDB JavaScript SDK
- evaluating realtime features, events, functions, or table views
- performing code review for correctness, security, and operability

## Rule Categories by Priority

| Priority | Category                           | Prefix           | Rules |
| -------- | ---------------------------------- | ---------------- | ----- |
| 1        | Schema & Data Modeling             | `schema-`        | 12    |
| 2        | Query Safety & Correctness         | `query-`         | 12    |
| 3        | Auth & Permissions                 | `auth-`          | 11    |
| 4        | Rust SDK Integration               | `rust-`          | 12    |
| 5        | TypeScript & React SDK Integration | `ts-` / `react-` | 3     |
| 6        | Indexing & Performance             | `perf-`          | 10    |
| 7        | Transactions & Consistency         | `txn-`           | 8     |
| 8        | Realtime, Events & Functions       | `rt-`            | 10    |
| 9        | Migrations & Deployment            | `mig-`           | 11    |
| 10       | Testing & Observability            | `test-`          | 8     |
| 11       | Anti-patterns                      | `anti-`          | 8     |

## Quick Reference

### Schema & Data Modeling

- [`schema-schemafull-default`](rules/schema-schemafull-default.md)
- [`schema-schemaless-exception`](rules/schema-schemaless-exception.md)
- [`schema-define-fields-explicitly`](rules/schema-define-fields-explicitly.md)
- [`schema-option-nullable`](rules/schema-option-nullable.md)
- [`schema-assert-at-boundary`](rules/schema-assert-at-boundary.md)
- [`schema-default-generated`](rules/schema-default-generated.md)
- [`schema-value-computed`](rules/schema-value-computed.md)
- [`schema-record-links`](rules/schema-record-links.md)
- [`schema-relate-many-to-many`](rules/schema-relate-many-to-many.md)
- [`schema-array-id-range`](rules/schema-array-id-range.md)
- [`schema-hot-cold-split`](rules/schema-hot-cold-split.md)
- [`schema-multi-model-intentional`](rules/schema-multi-model-intentional.md)

### Query Safety & Correctness

- [`query-bind-parameters`](rules/query-bind-parameters.md)
- [`query-typed-results`](rules/query-typed-results.md)
- [`query-take-explicit`](rules/query-take-explicit.md)
- [`query-only-single-record`](rules/query-only-single-record.md)
- [`query-limit-intentional`](rules/query-limit-intentional.md)
- [`query-fetch-selective`](rules/query-fetch-selective.md)
- [`query-id-over-scan`](rules/query-id-over-scan.md)
- [`query-parse-dates-ids`](rules/query-parse-dates-ids.md)
- [`query-minimize-multi-statement`](rules/query-minimize-multi-statement.md)
- [`query-explicit-ordering`](rules/query-explicit-ordering.md)
- [`query-shape-stable`](rules/query-shape-stable.md)
- [`query-explain-profile`](rules/query-explain-profile.md)

### Auth & Permissions

- [`auth-record-access-default`](rules/auth-record-access-default.md)
- [`auth-least-privilege`](rules/auth-least-privilege.md)
- [`auth-table-permissions`](rules/auth-table-permissions.md)
- [`auth-no-root-runtime`](rules/auth-no-root-runtime.md)
- [`auth-password-hash`](rules/auth-password-hash.md)
- [`auth-short-token-duration`](rules/auth-short-token-duration.md)
- [`auth-service-vs-user`](rules/auth-service-vs-user.md)
- [`auth-claims-minimal`](rules/auth-claims-minimal.md)
- [`auth-test-denials`](rules/auth-test-denials.md)
- [`auth-if-not-exists`](rules/auth-if-not-exists.md)
- [`auth-bucket-permissions`](rules/auth-bucket-permissions.md)

### Rust SDK Integration

- [`rust-engine-explicit`](rules/rust-engine-explicit.md)
- [`rust-use-ns-db-once`](rules/rust-use-ns-db-once.md)
- [`rust-shared-client`](rules/rust-shared-client.md)
- [`rust-bind-all-dynamic-values`](rules/rust-bind-all-dynamic-values.md)
- [`rust-typed-crud-first`](rules/rust-typed-crud-first.md)
- [`rust-query-when-needed`](rules/rust-query-when-needed.md)
- [`rust-serde-models`](rules/rust-serde-models.md)
- [`rust-recordid-types`](rules/rust-recordid-types.md)
- [`rust-error-context`](rules/rust-error-context.md)
- [`rust-live-stream-backpressure`](rules/rust-live-stream-backpressure.md)
- [`rust-test-engine-fit`](rules/rust-test-engine-fit.md)
- [`rust-startup-bootstrap`](rules/rust-startup-bootstrap.md)

### TypeScript & React SDK Integration

- [`ts-shared-client-and-session-boundaries`](./rules/ts-shared-client-and-session-boundaries.md)
- [`ts-typed-methods-and-query-results`](./rules/ts-typed-methods-and-query-results.md)
- [`react-provider-context-boundary`](./rules/react-provider-context-boundary.md)
- [`react-effect-cleanup-for-live-sdk`](./rules/react-effect-cleanup-for-live-sdk.md)

### Indexing, Transactions, Realtime, Migrations, Testing, Anti-patterns

See the remaining rule files under `rules/` for performance, consistency, realtime, deployment, observability, and anti-pattern guidance.

Important storage-specific rules include:

- [`mig-bucket-backend-explicit`](rules/mig-bucket-backend-explicit.md)
- [`mig-bucket-s3-global-explicit`](./rules/mig-bucket-s3-global-explicit.md)

## Review Checklist

- Are core tables `SCHEMAFULL`, or is there a documented exception?
- Are dynamic query values bound instead of interpolated?
- Do indexes enforce important uniqueness and filter paths?
- Do permissions protect data even if the app layer is bypassed?
- Are bucket permissions explicit for `put`, `get`, `delete`, `copy`, `rename`, and `list` where file storage is exposed?
- Do TypeScript SDK call sites prefer typed methods and typed query results over `any`-shaped responses?
- Do React apps keep connection ownership in a provider or equivalent app-level boundary instead of scattering SDK setup through leaf components?
- Do React integrations clean up SDK connections or live subscriptions on dependency change and unmount?
- Are migrations ordered, idempotent where possible, and safe to rerun?
- Is bucket backend choice intentional for transient, durable local, or global/object-backed storage?
- Are root credentials limited to bootstrap and maintenance flows?
- Are realtime features justified by a real workload?

## Rule Format

The Rust rules in this repository are a better model than one-paragraph rule stubs. SurrealDB rules should converge on the same structure:

- one-line statement of the rule
- `Why It Matters` with the failure mode or tradeoff
- `Bad` example that shows the mistake clearly
- `Good` example using SurrealQL or an official SurrealDB SDK
- `See Also` links to adjacent rules

The most important SurrealDB rules should carry executable-looking examples first: schema, query safety, auth, and SDK integration.

## Reference Guide Coverage

The skill should reflect these reference-guide specifics, not just generic database advice:

- Schema creation:
  define arrays and sets with element types and size limits when the domain knows them; use `ASSERT` with `THROW` when richer failure messages matter; use `VALUE` or computed fields deliberately; use `DEFINE PARAM` for shared constants and policy values; use `ENFORCED` relationships or graph-aware schema where link existence matters.
- Performance:
  select single records directly when identity is known; simplify `WHERE` logic so indexes are usable; prefer `UPSERT` when unique indexes define identity; use remote-field index lookups deliberately; choose embedded, single-node, cluster, or cloud deployment modes based on workload, not convenience.
- Real-time and events:
  use temporal querying and predictable IDs for record ranges and table views; choose UUID, ULID, or compound IDs based on ordering needs; keep events small; be explicit about outbound network requirements such as `--allow-net` when using `http::` functions in events.
- File storage and buckets:
  choose bucket backends intentionally: `memory` for ephemeral workloads, `file:` for durable local storage with an allowlisted path, or a global/object-backed setup such as S3 when shared storage is required; define bucket permissions explicitly using `$action`, `$file`, and `$target`; use file methods such as `put`, `get`, `head`, `delete`, `copy`, `rename`, `exists`, and `list` with the same review rigor as data queries.
- SDK integration:
  establish connection, auth, namespace, and database selection once at the correct lifecycle boundary; in Rust, prefer typed CRUD methods before raw query text and bind query values; in TypeScript, prefer typed SDK methods and typed `query()` tuples or collectors over `any`; in React, keep SDK ownership in a provider or other app-level boundary and treat live connections as external systems managed by effects with cleanup.
- Sample schemas:
  treat industry schemas as modeling patterns for graph, time-series, geospatial, search, computed fields, futures, and structured objects, not as copy-paste templates.
- Observability:
  account for OpenTelemetry export, metrics, log output settings, and tools such as `tokio-console` in operational guidance for Rust-backed SurrealDB deployments.

If a rule omits one of these reference-guide themes where it clearly applies, the rule is incomplete.

## How to Use

1. Start with the category matching the task.
2. Apply the CRITICAL rules before optimizing lower-priority concerns.
3. Use the anti-pattern rules during review to find regressions quickly.
4. Treat the rules as design constraints, not optional style notes.
