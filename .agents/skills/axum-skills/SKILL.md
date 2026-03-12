---
name: axum-skills
description: >
  Generic Axum best practices for routing, extractors, shared state, response
  design, and graceful shutdown. Use when writing, reviewing, or refactoring
  Axum services. Based on official Axum and Tokio documentation.
license: MIT
metadata:
  author: GitHub Copilot
  version: "1.0.0"
  sources:
    - Axum docs
    - Tokio graceful shutdown guide
---

# Axum Best Practices

Generic guide for building clear, type-safe, and production-ready HTTP services with Axum. This first edition contains 4 high-value rules focused on the patterns Axum documents most strongly.

## When to Apply

Reference these guidelines when:

- Building new Axum routers, handlers, or middleware stacks
- Reviewing request extraction and response design
- Refactoring shared application state
- Adding graceful shutdown behavior to services

## Rule Categories by Priority

| Priority | Category          | Impact   | Prefix     | Rules |
| -------- | ----------------- | -------- | ---------- | ----- |
| 1        | Shared State      | CRITICAL | `state-`   | 1     |
| 2        | Request Handling  | HIGH     | `extract-` | 1     |
| 3        | Response Design   | HIGH     | `resp-`    | 1     |
| 4        | Runtime Lifecycle | HIGH     | `run-`     | 1     |

---

## Quick Reference

### 1. Shared State

- [state-use-state-extractor](rules/state-use-state-extractor.md) - Prefer `State` over ad hoc request extensions for shared application state

### 2. Request Handling

- [extract-use-typed-extractors](rules/extract-use-typed-extractors.md) - Model request inputs with typed extractors instead of manual parsing

### 3. Response Design

- [resp-return-intoresponse](rules/resp-return-intoresponse.md) - Return typed values that implement `IntoResponse`

### 4. Runtime Lifecycle

- [run-graceful-shutdown](rules/run-graceful-shutdown.md) - Implement explicit graceful shutdown with signal handling and task coordination

---

## Review Checklist

- Shared state flows through `State<T>` instead of hidden request-local wiring.
- Handlers use extractors for `Path`, `Query`, headers, bodies, and state.
- Response types are explicit and compose through `IntoResponse`.
- The server has a shutdown path that stops accepting work and lets in-flight tasks finish.

## Rule Format

Each rule follows the same structure used by the stronger Rust rules:

- One-line rule summary
- `Why It Matters`
- `Bad`
- `Good`
- `See Also`
