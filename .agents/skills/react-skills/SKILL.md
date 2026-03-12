---
name: react-skills
description: >
  Generic React best practices for component purity, Hooks, effects, and list
  rendering. Use when writing, reviewing, or refactoring modern React code.
  Based on official React documentation.
license: MIT
metadata:
  author: GitHub Copilot
  version: "1.1.0"
  sources:
    - React Learn
    - React Reference Rules
    - React v19 release post
---

# React Best Practices

Generic guide for writing predictable, maintainable React components. This first edition focuses on 4 rules React documents as foundational for correct behavior.

## Version Baseline

This skill is intended for modern React 19 codebases. The rules remain broadly valid for React 18, but examples and review guidance should prefer current React 19 semantics where relevant.

## When to Apply

Reference these guidelines when:

- Writing new React components or custom hooks
- Reviewing component purity and state flow
- Refactoring `useEffect` usage
- Rendering dynamic lists and collections

## Rule Categories by Priority

| Priority | Category         | Impact   | Prefix    | Rules |
| -------- | ---------------- | -------- | --------- | ----- |
| 1        | Render Semantics | CRITICAL | `render-` | 1     |
| 2        | Hooks            | CRITICAL | `hook-`   | 1     |
| 3        | Effects          | HIGH     | `effect-` | 1     |
| 4        | Lists            | HIGH     | `list-`   | 1     |

---

## Quick Reference

### 1. Render Semantics

- [render-keep-components-pure](rules/render-keep-components-pure.md) - Keep render logic pure and idempotent

### 2. Hooks

- [hook-top-level-only](rules/hook-top-level-only.md) - Call Hooks only at the top level of React functions

### 3. Effects

- [effect-use-only-for-external-sync](rules/effect-use-only-for-external-sync.md) - Use effects to synchronize with external systems, not to model ordinary data flow

### 4. Lists

- [list-use-stable-keys](rules/list-use-stable-keys.md) - Use stable keys derived from data, not positions or randomness

---

## Review Checklist

- Components do not mutate props, state snapshots, or non-local values during render.
- Hooks are called in a stable order at the top level.
- Effects represent real synchronization work and clean up correctly.
- List keys come from stable identities in the backing data.
