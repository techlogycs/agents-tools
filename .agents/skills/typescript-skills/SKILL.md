---
name: typescript-skills
description: >
  Generic TypeScript best practices for strictness, narrowing, function design,
  and safe unknown data handling. Use when writing, reviewing, or refactoring
  TypeScript code. Based on official TypeScript documentation.
license: MIT
metadata:
  author: GitHub Copilot
  version: "1.0.0"
  sources:
    - TypeScript Handbook
    - TypeScript TSConfig reference
---

# TypeScript Best Practices

Generic guide for writing safer and more maintainable TypeScript. This first edition focuses on 4 documented rules that have large practical impact on day-to-day code quality.

## When to Apply

Reference these guidelines when:

- Writing new TypeScript modules and APIs
- Reviewing runtime boundary handling
- Refactoring union-heavy business logic
- Designing function signatures and callback types

## Rule Categories by Priority

| Priority | Category            | Impact   | Prefix    | Rules |
| -------- | ------------------- | -------- | --------- | ----- |
| 1        | Compiler Strictness | CRITICAL | `cfg-`    | 1     |
| 2        | Type Refinement     | CRITICAL | `narrow-` | 1     |
| 3        | Function Signatures | HIGH     | `fn-`     | 1     |
| 4        | Untrusted Data      | HIGH     | `data-`   | 1     |

---

## Quick Reference

### 1. Compiler Strictness

- [cfg-enable-strict-mode](rules/cfg-enable-strict-mode.md) - Treat `strict` mode as the baseline configuration

### 2. Type Refinement

- [narrow-before-member-access](rules/narrow-before-member-access.md) - Narrow unions before using member-specific operations

### 3. Function Signatures

- [fn-prefer-unions-over-overloads](rules/fn-prefer-unions-over-overloads.md) - Prefer union parameters over overloads when the call shape is compatible

### 4. Untrusted Data

- [data-prefer-unknown-over-any](rules/data-prefer-unknown-over-any.md) - Use `unknown` at untrusted boundaries and refine before use

---

## Review Checklist

- `strict` is enabled unless there is a justified migration constraint.
- Union values are narrowed with runtime checks before member-specific access.
- Function signatures stay simple and inference-friendly.
- External data enters the system as `unknown` and is validated before use.
