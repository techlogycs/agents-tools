---
name: bun-skills
description: >
  Generic Bun best practices for deterministic installs, trusted dependency
  scripts, workspaces, and runtime usage. Use when writing, reviewing, or
  refactoring Bun-based projects. Based on official Bun documentation.
license: MIT
metadata:
  author: GitHub Copilot
  version: "1.0.0"
  sources:
    - Bun package manager docs
    - Bun runtime docs
---

# Bun Best Practices

Generic guide for using Bun as a runtime and package manager. This first edition covers 4 rules directly grounded in Bun's documented behavior around installs, workspaces, scripts, and execution.

## When to Apply

Reference these guidelines when:

- Setting up Bun projects or CI pipelines
- Reviewing dependency installation behavior
- Managing monorepos with Bun workspaces
- Writing runtime commands and scripts

## Rule Categories by Priority

| Priority | Category                | Impact   | Prefix     | Rules |
| -------- | ----------------------- | -------- | ---------- | ----- |
| 1        | Dependency Installation | CRITICAL | `install-` | 1     |
| 2        | Supply Chain Safety     | CRITICAL | `trust-`   | 1     |
| 3        | Workspaces              | HIGH     | `ws-`      | 1     |
| 4        | Runtime Execution       | HIGH     | `run-`     | 1     |

---

## Quick Reference

### 1. Dependency Installation

- [install-use-lockfile-and-frozen-installs](rules/install-use-lockfile-and-frozen-installs.md) - Commit the Bun lockfile and use frozen installs in CI

### 2. Supply Chain Safety

- [trust-whitelist-dependency-scripts](rules/trust-whitelist-dependency-scripts.md) - Explicitly trust dependency lifecycle scripts instead of assuming they run

### 3. Workspaces

- [ws-use-workspaces-and-filters](rules/ws-use-workspaces-and-filters.md) - Use Bun workspaces and filters instead of ad hoc multi-package shell loops

### 4. Runtime Execution

- [run-use-bun-runtime-explicitly](rules/run-use-bun-runtime-explicitly.md) - Use Bun runtime invocation intentionally and keep flag placement correct
